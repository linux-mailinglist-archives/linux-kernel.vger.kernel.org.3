Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241F2467D83
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348562AbhLCSyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhLCSyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:54:39 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5E3C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:51:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u3so8733853lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AoGWj/bWqwFWdFDfAGCiZt2+Rrs0vhzQ2O7jMvIrWTE=;
        b=i7hnxehXR4Qq6dr9FYM+t6kwmA5qmPA39SksNpMT3nrmhOGSEp0jngHnpulMw5gXXb
         c+vskdcXt2UBcrbrvhsUNkWEIHIPFuVeBkFZmzot8MboOly04tZW5IK9Ex30bQYbYIFG
         hHp8w43Fhec4OCyS0j5tlitqI9VhnlZXT3VRk+LlTfHxItKgMqvHBFstf4FzVH3fmSz4
         5eSJ0v8ygAj24QW8Gp8v8JAW8GnU4VCOLeiKPBZo7FJsWbsNzpFbdSeApsYFHBWbeHjc
         lpGJEBgwU9yn9FvkYpUN9XfL7eLmwuNYYHWGaxAZ+JPdAZ2RYeGwtsAxVwKDxx4sBJmY
         IAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AoGWj/bWqwFWdFDfAGCiZt2+Rrs0vhzQ2O7jMvIrWTE=;
        b=nP25A4J01JkcoeZhiE9xo7Cd0/CHYI9XW9roo0zqRMhJd2/aL7CRZ5+bflXCRZOIoi
         r8J81p3rjHAAVbqVsewoQr7Jazj0IIubgRtbPkJhd7/umgVQ7fIZmJfVSwpZsnldoC4E
         T+quztU9Kft/OFcYtERgvfAQduAt6k0YejeI4EEW4wzfMbj9jEo3mnUZtoDerZGDvm3A
         sUhBuTwXlEuevurT8EXDnlcLt6mkp/PycDWflSOdg3l03UUCpnYcJy0UDCfStrUOKJUC
         0tOkv2GJIDJi8p/+TtuRyEPMOyk/WsIOwQKOKCMYlWMRhOcfexguPhIF38aGz6dQLkLS
         oYjg==
X-Gm-Message-State: AOAM532Zu150De4fLL/85z47k9CQBemVgIft242dNatOU1vzafAslaGk
        Tq1/CN0DwkuYd289+WbYyh2qiA==
X-Google-Smtp-Source: ABdhPJx3oNQ/pRiEn2+/u0ktbVPcBmU8snjmPDRzgL+8t9ORKohqKzHYrihygwoe+ybgKC2OUge75Q==
X-Received: by 2002:ac2:55a6:: with SMTP id y6mr18888149lfg.406.1638557473337;
        Fri, 03 Dec 2021 10:51:13 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id c15sm465158lfb.154.2021.12.03.10.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:51:12 -0800 (PST)
Message-ID: <8ee2b4d4-44f3-6d03-b674-613b5b04a754@linaro.org>
Date:   Fri, 3 Dec 2021 21:51:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/msm/a5xx: Add support for Adreno 506 GPU
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211022114349.102552-1-vladimir.lypak@gmail.com>
 <YXL16V17upehvUwt@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YXL16V17upehvUwt@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2021 20:33, Bjorn Andersson wrote:
> On Fri 22 Oct 04:43 PDT 2021, Vladimir Lypak wrote:
> 
>> This GPU is found on SoCs such as MSM8953(650MHz), SDM450(600MHz),
>> SDM632(725MHz).
>>
>> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>> ---
>>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c      | 34 ++++++++++++++--------
>>   drivers/gpu/drm/msm/adreno/adreno_device.c | 18 ++++++++++++
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 ++++
>>   3 files changed, 45 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>> index 5e2750eb3810..249a0d8bc673 100644
>> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>> @@ -441,7 +441,7 @@ void a5xx_set_hwcg(struct msm_gpu *gpu, bool state)
>>   	const struct adreno_five_hwcg_regs *regs;
>>   	unsigned int i, sz;
>>   
>> -	if (adreno_is_a508(adreno_gpu)) {
>> +	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu)) {
>>   		regs = a50x_hwcg;
>>   		sz = ARRAY_SIZE(a50x_hwcg);
>>   	} else if (adreno_is_a509(adreno_gpu) || adreno_is_a512(adreno_gpu)) {
>> @@ -485,7 +485,7 @@ static int a5xx_me_init(struct msm_gpu *gpu)
>>   	OUT_RING(ring, 0x00000000);
>>   
>>   	/* Specify workarounds for various microcode issues */
>> -	if (adreno_is_a530(adreno_gpu)) {
>> +	if (adreno_is_a506(adreno_gpu) || adreno_is_a530(adreno_gpu)) {
>>   		/* Workaround for token end syncs
>>   		 * Force a WFI after every direct-render 3D mode draw and every
>>   		 * 2D mode 3 draw
>> @@ -620,8 +620,17 @@ static int a5xx_ucode_init(struct msm_gpu *gpu)
>>   
>>   static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
>>   {
>> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>>   	int ret;
>>   
>> +	/*
>> +	 * Adreno 506,508,512 have CPZ Retention feature and
>> +	 * don't need to resume zap shader
>> +	 */
>> +	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu) ||
>> +	    adreno_is_a512(adreno_gpu))
>> +		return 0;
> 
> Afaict all other changes in the patch adds a506 support, but this hunk
> changes a508 and a512 behavior.
> 
> I'm not saying that the change is wrong, but this hunk deserves to be in
> it's own patch - so that if there's any impact on those other versions
> it can be tracked down to that specific patch.

Vladimir, any plans to submit v2? This comment requests splitting the 
patch in two.


-- 
With best wishes
Dmitry
