Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F46F515B18
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382340AbiD3Hw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 03:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382338AbiD3Hwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:52:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74020F49
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:49:30 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4R4i-1nsijg2lgE-011V69; Sat, 30 Apr 2022 09:48:54 +0200
Message-ID: <3b57224b-41a2-6393-51b8-a9c3435fa4d1@i2se.com>
Date:   Sat, 30 Apr 2022 09:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] staging: vchiq_arm: use standard print helpers
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220428150550.261499-1-athierry@redhat.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220428150550.261499-1-athierry@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HP3mKp0Sb8o8pQbVWE7eFuHYvYntWx1nW3hEh5S6FufyGpSiclC
 qEzxI+VD1z7rI9M9d9pIb+JvBN5Rsy9tSFu5DOPlBKlqZneghjh8tuy+uUEMWZB9/rwPl07
 IU20X8zVQvQ70Ukmox5Xd6ou36unbVp3ojoP7LpoSsnt5tr7ETt3mRP+YGacVfVgTN3VMXI
 LbgBUiqaWsQgvdxlkUs2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hn+ts4GzeIs=:D7hsSqoXB91UGnuveDdRM2
 a2jWbjT+M4J/90X5Rhz2waqwSieJ8l8uU/4FQyDjJ8RYzShvlWKbKAksTzhnilggORqSTX+JF
 VV4VCJVLZ9dx+sRvaExi30ik/6NnjZufi3Q1FhFWz2K4PtnOKQDxc7j6pJUdsZr6ik9A4t/j6
 p+QOrvgmMMCV+9PZk1Yqpl4rgvvbrAd3KAE2OZ3pY7JJGglEad0VNhYaSHiWiKVklPHoSR7wk
 rgJOzkhW1kTg0oKQZ/ciNW9oWSc75ZBlkiBMaZxwG6pxDHfI3Gcrs+ynoF3TPiZFoXnRaDU2W
 Ot9+4LEEvZdSmamE1QtsEUQ5h/ky897aatL7RJtJsAtG7QSI+yp37HEBtJl439LCNl+CgN9lA
 RGVCy4UXg5aKJ8i3h1K6rIJtzwk+elw1kd0puhblT7nbMKMaDCzNADkThpWicngCNNXERVQ8n
 tq3ibeHkruuJEoDS2iOHei1FJhXx0tB8XOOMVhkTzwjDCxPIcq5aVppM6hcsKiEP4pC/CP5X/
 KuYj6gOd9XrjFNaZBURWA74snhnSkkKFHOPl2cUwYb4g/Ci80gfMnsC30+tFRmXIBQCgs3xqU
 JVenee+hyORNaMdTm9dSkxieae3u8LeAGpyCey7rPgK4hqSfRmEKDawJ4+zb090yIaDqmpGxI
 OAv2XUoSQC5nELpfEDYdWIYljWmoUnR4o5tR29AUG8t6OZgORJrosQIKBgLblJwyCWWHne7HV
 7DvbFQ4k4vIpk3X5
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

thanks for taking care of this.

Am 28.04.22 um 17:05 schrieb Adrien Thierry:
> Replace the custom debug print macros with the standard dev_err() and
> friends.
>
> This handles TODO item "Cleanup logging mechanism".
>
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
>
> Changes since v1: removed function name in dev_dbg() calls
>
>   .../interface/vchiq_arm/vchiq_arm.c           | 157 +++---
>   .../interface/vchiq_arm/vchiq_connected.c     |   7 +-
>   .../interface/vchiq_arm/vchiq_connected.h     |   4 +-
>   .../interface/vchiq_arm/vchiq_core.c          | 495 ++++++++----------
>   .../interface/vchiq_arm/vchiq_core.h          |  43 +-
>   .../interface/vchiq_arm/vchiq_debugfs.c       | 105 ----
>   .../interface/vchiq_arm/vchiq_dev.c           |  86 ++-
>   7 files changed, 341 insertions(+), 556 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 0596ac61e286..15e6e096441a 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -58,10 +58,6 @@
>   #define KEEPALIVE_VER 1
>   #define KEEPALIVE_VER_MIN KEEPALIVE_VER
>   
> -/* Run time control of log level, based on KERN_XXX level. */
> -int vchiq_arm_log_level = VCHIQ_LOG_DEFAULT;
> -int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
> -
>   DEFINE_SPINLOCK(msg_queue_spinlock);
>   struct vchiq_state g_state;
>   
> @@ -253,7 +249,7 @@ create_pagelist(char *buf, char __user *ubuf,
>   	pagelist = dma_alloc_coherent(g_dev, pagelist_size, &dma_addr,
>   				      GFP_KERNEL);
>   
> -	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK", __func__, pagelist);
> +	dev_dbg(g_dev, "%pK", pagelist);
>   
>   	if (!pagelist)
>   		return NULL;
> @@ -308,9 +304,7 @@ create_pagelist(char *buf, char __user *ubuf,
>   						   type == PAGELIST_READ, pages);
>   
>   		if (actual_pages != num_pages) {
> -			vchiq_log_info(vchiq_arm_log_level,
> -				       "%s - only %d/%d pages locked",
> -				       __func__, actual_pages, num_pages);
> +			dev_info(g_dev, "only %d/%d pages locked", actual_pages, num_pages);
>   
>   			/* This is probably due to the process being killed */
>   			if (actual_pages > 0)
> @@ -404,8 +398,7 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
>   	struct page **pages = pagelistinfo->pages;
>   	unsigned int num_pages = pagelistinfo->num_pages;
>   
> -	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK, %d",
> -			__func__, pagelistinfo->pagelist, actual);
> +	dev_dbg(g_dev, "%pK, %d", pagelistinfo->pagelist, actual);
>   
>   	/*
>   	 * NOTE: dma_unmap_sg must be called before the
> @@ -519,7 +512,7 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
>   	*(char **)&g_fragments_base[i * g_fragments_size] = NULL;
>   	sema_init(&g_free_fragments_sema, MAX_FRAGMENTS);
>   
> -	err = vchiq_init_state(state, vchiq_slot_zero);
> +	err = vchiq_init_state(state, vchiq_slot_zero, dev);
>   	if (err)
>   		return err;

As Greg already suggested please move this kind of functional change 
into a separate patch. One goal is to have a single patch which almost 
replaces vchiq_log_* with dev_*

>   
> @@ -548,8 +541,8 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
>   	}
>   
>   	g_dev = dev;
> -	vchiq_log_info(vchiq_arm_log_level, "vchiq_init - done (slots %pK, phys %pad)",
> -		       vchiq_slot_zero, &slot_phys);
> +	dev_info(dev, "vchiq_init - done (slots %pK, phys %pad)",
> +		 vchiq_slot_zero, &slot_phys);
>   
>   	vchiq_call_connected_callbacks();
>   
> @@ -675,18 +668,16 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
>   		usleep_range(500, 600);
>   	}
>   	if (i == VCHIQ_INIT_RETRIES) {
> -		vchiq_log_error(vchiq_core_log_level, "%s: videocore not initialized\n", __func__);
> +		dev_err(g_dev, "videocore not initialized\n");
>   		ret = -ENOTCONN;
>   		goto failed;
>   	} else if (i > 0) {
> -		vchiq_log_warning(vchiq_core_log_level,
> -				  "%s: videocore initialized after %d retries\n", __func__, i);
> +		dev_warn(g_dev, "videocore initialized after %d retries\n", i);
>   	}
>   
>   	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
>   	if (!instance) {
> -		vchiq_log_error(vchiq_core_log_level,
> -				"%s: error allocating vchiq instance\n", __func__);
> +		dev_err(g_dev, "error allocating vchiq instance\n");
>   		ret = -ENOMEM;
>   		goto failed;
>   	}
> @@ -701,7 +692,7 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
>   	ret = 0;
>   
>   failed:
> -	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, ret);
> +	dev_dbg(g_dev, "instance=%p: returning %d", instance, ret);
>   
>   	return ret;
>   }
> @@ -714,8 +705,8 @@ void free_bulk_waiter(struct vchiq_instance *instance)
>   	list_for_each_entry_safe(waiter, next,
>   				 &instance->bulk_waiter_list, list) {
>   		list_del(&waiter->list);
> -		vchiq_log_info(vchiq_arm_log_level, "bulk_waiter - cleaned up %pK for pid %d",
> -			       waiter, waiter->pid);
> +		dev_info(instance->state->dev, "bulk_waiter - cleaned up %pK for pid %d",
> +			 waiter, waiter->pid);
>   		kfree(waiter);
>   	}
>   }
> @@ -733,7 +724,7 @@ enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance)
>   
>   	mutex_unlock(&state->mutex);
>   
> -	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
> +	dev_dbg(state->dev, "instance=%p: returning %d", instance, status);
>   
>   	free_bulk_waiter(instance);
>   	kfree(instance);
> @@ -753,7 +744,7 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
>   	struct vchiq_state *state = instance->state;
>   
>   	if (mutex_lock_killable(&state->mutex)) {
> -		vchiq_log_trace(vchiq_core_log_level, "%s: call to mutex_lock failed", __func__);
> +		dev_dbg(state->dev, "call to mutex_lock failed");
>   		status = VCHIQ_RETRY;
>   		goto failed;
>   	}
> @@ -765,7 +756,7 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
>   	mutex_unlock(&state->mutex);
>   
>   failed:
> -	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
> +	dev_dbg(state->dev, "instance=%p: returning %d", instance, status);
>   
>   	return status;
>   }
> @@ -796,7 +787,7 @@ vchiq_add_service(struct vchiq_instance *instance,
>   		status = VCHIQ_ERROR;
>   	}
>   
> -	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
> +	dev_dbg(state->dev, "instance=%p: returning %d", instance, status);
>   
>   	return status;
>   }
> @@ -827,7 +818,7 @@ vchiq_open_service(struct vchiq_instance *instance,
>   	}
>   
>   failed:
> -	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
> +	dev_dbg(state->dev, "instance=%p: returning %d", instance, status);
>   
>   	return status;
>   }
> @@ -954,7 +945,7 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
>   	} else {
>   		waiter = kzalloc(sizeof(*waiter), GFP_KERNEL);
>   		if (!waiter) {
> -			vchiq_log_error(vchiq_core_log_level, "%s - out of memory", __func__);
> +			dev_err(instance->state->dev, "out of memory");
>   			return VCHIQ_ERROR;
>   		}
>   	}
> @@ -977,8 +968,8 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
>   		mutex_lock(&instance->bulk_waiter_list_mutex);
>   		list_add(&waiter->list, &instance->bulk_waiter_list);
>   		mutex_unlock(&instance->bulk_waiter_list_mutex);
> -		vchiq_log_info(vchiq_arm_log_level, "saved bulk_waiter %pK for pid %d", waiter,
> -			       current->pid);
> +		dev_info(instance->state->dev, "saved bulk_waiter %pK for pid %d", waiter,
> +			 current->pid);
>   	}
>   
>   	return status;
> @@ -990,6 +981,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
>   	       void *bulk_userdata)
>   {
>   	struct vchiq_completion_data_kernel *completion;
> +	struct device *dev = instance->state->dev;
>   	int insert;
>   
>   	DEBUG_INITIALISE(g_state.local);
> @@ -998,13 +990,13 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
>   	while ((insert - instance->completion_remove) >= MAX_COMPLETIONS) {
>   		/* Out of space - wait for the client */
>   		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
> -		vchiq_log_trace(vchiq_arm_log_level, "%s - completion queue full", __func__);
> +		dev_dbg(dev, "completion queue full");
>   		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
>   		if (wait_for_completion_interruptible(&instance->remove_event)) {
> -			vchiq_log_info(vchiq_arm_log_level, "service_callback interrupted");
> +			dev_info(dev, "service_callback interrupted");
>   			return VCHIQ_RETRY;
>   		} else if (instance->closing) {
> -			vchiq_log_info(vchiq_arm_log_level, "service_callback closing");
> +			dev_info(dev, "service_callback closing");
>   			return VCHIQ_SUCCESS;
>   		}
>   		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
> @@ -1059,6 +1051,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
>   	struct vchiq_service *service;
>   	struct vchiq_instance *instance;
>   	bool skip_completion = false;
> +	struct device *dev;
>   
>   	DEBUG_INITIALISE(g_state.local);
>   
> @@ -1086,11 +1079,12 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
>   	vchiq_service_get(service);
>   	rcu_read_unlock();
>   
> -	vchiq_log_trace(vchiq_arm_log_level,
> -			"%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
> -			__func__, (unsigned long)user_service, service->localport,
> -			user_service->userdata, reason, (unsigned long)header,
> -			(unsigned long)instance, (unsigned long)bulk_userdata);
> +	dev = instance->state->dev;
> +
> +	dev_dbg(dev, "service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
> +		(unsigned long)user_service, service->localport,
> +		user_service->userdata, reason, (unsigned long)header,
> +		(unsigned long)instance, (unsigned long)bulk_userdata);
>   
>   	if (header && user_service->is_vchi) {
>   		spin_lock(&msg_queue_spinlock);
> @@ -1099,7 +1093,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
>   			spin_unlock(&msg_queue_spinlock);
>   			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
>   			DEBUG_COUNT(MSG_QUEUE_FULL_COUNT);
> -			vchiq_log_trace(vchiq_arm_log_level, "%s - msg queue full", __func__);
> +			dev_dbg(dev, "msg queue full");
>   			/*
>   			 * If there is no MESSAGE_AVAILABLE in the completion
>   			 * queue, add one
> @@ -1108,8 +1102,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
>   				instance->completion_remove) < 0) {
>   				enum vchiq_status status;
>   
> -				vchiq_log_info(vchiq_arm_log_level,
> -					       "Inserting extra MESSAGE_AVAILABLE");
> +				dev_info(dev, "Inserting extra MESSAGE_AVAILABLE");
>   				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
>   				status = add_completion(instance, reason, NULL, user_service,
>   							bulk_userdata);
> @@ -1122,12 +1115,12 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
>   
>   			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
>   			if (wait_for_completion_interruptible(&user_service->remove_event)) {
> -				vchiq_log_info(vchiq_arm_log_level, "%s interrupted", __func__);
> +				dev_info(dev, "%s interrupted", __func__);
>   				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
>   				vchiq_service_put(service);
>   				return VCHIQ_RETRY;
>   			} else if (instance->closing) {
> -				vchiq_log_info(vchiq_arm_log_level, "%s closing", __func__);
> +				dev_info(dev, "%s closing", __func__);
>   				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
>   				vchiq_service_put(service);
>   				return VCHIQ_ERROR;
> @@ -1322,7 +1315,7 @@ vchiq_keepalive_vchiq_callback(enum vchiq_reason reason,
>   			       struct vchiq_header *header,
>   			       unsigned int service_user, void *bulk_user)
>   {
> -	vchiq_log_error(vchiq_susp_log_level, "%s callback reason %d", __func__, reason);
> +	dev_err(g_dev, "callback reason %d", reason);
Oops, the function name get lost?
>   	return 0;
>   }
>   
> @@ -1332,6 +1325,8 @@ vchiq_keepalive_thread_func(void *v)
>   	struct vchiq_state *state = (struct vchiq_state *)v;
>   	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
>   
> +	struct device *dev = state->dev;
> +
>   	enum vchiq_status status;
>   	struct vchiq_instance *instance;
>   	unsigned int ka_handle;
> @@ -1346,22 +1341,19 @@ vchiq_keepalive_thread_func(void *v)
>   
>   	ret = vchiq_initialise(&instance);
>   	if (ret) {
> -		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_initialise failed %d", __func__,
> -				ret);
> +		dev_err(dev, "vchiq_initialise failed %d", ret);
>   		goto exit;
>   	}
>   
>   	status = vchiq_connect(instance);
>   	if (status != VCHIQ_SUCCESS) {
> -		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_connect failed %d", __func__,
> -				status);
> +		dev_err(dev, "vchiq_connect failed %d", status);
>   		goto shutdown;
>   	}
>   
>   	status = vchiq_add_service(instance, &params, &ka_handle);
>   	if (status != VCHIQ_SUCCESS) {
> -		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_open_service failed %d", __func__,
> -				status);
> +		dev_err(dev, "vchiq_open_service failed %d", status);
>   		goto shutdown;
>   	}
>   
> @@ -1369,7 +1361,7 @@ vchiq_keepalive_thread_func(void *v)
>   		long rc = 0, uc = 0;
>   
>   		if (wait_for_completion_interruptible(&arm_state->ka_evt)) {
> -			vchiq_log_error(vchiq_susp_log_level, "%s interrupted", __func__);
> +			dev_err(dev, "interrupted");
>   			flush_signals(current);
>   			continue;
>   		}
> @@ -1389,16 +1381,13 @@ vchiq_keepalive_thread_func(void *v)
>   			atomic_inc(&arm_state->ka_use_ack_count);
>   			status = vchiq_use_service(ka_handle);
>   			if (status != VCHIQ_SUCCESS) {
> -				vchiq_log_error(vchiq_susp_log_level,
> -						"%s vchiq_use_service error %d", __func__, status);
> +				dev_err(dev, "vchiq_use_service error %d", status);
>   			}
>   		}
>   		while (rc--) {
>   			status = vchiq_release_service(ka_handle);
>   			if (status != VCHIQ_SUCCESS) {
> -				vchiq_log_error(vchiq_susp_log_level,
> -						"%s vchiq_release_service error %d", __func__,
> -						status);
> +				dev_err(dev, "vchiq_release_service error %d", status);
>   			}
>   		}
>   	}
> @@ -1433,7 +1422,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
>   			service->client_id);
>   		entity_uc = &service->service_use_count;
>   	} else {
> -		vchiq_log_error(vchiq_susp_log_level, "%s null service ptr", __func__);
> +		dev_err(state->dev, "null service ptr");
>   		ret = -EINVAL;
>   		goto out;
>   	}
> @@ -1442,8 +1431,8 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
>   	local_uc = ++arm_state->videocore_use_count;
>   	++(*entity_uc);
>   
> -	vchiq_log_trace(vchiq_susp_log_level, "%s %s count %d, state count %d", __func__, entity,
> -			*entity_uc, local_uc);
> +	dev_dbg(state->dev, "%s count %d, state count %d", entity,
> +		*entity_uc, local_uc);
>   
>   	write_unlock_bh(&arm_state->susp_res_lock);
>   
> @@ -1462,7 +1451,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
>   	}
>   
>   out:
> -	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, ret);
> +	dev_dbg(state->dev, "exit %d", ret);
>   	return ret;
>   }
>   
> @@ -1500,14 +1489,14 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
>   	--arm_state->videocore_use_count;
>   	--(*entity_uc);
>   
> -	vchiq_log_trace(vchiq_susp_log_level, "%s %s count %d, state count %d", __func__, entity,
> -			*entity_uc, arm_state->videocore_use_count);
> +	dev_dbg(state->dev, "%s count %d, state count %d", entity,
> +		*entity_uc, arm_state->videocore_use_count);
>   
>   unlock:
>   	write_unlock_bh(&arm_state->susp_res_lock);
>   
>   out:
> -	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, ret);
> +	dev_dbg(state->dev, "exit %d", ret);
>   	return ret;
>   }
>   
> @@ -1681,18 +1670,17 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
>   	read_unlock_bh(&arm_state->susp_res_lock);
>   
>   	if (only_nonzero)
> -		vchiq_log_warning(vchiq_susp_log_level, "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
> -				  active_services, found);
> +		dev_warn(state->dev, "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
> +			 active_services, found);
>   
>   	for (i = 0; i < found; i++) {
> -		vchiq_log_warning(vchiq_susp_log_level, "----- %c%c%c%c:%d service count %d %s",
> -				  VCHIQ_FOURCC_AS_4CHARS(service_data[i].fourcc),
> -				  service_data[i].clientid, service_data[i].use_count,
> -				  service_data[i].use_count ? nz : "");
> +		dev_warn(state->dev, "----- %c%c%c%c:%d service count %d %s",
> +			 VCHIQ_FOURCC_AS_4CHARS(service_data[i].fourcc),
> +			 service_data[i].clientid, service_data[i].use_count,
> +			 service_data[i].use_count ? nz : "");
>   	}
> -	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count %d", peer_count);
> -	vchiq_log_warning(vchiq_susp_log_level, "--- Overall vchiq instance use count %d",
> -			  vc_use_count);
> +	dev_warn(state->dev, "----- VCHIQ use count %d", peer_count);
> +	dev_warn(state->dev, "--- Overall vchiq instance use count %d", vc_use_count);
>   
>   	kfree(service_data);
>   }
> @@ -1714,10 +1702,10 @@ vchiq_check_service(struct vchiq_service *service)
>   	read_unlock_bh(&arm_state->susp_res_lock);
>   
>   	if (ret == VCHIQ_ERROR) {
> -		vchiq_log_error(vchiq_susp_log_level,
> -				"%s ERROR - %c%c%c%c:%d service count %d, state count %d", __func__,
> -				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
> -				service->service_use_count, arm_state->videocore_use_count);
> +		dev_err(service->state->dev,
> +			"ERROR - %c%c%c%c:%d service count %d, state count %d",
> +			VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
> +			service->service_use_count, arm_state->videocore_use_count);
>   		vchiq_dump_service_use_state(service->state);
>   	}
>   out:
> @@ -1731,8 +1719,8 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
>   	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
>   	char threadname[16];
>   
> -	vchiq_log_info(vchiq_susp_log_level, "%d: %s->%s", state->id,
> -		       get_conn_state_name(oldstate), get_conn_state_name(newstate));
> +	dev_dbg(state->dev, "%d: %s->%s", state->id,
> +		get_conn_state_name(oldstate), get_conn_state_name(newstate));
This changes the log level from info to dbg. If this is really intented, 
make it a separate patch with a explanation why this is necessary.
>   	if (state->conn_state != VCHIQ_CONNSTATE_CONNECTED)
>   		return;
>   
> @@ -1750,9 +1738,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
>   					      (void *)state,
>   					      threadname);
>   	if (IS_ERR(arm_state->ka_thread)) {
> -		vchiq_log_error(vchiq_susp_log_level,
> -				"vchiq: FATAL: couldn't create thread %s",
> -				threadname);
> +		dev_err(state->dev, "vchiq: FATAL: couldn't create thread %s", threadname);
>   	} else {
>   		wake_up_process(arm_state->ka_thread);
>   	}
> @@ -1819,9 +1805,9 @@ static int vchiq_probe(struct platform_device *pdev)
>   
>   	vchiq_debugfs_init();
>   
> -	vchiq_log_info(vchiq_arm_log_level,
> -		       "vchiq: platform initialised - version %d (min %d)",
> -		       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
> +	dev_info(&pdev->dev,
> +		 "vchiq: platform initialised - version %d (min %d)",
> +		 VCHIQ_VERSION, VCHIQ_VERSION_MIN);
>   
>   	/*
>   	 * Simply exit on error since the function handles cleanup in
> @@ -1829,8 +1815,7 @@ static int vchiq_probe(struct platform_device *pdev)
>   	 */
>   	err = vchiq_register_chrdev(&pdev->dev);
>   	if (err) {
> -		vchiq_log_warning(vchiq_arm_log_level,
> -				  "Failed to initialize vchiq cdev");
> +		dev_warn(&pdev->dev, "Failed to initialize vchiq cdev");
>   		goto error_exit;
>   	}
>   
> @@ -1840,7 +1825,7 @@ static int vchiq_probe(struct platform_device *pdev)
>   	return 0;
>   
>   failed_platform_init:
> -	vchiq_log_warning(vchiq_arm_log_level, "could not initialize vchiq platform");
> +	dev_warn(&pdev->dev, "could not initialize vchiq platform");
>   error_exit:
>   	return err;
>   }
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> index bdb0ab617d8b..fa9395eb8f7f 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> @@ -27,7 +27,7 @@ static void connected_init(void)
>    * be made immediately, otherwise it will be deferred until
>    * vchiq_call_connected_callbacks is called.
>    */
> -void vchiq_add_connected_callback(void (*callback)(void))
> +void vchiq_add_connected_callback(struct device *dev, void (*callback)(void))
>   {
>   	connected_init();
>   
> @@ -39,9 +39,8 @@ void vchiq_add_connected_callback(void (*callback)(void))
>   		callback();
>   	} else {
>   		if (g_num_deferred_callbacks >= MAX_CALLBACKS) {
> -			vchiq_log_error(vchiq_core_log_level,
> -					"There already %d callback registered - please increase MAX_CALLBACKS",
> -					g_num_deferred_callbacks);
> +			dev_err(dev, "There already %d callback registered - please increase MAX_CALLBACKS",
> +				g_num_deferred_callbacks);
>   		} else {
>   			g_deferred_callback[g_num_deferred_callbacks] =
>   				callback;
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
> index 4caf5e30099d..355fe9d0f068 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
> @@ -4,7 +4,9 @@
>   #ifndef VCHIQ_CONNECTED_H
>   #define VCHIQ_CONNECTED_H
>   
> -void vchiq_add_connected_callback(void (*callback)(void));
> +#include <linux/device.h>
> +
> +void vchiq_add_connected_callback(struct device *dev, void (*callback)(void));
>   void vchiq_call_connected_callbacks(void);
>   
>   #endif /* VCHIQ_CONNECTED_H */
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 8f99272dbd6f..5997c64ad8b9 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -12,7 +12,9 @@
>   #include <linux/kref.h>
>   #include <linux/rcupdate.h>
>   #include <linux/sched/signal.h>
> +#include <linux/dev_printk.h>
>   
> +#include "vchiq_arm.h"
>   #include "vchiq_core.h"
>   
>   #define VCHIQ_SLOT_HANDLER_STACK 8192
> @@ -102,10 +104,7 @@ static_assert((unsigned int)VCHIQ_PORT_MAX <
>   
>   #define BULK_INDEX(x) ((x) & (VCHIQ_NUM_SERVICE_BULKS - 1))
>   
> -#define SRVTRACE_LEVEL(srv) \
> -	(((srv) && (srv)->trace) ? VCHIQ_LOG_TRACE : vchiq_core_msg_log_level)
> -#define SRVTRACE_ENABLED(srv, lev) \
> -	(((srv) && (srv)->trace) || (vchiq_core_msg_log_level >= (lev)))
> +#define SRVTRACE_ENABLED(srv) ((srv) && (srv)->trace)
>   
>   #define NO_CLOSE_RECVD	0
>   #define CLOSE_RECVD	1
> @@ -153,11 +152,6 @@ static inline void check_sizes(void)
>   	BUILD_BUG_ON_NOT_POWER_OF_2(VCHIQ_MAX_SERVICES);
>   }
>   
> -/* Run time control of log level, based on KERN_XXX level. */
> -int vchiq_core_log_level = VCHIQ_LOG_DEFAULT;
> -int vchiq_core_msg_log_level = VCHIQ_LOG_DEFAULT;
> -int vchiq_sync_log_level = VCHIQ_LOG_DEFAULT;
> -
>   DEFINE_SPINLOCK(bulk_waiter_spinlock);
>   static DEFINE_SPINLOCK(quota_spinlock);
>   
> @@ -227,10 +221,10 @@ static const char *msg_type_str(unsigned int msg_type)
>   static inline void
>   set_service_state(struct vchiq_service *service, int newstate)
>   {
> -	vchiq_log_info(vchiq_core_log_level, "%d: srv:%d %s->%s",
> -		       service->state->id, service->localport,
> -		       srvstate_names[service->srvstate],
> -		       srvstate_names[newstate]);
> +	dev_dbg(service->state->dev, "%d: srv:%d %s->%s",
> +		service->state->id, service->localport,
> +		srvstate_names[service->srvstate],
> +		srvstate_names[newstate]);
>   	service->srvstate = newstate;
>   }
>   
> @@ -249,8 +243,7 @@ find_service_by_handle(unsigned int handle)
>   		return service;
>   	}
>   	rcu_read_unlock();
> -	vchiq_log_info(vchiq_core_log_level,
> -		       "Invalid service handle 0x%x", handle);
> +	dev_info(vchiq_states[0]->dev, "Invalid service handle 0x%x", handle);
>   	return NULL;
>   }
>   
> @@ -270,8 +263,7 @@ find_service_by_port(struct vchiq_state *state, unsigned int localport)
>   		}
>   		rcu_read_unlock();
>   	}
> -	vchiq_log_info(vchiq_core_log_level,
> -		       "Invalid port %u", localport);
> +	dev_info(state->dev, "Invalid port %u", localport);
>   	return NULL;
>   }
>   
> @@ -291,8 +283,7 @@ find_service_for_instance(struct vchiq_instance *instance, unsigned int handle)
>   		return service;
>   	}
>   	rcu_read_unlock();
> -	vchiq_log_info(vchiq_core_log_level,
> -		       "Invalid service handle 0x%x", handle);
> +	dev_info(instance->state->dev, "Invalid service handle 0x%x", handle);
>   	return NULL;
>   }
>   
> @@ -314,8 +305,7 @@ find_closed_service_for_instance(struct vchiq_instance *instance, unsigned int h
>   		return service;
>   	}
>   	rcu_read_unlock();
> -	vchiq_log_info(vchiq_core_log_level,
> -		       "Invalid service handle 0x%x", handle);
> +	dev_info(instance->state->dev, "Invalid service handle 0x%x", handle);
>   	return service;
>   }
>   
> @@ -463,14 +453,14 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
>   {
>   	enum vchiq_status status;
>   
> -	vchiq_log_trace(vchiq_core_log_level, "%d: callback:%d (%s, %pK, %pK)",
> -			service->state->id, service->localport, reason_names[reason],
> -			header, bulk_userdata);
> +	dev_dbg(service->state->dev, "%d: callback:%d (%s, %pK, %pK)",
> +		service->state->id, service->localport, reason_names[reason],
> +		header, bulk_userdata);
>   	status = service->base.callback(reason, header, service->handle, bulk_userdata);
>   	if (status == VCHIQ_ERROR) {
> -		vchiq_log_warning(vchiq_core_log_level,
> -				  "%d: ignoring ERROR from callback to service %x",
> -				  service->state->id, service->handle);
> +		dev_warn(service->state->dev,
> +			 "%d: ignoring ERROR from callback to service %x",
> +			 service->state->id, service->handle);
>   		status = VCHIQ_SUCCESS;
>   	}
>   
> @@ -485,8 +475,8 @@ vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate)
>   {
>   	enum vchiq_connstate oldstate = state->conn_state;
>   
> -	vchiq_log_info(vchiq_core_log_level, "%d: %s->%s", state->id, conn_state_names[oldstate],
> -		       conn_state_names[newstate]);
> +	dev_dbg(state->dev, "%d: %s->%s", state->id, conn_state_names[oldstate],
> +		conn_state_names[newstate]);
>   	state->conn_state = newstate;
>   	vchiq_platform_conn_state_changed(state, oldstate, newstate);
>   }
> @@ -732,10 +722,10 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
>   		 */
>   		complete(&quota->quota_event);
>   	} else if (count == 0) {
> -		vchiq_log_error(vchiq_core_log_level,
> -				"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
> -				port, quota->message_use_count, header, msgid, header->msgid,
> -				header->size);
> +		dev_err(state->dev,
> +			"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
> +			port, quota->message_use_count, header, msgid, header->msgid,
> +			header->size);
>   		WARN(1, "invalid message use count\n");
>   	}
>   	if (!BITSET_IS_SET(service_found, port)) {
> @@ -754,12 +744,12 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
>   			 * it has dropped below its quota
>   			 */
>   			complete(&quota->quota_event);
> -			vchiq_log_trace(vchiq_core_log_level, "%d: pfq:%d %x@%pK - slot_use->%d",
> -					state->id, port, header->size, header, count - 1);
> +			dev_dbg(state->dev, "%d: pfq:%d %x@%pK - slot_use->%d",
> +				state->id, port, header->size, header, count - 1);
>   		} else {
> -			vchiq_log_error(vchiq_core_log_level,
> -					"service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
> -					port, count, header, msgid, header->msgid, header->size);
> +			dev_err(state->dev,
> +				"service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
> +				port, count, header, msgid, header->msgid, header->size);
>   			WARN(1, "bad slot use count\n");
>   		}
>   	}
> @@ -800,9 +790,9 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
>   		 */
>   		rmb();
>   
> -		vchiq_log_trace(vchiq_core_log_level, "%d: pfq %d=%pK %x %x",
> -				state->id, slot_index, data, local->slot_queue_recycle,
> -				slot_queue_available);
> +		dev_dbg(state->dev, "%d: pfq %d=%pK %x %x",
> +			state->id, slot_index, data, local->slot_queue_recycle,
> +			slot_queue_available);
>   
>   		/* Initialise the bitmask for services which have used this slot */
>   		memset(service_found, 0, length);
> @@ -822,9 +812,9 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
>   
>   			pos += calc_stride(header->size);
>   			if (pos > VCHIQ_SLOT_SIZE) {
> -				vchiq_log_error(vchiq_core_log_level,
> -						"pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
> -						pos, header, msgid, header->msgid, header->size);
> +				dev_err(state->dev,
> +					"pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
> +					pos, header, msgid, header->msgid, header->size);
>   				WARN(1, "invalid slot position\n");
>   			}
>   		}
> @@ -971,10 +961,9 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
>   		       ((tx_end_index != quota->previous_tx_index) &&
>   			(quota->slot_use_count == quota->slot_quota))) {
>   			spin_unlock(&quota_spinlock);
> -			vchiq_log_trace(vchiq_core_log_level,
> -					"%d: qm:%d %s,%zx - quota stall (msg %d, slot %d)",
> -					state->id, service->localport, msg_type_str(type), size,
> -					quota->message_use_count, quota->slot_use_count);
> +			dev_dbg(state->dev, "%d: qm:%d %s,%zx - quota stall (msg %d, slot %d)",
> +				state->id, service->localport, msg_type_str(type), size,
> +				quota->message_use_count, quota->slot_use_count);
>   			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
>   			mutex_unlock(&state->slot_mutex);
>   			if (wait_for_completion_interruptible(&quota->quota_event))
> @@ -1014,9 +1003,9 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
>   		int tx_end_index;
>   		int slot_use_count;
>   
> -		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
> -			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
> -			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
> +		dev_dbg(state->dev, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
> +			msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
> +			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
>   
>   		WARN_ON(flags & (QMFLAGS_NO_MUTEX_LOCK |
>   				 QMFLAGS_NO_MUTEX_UNLOCK));
> @@ -1031,8 +1020,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
>   			return VCHIQ_ERROR;
>   		}
>   
> -		if (SRVTRACE_ENABLED(service,
> -				     VCHIQ_LOG_INFO))
> +		if (SRVTRACE_ENABLED(service))
This kind of change should be also a separate patch.
>   			vchiq_log_dump_mem("Sent", 0,
>   					   header->data,
>   					   min_t(size_t, 16, callback_result));
> @@ -1066,17 +1054,16 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
>   		spin_unlock(&quota_spinlock);
>   
>   		if (slot_use_count)
> -			vchiq_log_trace(vchiq_core_log_level,
> -					"%d: qm:%d %s,%zx - slot_use->%d (hdr %p)", state->id,
> -					service->localport, msg_type_str(VCHIQ_MSG_TYPE(msgid)),
> -					size, slot_use_count, header);
> +			dev_dbg(state->dev, "%d: qm:%d %s,%zx - slot_use->%d (hdr %p)", state->id,
> +				service->localport, msg_type_str(VCHIQ_MSG_TYPE(msgid)),
> +				size, slot_use_count, header);
>   
>   		VCHIQ_SERVICE_STATS_INC(service, ctrl_tx_count);
>   		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
>   	} else {
> -		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
> -			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
> -			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
> +		dev_dbg(state->dev, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
> +			msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
> +			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
>   		if (size != 0) {
>   			/*
>   			 * It is assumed for now that this code path
> @@ -1104,11 +1091,11 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
>   			? service->base.fourcc
>   			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
>   
> -		vchiq_log_info(SRVTRACE_LEVEL(service),
> -			       "Sent Msg %s(%u) to %c%c%c%c s:%u d:%d len:%zu",
> -			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
> -			       VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
> -			       VCHIQ_MSG_DSTPORT(msgid), size);
> +		dev_dbg(state->dev,
> +			"Sent Msg %s(%u) to %c%c%c%c s:%u d:%d len:%zu",
> +			msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
> +			VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
> +			VCHIQ_MSG_DSTPORT(msgid), size);
>   	}
>   
>   	/* Make sure the new header is visible to the peer. */
> @@ -1140,6 +1127,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
>   	struct vchiq_shared_state *local;
>   	struct vchiq_header *header;
>   	ssize_t callback_result;
> +	int svc_fourcc;
>   
>   	local = state->local;
>   
> @@ -1158,15 +1146,15 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
>   		int oldmsgid = header->msgid;
>   
>   		if (oldmsgid != VCHIQ_MSGID_PADDING)
> -			vchiq_log_error(vchiq_core_log_level, "%d: qms - msgid %x, not PADDING",
> -					state->id, oldmsgid);
> +			dev_err(state->dev, "%d: qms - msgid %x, not PADDING",
> +				state->id, oldmsgid);
>   	}
>   
> -	vchiq_log_info(vchiq_sync_log_level,
> -		       "%d: qms %s@%pK,%x (%d->%d)", state->id,
> -		       msg_type_str(VCHIQ_MSG_TYPE(msgid)),
> -		       header, size, VCHIQ_MSG_SRCPORT(msgid),
> -		       VCHIQ_MSG_DSTPORT(msgid));
> +	dev_dbg(state->dev,
> +		"%d: qms %s@%pK,%x (%d->%d)", state->id,
> +		msg_type_str(VCHIQ_MSG_TYPE(msgid)),
> +		header, size, VCHIQ_MSG_SRCPORT(msgid),
> +		VCHIQ_MSG_DSTPORT(msgid));
>   
>   	callback_result =
>   		copy_message_data(copy_callback, context,
> @@ -1179,8 +1167,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
>   	}
>   
>   	if (service) {
> -		if (SRVTRACE_ENABLED(service,
> -				     VCHIQ_LOG_INFO))
> +		if (SRVTRACE_ENABLED(service))
>   			vchiq_log_dump_mem("Sent", 0,
>   					   header->data,
>   					   min_t(size_t, 16, callback_result));
> @@ -1194,19 +1181,14 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
>   	header->size = size;
>   	header->msgid = msgid;
>   
> -	if (vchiq_sync_log_level >= VCHIQ_LOG_TRACE) {
> -		int svc_fourcc;
> +	svc_fourcc = service
> +		? service->base.fourcc
> +		: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
>   
> -		svc_fourcc = service
> -			? service->base.fourcc
> -			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
> -
> -		vchiq_log_trace(vchiq_sync_log_level,
> -				"Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
> -				msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
> -				VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
> -				VCHIQ_MSG_DSTPORT(msgid), size);
> -	}
> +	dev_dbg(state->dev, "Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
> +		msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
> +		VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
> +		VCHIQ_MSG_DSTPORT(msgid), size);
>   
>   	remote_event_signal(&state->remote->sync_trigger);
>   
> @@ -1258,9 +1240,9 @@ release_slot(struct vchiq_state *state, struct vchiq_slot_info *slot_info,
>   			VCHIQ_SLOT_QUEUE_MASK] =
>   			SLOT_INDEX_FROM_INFO(state, slot_info);
>   		state->remote->slot_queue_recycle = slot_queue_recycle + 1;
> -		vchiq_log_info(vchiq_core_log_level, "%d: %s %d - recycle->%x", state->id, __func__,
> -			       SLOT_INDEX_FROM_INFO(state, slot_info),
> -			       state->remote->slot_queue_recycle);
> +		dev_dbg(state->dev, "%d: %d - recycle->%x", state->id,
> +			SLOT_INDEX_FROM_INFO(state, slot_info),
> +			state->remote->slot_queue_recycle);
>   
>   		/*
>   		 * A write barrier is necessary, but remote_event_signal
> @@ -1295,9 +1277,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
>   {
>   	enum vchiq_status status = VCHIQ_SUCCESS;
>   
> -	vchiq_log_trace(vchiq_core_log_level, "%d: nb:%d %cx - p=%x rn=%x r=%x", service->state->id,
> -			service->localport, (queue == &service->bulk_tx) ? 't' : 'r',
> -			queue->process, queue->remote_notify, queue->remove);
> +	dev_dbg(service->state->dev, "%d: nb:%d %cx - p=%x rn=%x r=%x", service->state->id,
> +		service->localport, (queue == &service->bulk_tx) ? 't' : 'r',
> +		queue->process, queue->remote_notify, queue->remove);
>   
>   	queue->remote_notify = queue->process;
>   
> @@ -1377,9 +1359,9 @@ poll_services_of_group(struct vchiq_state *state, int group)
>   
>   		service_flags = atomic_xchg(&service->poll_flags, 0);
>   		if (service_flags & BIT(VCHIQ_POLL_REMOVE)) {
> -			vchiq_log_info(vchiq_core_log_level, "%d: ps - remove %d<->%d",
> -				       state->id, service->localport,
> -				       service->remoteport);
> +			dev_dbg(state->dev, "%d: ps - remove %d<->%d",
> +				state->id, service->localport,
> +				service->remoteport);
>   
>   			/*
>   			 * Make it look like a client, because
> @@ -1392,8 +1374,8 @@ poll_services_of_group(struct vchiq_state *state, int group)
>   							 VCHIQ_SUCCESS)
>   				request_poll(state, service, VCHIQ_POLL_REMOVE);
>   		} else if (service_flags & BIT(VCHIQ_POLL_TERMINATE)) {
> -			vchiq_log_info(vchiq_core_log_level, "%d: ps - terminate %d<->%d",
> -				       state->id, service->localport, service->remoteport);
> +			dev_dbg(state->dev, "%d: ps - terminate %d<->%d",
> +				state->id, service->localport, service->remoteport);
>   			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD) != VCHIQ_SUCCESS)
>   				request_poll(state, service, VCHIQ_POLL_TERMINATE);
>   		}
> @@ -1422,9 +1404,9 @@ abort_outstanding_bulks(struct vchiq_service *service,
>   {
>   	int is_tx = (queue == &service->bulk_tx);
>   
> -	vchiq_log_trace(vchiq_core_log_level, "%d: aob:%d %cx - li=%x ri=%x p=%x",
> -			service->state->id, service->localport, is_tx ? 't' : 'r',
> -			queue->local_insert, queue->remote_insert, queue->process);
> +	dev_dbg(service->state->dev, "%d: aob:%d %cx - li=%x ri=%x p=%x",
> +		service->state->id, service->localport, is_tx ? 't' : 'r',
> +		queue->local_insert, queue->remote_insert, queue->process);
>   
>   	WARN_ON((int)(queue->local_insert - queue->process) < 0);
>   	WARN_ON((int)(queue->remote_insert - queue->process) < 0);
> @@ -1443,11 +1425,11 @@ abort_outstanding_bulks(struct vchiq_service *service,
>   		if (queue->process != queue->local_insert) {
>   			vchiq_complete_bulk(bulk);
>   
> -			vchiq_log_info(SRVTRACE_LEVEL(service),
> -				       "%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
> -				       is_tx ? "Send Bulk to" : "Recv Bulk from",
> -				       VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
> -				       service->remoteport, bulk->size, bulk->remote_size);
> +			dev_dbg(service->state->dev,
> +				"%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
> +				is_tx ? "Send Bulk to" : "Recv Bulk from",
> +				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
> +				service->remoteport, bulk->size, bulk->remote_size);
>   		} else {
>   			/* fabricate a matching dummy bulk */
>   			bulk->data = 0;
> @@ -1480,8 +1462,8 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
>   
>   	payload = (struct vchiq_open_payload *)header->data;
>   	fourcc = payload->fourcc;
> -	vchiq_log_info(vchiq_core_log_level, "%d: prs OPEN@%pK (%d->'%c%c%c%c')",
> -		       state->id, header, localport, VCHIQ_FOURCC_AS_4CHARS(fourcc));
> +	dev_dbg(state->dev, "%d: prs OPEN@%pK (%d->'%c%c%c%c')",
> +		state->id, header, localport, VCHIQ_FOURCC_AS_4CHARS(fourcc));
>   
>   	service = get_listening_service(state, fourcc);
>   	if (!service)
> @@ -1493,11 +1475,9 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
>   
>   	if ((service->version < version_min) || (version < service->version_min)) {
>   		/* Version mismatch */
> -		vchiq_loud_error_header();

Please try to drop all irreplaceable function at first.

Best regards


