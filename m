Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE74B7A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbiBOWlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:41:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244695AbiBOWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:40:52 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A908C1C8E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:38 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e8so112361ilm.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s3S+ZBHc3O8N3HfRVKVNePzpEy5amtqjf7RHMF5rRnE=;
        b=iwIWNIIlDgQIxBgeolVH9CWJ43u83733cf1DLYW08OnChtIbN3f0gfofr270sPTfSe
         FRHma1EMI1KLwZuhdi5guZeCYqb+bJ8YN89vyzY0JR01E0DT5rbPxAJUmW6QEmtqIG/0
         2hxiX7+QkPYH87BQ8nHE2Rssg9zyqGjX5lbk2Mq41o6xd/874piXZS7Mj2vdESa7cree
         8oiUr66YygsyQuECK7eoZLq+kEtchua/H8FOIivdANXvZhlePQ51o8xPykPtI6lWVFYe
         LSUXhyvTfgKbgc11bpqi/ImKrXaYX26l/TiKy9j7p1a65jSQRiD50V/6ChtB6ZywQ/x/
         vHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s3S+ZBHc3O8N3HfRVKVNePzpEy5amtqjf7RHMF5rRnE=;
        b=NfOSty2W3y4tcL0H1WAm8XjxkjXOZug6xIgyZt33wCa7wGi2vjfKIq69H51j4VHGzg
         7e4V3U6eYYqrZdJerJIaX1clF0U07xQVqAIwlu4m4gd0PzDRoYImUMZC09QZ3cS78hfn
         fFpHQ8nNnOXle4batwyKA23VmJz7S4LQX9vrXKBtKv7Ao3pkie4ZsftBml/fT6PscbHx
         w00jXm5ShtHQNFELMPYGrKH0zxyN27RQ/csd74o4FfTn3OiPMkA+5qIODc8moS1Z1FBg
         yhwveFVrEZFwhIQV21BVPgIsOGYmlgb/N84iOHWzS5aFO1WqXE04v5F9ot+sc3777Xas
         jKgg==
X-Gm-Message-State: AOAM531FNEY2V6IkZnJcxjVZHRS7dESKqzCAyZkkJyAn3PIugJhww/Lj
        Fcx4Hi/hovFWn9ivRllyV/Kn/sbiR94MBfJ7
X-Google-Smtp-Source: ABdhPJwcvqCC2LXb/bb/4iUcEbXnAop+6ntKZrqA3SaLV0AgGTPLP7OdP7l34HU35Zx159jCPIcAfw==
X-Received: by 2002:a05:6e02:1bc1:: with SMTP id x1mr766657ilv.268.1644964837781;
        Tue, 15 Feb 2022 14:40:37 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id r7sm16538062ilm.14.2022.02.15.14.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:40:37 -0800 (PST)
Message-ID: <05575816-878c-852a-5aa0-5854d1b49394@linaro.org>
Date:   Tue, 15 Feb 2022 16:40:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 24/25] bus: mhi: ep: Add support for suspending and
 resuming channels
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-25-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-25-manivannan.sadhasivam@linaro.org>
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

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> Add support for suspending and resuming the channels in MHI endpoint stack.
> The channels will be moved to the suspended state during M3 state
> transition and will be resumed during M0 transition.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/ep/internal.h |  2 ++
>   drivers/bus/mhi/ep/main.c     | 58 +++++++++++++++++++++++++++++++++++
>   drivers/bus/mhi/ep/sm.c       |  4 +++
>   3 files changed, 64 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> index 8654af7caf40..e23d2fd04282 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -242,6 +242,8 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
>   int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
>   int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
>   void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_resume_channels(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_suspend_channels(struct mhi_ep_cntrl *mhi_cntrl);
>   
>   /* MHI EP memory management functions */
>   int mhi_ep_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, size_t size,
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index e4186b012257..315409705b91 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1106,6 +1106,64 @@ void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl)
>   }
>   EXPORT_SYMBOL_GPL(mhi_ep_power_down);
>   
> +void mhi_ep_suspend_channels(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct mhi_ep_chan *mhi_chan;
> +	u32 tmp;
> +	int i;
> +
> +	for (i = 0; i < mhi_cntrl->max_chan; i++) {
> +		mhi_chan = &mhi_cntrl->mhi_chan[i];
> +
> +		if (!mhi_chan->mhi_dev)
> +			continue;
> +
> +		mutex_lock(&mhi_chan->lock);
> +		/* Skip if the channel is not currently running */
> +		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[i].chcfg);
> +		if (FIELD_GET(CHAN_CTX_CHSTATE_MASK, tmp) != MHI_CH_STATE_RUNNING) {
> +			mutex_unlock(&mhi_chan->lock);
> +			continue;
> +		}
> +
> +		dev_dbg(&mhi_chan->mhi_dev->dev, "Suspending channel\n");
> +		/* Set channel state to SUSPENDED */
> +		tmp &= ~CHAN_CTX_CHSTATE_MASK;
> +		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_SUSPENDED);

Somebody really needs to write a FIELD_UPDATE() macro to
do this read/modify/write pattern.

> +		mhi_cntrl->ch_ctx_cache[i].chcfg = cpu_to_le32(tmp);
> +		mutex_unlock(&mhi_chan->lock);
> +	}
> +}
> +
> +void mhi_ep_resume_channels(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct mhi_ep_chan *mhi_chan;
> +	u32 tmp;
> +	int i;
> +
> +	for (i = 0; i < mhi_cntrl->max_chan; i++) {
> +		mhi_chan = &mhi_cntrl->mhi_chan[i];
> +
> +		if (!mhi_chan->mhi_dev)
> +			continue;
> +
> +		mutex_lock(&mhi_chan->lock);
> +		/* Skip if the channel is not currently suspended */
> +		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[i].chcfg);
> +		if (FIELD_GET(CHAN_CTX_CHSTATE_MASK, tmp) != MHI_CH_STATE_SUSPENDED) {
> +			mutex_unlock(&mhi_chan->lock);
> +			continue;
> +		}
> +
> +		dev_dbg(&mhi_chan->mhi_dev->dev, "Resuming channel\n");
> +		/* Set channel state to RUNNING */
> +		tmp &= ~CHAN_CTX_CHSTATE_MASK;
> +		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_RUNNING);
> +		mhi_cntrl->ch_ctx_cache[i].chcfg = cpu_to_le32(tmp);
> +		mutex_unlock(&mhi_chan->lock);
> +	}
> +}
> +
>   static void mhi_ep_release_device(struct device *dev)
>   {
>   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
> index 9a75ecfe1adf..e24ba2d85e13 100644
> --- a/drivers/bus/mhi/ep/sm.c
> +++ b/drivers/bus/mhi/ep/sm.c
> @@ -88,8 +88,11 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl)
>   	enum mhi_state old_state;
>   	int ret;
>   
> +	/* If MHI is in M3, resume suspended channels */
>   	spin_lock_bh(&mhi_cntrl->state_lock);
>   	old_state = mhi_cntrl->mhi_state;
> +	if (old_state == MHI_STATE_M3)
> +		mhi_ep_resume_channels(mhi_cntrl);
>   
>   	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
>   	if (ret) {
> @@ -135,6 +138,7 @@ int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl)
>   	}
>   
>   	spin_unlock_bh(&mhi_cntrl->state_lock);
> +	mhi_ep_suspend_channels(mhi_cntrl);
>   
>   	/* Signal host that the device moved to M3 */
>   	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M3);

