Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176D4B7A97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244609AbiBOWkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:40:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244585AbiBOWkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:40:08 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABFCC1166
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:57 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id t6so199561ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4PZ7zcjQz54xkfUmKgCqvx2ZdGNaPFOWrQOzSiCIfeI=;
        b=hHHvXNV2llDNqwZzzToJAV5CdtTry2YP4fhOQsXbynftNnmqUgGA95a1l0EqS1xD9v
         kqTBtHwfM5tdJ89KaLYQujNOzN5+nbxosQJCHhdkYBxy1+6I9lbGlENqbXEGtchQE7oY
         nx/qT4SrpBEqqES1dP1ba41c5mad+IwUZDtzrdgRtFIy8LxeWqu+vKEcaiNgWHzrGJoY
         me1mDKq+VRnCi0teXRuH4Pvc7O9TmxSMwmEVjKG/b8Z642aWiG/ao+p+FGHUrPXqqSFE
         KGuEtiBQBV31b94WqOCmaE0Cs8M5BHy9VfMgEzceU2JcMFAi1D7Rl+g6pISNi+7QhZap
         VOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4PZ7zcjQz54xkfUmKgCqvx2ZdGNaPFOWrQOzSiCIfeI=;
        b=RMmG7eU7qPI4YxCIdyUu3npq0R+JilK9HFGKZoM7OpEjKiWP0X3ed0uwWfCFoMzacU
         XnHtYmvyAsibeMMMTb7+sTnaOtAATjIEupTgwDLmNERXJ7qMXLtqcbisis9JvZh/7OWv
         wJ/FyRgNYYthoWIevTgBEbLlTFoxlQoS0XLzw81M7vEluMX+jtAbvadJXZZ47O72gCjN
         jMSRPNJW/2UUmyyPMXJN716+YMSyVSjfUTrfGCgfaLtDT83oA3P25yEl4w+gmy/aXPet
         s/w5wd4Co5Ijj+ivJ/11VZvhlUMYALfslPvwANmtTAhHkjM57zJCEfq1VCIvjQ9I9lis
         mDBQ==
X-Gm-Message-State: AOAM533F71SKRegmo94/NwMw4lt6VqQMeluIca/JKbMcsb3jh7Ag3ZVU
        swvf0IGMu1jYe4vqcqlCbtCPqA==
X-Google-Smtp-Source: ABdhPJwCo8sla45rWyks5/fAqlLVyLY9WMKYKk834ABOkXYeRr95WzraYwijv+2kpbtvquXkNvq/xA==
X-Received: by 2002:a5e:860b:0:b0:614:8a8f:b18d with SMTP id z11-20020a5e860b000000b006148a8fb18dmr7986ioj.11.1644964797075;
        Tue, 15 Feb 2022 14:39:57 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id t7sm17994038ils.81.2022.02.15.14.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:39:56 -0800 (PST)
Message-ID: <40212d64-7423-014a-2a8d-cad5cc41795f@linaro.org>
Date:   Tue, 15 Feb 2022 16:39:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 19/25] bus: mhi: ep: Add support for handling SYS_ERR
 condition
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
 <20220212182117.49438-20-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-20-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> Add support for handling SYS_ERR (System Error) condition in the MHI
> endpoint stack. The SYS_ERR flag will be asserted by the endpoint device
> when it detects an internal error. The host will then issue reset and
> reinitializes MHI to recover from the error state.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I have a few small comments, but this look good enough for me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/ep/internal.h |  1 +
>   drivers/bus/mhi/ep/main.c     | 24 ++++++++++++++++++++++++
>   drivers/bus/mhi/ep/sm.c       |  2 ++
>   3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> index ee8c5974f0c0..8654af7caf40 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -241,6 +241,7 @@ int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_stat
>   int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
>   int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
>   int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl);
>   
>   /* MHI EP memory management functions */
>   int mhi_ep_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, size_t size,
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index ddedd0fb19aa..6378ac5c7e37 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -611,6 +611,30 @@ static void mhi_ep_reset_worker(struct work_struct *work)
>   	}
>   }
>   
> +/*
> + * We don't need to do anything special other than setting the MHI SYS_ERR
> + * state. The host issue will reset all contexts and issue MHI RESET so that we

s/host issue/host/

> + * could also recover from error state.
> + */
> +void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	int ret;
> +
> +	/* If MHI EP is not enabled, nothing to do */
> +	if (!mhi_cntrl->is_enabled)

Is this an expected condition?  SYS_ERR with the endpoint
disabled?

> +		return;
> +
> +	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
> +	if (ret)
> +		return;
> +
> +	/* Signal host that the device went to SYS_ERR state */
> +	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_SYS_ERR);
> +	if (ret)
> +		dev_err(dev, "Failed sending SYS_ERR state change event: %d\n", ret);
> +}
> +
>   int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
> index 68e7f99b9137..9a75ecfe1adf 100644
> --- a/drivers/bus/mhi/ep/sm.c
> +++ b/drivers/bus/mhi/ep/sm.c
> @@ -93,6 +93,7 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl)
>   
>   	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
>   	if (ret) {
> +		mhi_ep_handle_syserr(mhi_cntrl);
>   		spin_unlock_bh(&mhi_cntrl->state_lock);
>   		return ret;
>   	}
> @@ -128,6 +129,7 @@ int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl)
>   	spin_lock_bh(&mhi_cntrl->state_lock);
>   	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M3);

Are there any other spots that should do this?  For example, in
mhi_ep_set_ready_state() you don't check the return value of
the call to mhi_ep_set_mhi_state().  It seems to me it should
be possible to preclude bogus state changes anyway, but I'm
not completely sure.

>   	if (ret) {
> +		mhi_ep_handle_syserr(mhi_cntrl);
>   		spin_unlock_bh(&mhi_cntrl->state_lock);
>   		return ret;
>   	}

