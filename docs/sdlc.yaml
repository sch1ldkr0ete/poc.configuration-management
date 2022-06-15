::: mermaid
sequenceDiagram
   autonumber

   participant d as Developer
   participant app as Application Repo
   participant ci as Build Pipeline
   participant cd as Release Pipeline
   participant flux as Flux
   participant acr as Container Registry
   participant manifest as Manifest Repo

   rect rgba(0,255,0,.1)
      %% trigger

      d->>+app: commit changes

      %%
      %% build
      %%
      alt
         d-)ci: trigger new build
      else    
         app-)ci: trigger new build
      end

      %% run ci   
      activate ci

      %% build
      ci->>ci: build app

      %% test
      ci->>ci: unit test app

      %% publish
      opt
         ci-->>ci: publish artifacts
         ci-->>acr: build and publish container
         ci-->>app:set version tag
      end

      deactivate ci
   end



   %%
   %% deployment
   %%
   rect rgba(0,0,255,.2)
            %% run cd
      loop foreach environment
         alt
            d-)manifest: update manifests
         else
            cd-)manifest: update manifests
         else
            activate flux
            acr-->>flux: trigger image updater policy
            flux->>manifest: update manifests
            deactivate flux
         end

        alt
            d-->>manifest:Generate/Approve/Reject PR for stage
         else
            cd-->>manifest:Generate/Approve/Reject PR for stage
        end

        %% deploy
        rect rgba(0,155,155.2)
           activate flux
           note right of flux: deploy manifests
           manifest-->>flux: pull new manifests
           acr-->>flux: pull new image
           flux->>flux: deploy images
            deactivate flux
        end

      end
      
   end

:::

