### Canary deployment workflow
Create 2 pipeline to edit production source code
Trigger p1: edit replicas=1 and image tag for canary Deployment resource
Trigger p2: edit replicas=0 for canary, edit production image tag
