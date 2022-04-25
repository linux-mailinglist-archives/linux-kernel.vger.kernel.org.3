Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8850EB21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiDYVP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiDYVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:15:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0871580201
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:12:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so28484616lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n48UC8FYBgza6LVhcnu3WqzBBzGR0TUqYOXWNSGJNhA=;
        b=NH4maRhQqGMoN/cZAlAaVgXCc/h1NJVTKr8F0GqK2f8ubsZMl5exb0+1Pt4QRMKgg0
         AYUnTGmzTKIb3XBcHuUVxyDZACSd0xMzNm2eH5moaKl8WolVTJO/Y/dyEo2jDXCPr9a+
         y/6FIg3Nyp8fupRVie1iD6axXOMvzsZzzZLyhJMfWKDA4Q7A5msr07uvlTkaMP90b5yp
         JegglGvQ5rDlYD519GW/1BkBSsJJRIx12rxtN/ySXsP47PQ97e56NX9M+jJd4+r2fLFF
         tVYHv0gQHpwX4pOLAj+krJiRGHPiarefgMG3xVWcRrBwIDkgeQKeCoNucZ1CwuAt6FJ5
         v3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n48UC8FYBgza6LVhcnu3WqzBBzGR0TUqYOXWNSGJNhA=;
        b=J8ezsmYLroGyBNEY5uf8/hkeCZQRdFhXse6hOVnux0AG4AIGlFNxEZm1X46auJ9wd1
         z4OoWnulU+sVPLzW46g0qIhQGaXob3+mXqKRIl55YNCwqYXQD6Ayt+y9Fp4UR35Jpzwe
         t3PFaVkhWRE4vfZeKDKyNvp8P+TGTX9MCrsoz8UFOULSMJrqm+69SqIR1Ts4NhDFXWFv
         wKlUIRHuzsE8x83B8AT8ETlZaYnBTxPpzsQtULZ6ERsbN6c8rzj/79rtX0hO+VGZXDEc
         7Ds2+oB6q7awpwE5M4bGPAGFLy3nQ/CKrN4EiduAZD9fN7rSdG2hcNTpLAqIpuYKaFs6
         xdfQ==
X-Gm-Message-State: AOAM533FxXicXM9l7lcOhzTki9jDKtgn/XEeP8H/hD4kRIQio/01Bdtq
        7DFHXxyX/WIJaAtYjzyhh7rkVQ==
X-Google-Smtp-Source: ABdhPJwzna+WG3O2iW9VkiovidbQKqbuLtVxXaL1TUSZEFmS83MEMFZt8wBnv/+oE2d5HSXwHkMtqQ==
X-Received: by 2002:a19:674c:0:b0:448:3f49:e6d5 with SMTP id e12-20020a19674c000000b004483f49e6d5mr14477854lfj.518.1650921136308;
        Mon, 25 Apr 2022 14:12:16 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b11-20020a19670b000000b0044a385058acsm1522365lfc.187.2022.04.25.14.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 14:12:15 -0700 (PDT)
Message-ID: <664de9f0-a9a1-9b5e-9612-06a051c85434@linaro.org>
Date:   Tue, 26 Apr 2022 00:12:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 1/4] drm/msm/dp: Add eDP support via aux_bus
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "robdclark@gmail.com" <robdclark@gmail.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        Aravind Venkateswaran <quic_aravindh@quicinc.com>,
        "steev@kali.org" <steev@kali.org>
References: <1650618666-15342-1-git-send-email-quic_sbillaka@quicinc.com>
 <1650618666-15342-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAE-0n51VBDmOOworjpuB1nqVD-7055yqvn2Er5H13qgFC5R2AQ@mail.gmail.com>
 <MW4PR02MB7186108BA0131C8BFC46A219E1F89@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAE-0n51oUFkYuZ5qd2CbnaUGo2xcAjU+F0M+Kptk8b=7curH0Q@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAE-0n51oUFkYuZ5qd2CbnaUGo2xcAjU+F0M+Kptk8b=7curH0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 23:26, Stephen Boyd wrote:
> Quoting Sankeerth Billakanti (QUIC) (2022-04-25 02:39:43)
>> Hi Stephen,
>>
>>> Quoting Sankeerth Billakanti (2022-04-22 02:11:03)
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index d7a19d6..055681a 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>
>>> Some nitpicks
>>>
>>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>>>
>>>> @@ -1508,7 +1509,8 @@ void msm_dp_irq_postinstall(struct msm_dp
>>>> *dp_display)
>>>>
>>>>          dp_hpd_event_setup(dp);
>>>>
>>>> -       dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
>>>> +       if (!dp_display->is_edp)
>>>> +               dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
>>>
>>> Did it turn out that in fact DP isn't ready still to setup even after delaying the
>>> irq?
>>>
>>
>> The host_init, config_hpd, phy_init and enable_irq are happening in modeset_init already for eDP.
>> So, I am not scheduling the EV_HPD_INIT_SETUP event for eDP. I am not modifying the delay for DP.
> 
> Cool. That didn't answer my question though. Why does DP still need the
> delay? I thought recent changes made it unnecessary.

I'd say that if it is not necessary, it should be changed in the 
separate commit. The question is valid nevertheless.


-- 
With best wishes
Dmitry
