LOCAL_IMAGE=zeppelin
SPARK_IMAGE=jeffreymanning/zeppelin

# If you're pushing to an integrated registry
# in Openshift, SPARK_IMAGE will look something like this
# SPARK_IMAGE=172.30.242.71:5000/myproject/openshift-spark

.PHONY: build clean push create destroy

build:
	docker build -t $(LOCAL_IMAGE) .

clean:
	docker rmi $(LOCAL_IMAGE)

push: build
	docker tag $(LOCAL_IMAGE) $(SPARK_IMAGE)
	docker push $(SPARK_IMAGE)

# need to update for zeppelin
create: push template.yaml
	oc process -f template.yaml -v SPARK_IMAGE=$(SPARK_IMAGE) > template.active
	oc create -f template.active

destroy: template.active
	oc delete -f template.active
	rm template.active
