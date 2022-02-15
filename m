Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29034B77B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbiBOUCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:02:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243920AbiBOUCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:02:39 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1464D716D5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:24 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i62so25351770ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D3ST9OwWV2E0u/pY+Bso2hkYIX4M80QDHlk9PLpNxg0=;
        b=oEnIqV917D/RmVjT9kQeu4DBp25Gy7JkTOlPxVTr0UoTXahW9A6z8sT4tIU0hxpKzz
         Lu4Us+v3iwNHpxT3ZPN0s6Gy9DKIf/3278ZY2BhDbM3WHZ2b2o1U2N/LVOghAdbCD8Rz
         MKXKL7N4GrUNzWelfqSfO6YJaQIIs6SPLK+YniGiuUm4F09suQEMlnyCU7nKoGEeeiaB
         xfPeV1Mos4TTX/KB3LEfxRnSz13SowBcqpQLkYWwaslXsHRsaO3oca2/SoFSCu7kG4WD
         ou5Ida9Kq171KCUkq5Fg07LxAFB96NdArjoip94vER9hxBt0//TFYulWohTSVcdNP0aR
         NajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D3ST9OwWV2E0u/pY+Bso2hkYIX4M80QDHlk9PLpNxg0=;
        b=Et1pza8iOpD/7gdCIuyO9Iq/GMWm8ONI1dhw5Vk4JMU36CFmk2QgvuLtA89lZik5gV
         sBAlj7T658XyhFdKXroKjhj4eXL6Y140YDO0T93/y3I0tFl8EDIJKcfxz6tRo+DvOktj
         HnNm7uUW0g0SdmdM/bZ3Fqyw50jDWc0D4bQncBlK4P5kxXdd5DiDCeIb2R55jGSE+9eD
         ZaBz0t4u0rd07nh/HXkzUqvAfinOr8ayS958YiS0sYRl/pAsdsIgjOX421om1r+X0X/b
         FlBO13zptB4Tn+Swb4F2nvdEXASHSQZb0NP8pLRkED4VsqfBplQm29VCUKqz+EeUT/uy
         YCqg==
X-Gm-Message-State: AOAM533ef78yhfqWSSdBqL0DaDE8l2XmdqyjekKOOV8v3+ePGSwgw8zA
        xvsxZN9XRKa0uRe+AauD34W5Ew==
X-Google-Smtp-Source: ABdhPJynIRiQx9dl8eNLBZn7OgaXdvY7Z/CbCICqNqUITECzuG6C2Vjix3DQ5GF6qHDg98ohOEWz4Q==
X-Received: by 2002:a05:6638:3711:: with SMTP id k17mr368776jav.70.1644955343415;
        Tue, 15 Feb 2022 12:02:23 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f2sm3063727ilu.79.2022.02.15.12.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:02:22 -0800 (PST)
Message-ID: <f5222344-b74f-083c-d0f6-48fb3f034542@linaro.org>
Date:   Tue, 15 Feb 2022 14:02:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/25] bus: mhi: Make mhi_state_str[] array static
 inline and move to common.h
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
 <20220212182117.49438-6-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-6-manivannan.sadhasivam@linaro.org>
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

On 2/12/22 12:20 PM, Manivannan Sadhasivam wrote:
> mhi_state_str[] array could be used by MHI endpoint stack also. So let's
> make the array as "static inline function" and move it inside the
> "common.h" header so that the endpoint stack could also make use of it.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I like the use of a function to encapsulate this rather than
using the array as before.

But I still don't like declaring this much static data in a static 
inline function in a header file.  Define it as a "real" function
somewhere common and declare it here instead.

One more minor comment below.

					-Alex

> ---
>   drivers/bus/mhi/common.h       | 29 +++++++++++++++++++++++++----
>   drivers/bus/mhi/host/boot.c    |  2 +-
>   drivers/bus/mhi/host/debugfs.c |  6 +++---
>   drivers/bus/mhi/host/init.c    | 12 ------------
>   drivers/bus/mhi/host/main.c    |  8 ++++----
>   drivers/bus/mhi/host/pm.c      | 14 +++++++-------
>   6 files changed, 40 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> index 0d13a202d334..288e47168649 100644
> --- a/drivers/bus/mhi/common.h
> +++ b/drivers/bus/mhi/common.h
> @@ -159,9 +159,30 @@ struct mhi_cmd_ctxt {
>   	__le64 wp __packed __aligned(4);
>   };
>   
> -extern const char * const mhi_state_str[MHI_STATE_MAX];
> -#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
> -				  !mhi_state_str[state]) ? \
> -				"INVALID_STATE" : mhi_state_str[state])
> +static inline const char * const mhi_state_str(enum mhi_state state)
> +{
> +	switch (state) {
> +	case MHI_STATE_RESET:
> +		return "RESET";
> +	case MHI_STATE_READY:
> +		return "READY";
> +	case MHI_STATE_M0:
> +		return "M0";
> +	case MHI_STATE_M1:
> +		return "M1";
> +	case MHI_STATE_M2:
> +		return"M2";

Add space after "return" here and in a few places below.

> +	case MHI_STATE_M3:
> +		return"M3";
> +	case MHI_STATE_M3_FAST:
> +		return"M3 FAST";
> +	case MHI_STATE_BHI:
> +		return"BHI";
> +	case MHI_STATE_SYS_ERR:
> +		return "SYS ERROR";
> +	default:
> +		return "Unknown state";
> +	}
> +};
>   
>   #endif /* _MHI_COMMON_H */
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index 74295d3cc662..93cb705614c6 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -68,7 +68,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>   
>   	dev_dbg(dev, "Entered with pm_state:%s dev_state:%s ee:%s\n",
>   		to_mhi_pm_state_str(mhi_cntrl->pm_state),
> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
> +		mhi_state_str(mhi_cntrl->dev_state),
>   		TO_MHI_EXEC_STR(mhi_cntrl->ee));
>   
>   	/*
> diff --git a/drivers/bus/mhi/host/debugfs.c b/drivers/bus/mhi/host/debugfs.c
> index d818586c229d..399d0db1f1eb 100644
> --- a/drivers/bus/mhi/host/debugfs.c
> +++ b/drivers/bus/mhi/host/debugfs.c
> @@ -20,7 +20,7 @@ static int mhi_debugfs_states_show(struct seq_file *m, void *d)
>   	seq_printf(m, "PM state: %s Device: %s MHI state: %s EE: %s wake: %s\n",
>   		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
>   		   mhi_is_active(mhi_cntrl) ? "Active" : "Inactive",
> -		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
> +		   mhi_state_str(mhi_cntrl->dev_state),
>   		   TO_MHI_EXEC_STR(mhi_cntrl->ee),
>   		   mhi_cntrl->wake_set ? "true" : "false");
>   
> @@ -206,13 +206,13 @@ static int mhi_debugfs_regdump_show(struct seq_file *m, void *d)
>   
>   	seq_printf(m, "Host PM state: %s Device state: %s EE: %s\n",
>   		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
> -		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
> +		   mhi_state_str(mhi_cntrl->dev_state),
>   		   TO_MHI_EXEC_STR(mhi_cntrl->ee));
>   
>   	state = mhi_get_mhi_state(mhi_cntrl);
>   	ee = mhi_get_exec_env(mhi_cntrl);
>   	seq_printf(m, "Device EE: %s state: %s\n", TO_MHI_EXEC_STR(ee),
> -		   TO_MHI_STATE_STR(state));
> +		   mhi_state_str(state));
>   
>   	for (i = 0; regs[i].name; i++) {
>   		if (!regs[i].base)
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 4bd62f32695d..0e301f3f305e 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -44,18 +44,6 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
>   	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
>   };
>   
> -const char * const mhi_state_str[MHI_STATE_MAX] = {
> -	[MHI_STATE_RESET] = "RESET",
> -	[MHI_STATE_READY] = "READY",
> -	[MHI_STATE_M0] = "M0",
> -	[MHI_STATE_M1] = "M1",
> -	[MHI_STATE_M2] = "M2",
> -	[MHI_STATE_M3] = "M3",
> -	[MHI_STATE_M3_FAST] = "M3 FAST",
> -	[MHI_STATE_BHI] = "BHI",
> -	[MHI_STATE_SYS_ERR] = "SYS ERROR",
> -};
> -
>   const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
>   	[MHI_CH_STATE_TYPE_RESET] = "RESET",
>   	[MHI_CH_STATE_TYPE_STOP] = "STOP",
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 85f4f7c8d7c6..e436c2993d97 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -479,8 +479,8 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>   	ee = mhi_get_exec_env(mhi_cntrl);
>   	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
>   		TO_MHI_EXEC_STR(mhi_cntrl->ee),
> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
> -		TO_MHI_EXEC_STR(ee), TO_MHI_STATE_STR(state));
> +		mhi_state_str(mhi_cntrl->dev_state),
> +		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
>   
>   	if (state == MHI_STATE_SYS_ERR) {
>   		dev_dbg(dev, "System error detected\n");
> @@ -846,7 +846,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>   			new_state = MHI_TRE_GET_EV_STATE(local_rp);
>   
>   			dev_dbg(dev, "State change event to state: %s\n",
> -				TO_MHI_STATE_STR(new_state));
> +				mhi_state_str(new_state));
>   
>   			switch (new_state) {
>   			case MHI_STATE_M0:
> @@ -873,7 +873,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>   			}
>   			default:
>   				dev_err(dev, "Invalid state: %s\n",
> -					TO_MHI_STATE_STR(new_state));
> +					mhi_state_str(new_state));
>   			}
>   
>   			break;
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index c35c5ddc7220..088ade0f3e0b 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -545,7 +545,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>   
>   	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
>   		to_mhi_pm_state_str(mhi_cntrl->pm_state),
> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
> +		mhi_state_str(mhi_cntrl->dev_state));
>   
>   	mutex_unlock(&mhi_cntrl->pm_mutex);
>   }
> @@ -689,7 +689,7 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
>   exit_sys_error_transition:
>   	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
>   		to_mhi_pm_state_str(mhi_cntrl->pm_state),
> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
> +		mhi_state_str(mhi_cntrl->dev_state));
>   
>   	mutex_unlock(&mhi_cntrl->pm_mutex);
>   }
> @@ -864,7 +864,7 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
>   	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
>   		dev_err(dev,
>   			"Did not enter M3 state, MHI state: %s, PM state: %s\n",
> -			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
> +			mhi_state_str(mhi_cntrl->dev_state),
>   			to_mhi_pm_state_str(mhi_cntrl->pm_state));
>   		return -EIO;
>   	}
> @@ -890,7 +890,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
>   
>   	dev_dbg(dev, "Entered with PM state: %s, MHI state: %s\n",
>   		to_mhi_pm_state_str(mhi_cntrl->pm_state),
> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
> +		mhi_state_str(mhi_cntrl->dev_state));
>   
>   	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
>   		return 0;
> @@ -900,7 +900,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
>   
>   	if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3) {
>   		dev_warn(dev, "Resuming from non M3 state (%s)\n",
> -			 TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
> +			 mhi_state_str(mhi_get_mhi_state(mhi_cntrl)));
>   		if (!force)
>   			return -EINVAL;
>   	}
> @@ -937,7 +937,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
>   	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
>   		dev_err(dev,
>   			"Did not enter M0 state, MHI state: %s, PM state: %s\n",
> -			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
> +			mhi_state_str(mhi_cntrl->dev_state),
>   			to_mhi_pm_state_str(mhi_cntrl->pm_state));
>   		return -EIO;
>   	}
> @@ -1088,7 +1088,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>   
>   	state = mhi_get_mhi_state(mhi_cntrl);
>   	dev_dbg(dev, "Attempting power on with EE: %s, state: %s\n",
> -		TO_MHI_EXEC_STR(current_ee), TO_MHI_STATE_STR(state));
> +		TO_MHI_EXEC_STR(current_ee), mhi_state_str(state));
>   
>   	if (state == MHI_STATE_SYS_ERR) {
>   		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);

