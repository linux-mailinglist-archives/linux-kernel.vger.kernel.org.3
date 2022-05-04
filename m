Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F3251A31F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351877AbiEDPJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiEDPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:09:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB56621270
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:05:37 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8xwu-1niOQ103CY-0065BX; Wed, 04 May 2022 17:05:15 +0200
Message-ID: <8483a250-da97-1875-4ea3-598f46ae96ce@i2se.com>
Date:   Wed, 4 May 2022 17:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] staging: vchiq_arm: get rid of global device
 structure
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220502183045.206519-1-athierry@redhat.com>
 <20220502183045.206519-3-athierry@redhat.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220502183045.206519-3-athierry@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/eh3A9gnaFsLISMqsCxrMtAOywW8i/nrL4adGdA8ukouKAwnMMn
 EjNxsGm0Rq84wyuGXUZ0mV6xKd0dLTk4pOCOX3/vg5u4CRpx06W9LD9caF5O382/H8GSftf
 6qSLuJZN5R8WIx2ZDIkB16AX8TbUmHdMauTMVJMGm2HE+QYO/YkRHMOw670tysxGF+c2VYq
 IZoYGaa3+74EyzkXfJOPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/vx04fP0rKE=:5Ci8EXYukI2eo+7u538x/R
 9X2eFvMJhpzTpRzLtjNYF5mVv9SIWvJ5ObRyfmJLagbo+rIbeN0BSM5ABaZvNHpB1rz+Ifu6J
 Re204JlJzQExlBFaH3RByBbaVZpagqd5PUdDPu/ZP1Jx1oipO9R48rR1CGxGht3eQRiEkbj4q
 E0GE5XxvgOo8BzvmwQz0iA7sOfEfVXCVZRzHXT9slGjlL2Mipdz91aj4dBaPrkGU+EGa/YPdV
 QNanbZNvahiIRhLqzE5Wzp4Cg9UvprxcSttswHM+xB9REgUOOxwgM/ImVQ4j3pIRORqmNl1lD
 ewhg0xvrKV72sCEJlr2481bb0DjRqK0qGVf1XMXnF/WmRfYOHsqBiZnkTpHZuQms0LdnCQRfC
 vp4G2K2ShLw23erqptY3q/Z8nUtA7CZk09B7pQ830MnouTipFKIccz5FHa1ymxiPoQh5cFnte
 vYdHtUw2zRrxhBOgYAxgjdMA0dqQFjTILAIAtS533+C2clCa4zFFvmFJoKTxcK7wbjcump0dN
 wIPWxaYgQjFnLF07xoAfSshpyD06rl/q3Wm9xQX3Idc0ZxVS6MIZ9wGY3nBF6DeCcwnsCNgfX
 UYVJPAUj8M9vY3eggUe/3a34S/lcRlgL1fDTSDbvRFUCvFNxUGUTRpwd5NMKhSrMMHjDV8w50
 Yvcd/aKjgphjAS6FlUEEf3ljA7jvQyV+GwVR8IJzShLPnXmUnRqbMWsUcrPI+2Rp4uCQ4qsVu
 45uY9a14hoVinNgs
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

Am 02.05.22 um 20:30 schrieb Adrien Thierry:
> Get rid of the global g_dev structure.

i understand the motivation, but could you please explain more in detail 
why you decided to add vchiq_instance instead of device reference? I 
think vchiq_instance is a more internal structure which should be 
avoided in kernel consumers like bcm2835-audio or mmal.

Best regards

>
> This is part of an effort to address TODO item "Get rid of all non
> essential global structures and create a proper per device structure"
>
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
>   .../bcm2835-audio/bcm2835-vchiq.c             |  7 ++-
>   .../include/linux/raspberrypi/vchiq.h         | 12 ++--
>   .../interface/vchiq_arm/vchiq_arm.c           | 63 +++++++++----------
>   .../interface/vchiq_arm/vchiq_core.c          | 14 ++---
>   .../interface/vchiq_arm/vchiq_core.h          | 10 +--
>   .../interface/vchiq_arm/vchiq_dev.c           |  2 +-
>   .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  2 +-
>   7 files changed, 53 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> index e429b33b4d39..701abe430877 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> @@ -322,6 +322,8 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
>   			unsigned int size, void *src)
>   {
>   	struct bcm2835_audio_instance *instance = alsa_stream->instance;
> +	struct bcm2835_vchi_ctx *vchi_ctx = alsa_stream->chip->vchi_ctx;
> +	struct vchiq_instance *vchiq_instance = vchi_ctx->instance;
>   	struct vc_audio_msg m = {
>   		.type = VC_AUDIO_MSG_TYPE_WRITE,
>   		.write.count = size,
> @@ -343,9 +345,8 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
>   	count = size;
>   	if (!instance->max_packet) {
>   		/* Send the message to the videocore */
> -		status = vchiq_bulk_transmit(instance->service_handle, src,
> -					     count, NULL,
> -					     VCHIQ_BULK_MODE_BLOCKING);
> +		status = vchiq_bulk_transmit(vchiq_instance, instance->service_handle, src, count,
> +					     NULL, VCHIQ_BULK_MODE_BLOCKING);
>   	} else {
>   		while (count > 0) {
>   			int bytes = min(instance->max_packet, count);
> diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> index c93f2f3e87bb..715f02e7f1e1 100644
> --- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> +++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> @@ -96,12 +96,12 @@ extern void           vchiq_release_message(unsigned int service,
>   	struct vchiq_header *header);
>   extern int vchiq_queue_kernel_message(unsigned int handle, void *data,
>   				      unsigned int size);
> -extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
> -	const void *data, unsigned int size, void *userdata,
> -	enum vchiq_bulk_mode mode);
> -extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
> -	void *data, unsigned int size, void *userdata,
> -	enum vchiq_bulk_mode mode);
> +extern enum vchiq_status vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int service,
> +					     const void *data, unsigned int size, void *userdata,
> +					     enum vchiq_bulk_mode mode);
> +extern enum vchiq_status vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int service,
> +					    void *data, unsigned int size, void *userdata,
> +					    enum vchiq_bulk_mode mode);
>   extern void *vchiq_get_service_userdata(unsigned int service);
>   extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
>   	short *peer_version);
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index e6e0737c85fc..3b447c635c3f 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -148,12 +148,11 @@ static unsigned int g_fragments_size;
>   static char *g_fragments_base;
>   static char *g_free_fragments;
>   static struct semaphore g_free_fragments_sema;
> -static struct device *g_dev;
>   
>   static DEFINE_SEMAPHORE(g_free_fragments_mutex);
>   
>   static enum vchiq_status
> -vchiq_blocking_bulk_transfer(unsigned int handle, void *data,
> +vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
>   			     unsigned int size, enum vchiq_bulk_dir dir);
>   
>   static irqreturn_t
> @@ -175,17 +174,17 @@ vchiq_doorbell_irq(int irq, void *dev_id)
>   }
>   
>   static void
> -cleanup_pagelistinfo(struct vchiq_pagelist_info *pagelistinfo)
> +cleanup_pagelistinfo(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagelistinfo)
>   {
>   	if (pagelistinfo->scatterlist_mapped) {
> -		dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
> +		dma_unmap_sg(instance->state->dev, pagelistinfo->scatterlist,
>   			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
>   	}
>   
>   	if (pagelistinfo->pages_need_release)
>   		unpin_user_pages(pagelistinfo->pages, pagelistinfo->num_pages);
>   
> -	dma_free_coherent(g_dev, pagelistinfo->pagelist_buffer_size,
> +	dma_free_coherent(instance->state->dev, pagelistinfo->pagelist_buffer_size,
>   			  pagelistinfo->pagelist, pagelistinfo->dma_addr);
>   }
>   
> @@ -212,7 +211,7 @@ is_adjacent_block(u32 *addrs, u32 addr, unsigned int k)
>    */
>   
>   static struct vchiq_pagelist_info *
> -create_pagelist(char *buf, char __user *ubuf,
> +create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
>   		size_t count, unsigned short type)
>   {
>   	struct pagelist *pagelist;
> @@ -250,7 +249,7 @@ create_pagelist(char *buf, char __user *ubuf,
>   	/* Allocate enough storage to hold the page pointers and the page
>   	 * list
>   	 */
> -	pagelist = dma_alloc_coherent(g_dev, pagelist_size, &dma_addr,
> +	pagelist = dma_alloc_coherent(instance->state->dev, pagelist_size, &dma_addr,
>   				      GFP_KERNEL);
>   
>   	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK", __func__, pagelist);
> @@ -292,7 +291,7 @@ create_pagelist(char *buf, char __user *ubuf,
>   			size_t bytes = PAGE_SIZE - off;
>   
>   			if (!pg) {
> -				cleanup_pagelistinfo(pagelistinfo);
> +				cleanup_pagelistinfo(instance, pagelistinfo);
>   				return NULL;
>   			}
>   
> @@ -315,7 +314,7 @@ create_pagelist(char *buf, char __user *ubuf,
>   			/* This is probably due to the process being killed */
>   			if (actual_pages > 0)
>   				unpin_user_pages(pages, actual_pages);
> -			cleanup_pagelistinfo(pagelistinfo);
> +			cleanup_pagelistinfo(instance, pagelistinfo);
>   			return NULL;
>   		}
>   		 /* release user pages */
> @@ -338,13 +337,13 @@ create_pagelist(char *buf, char __user *ubuf,
>   		count -= len;
>   	}
>   
> -	dma_buffers = dma_map_sg(g_dev,
> +	dma_buffers = dma_map_sg(instance->state->dev,
>   				 scatterlist,
>   				 num_pages,
>   				 pagelistinfo->dma_dir);
>   
>   	if (dma_buffers == 0) {
> -		cleanup_pagelistinfo(pagelistinfo);
> +		cleanup_pagelistinfo(instance, pagelistinfo);
>   		return NULL;
>   	}
>   
> @@ -378,7 +377,7 @@ create_pagelist(char *buf, char __user *ubuf,
>   		char *fragments;
>   
>   		if (down_interruptible(&g_free_fragments_sema)) {
> -			cleanup_pagelistinfo(pagelistinfo);
> +			cleanup_pagelistinfo(instance, pagelistinfo);
>   			return NULL;
>   		}
>   
> @@ -397,7 +396,7 @@ create_pagelist(char *buf, char __user *ubuf,
>   }
>   
>   static void
> -free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
> +free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagelistinfo,
>   	      int actual)
>   {
>   	struct pagelist *pagelist = pagelistinfo->pagelist;
> @@ -411,7 +410,7 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
>   	 * NOTE: dma_unmap_sg must be called before the
>   	 * cpu can touch any of the data/pages.
>   	 */
> -	dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
> +	dma_unmap_sg(instance->state->dev, pagelistinfo->scatterlist,
>   		     pagelistinfo->num_pages, pagelistinfo->dma_dir);
>   	pagelistinfo->scatterlist_mapped = 0;
>   
> @@ -460,7 +459,7 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
>   			set_page_dirty(pages[i]);
>   	}
>   
> -	cleanup_pagelistinfo(pagelistinfo);
> +	cleanup_pagelistinfo(instance, pagelistinfo);
>   }
>   
>   int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
> @@ -547,7 +546,6 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
>   		return err ? : -ENXIO;
>   	}
>   
> -	g_dev = dev;
>   	vchiq_log_info(vchiq_arm_log_level, "vchiq_init - done (slots %pK, phys %pad)",
>   		       vchiq_slot_zero, &slot_phys);
>   
> @@ -615,12 +613,12 @@ remote_event_signal(struct remote_event *event)
>   }
>   
>   int
> -vchiq_prepare_bulk_data(struct vchiq_bulk *bulk, void *offset,
> +vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk, void *offset,
>   			void __user *uoffset, int size, int dir)
>   {
>   	struct vchiq_pagelist_info *pagelistinfo;
>   
> -	pagelistinfo = create_pagelist(offset, uoffset, size,
> +	pagelistinfo = create_pagelist(instance, offset, uoffset, size,
>   				       (dir == VCHIQ_BULK_RECEIVE)
>   				       ? PAGELIST_READ
>   				       : PAGELIST_WRITE);
> @@ -640,10 +638,10 @@ vchiq_prepare_bulk_data(struct vchiq_bulk *bulk, void *offset,
>   }
>   
>   void
> -vchiq_complete_bulk(struct vchiq_bulk *bulk)
> +vchiq_complete_bulk(struct vchiq_instance *instance, struct vchiq_bulk *bulk)
>   {
>   	if (bulk && bulk->remote_data && bulk->actual)
> -		free_pagelist((struct vchiq_pagelist_info *)bulk->remote_data,
> +		free_pagelist(instance, (struct vchiq_pagelist_info *)bulk->remote_data,
>   			      bulk->actual);
>   }
>   
> @@ -834,8 +832,8 @@ vchiq_open_service(struct vchiq_instance *instance,
>   EXPORT_SYMBOL(vchiq_open_service);
>   
>   enum vchiq_status
> -vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
> -		    void *userdata, enum vchiq_bulk_mode mode)
> +vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const void *data,
> +		    unsigned int size, void *userdata, enum vchiq_bulk_mode mode)
>   {
>   	enum vchiq_status status;
>   
> @@ -843,13 +841,13 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
>   		switch (mode) {
>   		case VCHIQ_BULK_MODE_NOCALLBACK:
>   		case VCHIQ_BULK_MODE_CALLBACK:
> -			status = vchiq_bulk_transfer(handle,
> +			status = vchiq_bulk_transfer(instance, handle,
>   						     (void *)data, NULL,
>   						     size, userdata, mode,
>   						     VCHIQ_BULK_TRANSMIT);
>   			break;
>   		case VCHIQ_BULK_MODE_BLOCKING:
> -			status = vchiq_blocking_bulk_transfer(handle, (void *)data, size,
> +			status = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
>   							      VCHIQ_BULK_TRANSMIT);
>   			break;
>   		default:
> @@ -871,8 +869,8 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
>   }
>   EXPORT_SYMBOL(vchiq_bulk_transmit);
>   
> -enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
> -				     unsigned int size, void *userdata,
> +enum vchiq_status vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
> +				     void *data, unsigned int size, void *userdata,
>   				     enum vchiq_bulk_mode mode)
>   {
>   	enum vchiq_status status;
> @@ -881,12 +879,12 @@ enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
>   		switch (mode) {
>   		case VCHIQ_BULK_MODE_NOCALLBACK:
>   		case VCHIQ_BULK_MODE_CALLBACK:
> -			status = vchiq_bulk_transfer(handle, data, NULL,
> +			status = vchiq_bulk_transfer(instance, handle, data, NULL,
>   						     size, userdata,
>   						     mode, VCHIQ_BULK_RECEIVE);
>   			break;
>   		case VCHIQ_BULK_MODE_BLOCKING:
> -			status = vchiq_blocking_bulk_transfer(handle, (void *)data, size,
> +			status = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
>   							      VCHIQ_BULK_RECEIVE);
>   			break;
>   		default:
> @@ -909,10 +907,9 @@ enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
>   EXPORT_SYMBOL(vchiq_bulk_receive);
>   
>   static enum vchiq_status
> -vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
> -			     enum vchiq_bulk_dir dir)
> +vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
> +			     unsigned int size, enum vchiq_bulk_dir dir)
>   {
> -	struct vchiq_instance *instance;
>   	struct vchiq_service *service;
>   	enum vchiq_status status;
>   	struct bulk_waiter_node *waiter = NULL, *iter;
> @@ -921,8 +918,6 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
>   	if (!service)
>   		return VCHIQ_ERROR;
>   
> -	instance = service->instance;
> -
>   	vchiq_service_put(service);
>   
>   	mutex_lock(&instance->bulk_waiter_list_mutex);
> @@ -959,7 +954,7 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
>   		}
>   	}
>   
> -	status = vchiq_bulk_transfer(handle, data, NULL, size,
> +	status = vchiq_bulk_transfer(instance, handle, data, NULL, size,
>   				     &waiter->bulk_waiter,
>   				     VCHIQ_BULK_MODE_BLOCKING, dir);
>   	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 0d5c39d7c6e2..04eec18835da 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -1441,7 +1441,7 @@ abort_outstanding_bulks(struct vchiq_service *service,
>   		}
>   
>   		if (queue->process != queue->local_insert) {
> -			vchiq_complete_bulk(bulk);
> +			vchiq_complete_bulk(service->instance, bulk);
>   
>   			vchiq_log_info(SRVTRACE_LEVEL(service),
>   				       "%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
> @@ -1769,7 +1769,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
>   
>   			DEBUG_TRACE(PARSE_LINE);
>   			WARN_ON(queue->process == queue->local_insert);
> -			vchiq_complete_bulk(bulk);
> +			vchiq_complete_bulk(service->instance, bulk);
>   			queue->process++;
>   			mutex_unlock(&service->bulk_mutex);
>   			DEBUG_TRACE(PARSE_LINE);
> @@ -2998,9 +2998,9 @@ vchiq_remove_service(unsigned int handle)
>    * When called in blocking mode, the userdata field points to a bulk_waiter
>    * structure.
>    */
> -enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __user *uoffset,
> -				      int size, void *userdata, enum vchiq_bulk_mode mode,
> -				      enum vchiq_bulk_dir dir)
> +enum vchiq_status vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
> +				      void *offset, void __user *uoffset, int size, void *userdata,
> +				      enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir)
>   {
>   	struct vchiq_service *service = find_service_by_handle(handle);
>   	struct vchiq_bulk_queue *queue;
> @@ -3077,7 +3077,7 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
>   	bulk->size = size;
>   	bulk->actual = VCHIQ_BULK_ACTUAL_ABORTED;
>   
> -	if (vchiq_prepare_bulk_data(bulk, offset, uoffset, size, dir))
> +	if (vchiq_prepare_bulk_data(instance, bulk, offset, uoffset, size, dir))
>   		goto unlock_error_exit;
>   
>   	wmb();
> @@ -3141,7 +3141,7 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
>   unlock_both_error_exit:
>   	mutex_unlock(&state->slot_mutex);
>   cancel_bulk_error_exit:
> -	vchiq_complete_bulk(bulk);
> +	vchiq_complete_bulk(service->instance, bulk);
>   unlock_error_exit:
>   	mutex_unlock(&service->bulk_mutex);
>   
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 352017ff5309..2ce54ce9f02a 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -489,8 +489,8 @@ extern void
>   remote_event_pollall(struct vchiq_state *state);
>   
>   extern enum vchiq_status
> -vchiq_bulk_transfer(unsigned int handle, void *offset, void __user *uoffset,
> -		    int size, void *userdata, enum vchiq_bulk_mode mode,
> +vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *offset,
> +		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_mode mode,
>   		    enum vchiq_bulk_dir dir);
>   
>   extern int
> @@ -556,10 +556,10 @@ vchiq_queue_message(unsigned int handle,
>   		    void *context,
>   		    size_t size);
>   
> -int vchiq_prepare_bulk_data(struct vchiq_bulk *bulk, void *offset, void __user *uoffset,
> -			    int size, int dir);
> +int vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk, void *offset,
> +			    void __user *uoffset, int size, int dir);
>   
> -void vchiq_complete_bulk(struct vchiq_bulk *bulk);
> +void vchiq_complete_bulk(struct vchiq_instance *instance, struct vchiq_bulk *bulk);
>   
>   void remote_event_signal(struct remote_event *event);
>   
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 66bbfec332ba..077e3fcbd651 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -330,7 +330,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
>   		userdata = args->userdata;
>   	}
>   
> -	status = vchiq_bulk_transfer(args->handle, NULL, args->data, args->size,
> +	status = vchiq_bulk_transfer(instance, args->handle, NULL, args->data, args->size,
>   				     userdata, args->mode, dir);
>   
>   	if (!waiter) {
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 249dd3e30c2f..88813af8de49 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -293,7 +293,7 @@ static void buffer_to_host_work_cb(struct work_struct *work)
>   		len = 8;
>   	/* queue the bulk submission */
>   	vchiq_use_service(instance->service_handle);
> -	ret = vchiq_bulk_receive(instance->service_handle,
> +	ret = vchiq_bulk_receive(instance->vchiq_instance, instance->service_handle,
>   				 msg_context->u.bulk.buffer->buffer,
>   				 /* Actual receive needs to be a multiple
>   				  * of 4 bytes
