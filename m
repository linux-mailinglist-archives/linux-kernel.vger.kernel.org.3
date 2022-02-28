Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0DD4C71D0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiB1Qii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiB1Qig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:38:36 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A023F24F16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:37:56 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id j5so10428413ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VpryL/4glEoBZZ5KMN4DVcGmV304l+SZhLRo+W5edLQ=;
        b=ojoqXHt4Qvo1GDOHgBJN1zp/CJBX+GpnH0bvwB0j88XeEbpJYXmRzGVvUOPdO7PR0S
         nfZBKTT842O72RNw3hnBLxHucVXDmSi0Xg0Rnllk2FurotseS5XRKI3QRtNtb0m1wkEA
         qUP5L6GVIS54I9NAdYwDZeEuPf7mKMFDm3Gzx/5VoITv6A9z6Q1oS4/dg6zIPqUZ35Sp
         BuqZVME356rsuZa+9Lcl+PJPLJVhJaWNa824BYsghcJl+5Mx+dUBhx8rTuV+Lq0oOjZY
         iCf5yIW1VTaUpm4vK3YLzCXNmpztyp0/Muqi53h0xSxM9+3kMbmVXCiGD5DRYnKwuabx
         L1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VpryL/4glEoBZZ5KMN4DVcGmV304l+SZhLRo+W5edLQ=;
        b=iipcCPlug4J0C2o4Od+Ho82X1FadbH5kqjIVvLszMJgjyiYgRDXE4FqrH89+Qm+DWY
         TrEVajhCOXXGoosawGxAoH9WbVQcN2oQiYWfUBqBRI/DIUG1e2vzVQG+4DoQoyRENosa
         Ab04TV4p6anlEtnoXd/nnGlw+pO+Ihx57b5HJ+adrXML0PmemnBdnVKBz9Igu9lByI67
         YKFoibgNiFKLVDmN6XilS7APADsIXhEWiimmUF1PaznDSqGIxb7t3z8W7nT6FLpCESUD
         EjCr6CqfhIIsN98S4rnRdAFpdEQHoPwdithg6XZY4qtf7fH1G/CDohlaFBTDmULn7QKc
         vyJg==
X-Gm-Message-State: AOAM530rkKJfkT+ijLCZSHwBuz1uOY64ESrR6ziwxYATY0eegDuvSOS1
        yuF80IwoFUvNSea5UTKaGJBY/g==
X-Google-Smtp-Source: ABdhPJwCZCIIQM96e4SPiHDrCV3toSHPVynB+wM8XOj6tkMow3jiFvFmhYTVtkdJRE/7rzBdnLHw+A==
X-Received: by 2002:a92:8e43:0:b0:2ba:cde1:8215 with SMTP id k3-20020a928e43000000b002bacde18215mr18895195ilh.78.1646066275898;
        Mon, 28 Feb 2022 08:37:55 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id r9-20020a6b6009000000b006412abddbbbsm6129945iog.24.2022.02.28.08.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:37:55 -0800 (PST)
Message-ID: <d1c56d67-4933-9747-29b4-407b82f5ba7c@linaro.org>
Date:   Mon, 28 Feb 2022 10:37:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 15/27] bus: mhi: ep: Add support for sending events to
 the host
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
 <20220228124344.77359-16-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220228124344.77359-16-manivannan.sadhasivam@linaro.org>
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
> Add support for sending the events to the host over MHI bus from the
> endpoint. Following events are supported:
> 
> 1. Transfer completion event
> 2. Command completion event
> 3. State change event
> 4. Execution Environment (EE) change event
> 
> An event is sent whenever an operation has been completed in the MHI EP
> device. Event is sent using the MHI event ring and additionally the host
> is notified using an IRQ if required.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This code involves some of the same sort of bitfield manipulation
as was commented on in patch 5.  Whatever you do there, plan to
do something similar here.

I have minor suggestions/comments below, but this looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/common.h      | 22 +++++++++
>   drivers/bus/mhi/ep/internal.h |  4 ++
>   drivers/bus/mhi/ep/main.c     | 90 +++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        |  8 ++++
>   4 files changed, 124 insertions(+)
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> index ec75ba1e6686..5b30e2d0832e 100644
> --- a/drivers/bus/mhi/common.h
> +++ b/drivers/bus/mhi/common.h
> @@ -165,6 +165,22 @@
>   #define MHI_TRE_GET_EV_LINKSPEED(tre)	FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1)))
>   #define MHI_TRE_GET_EV_LINKWIDTH(tre)	FIELD_GET(GENMASK(7, 0), (MHI_TRE_GET_DWORD(tre, 0)))
>   
> +/* State change event */
> +#define MHI_SC_EV_PTR			0
> +#define MHI_SC_EV_DWORD0(state)		cpu_to_le32(FIELD_PREP(GENMASK(31, 24), state))
> +#define MHI_SC_EV_DWORD1(type)		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), type))
> +
> +/* EE event */
> +#define MHI_EE_EV_PTR			0
> +#define MHI_EE_EV_DWORD0(ee)		cpu_to_le32(FIELD_PREP(GENMASK(31, 24), ee))
> +#define MHI_EE_EV_DWORD1(type)		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), type))
> +
> +
> +/* Command Completion event */
> +#define MHI_CC_EV_PTR(ptr)		cpu_to_le64(ptr)
> +#define MHI_CC_EV_DWORD0(code)		cpu_to_le32(FIELD_PREP(GENMASK(31, 24), code))
> +#define MHI_CC_EV_DWORD1(type)		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), type))
> +
>   /* Transfer descriptor macros */
>   #define MHI_TRE_DATA_PTR(ptr)		cpu_to_le64(ptr)
>   #define MHI_TRE_DATA_DWORD0(len)	cpu_to_le32(FIELD_PREP(GENMASK(15, 0), len))
> @@ -175,6 +191,12 @@
>   								FIELD_PREP(BIT(9), ieot) |  \
>   								FIELD_PREP(BIT(8), ieob) |  \
>   								FIELD_PREP(BIT(0), chain))
> +#define MHI_TRE_DATA_GET_PTR(tre)	le64_to_cpu((tre)->ptr)
> +#define MHI_TRE_DATA_GET_LEN(tre)	FIELD_GET(GENMASK(15, 0), MHI_TRE_GET_DWORD(tre, 0))

You might consider making these macros produce Boolean results.

> +#define MHI_TRE_DATA_GET_CHAIN(tre)	FIELD_GET(BIT(0), MHI_TRE_GET_DWORD(tre, 1))
> +#define MHI_TRE_DATA_GET_IEOB(tre)	FIELD_GET(BIT(8), MHI_TRE_GET_DWORD(tre, 1))
> +#define MHI_TRE_DATA_GET_IEOT(tre)	FIELD_GET(BIT(9), MHI_TRE_GET_DWORD(tre, 1))
> +#define MHI_TRE_DATA_GET_BEI(tre)	FIELD_GET(BIT(10), MHI_TRE_GET_DWORD(tre, 1))
>   
>   /* RSC transfer descriptor macros */
>   #define MHI_RSCTRE_DATA_PTR(ptr, len)	cpu_to_le64(FIELD_PREP(GENMASK(64, 48), len) | ptr)
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> index b3b8770f2f4e..8753ae93eda3 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -195,4 +195,8 @@ void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *s
>   void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl);
>   void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
>   
> +/* MHI EP core functions */
> +int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state);
> +int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env);
> +
>   #endif
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index d76387c4d5fa..903f9bd3e03d 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -18,6 +18,94 @@
>   
>   static DEFINE_IDA(mhi_ep_cntrl_ida);
>   
> +static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
> +			     struct mhi_ring_element *el, bool bei)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	union mhi_ep_ring_ctx *ctx;
> +	struct mhi_ep_ring *ring;
> +	int ret;
> +
> +	mutex_lock(&mhi_cntrl->event_lock);
> +	ring = &mhi_cntrl->mhi_event[ring_idx].ring;
> +	ctx = (union mhi_ep_ring_ctx *)&mhi_cntrl->ev_ctx_cache[ring_idx];
> +	if (!ring->started) {
> +		ret = mhi_ep_ring_start(mhi_cntrl, ring, ctx);
> +		if (ret) {
> +			dev_err(dev, "Error starting event ring (%u)\n", ring_idx);
> +			goto err_unlock;
> +		}
> +	}
> +
> +	/* Add element to the event ring */
> +	ret = mhi_ep_ring_add_element(ring, el);
> +	if (ret) {
> +		dev_err(dev, "Error adding element to event ring (%u)\n", ring_idx);
> +		goto err_unlock;
> +	}
> +
> +	mutex_unlock(&mhi_cntrl->event_lock);
> +
> +	/*
> +	 * Raise IRQ to host only if the BEI flag is not set in TRE. Host might
> +	 * set this flag for interrupt moderation as per MHI protocol.
> +	 */
> +	if (!bei)
> +		mhi_cntrl->raise_irq(mhi_cntrl, ring->irq_vector);
> +
> +	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&mhi_cntrl->event_lock);
> +
> +	return ret;
> +}
> +
> +static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
> +					struct mhi_ring_element *tre, u32 len, enum mhi_ev_ccs code)
> +{
> +	struct mhi_ring_element event = {};
> +
> +	event.ptr = cpu_to_le64(ring->rbase + (ring->rd_offset * (sizeof(*tre))));

The parentheses around the sizeof are unnecessary; so are the
parentheses around the factors of the mulitplication.

> +	event.dword[0] = MHI_TRE_EV_DWORD0(code, len);
> +	event.dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
> +
> +	return mhi_ep_send_event(mhi_cntrl, ring->er_index, &event, !!MHI_TRE_DATA_GET_BEI(tre));
> +}
> +
> +int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state)
> +{
> +	struct mhi_ring_element event = {};
> +
> +	event.dword[0] = MHI_SC_EV_DWORD0(state);
> +	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
> +
> +	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
> +}
> +
> +int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env)
> +{
> +	struct mhi_ring_element event = {};
> +
> +	event.dword[0] = MHI_EE_EV_DWORD0(exec_env);
> +	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
> +
> +	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
> +}
> +
> +static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ev_ccs code)
> +{
> +	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_cmd->ring;
> +	struct mhi_ring_element event = {};
> +
> +	event.ptr = cpu_to_le64(ring->rbase + (ring->rd_offset *
> +					       (sizeof(struct mhi_ring_element))));
> +	event.dword[0] = MHI_CC_EV_DWORD0(code);
> +	event.dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
> +
> +	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
> +}
> +
>   static void mhi_ep_release_device(struct device *dev)
>   {
>   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> @@ -227,6 +315,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   		goto err_free_ch;
>   	}
>   
> +	mutex_init(&mhi_cntrl->event_lock);
> +
>   	/* Set MHI version and AMSS EE before enumeration */
>   	mhi_ep_mmio_write(mhi_cntrl, EP_MHIVER, config->mhi_version);
>   	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EE_AMSS);
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 8e1de062f820..44a4669382ad 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -59,10 +59,14 @@ struct mhi_ep_db_info {
>    * @mhi_event: Points to the event ring configurations table
>    * @mhi_cmd: Points to the command ring configurations table
>    * @sm: MHI Endpoint state machine
> + * @ch_ctx_cache: Cache of host channel context data structure
> + * @ev_ctx_cache: Cache of host event context data structure
> + * @cmd_ctx_cache: Cache of host command context data structure
>    * @ch_ctx_host_pa: Physical address of host channel context data structure
>    * @ev_ctx_host_pa: Physical address of host event context data structure
>    * @cmd_ctx_host_pa: Physical address of host command context data structure
>    * @chdb: Array of channel doorbell interrupt info
> + * @event_lock: Lock for protecting event rings
>    * @raise_irq: CB function for raising IRQ to the host
>    * @alloc_addr: CB function for allocating memory in endpoint for storing host context
>    * @map_addr: CB function for mapping host context to endpoint
> @@ -89,11 +93,15 @@ struct mhi_ep_cntrl {
>   	struct mhi_ep_cmd *mhi_cmd;
>   	struct mhi_ep_sm *sm;
>   
> +	struct mhi_chan_ctxt *ch_ctx_cache;
> +	struct mhi_event_ctxt *ev_ctx_cache;
> +	struct mhi_cmd_ctxt *cmd_ctx_cache;
>   	u64 ch_ctx_host_pa;
>   	u64 ev_ctx_host_pa;
>   	u64 cmd_ctx_host_pa;
>   
>   	struct mhi_ep_db_info chdb[4];
> +	struct mutex event_lock;
>   
>   	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
>   	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t *phys_addr,

