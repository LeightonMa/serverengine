#
# ServerEngine
#
# Copyright (C) 2012-2013 FURUHASHI Sadayuki
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
module ServerEngine

  class EmbeddedServer < Server
    def run
      @worker = create_worker(0)
      until @stop
        @worker.main
      end
    end

    def stop(stop_graceful)
      super
      Thread.new { @worker.stop }
      nil
    end

    def restart(stop_graceful)
      super
      Thread.new { @worker.stop }
      nil
    end

    def reload
      super
      Thread.new { @worker.reload }
      nil
    end
  end

end
