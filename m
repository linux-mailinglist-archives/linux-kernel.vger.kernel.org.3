Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50694BAF18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiBRBLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:11:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiBRBLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:11:10 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F13D4AD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:10:55 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u20so2479783lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0W1WD7a5hLH9VH6hSRJEAE/461r0glPlRYJ47p1TYCY=;
        b=qiFqTbxrbWjxfX4G899lNbH2XzztarAnZ1OFCDYiKzPDevKIHf6dGO8n/iNQUe49fD
         QI8sW7y3AhmVfC2wniziEeTeVoctoPPIk3S5jlpWsWoXa2vjHNqPVvDLjFB0s4HX77e6
         6Hb6LJq/y/32RmdBZ0Rc5cx5Z9XnNlZZXNXgfhznVhb7ckGU2r8VVE3NZgDeX1QfLc+3
         N1ZIAiPs6tBwPprEC2T2+35p+xcfaMFZR9EcJmNjiXv+ibPxIafWn5GB1UaDn24sr088
         02mIQglH3R7IO5aRWlt5kTyE3w3ebyMZJIoenE4Um1bVRfZW4Nt4IjjWkxn4G6BTlcJr
         9M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0W1WD7a5hLH9VH6hSRJEAE/461r0glPlRYJ47p1TYCY=;
        b=L8WjMoZ7I3//s8lzLC3AGhVG8satxRFGxt2NQNjCllkjGKV2jjR3fO9grcGD/JYAI6
         YaxVTsquHJc3V7GHZznKADGbKAkay8NQkMxXsGvrHiLJyBNBw6WPuZgb7i0u3pR+9RIs
         NGcQgJviakYVncinGXbB4X8FMEAYC2FMUgjBHnVAzIA67KJ6jQ1vKYPtiudOk9KfPSiz
         C7oU72wbzcoWUt7fIDDGeg8laukGk1RiAgxjPMA37SvJmkJPicrrbssHfjmvXHT1Gx2K
         nXgsaoyoX4slaCJMGiB+T8BO7Rwt+sLABuWVIbW1gjaB2kO5xVuRoRajkTQthok8Hec8
         7wuQ==
X-Gm-Message-State: AOAM531okmdkPWhZuZ22mAvniWAIltgp2t/dJnPF+I/x0Qasq24RZlex
        zmRELW/p5mRhF2ALa5dy+3lQDQ==
X-Google-Smtp-Source: ABdhPJzvi2LBUWLmCjxrHaFgDG3X1/BcfU0BR4XZTuJD/Du/I++bKf46YtVejY7wlJtI8/1kZIbImw==
X-Received: by 2002:a05:6512:c09:b0:442:d4fa:9bce with SMTP id z9-20020a0565120c0900b00442d4fa9bcemr3708901lfu.483.1645146653232;
        Thu, 17 Feb 2022 17:10:53 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u9sm142607ljd.48.2022.02.17.17.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 17:10:52 -0800 (PST)
Message-ID: <e2fab93e-82a6-4837-4ee5-ee1b16caa84d@linaro.org>
Date:   Fri, 18 Feb 2022 04:10:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [Freedreno] [PATCH v2 2/2] drm/msm/dpu: Add SC8180x to hw catalog
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220215043353.1256754-1-bjorn.andersson@linaro.org>
 <20220215043353.1256754-2-bjorn.andersson@linaro.org>
 <be397e2e-05ab-5c18-8e2d-16c443f0a6d1@quicinc.com>
 <Ygvisfhi0SY6XdAz@builder.lan>
 <6a3ef247-b26b-d505-cd85-92fb277163dd@quicinc.com>
 <CAA8EJprCaiPW=Kk0B69RNNwAk0xcqaxQA031sfR0ky+BfzcWKQ@mail.gmail.com>
 <ceb861e5-b1c8-d33e-c0b0-bea0b4cc0b66@quicinc.com>
 <CAA8EJppj+OBPVUgvefO38zp1RHpJw5pL0-4DCkgn3iAcPH-ptA@mail.gmail.com>
 <d0cac12e-7c03-2ba3-fb8d-aee09b72a1b1@quicinc.com>
 <YgxbYnpbBeOIkGWi@builder.lan>
 <7b33c826-b141-c6a2-b0eb-18b99ceeda24@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <7b33c826-b141-c6a2-b0eb-18b99ceeda24@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 05:16, Abhinav Kumar wrote:
> 
> 
> On 2/15/2022 6:03 PM, Bjorn Andersson wrote:
>> On Tue 15 Feb 19:34 CST 2022, Abhinav Kumar wrote:
>>
>>>
>>>
>>> On 2/15/2022 4:20 PM, Dmitry Baryshkov wrote:
>>>> On Tue, 15 Feb 2022 at 23:21, Abhinav Kumar 
>>>> <quic_abhinavk@quicinc.com> wrote:
>>>>> On 2/15/2022 10:42 AM, Dmitry Baryshkov wrote:
>>>>>> On Tue, 15 Feb 2022 at 20:42, Abhinav Kumar 
>>>>>> <quic_abhinavk@quicinc.com> wrote:
>>>>>>> On 2/15/2022 9:28 AM, Bjorn Andersson wrote:
>>>>>>>> On Tue 15 Feb 11:14 CST 2022, Abhinav Kumar wrote:
>>>>>>>>> On 2/14/2022 8:33 PM, Bjorn Andersson wrote:
>>>>>>>>>> From: Rob Clark <robdclark@chromium.org>
>> [..]
>>>>>> (thus leading us to cases when someone would forget to add INTF_EDP
>>>>>> next to INTF_DP)
>>>>>>
>>>>>> Also, if we are switching from INTF_DP to INTF_EDP, should we stop
>>>>>> using end-to-end numbering (like MSM_DP_CONTROLLER_2 for INTF_5) and
>>>>>> add a separate numbering scheme for INTF_EDP?
>>>>>>
>>>>> We should change the controller ID to match what it actually is.
>>>>>
>>>>> Now that you pointed this out, this looks even more confusing to me to
>>>>> say that  MSM_DP_CONTROLLER_2 is actually a EDP controller because
>>>>> fundamentally and even hardware block wise they are different.
>>>>
>>>> So, do we split msm_priv->dp too? It's indexed using
>>>> MSM_DP_CONTROLLER_n entries.
>>>> Do we want to teach drm/msm/dp code that there are priv->dp[] and
>>>> priv->edp arrays?
>>>
>>> ok so now priv->dp and priv->edp arrays are also in the picture here :)
>>>
>>> Actually all these questions should have probably come when we were 
>>> figuring
>>> out how best to re-use eDP and DP driver.

Well, these questions were evaluated. And this resulted in our 
suggestion to reuse DP driver, INTF_DP type and priv->dp array.

>>>
>>> Either way atleast, its good we are documenting all these questions 
>>> on this
>>> thread so that anyone can refer this to know what all was missed out :)
>>>
>>> priv->dp is of type msm_dp. When re-using DP driver for eDP and since
>>> struct msm_dp is the shared struct between dpu and the msm/dp, I get 
>>> your
>>> point of re-using MSM_DP_CONTROLLER_* as thats being use to index.
>>>
>>> So MSM_DP_CONTROLLER_* is more of an index into the DP driver and not 
>>> really
>>> a hardware indexing scheme.
>>>
>>> If we split into two arrays, we need more changes to dpu_encoder too.
>>>
>>> Too instrusive a change at this point, even though probably correct.
>>>
>>
>> I'm sorry, but performing such a split would create a whole bunch of
>> duplication and I don't see the reasons yet. Can you please give me an
>> example of when the DPU _code_ would benefit from being specifically
>> written for EDP vs DP?
>>
>> Things where it doesn't make sense to enable certain features in
>> runtime - but really have different implementation for the two interface
>> types.
>>
> 
> Like I have mentioned in my previous comment, this would be a big change 
> and I am also not in favor of this big change.
I'm also not in favour of splitting priv->dp into ->dp and ->edp.

One of the reasons, pointed out by Bjorn, is that some of interfaces can 
be used for both DP and eDP. Adding them to either of arrays would 
create confusion.

Second reason being that introducing the split would bring in extra code 
for no additional benefits. From the DPU point of view both DP and eDP 
interfaces look the same.

>>> But are you seeing more changes required even if we just change 
>>> INTF_DP to
>>> INTF_eDP for the eDP entries? What are the challenges there?
>>>
>>
>> What are the benefits?
> 
> In terms of current code, again like I said before in my previous 
> comments several times I do not have an example.
> 
> I was keeping the separation in case in future for some features we do 
> need to differentiate eDP and DP.

And we also might need to separte eDP-behind msm/dp and old-8x74-eDP.
It the same "possible" future that we might face.

> 
> Somehow I also feel this change and below are interlinked that way.
> 
> https://patchwork.freedesktop.org/patch/473871/
> 
> The only reason we need this change is because both eDP and DP use 
> DRM_MODE_ENCODER_TMDS and specifying the intf_type directly will clear 
> the confusion because DRM_MODE_ENCODER_DSI means DSI and 
> DRM_MODE_ENCODER_VIRTUAL means Writeback but DRM_MODE_ENCODER_TMDS can 
> mean DP OR eDP interface.
> 
> The ambiguity was always for eDP and DP.
> 
> That led to the discussion about the INTF_* we are specifying in the 
> dpu_hw_catalog only to find the discrepancy.
> 
> So now by clearing that ambiguity that change makes sense. That 
> discussion trickled into this one.

I did some research for the INTF_*. As you probably remember (I didn't) 
on mdp4 and mdp5 chipsets we program the DISP_INTF_SEL registers, 
telling the hardware which hardware is to be driven by each of INTFs.
The freely available 410E HRD demands that this register is written.

At some point this became unnecessary, but the DPU driver kept INTF_* 
intact. Including INTF_EDP, INTF_LCDC, INTF_HDMI, etc. However from my 
understanding INTF_EDP would correspond to older eDP interfaces, not to 
eDP panels being connected by the contemporary DP/eDP ports.

Oh, and last but not least, I'd suggest to follow downstream, which uses 
"dp" to name all of DP/EDP ports. See 
https://github.com/TheXPerienceProject/android_kernel_xiaomi_courbet/blob/xpe-16.0/arch/arm64/boot/dts/qcom/sdmshrike-sde.dtsi#L89

So, to summarize my proposal:
- Keep INTF_EDP reserved for 8x74/8x84
- Use INTF_DP for all contemporary DP and eDP ports
- Documet this in dpu_hw_mdss.h
- Remove INTF_EDP usage in dpu1 driver.

-- 
With best wishes
Dmitry
