Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E63846989B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbhLFOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245377AbhLFOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:25:52 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86D9C061359
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 06:22:23 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id t6so11267509qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kRncryoplbgaJpeV0eEsttn1Wbr7ZCHuVrWpcBNe94w=;
        b=Xnyjr/h4PKcJrMEYIfxGKzmK2zKxryeOFNIVXSFxZj1awPEotWBG2ePd3id51lK/d8
         msHza8noDMbrkBQqEHD1FfRPgLaMw7sSBB5O9CTpQcuPqFuqvPQBtspoo12K9UHUImpa
         bcH7jUckFJCA4E+luCE8qjRMdWYWs7wPMwwyNA1BG7DHP3SmPhjENDR2+CM4VRbsUZ+g
         WLnVR/XTHKDm+G9bDKskNNtkSz1e3a2sjxZAb08Ytxs81iydwUrOtUGLitZSsBF4Zk9M
         OQzVSA6iu14FVK0roN0sKmIgJaYYY+XgU0V997ylxWGPaqUFaoP3jf4eIddtPMoLz6dy
         h9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kRncryoplbgaJpeV0eEsttn1Wbr7ZCHuVrWpcBNe94w=;
        b=MG+neGBcKyji5zF9/FIM0hUvXqGhffqCPOujM6GOstAjJiSw+m/5THNThnKjdNrBG6
         Z61XJKUJRMuaYudQp3tgVWhMObT4IeJGVyvGdFY9yKZsEkX1Fg4oBGTap/f6/UeXGK45
         h04DruTvyJzbu3APkDeALg8u/gHoIrHFdanyYsfy6pjWKVaqiW8pHJkangJtrzCxDedx
         wZ0hD2x+OKdVxIojA5hfu7grmmSceJtDzptkwl7gjvzysZtwyFw/pMfYDq19Jp79Ol+x
         4hmFtEDcRabf1glhIGQbzbkIJ5AkCA1tDr5u7b0NEnrKi+bANGnnbW0T8hCcwIIzte+7
         Ft/A==
X-Gm-Message-State: AOAM532E4VFjAAQkbgiRpe0FZnbjP5arS3Q/nq3EV074WkFSklITdBJI
        gzzUZDOdV/v0PG6QoGFKqGJbfU4e2HniRw==
X-Google-Smtp-Source: ABdhPJzqbwIJbL1QNoOo2PSy4XdmW3rAvUfZaFujGIJX62m6SEIXm+R9F5DJOTut1jzGyZ7SctFg2g==
X-Received: by 2002:a37:f619:: with SMTP id y25mr33578687qkj.201.1638800542654;
        Mon, 06 Dec 2021 06:22:22 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id f1sm7653268qtf.74.2021.12.06.06.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 06:22:22 -0800 (PST)
Subject: Re: [PATCH 1/3] thermal: qcom: lmh: Add support for sm8150
To:     Konrad Dybcio <konrad.dybcio@somainline.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211202223802.382068-1-thara.gopinath@linaro.org>
 <20211202223802.382068-2-thara.gopinath@linaro.org>
 <f0ae3d36-8317-b297-cc99-645adca1f25c@somainline.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <6771fdd4-b863-6a63-8cf5-441e866f771c@linaro.org>
Date:   Mon, 6 Dec 2021 09:22:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f0ae3d36-8317-b297-cc99-645adca1f25c@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for the review.

On 12/4/21 8:34 AM, Konrad Dybcio wrote:
> Hi,
> 
> On 02.12.2021 23:38, Thara Gopinath wrote:
>> Add compatible to support LMh for sm8150 SoC.
>> sm8150 does not require explicit enabling for various LMh subsystems.
>> Move this piece of code under condition that it is executed only
>> for sdm845 SoC.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/thermal/qcom/lmh.c | 61 ++++++++++++++++++++------------------
>>   1 file changed, 32 insertions(+), 29 deletions(-)
> 
> [...]
> 
> 
>> -		return ret;
>> +	if (of_device_is_compatible(np, "qcom,sdm845-lmh")) {
>> +		if (!qcom_scm_lmh_dcvsh_available())
>> +			return -EINVAL;
> 
> I don't believe this is the correct approach, as different SoCs may
> 
> require different sequences of these writes (for example SDM660/MSM8998
> 
> seems to only enable the thermal algorithm), and there will (hopefully) be interest
> 
> in adding LMH support for more platforms, so perhaps separating this somehow
> 
> could keep this a bit cleaner and easier to work with for the next person..

I have not looked at SDM660/MSM8998. Are you telling me that these SoCs 
don't enable the current and BCL portion of LMh. Maybe they have an 
earlier version of Lmh which does not support all the features. The 
right approach in this case will be to add a match table with flags for 
init based on SoC. I can send v2, adding a match table with a flag to 
specify whether to do the init sequence or not. Since I am not adding 
the support for any other SoC at the moment, I cannot put in flags 
separating out thermal , current and BCL init.

> 
> 
> 
> Konrad
> 

-- 
Warm Regards
Thara (She/Her/Hers)
