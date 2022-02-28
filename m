Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AF44C71D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbiB1QmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiB1QmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:42:17 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185FF60ABD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:41:38 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 195so15406221iou.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hPakznVuhJ1xaWvKgzoZiETkDKgXaYCtu8p9TdQ8faQ=;
        b=fgdF3GXIaRoTZMBPTvi+jmEsukupYacTFncMKDvOHsKaCmZUSUxZWbpPIfDdPRviK6
         zCi9MpDYol1ups/FT/J4zVt0gJG8hK9/HWjW92WOMx0ZENuqUyk5CxpihfOwSnq6O39N
         tZO+ax3lG7SbLSzbhJXti12T048Ny8FD7/PdiQfz2x4sHutvlydGwyJ5Tpk0aLwAakn9
         zuoMVaq3MqNUNy854XEU4sWZi5SYw23tqSrxSRDHXcyWDlevRkCA24H8IPt3RZLUw9Ot
         Txyu5kJCrVwDH5CSf9xOLZSqV8TmZqBWuYSgFotv/1vcQq8K4yyf4/2iaIgj4ph7p98q
         7sIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hPakznVuhJ1xaWvKgzoZiETkDKgXaYCtu8p9TdQ8faQ=;
        b=4JnyoOSwiseVXNo7omKTVve0dazQWwf0Dpp6OoqyXPUK/Ch7yDRNNeimXEdJQkPVCy
         TrNHiq4JPcpuVd6T5YD/Alcf+Z5yIKPbcsz3vdDnjjn5+e05qLfJMpMgr24tKmDeU7gr
         xIy3ZxPUQ6WcoOs6C9E9CAAw9qqL9rBcJdIIgc3lC0DDRPEX1XVJ2BbpE6MpTe20lcJL
         bz3o5jAYP3A5Zy9drxHay7U0XA9wAOpCJ2o9+OlhL4UB3vkgfZN6Y2YAEXe6/VOKMxSq
         Hbe40LUkwgewa0c98Jvu4D6a1szl7oce97Nqk4HDIAcwFNaBJyMLjL7cq/fh+AndlQL5
         rFIQ==
X-Gm-Message-State: AOAM5319PnsdNAp6cYOO3LppIGK+otF3d3UD8DE3sqSsBA2RrjPT3y7w
        +d94fRcEmP9sB6PkhfNpGZFDsA==
X-Google-Smtp-Source: ABdhPJzPb7W4ahDgwTq0Ym69XmRY6CAObJs0KHfXc3mdTyzDcSuUsC+7U8yOsMT6GgNgXeb6QWxpTQ==
X-Received: by 2002:a05:6638:2387:b0:314:7ce4:1be8 with SMTP id q7-20020a056638238700b003147ce41be8mr18151326jat.286.1646066497383;
        Mon, 28 Feb 2022 08:41:37 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g10-20020a92520a000000b002c28ee02997sm6660207ilb.54.2022.02.28.08.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:41:36 -0800 (PST)
Message-ID: <043bd7c6-97af-26ae-78fa-8b22b0e5606d@linaro.org>
Date:   Mon, 28 Feb 2022 10:41:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 16/27] bus: mhi: ep: Add support for managing MHI state
 machine
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <20220228124344.77359-17-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220228124344.77359-17-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 6:43 AM, Manivannan Sadhasivam wrote:
> Add support for managing the MHI state machine by controlling the state
> transitions. Only the following MHI state transitions are supported:
> 
> 1. Ready state
> 2. M0 state
> 3. M3 state
> 4. SYS_ERR state
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Some minor comments below, but otherwise:

Reviewed-by: Alex Elder <elder@linaro.org.

> ---
>   drivers/bus/mhi/ep/Makefile   |   2 +-
>   drivers/bus/mhi/ep/internal.h |  11 +++
>   drivers/bus/mhi/ep/main.c     |  54 +++++++++++++-
>   drivers/bus/mhi/ep/sm.c       | 136 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        |  12 +++
>   5 files changed, 213 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/bus/mhi/ep/sm.c
> 
> diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
> index 7ba0e04801eb..aad85f180b70 100644
> --- a/drivers/bus/mhi/ep/Makefile
> +++ b/drivers/bus/mhi/ep/Makefile
> @@ -1,2 +1,2 @@
>   obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
> -mhi_ep-y := main.o mmio.o ring.o
> +mhi_ep-y := main.o mmio.o ring.o sm.o
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> index 8753ae93eda3..536351218685 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -144,6 +144,11 @@ struct mhi_ep_event {
>   	struct mhi_ep_ring ring;
>   };
>   
> +struct mhi_ep_state_transition {
> +	struct list_head node;
> +	enum mhi_state state;
> +};
> +
>   struct mhi_ep_chan {
>   	char *name;
>   	struct mhi_ep_device *mhi_dev;
> @@ -198,5 +203,11 @@ void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
>   /* MHI EP core functions */
>   int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state);
>   int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env);
> +bool mhi_ep_check_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state cur_mhi_state,
> +			    enum mhi_state mhi_state);
> +int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_state);
> +int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
> +int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
> +int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
>   
>   #endif
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 903f9bd3e03d..7a29543586d0 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -106,6 +106,43 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
>   	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
>   }
>   
> +static void mhi_ep_state_worker(struct work_struct *work)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, state_work);
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_ep_state_transition *itr, *tmp;
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +	int ret;
> +
> +	spin_lock_irqsave(&mhi_cntrl->list_lock, flags);
> +	list_splice_tail_init(&mhi_cntrl->st_transition_list, &head);
> +	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);
> +
> +	list_for_each_entry_safe(itr, tmp, &head, node) {
> +		list_del(&itr->node);
> +		dev_dbg(dev, "Handling MHI state transition to %s\n",
> +			 mhi_state_str(itr->state));
> +
> +		switch (itr->state) {
> +		case MHI_STATE_M0:
> +			ret = mhi_ep_set_m0_state(mhi_cntrl);
> +			if (ret)
> +				dev_err(dev, "Failed to transition to M0 state\n");
> +			break;
> +		case MHI_STATE_M3:
> +			ret = mhi_ep_set_m3_state(mhi_cntrl);
> +			if (ret)
> +				dev_err(dev, "Failed to transition to M3 state\n");
> +			break;
> +		default:
> +			dev_err(dev, "Invalid MHI state transition: %d\n", itr->state);
> +			break;
> +		}
> +		kfree(itr);
> +	}
> +}
> +
>   static void mhi_ep_release_device(struct device *dev)
>   {
>   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> @@ -315,6 +352,17 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   		goto err_free_ch;
>   	}
>   
> +	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
> +
> +	mhi_cntrl->wq = alloc_workqueue("mhi_ep_wq", 0, 0);
> +	if (!mhi_cntrl->wq) {
> +		ret = -ENOMEM;
> +		goto err_free_cmd;
> +	}
> +
> +	INIT_LIST_HEAD(&mhi_cntrl->st_transition_list);
> +	spin_lock_init(&mhi_cntrl->state_lock);
> +	spin_lock_init(&mhi_cntrl->list_lock);
>   	mutex_init(&mhi_cntrl->event_lock);
>   
>   	/* Set MHI version and AMSS EE before enumeration */
> @@ -325,7 +373,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
>   	if (mhi_cntrl->index < 0) {
>   		ret = mhi_cntrl->index;
> -		goto err_free_cmd;
> +		goto err_destroy_wq;
>   	}
>   
>   	/* Allocate the controller device */
> @@ -352,6 +400,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   	put_device(&mhi_dev->dev);
>   err_ida_free:
>   	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
> +err_destroy_wq:
> +	destroy_workqueue(mhi_cntrl->wq);
>   err_free_cmd:
>   	kfree(mhi_cntrl->mhi_cmd);
>   err_free_ch:
> @@ -365,6 +415,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
>   
> +	destroy_workqueue(mhi_cntrl->wq);
> +
>   	kfree(mhi_cntrl->mhi_cmd);
>   	kfree(mhi_cntrl->mhi_chan);
>   
> diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
> new file mode 100644
> index 000000000000..ad49276ec044
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/sm.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/mhi_ep.h>
> +#include "internal.h"
> +
> +bool __must_check mhi_ep_check_mhi_state(struct mhi_ep_cntrl *mhi_cntrl,
> +					 enum mhi_state cur_mhi_state,
> +					 enum mhi_state mhi_state)
> +{
> +	if (mhi_state == MHI_STATE_SYS_ERR)
> +		return true;    /* Allowed in any state */
> +
> +	if (mhi_state == MHI_STATE_READY)
> +		return cur_mhi_state == MHI_STATE_RESET;
> +
> +	if (mhi_state == MHI_STATE_M0)
> +		return (cur_mhi_state == MHI_STATE_M3 || cur_mhi_state == MHI_STATE_READY);

Parentheses not required here.

> +
> +	if (mhi_state == MHI_STATE_M3)
> +		return cur_mhi_state == MHI_STATE_M0;
> +
> +	return false;
> +}
> +
> +int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_state)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +
> +	if (!mhi_ep_check_mhi_state(mhi_cntrl, mhi_cntrl->mhi_state, mhi_state)) {
> +		dev_err(dev, "MHI state change to %s from %s is not allowed!\n",
> +			mhi_state_str(mhi_state),
> +			mhi_state_str(mhi_cntrl->mhi_state));
> +		return -EACCES;
> +	}
> +
> +	/* TODO */

What is TODO here?  It probably doesn't belong, but if you're going
to keep it, at least say what's expected...

> +	if (mhi_state == MHI_STATE_M1 || mhi_state == MHI_STATE_M2) {
> +		dev_err(dev, "MHI state (%s) not supported\n", mhi_state_str(mhi_state));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	mhi_ep_mmio_masked_write(mhi_cntrl, EP_MHISTATUS, MHISTATUS_MHISTATE_MASK, mhi_state);
> +	mhi_cntrl->mhi_state = mhi_state;
> +
> +	if (mhi_state == MHI_STATE_READY)
> +		mhi_ep_mmio_masked_write(mhi_cntrl, EP_MHISTATUS, MHISTATUS_READY_MASK, 1);
> +
> +	if (mhi_state == MHI_STATE_SYS_ERR)
> +		mhi_ep_mmio_masked_write(mhi_cntrl, EP_MHISTATUS, MHISTATUS_SYSERR_MASK, 1);
> +
> +	return 0;
> +}
> +
> +int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	enum mhi_state old_state;
> +	int ret;
> +
> +	spin_lock_bh(&mhi_cntrl->state_lock);
> +	old_state = mhi_cntrl->mhi_state;
> +
> +	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
> +	spin_unlock_bh(&mhi_cntrl->state_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Signal host that the device moved to M0 */
> +	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M0);
> +	if (ret) {
> +		dev_err(dev, "Failed sending M0 state change event\n");
> +		return ret;
> +	}
> +
> +	if (old_state == MHI_STATE_READY) {
> +		/* Send AMSS EE event to host */
> +		ret = mhi_ep_send_ee_event(mhi_cntrl, MHI_EE_AMSS);
> +		if (ret) {
> +			dev_err(dev, "Failed sending AMSS EE event\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	int ret;
> +
> +	spin_lock_bh(&mhi_cntrl->state_lock);
> +	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
> +	spin_unlock_bh(&mhi_cntrl->state_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Signal host that the device moved to M3 */
> +	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M3);
> +	if (ret) {
> +		dev_err(dev, "Failed sending M3 state change event\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	enum mhi_state mhi_state;
> +	int ret, is_ready;
> +
> +	spin_lock_bh(&mhi_cntrl->state_lock);
> +	/* Ensure that the MHISTATUS is set to RESET by host */
> +	mhi_state = mhi_ep_mmio_masked_read(mhi_cntrl, EP_MHISTATUS, MHISTATUS_MHISTATE_MASK);
> +	is_ready = mhi_ep_mmio_masked_read(mhi_cntrl, EP_MHISTATUS, MHISTATUS_READY_MASK);
> +
> +	if (mhi_state != MHI_STATE_RESET || is_ready) {
> +		dev_err(dev, "READY state transition failed. MHI host not in RESET state\n");
> +		spin_unlock_bh(&mhi_cntrl->state_lock);
> +		return -EIO;
> +	}
> +
> +	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_READY);
> +	spin_unlock_bh(&mhi_cntrl->state_lock);
> +
> +	return ret;
> +}
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 44a4669382ad..dc27a5de7d3c 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -67,6 +67,11 @@ struct mhi_ep_db_info {
>    * @cmd_ctx_host_pa: Physical address of host command context data structure
>    * @chdb: Array of channel doorbell interrupt info
>    * @event_lock: Lock for protecting event rings
> + * @list_lock: Lock for protecting state transition and channel doorbell lists
> + * @state_lock: Lock for protecting state transitions
> + * @st_transition_list: List of state transitions
> + * @wq: Dedicated workqueue for handling rings and state changes
> + * @state_work: State transition worker
>    * @raise_irq: CB function for raising IRQ to the host
>    * @alloc_addr: CB function for allocating memory in endpoint for storing host context
>    * @map_addr: CB function for mapping host context to endpoint
> @@ -102,6 +107,13 @@ struct mhi_ep_cntrl {
>   
>   	struct mhi_ep_db_info chdb[4];
>   	struct mutex event_lock;
> +	spinlock_t list_lock;
> +	spinlock_t state_lock;
> +
> +	struct list_head st_transition_list;
> +
> +	struct workqueue_struct *wq;
> +	struct work_struct state_work;
>   
>   	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
>   	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t *phys_addr,

