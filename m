Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89214C0425
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiBVVxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbiBVVxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:53:22 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA0A145E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:52:54 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id p20so13383967ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DnQVyyMn8RG++Vgl/Pa8NzULdHKj/pUJucwQb5cYs+g=;
        b=s8yuX9EfwrdMsKsJdaHldrNLwhygAeMsozgvqodkSh6UwTSPwjMUpMOItZE4zbbICi
         nyl66PhI3+bsqrWnNUMc6Abr3kUid1/cO5/95pY2eC38/+MW60dZx8HuMsrxViYNlK1z
         CCg4K6PsA+CEt+2ArTHWYJe6w5N8liXkDk5JT0TouKwhyd5/0EOWN2S60MmjbAOFs9wm
         Jf2WD0lNSpxfxmZp4dFydIGaqJcJot9b1o/LnQZNWNf8zLyb5zpObJgNCOAOnzf7w/RY
         TuKd9zHJ7sUkv1A8uCo3PLTCG0HtMGHxaFRX8h6MRG1StVcPS0WcthPy2ykUREpUZO+i
         KEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DnQVyyMn8RG++Vgl/Pa8NzULdHKj/pUJucwQb5cYs+g=;
        b=l97op55kOPxsV+4DctRlmzrvXFZDTzxs5So/OL1T1eM1LP9Y8lJFKbyfiJxqRP8K4N
         /awDIrRM8RJkYWZZKQHQzfd1RwRFQgThRGG1T9yN7AzZP1Lh+npExLnHuztWr6jxAqnR
         FRChazFSx/xgWjd7pFj5Odh2bJxdWM+oJNHRQpIN3sjl42cqVj0+MAY9wgA/3EuhFYF3
         IfkBPKi1kfu1qzlniQYkhbCLxMCJ0UeAtayXKdiUzaQDgARbZOa+lSWe+UcIPRJ9G3qD
         fmXyUjkvJl1r9sdrDX/omXjZuJGPwP9lyxFX5XtrgNpKOa8z5GBHpO29QHSSnMSaT6xq
         MrkQ==
X-Gm-Message-State: AOAM532bDwJ6EbP1jKY4UqE5/yT3Fjix5MdrYm4Ri14PRP9sm2bNaVCL
        vh8I7jiX6gLlI4Z1TaA4m003RQ==
X-Google-Smtp-Source: ABdhPJxpf7TacdvKOq8G88nEdBuaCHZdQKLsTEYszp+u/DF9UoUbIm7a2znK9UJSTxFT+YEjSMKjKw==
X-Received: by 2002:a05:651c:12c5:b0:23e:1f55:35b4 with SMTP id 5-20020a05651c12c500b0023e1f5535b4mr18221737lje.58.1645566772827;
        Tue, 22 Feb 2022 13:52:52 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a7sm1485675lfr.12.2022.02.22.13.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 13:52:52 -0800 (PST)
Message-ID: <490deb0b-aecb-c4a8-ea02-2c687a8da57b@linaro.org>
Date:   Wed, 23 Feb 2022 00:52:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/4] drm/msm/dp: Add basic PSR support for eDP
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, quic_kalyant@quicinc.com,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        quic_vproddut@quicinc.com
References: <1645455086-9359-1-git-send-email-quic_vpolimer@quicinc.com>
 <1645455086-9359-2-git-send-email-quic_vpolimer@quicinc.com>
 <CAA8EJppRUZ5OHSMS1NdFXDDvRXJFNsdoJDWgU7ZPUoAW9OD+eQ@mail.gmail.com>
 <CAD=FV=W2wi47egKmWDS+BZGSy85K+A8jX0gvi6CYhmFgoBBRmw@mail.gmail.com>
 <c388d91c-ea00-8fa8-3fcf-4ce754edb1b4@linaro.org>
 <CAD=FV=WJdcVEmnUvFfkJY3V2eWF2t4xkfCKNwaFHY+FwORg4VA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=WJdcVEmnUvFfkJY3V2eWF2t4xkfCKNwaFHY+FwORg4VA@mail.gmail.com>
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

On 23/02/2022 00:32, Doug Anderson wrote:
> Hi,
> 
> On Tue, Feb 22, 2022 at 1:23 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On 22/02/2022 22:25, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Mon, Feb 21, 2022 at 7:12 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>>> +static int dp_link_psr_status(struct dp_link_private *link)
>>>>> +{
>>>>> +       u8 status[2];
>>>>> +
>>>>> +       drm_dp_dpcd_read(link->aux, DP_PSR_ERROR_STATUS, status, 2);
>>>>> +
>>>>> +       if (status[0] & DP_PSR_LINK_CRC_ERROR)
>>>>> +               DRM_ERROR("PSR LINK CRC ERROR\n");
>>>>> +       else if (status[0] & DP_PSR_RFB_STORAGE_ERROR)
>>>>> +               DRM_ERROR("PSR RFB STORAGE ERROR\n");
>>>>> +       else if (status[0] & DP_PSR_VSC_SDP_UNCORRECTABLE_ERROR)
>>>>> +               DRM_ERROR("PSR VSC SDP UNCORRECTABLE ERROR\n");
>>>>> +       else if (status[1] & DP_PSR_CAPS_CHANGE)
>>>>> +               DRM_INFO("PSR Capability Change\n");
>>>>
>>>> DRM_DEBUG_DP
>>>
>>> Not sure I'll have time to go back and review the series, but one
>>> thing that caught my eye as this flashed through my inbox is that I
>>> think all of these "shouting" are deprecated. It's even officially
>>> documented now as of commit d2f0a8afc1be ("UPSTREAM: drm/print: Add
>>> deprecation notes to DRM_...() functions").
>>
>> Agreed. But not the DRM_INFO too.
> 
> You're saying that DRM_INFO _isn't_ deprecated? I was pretty sure that
> it was, too. If not, can you please submit a patch to `drm_print.h`
> clarifying since my patch (which folks Acked) marked it as deprecated:

It is deprecated

> My understanding (also in the description of my patch) was that
> DRM_INFO() by itself didn't add much so we should just use the
> standard pr_info(). If pr_info() wasn't to your liking then it was
> better to do drm_info(drmdev, ...) or drm_info(NULL, ...);

I don't think we should get this message at all, unless debugging is 
enabled. Thus I asked to change DRM_INFO to DEBUG.

Regarding your point, I'm fine with either of them. Hopefully when 
Kuogee's patches are in, we can use drm_dbg_db w/o any issues.

-- 
With best wishes
Dmitry
