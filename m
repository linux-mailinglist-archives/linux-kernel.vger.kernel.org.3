Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5124B8B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiBPOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:30:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiBPOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:30:47 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15476293B62
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:30:35 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id k18so1522495ils.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dwLzMfgNOWmPItYOyAcXlCBWmY3dWHk4dvllDYGGKro=;
        b=dSxb8Nr+ifXWcZ0I82j4ax+ByfppReil7K8ujbNKL6eXDywtEFRQKzyxi51Nj9/69i
         7vTlIFJJnyMqDHCr2sUy3FdkC6RTJoC5PbeiV0ESZFAfx0LKgm8q/xepRzC7t/IaCwvm
         1dx7GRSl9juxHh8nSSXZhMDJZ7Im02Dl/T6r/5fqQ7P2s03F3bz0ARILUzI9ADkTDofY
         dJiouJBNVUNa7BjnSTj5DGgZ5pVVETa/8+Urd50gc1UqXk7yC94t3HoZAsWibiZJV/8S
         TgnyjKgTpaoqR/HXz4Fzt6apOXvga7w7h5numvVR3b9f4o/PtP5j2tu1QgPp/5IMMbYX
         sj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dwLzMfgNOWmPItYOyAcXlCBWmY3dWHk4dvllDYGGKro=;
        b=7erFkcsfjofoKeekrqowFQ/HZZ4KiE7HtpXmj6O+l0DlWt9Np6H07ikEpYZpNzk2MJ
         NcCi9is9OLB4v+4xtGS7tG/2yVBGaTRPhx7wWPqOZmB/GaIpfAK8vzwPb0U0UCX0iSZ/
         L0GYoi9Kn9d17qdjJqwlE4FxxQazaKWjhMmPTB42g+sg7kJXktez8cAL85A9GIY8+XJQ
         9qBa9KP94zSCc5RvCOfj9/+UIqg1TcIU+SxKhEuYsJiyaTESy2ZRsz5RX4yDCVyzSUN6
         yQnPB1zxNOndMGtGblndRG6dcH4WU/o19VDbcfujnpGL/5WtVX3zSUHpwOte3y6NgU5T
         6S+w==
X-Gm-Message-State: AOAM530tozlIK3MVOkWcm+NbwXao5zzEvw33BOF39XJmgbGs8OAbCKoi
        iiATFX7RyhmJP522xCyQBENmcw==
X-Google-Smtp-Source: ABdhPJxnk7ohLYgxeus111vwVw6vOxg/Z6Csxrw8XxEvSKc50SMWXaCimdxVwcp1YuGMSmpzFML95w==
X-Received: by 2002:a05:6e02:54e:b0:2be:8108:c0dc with SMTP id i14-20020a056e02054e00b002be8108c0dcmr2010087ils.65.1645021834217;
        Wed, 16 Feb 2022 06:30:34 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v62sm19625810iof.26.2022.02.16.06.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 06:30:33 -0800 (PST)
Message-ID: <d0557bb0-7d9f-2abc-2b78-7d7ab078a2e0@linaro.org>
Date:   Wed, 16 Feb 2022 08:30:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/25] bus: mhi: Make mhi_state_str[] array static
 inline and move to common.h
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-6-manivannan.sadhasivam@linaro.org>
 <f5222344-b74f-083c-d0f6-48fb3f034542@linaro.org>
 <20220216113942.GC6225@workstation>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220216113942.GC6225@workstation>
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

On 2/16/22 5:39 AM, Manivannan Sadhasivam wrote:
> On Tue, Feb 15, 2022 at 02:02:21PM -0600, Alex Elder wrote:
>> On 2/12/22 12:20 PM, Manivannan Sadhasivam wrote:
>>> mhi_state_str[] array could be used by MHI endpoint stack also. So let's
>>> make the array as "static inline function" and move it inside the
>>> "common.h" header so that the endpoint stack could also make use of it.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> I like the use of a function to encapsulate this rather than
>> using the array as before.
>>
>> But I still don't like declaring this much static data in a static inline
>> function in a header file.  Define it as a "real" function
>> somewhere common and declare it here instead.
>>
> 
> The problem is we don't have a common c file to define this as a
> function. Even if we add one, then it would be an overkill.

OK, I accept that.	-Alex

> 
> This pattern is more commonly used throughout the kernel source.
> 
>> One more minor comment below.
>>
>> 					-Alex
>>
>>> ---
>>>    drivers/bus/mhi/common.h       | 29 +++++++++++++++++++++++++----
>>>    drivers/bus/mhi/host/boot.c    |  2 +-
>>>    drivers/bus/mhi/host/debugfs.c |  6 +++---
>>>    drivers/bus/mhi/host/init.c    | 12 ------------
>>>    drivers/bus/mhi/host/main.c    |  8 ++++----
>>>    drivers/bus/mhi/host/pm.c      | 14 +++++++-------
>>>    6 files changed, 40 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>>> index 0d13a202d334..288e47168649 100644
>>> --- a/drivers/bus/mhi/common.h
>>> +++ b/drivers/bus/mhi/common.h
>>> @@ -159,9 +159,30 @@ struct mhi_cmd_ctxt {
>>>    	__le64 wp __packed __aligned(4);
>>>    };
>>> -extern const char * const mhi_state_str[MHI_STATE_MAX];
>>> -#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
>>> -				  !mhi_state_str[state]) ? \
>>> -				"INVALID_STATE" : mhi_state_str[state])
>>> +static inline const char * const mhi_state_str(enum mhi_state state)
>>> +{
>>> +	switch (state) {
>>> +	case MHI_STATE_RESET:
>>> +		return "RESET";
>>> +	case MHI_STATE_READY:
>>> +		return "READY";
>>> +	case MHI_STATE_M0:
>>> +		return "M0";
>>> +	case MHI_STATE_M1:
>>> +		return "M1";
>>> +	case MHI_STATE_M2:
>>> +		return"M2";
>>
>> Add space after "return" here and in a few places below.
>>
> 
> Ack.
> 
> Thanks,
> Mani
> 
>>> +	case MHI_STATE_M3:
>>> +		return"M3";
>>> +	case MHI_STATE_M3_FAST:
>>> +		return"M3 FAST";
>>> +	case MHI_STATE_BHI:
>>> +		return"BHI";
>>> +	case MHI_STATE_SYS_ERR:
>>> +		return "SYS ERROR";
>>> +	default:
>>> +		return "Unknown state";
>>> +	}
>>> +};
>>>    #endif /* _MHI_COMMON_H */
>>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>>> index 74295d3cc662..93cb705614c6 100644
>>> --- a/drivers/bus/mhi/host/boot.c
>>> +++ b/drivers/bus/mhi/host/boot.c
>>> @@ -68,7 +68,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>>>    	dev_dbg(dev, "Entered with pm_state:%s dev_state:%s ee:%s\n",
>>>    		to_mhi_pm_state_str(mhi_cntrl->pm_state),
>>> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
>>> +		mhi_state_str(mhi_cntrl->dev_state),
>>>    		TO_MHI_EXEC_STR(mhi_cntrl->ee));
>>>    	/*
>>> diff --git a/drivers/bus/mhi/host/debugfs.c b/drivers/bus/mhi/host/debugfs.c
>>> index d818586c229d..399d0db1f1eb 100644
>>> --- a/drivers/bus/mhi/host/debugfs.c
>>> +++ b/drivers/bus/mhi/host/debugfs.c
>>> @@ -20,7 +20,7 @@ static int mhi_debugfs_states_show(struct seq_file *m, void *d)
>>>    	seq_printf(m, "PM state: %s Device: %s MHI state: %s EE: %s wake: %s\n",
>>>    		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
>>>    		   mhi_is_active(mhi_cntrl) ? "Active" : "Inactive",
>>> -		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
>>> +		   mhi_state_str(mhi_cntrl->dev_state),
>>>    		   TO_MHI_EXEC_STR(mhi_cntrl->ee),
>>>    		   mhi_cntrl->wake_set ? "true" : "false");
>>> @@ -206,13 +206,13 @@ static int mhi_debugfs_regdump_show(struct seq_file *m, void *d)
>>>    	seq_printf(m, "Host PM state: %s Device state: %s EE: %s\n",
>>>    		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
>>> -		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
>>> +		   mhi_state_str(mhi_cntrl->dev_state),
>>>    		   TO_MHI_EXEC_STR(mhi_cntrl->ee));
>>>    	state = mhi_get_mhi_state(mhi_cntrl);
>>>    	ee = mhi_get_exec_env(mhi_cntrl);
>>>    	seq_printf(m, "Device EE: %s state: %s\n", TO_MHI_EXEC_STR(ee),
>>> -		   TO_MHI_STATE_STR(state));
>>> +		   mhi_state_str(state));
>>>    	for (i = 0; regs[i].name; i++) {
>>>    		if (!regs[i].base)
>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>> index 4bd62f32695d..0e301f3f305e 100644
>>> --- a/drivers/bus/mhi/host/init.c
>>> +++ b/drivers/bus/mhi/host/init.c
>>> @@ -44,18 +44,6 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
>>>    	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
>>>    };
>>> -const char * const mhi_state_str[MHI_STATE_MAX] = {
>>> -	[MHI_STATE_RESET] = "RESET",
>>> -	[MHI_STATE_READY] = "READY",
>>> -	[MHI_STATE_M0] = "M0",
>>> -	[MHI_STATE_M1] = "M1",
>>> -	[MHI_STATE_M2] = "M2",
>>> -	[MHI_STATE_M3] = "M3",
>>> -	[MHI_STATE_M3_FAST] = "M3 FAST",
>>> -	[MHI_STATE_BHI] = "BHI",
>>> -	[MHI_STATE_SYS_ERR] = "SYS ERROR",
>>> -};
>>> -
>>>    const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
>>>    	[MHI_CH_STATE_TYPE_RESET] = "RESET",
>>>    	[MHI_CH_STATE_TYPE_STOP] = "STOP",
>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>> index 85f4f7c8d7c6..e436c2993d97 100644
>>> --- a/drivers/bus/mhi/host/main.c
>>> +++ b/drivers/bus/mhi/host/main.c
>>> @@ -479,8 +479,8 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>>>    	ee = mhi_get_exec_env(mhi_cntrl);
>>>    	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
>>>    		TO_MHI_EXEC_STR(mhi_cntrl->ee),
>>> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
>>> -		TO_MHI_EXEC_STR(ee), TO_MHI_STATE_STR(state));
>>> +		mhi_state_str(mhi_cntrl->dev_state),
>>> +		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
>>>    	if (state == MHI_STATE_SYS_ERR) {
>>>    		dev_dbg(dev, "System error detected\n");
>>> @@ -846,7 +846,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>>>    			new_state = MHI_TRE_GET_EV_STATE(local_rp);
>>>    			dev_dbg(dev, "State change event to state: %s\n",
>>> -				TO_MHI_STATE_STR(new_state));
>>> +				mhi_state_str(new_state));
>>>    			switch (new_state) {
>>>    			case MHI_STATE_M0:
>>> @@ -873,7 +873,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>>>    			}
>>>    			default:
>>>    				dev_err(dev, "Invalid state: %s\n",
>>> -					TO_MHI_STATE_STR(new_state));
>>> +					mhi_state_str(new_state));
>>>    			}
>>>    			break;
>>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>>> index c35c5ddc7220..088ade0f3e0b 100644
>>> --- a/drivers/bus/mhi/host/pm.c
>>> +++ b/drivers/bus/mhi/host/pm.c
>>> @@ -545,7 +545,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>>>    	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
>>>    		to_mhi_pm_state_str(mhi_cntrl->pm_state),
>>> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
>>> +		mhi_state_str(mhi_cntrl->dev_state));
>>>    	mutex_unlock(&mhi_cntrl->pm_mutex);
>>>    }
>>> @@ -689,7 +689,7 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
>>>    exit_sys_error_transition:
>>>    	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
>>>    		to_mhi_pm_state_str(mhi_cntrl->pm_state),
>>> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
>>> +		mhi_state_str(mhi_cntrl->dev_state));
>>>    	mutex_unlock(&mhi_cntrl->pm_mutex);
>>>    }
>>> @@ -864,7 +864,7 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
>>>    	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
>>>    		dev_err(dev,
>>>    			"Did not enter M3 state, MHI state: %s, PM state: %s\n",
>>> -			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
>>> +			mhi_state_str(mhi_cntrl->dev_state),
>>>    			to_mhi_pm_state_str(mhi_cntrl->pm_state));
>>>    		return -EIO;
>>>    	}
>>> @@ -890,7 +890,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
>>>    	dev_dbg(dev, "Entered with PM state: %s, MHI state: %s\n",
>>>    		to_mhi_pm_state_str(mhi_cntrl->pm_state),
>>> -		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
>>> +		mhi_state_str(mhi_cntrl->dev_state));
>>>    	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
>>>    		return 0;
>>> @@ -900,7 +900,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
>>>    	if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3) {
>>>    		dev_warn(dev, "Resuming from non M3 state (%s)\n",
>>> -			 TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
>>> +			 mhi_state_str(mhi_get_mhi_state(mhi_cntrl)));
>>>    		if (!force)
>>>    			return -EINVAL;
>>>    	}
>>> @@ -937,7 +937,7 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
>>>    	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
>>>    		dev_err(dev,
>>>    			"Did not enter M0 state, MHI state: %s, PM state: %s\n",
>>> -			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
>>> +			mhi_state_str(mhi_cntrl->dev_state),
>>>    			to_mhi_pm_state_str(mhi_cntrl->pm_state));
>>>    		return -EIO;
>>>    	}
>>> @@ -1088,7 +1088,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>>>    	state = mhi_get_mhi_state(mhi_cntrl);
>>>    	dev_dbg(dev, "Attempting power on with EE: %s, state: %s\n",
>>> -		TO_MHI_EXEC_STR(current_ee), TO_MHI_STATE_STR(state));
>>> +		TO_MHI_EXEC_STR(current_ee), mhi_state_str(state));
>>>    	if (state == MHI_STATE_SYS_ERR) {
>>>    		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
>>

