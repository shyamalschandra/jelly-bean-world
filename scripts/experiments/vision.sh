#!/bin/bash

export CUDA_VISIBLE_DEVICES=""

(( server = 2 ))
(( run_count = 20 ))
(( batch_size = 1 ))
(( agent_fov = 360 ))
(( step_count = 1000000 ))
visual_occlusion=false

(( start_run_id = 100 * server ))
(( end_run_id = start_run_id + run_count - 1 ))

if [[ "$visual_occlusion" = false ]]; then
  mkdir -p temp/results/reward-CollectOnions:agent-fov-$agent_fov:no-visual-occlusion/PPO/Vision/Plain
else
  mkdir -p temp/results/reward-CollectOnions:agent-fov-$agent_fov/PPO/Vision/Plain
fi

for i in $(seq $start_run_id $end_run_id);
do
  if [[ "$visual_occlusion" = true ]]; then
    .build/release/JellyBeanWorldExperiments run \
      --reward collectOnions \
      --agent ppo \
      --observation vision \
      --network plain \
      --minimum-run-id $i \
      --batch-size $batch_size \
      --agent-field-of-view $agent_fov \
      --step-count $step_count &
  else
    .build/release/JellyBeanWorldExperiments run \
      --reward collectOnions \
      --agent ppo \
      --observation vision \
      --network plain \
      --minimum-run-id $i \
      --batch-size $batch_size \
      --agent-field-of-view $agent_fov \
      --no-visual-occlusion \
      --step-count $step_count &
  fi
done
