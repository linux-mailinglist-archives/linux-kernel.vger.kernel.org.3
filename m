Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDCB4B8C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiBPPiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:38:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiBPPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:38:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CA9291F85
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:38:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h6so4099469wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4D8vkLWPsB+L5NVGMdhKjexz7qk9u2esSIMnsRYj4yw=;
        b=ZH3t3VjooA0WMKhqp/ZjVeXyOXGVqiAfn7O1tA87Uj+1ncONnemMgy3RuoMPrWErOn
         I3aHn+NFoulMcZCMFNDCh5t6uuQF9Z/XWn98klHsiY32L45yb8tdKoR2526NEQ4eJ5Lk
         xo7SD80kHm1YeAsh18wiPuwtaKUJjDoiXQmsO4tkwR87eCJAlPTX8X/RwY7ar7I4sfxu
         3lVB42wzr5NDJW2X0mSYt31UjNAA83Rp4E2Fr4GpVBJA4YFvRKhVYNnLYJcDm6k1COae
         HUBU59F0LDM+12oAqQWSGuASDICxU7uLIj79gyCgtJVXcG1qzwBHz8xrM8oqAaM3Fw0C
         NI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4D8vkLWPsB+L5NVGMdhKjexz7qk9u2esSIMnsRYj4yw=;
        b=UPoV6btyPCY+pUpEQOSgqM8MH5UhdB8w4NQPX7c+TARvF/w7ehvzIYFYMwFxrrFw0n
         HRsaME5hC3wmvk3kansrAVey6SFjKSfwO7CDsQeN0BOw/PcLN5gYwdE9CoWVkbadRAFF
         Tl108I3ic5fH8zNsAz1JnW/H6O81gxzybfd5jJTFlp518+OX/aaBJmhqGwxIGXeNrTxt
         RVvHw6SQjyx5dvsK5MPvyEBL0VmquDdr913mNQH6MLTUWrQBr61srKLQs9BZLBnCBADc
         g/WUI8d7mQqnzYr2CGWATC2SLCU2g1CeAFWlSyc1OXyuqGQBL14E6PYUe4PFHFuCzB6l
         kACg==
X-Gm-Message-State: AOAM531dggX0jpzgmDICsts32Wds0EBW5m2CD5d/M7f15vUDvDTYtNkG
        CYKWAlMKAq6zK+sxo0t87xHQAw==
X-Google-Smtp-Source: ABdhPJzwHrl5EQgylw3JeoAybMGg4Xtm2WpU9q/hqKvoLx1ryIPLVXKSfbFhx9NIFxZSg7OvNw7AjA==
X-Received: by 2002:a05:6000:36b:b0:1e3:8a3b:add8 with SMTP id f11-20020a056000036b00b001e38a3badd8mr2675144wrf.283.1645025884614;
        Wed, 16 Feb 2022 07:38:04 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id az2sm28127598wmb.2.2022.02.16.07.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 07:38:04 -0800 (PST)
Message-ID: <09b00fe9-1770-1723-3c4c-6c494da87e8d@linaro.org>
Date:   Wed, 16 Feb 2022 15:38:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 7/7] pinctrl: qcom: Update clock voting as optional
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-8-git-send-email-quic_srivasam@quicinc.com>
 <a209336a-9108-f1ac-ee6d-a838df115c6d@linaro.org>
 <b663f63f-4a5a-3a2a-9be7-fa7258ce93c5@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <b663f63f-4a5a-3a2a-9be7-fa7258ce93c5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/02/2022 14:41, Srinivasa Rao Mandadapu wrote:
> 
> On 2/16/2022 7:50 PM, Srinivas Kandagatla wrote:
> Thanks for Your Time Srini!!!
>>
>> On 14/02/2022 15:19, Srinivasa Rao Mandadapu wrote:
>>> Update bulk clock voting to optional voting as ADSP bypass platform 
>>> doesn't
>>> need macro and decodec clocks, these are maintained as power domains and
>>> operated from lpass audio core cc.
>>>
>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>> ---
>>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 16 +++++++++-------
>>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        |  1 +
>>>   drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c |  1 +
>>>   3 files changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c 
>>> b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>>> index 8a82fd9..103f0a6c 100644
>>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>>> @@ -407,13 +407,15 @@ int lpi_pinctrl_probe(struct platform_device 
>>> *pdev)
>>>           return dev_err_probe(dev, PTR_ERR(pctrl->slew_base),
>>>                        "Slew resource not provided\n");
>>>   -    ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
>>> -    if (ret)
>>> -        return dev_err_probe(dev, ret, "Can't get clocks\n");
>>> -
>>> -    ret = clk_bulk_prepare_enable(MAX_LPI_NUM_CLKS, pctrl->clks);
>>> -    if (ret)
>>> -        return dev_err_probe(dev, ret, "Can't enable clocks\n");
>>> +    if (!data->is_clk_optional) {
>>> +        ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
>>> +        if (ret)
>>> +            return dev_err_probe(dev, ret, "Can't get clocks\n");
>>> +
>>> +        ret = clk_bulk_prepare_enable(MAX_LPI_NUM_CLKS, pctrl->clks);
>>> +        if (ret)
>>> +            return dev_err_probe(dev, ret, "Can't enable clocks\n");
>>> +    }
>>>         pctrl->desc.pctlops = &lpi_gpio_pinctrl_ops;
>>>       pctrl->desc.pmxops = &lpi_gpio_pinmux_ops;
>>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h 
>>> b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>>> index a511d72..c1079bf 100644
>>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>>> @@ -77,6 +77,7 @@ struct lpi_pinctrl_variant_data {
>>>       int ngroups;
>>>       const struct lpi_function *functions;
>>>       int nfunctions;
>>> +    int is_clk_optional;
>>>   };
>>>     int lpi_pinctrl_probe(struct platform_device *pdev);
>>> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c 
>>> b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>>> index 5bf30d97..4277e31 100644
>>> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>>> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>>> @@ -143,6 +143,7 @@ static const struct lpi_pinctrl_variant_data 
>>> sc7280_lpi_data = {
>>>       .ngroups = ARRAY_SIZE(sc7280_groups),
>>>       .functions = sc7280_functions,
>>>       .nfunctions = ARRAY_SIZE(sc7280_functions),
>>> +    .is_clk_optional = 1,
>>
>> This is forcefully set assuming that sc7280 is always used in ADSP 
>> bypass mode. Which is not correct.
>>
>> Can't you use devm_clk_bulk_get_optional instead?
> 
> Yes. Agreed. Initially used devm_clk_bulk_get_optional, but Bjorn 
> suggested for conditional check instead of optional.
> 
> Again Shall we go for optional clock voting?

That means that the condition has to be dynamic based on the platform 
using DSP or not. Which is impossible to deduce without some help from DT.

I would prefer to stay with optional clock unless Bjorn has some strong 
objection on not using int.

--srini

> 
>>
>> --srini
>>
>>>   };
>>>     static const struct of_device_id lpi_pinctrl_of_match[] = {
