Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53F45A9050
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiIAHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiIAHcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:32:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F78126DE4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:28:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id k22so16947477ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JWfT+qeNC2CT3Ipogz2ktqK+tonEIf45b3bHsAFEBxU=;
        b=U08bGpTCBUkzRa9qDDUxPPJY9H5aZwby0Ihz6i9A2pZh+4DEQGs9qvCtLelKwDAkJh
         +Lvd7yeUF1/UlLZXezQt/VGyoOMfkFThGnImM9qBIH6ab9nQlyYjfsJYZHWAjwaSND4D
         0XiaNAfBOH0dsSrY7GM1HH/73SD/yJ457vDE8fuKTUTxOJO+2YQOQAtWJGrT/1WbSv6S
         Tr0xjz1ARJ7rfR20YM/+gHw4+JyP2ilQbZKgjl0JzZBNR14Hktv1+8da4PLdUcrWliFL
         R5X+W4U3EWNIATK+AtdiUo/DA1m5yvfr/crc6QQAm/bGEEKl0498ApyTAiZsFcTvvCpk
         bT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JWfT+qeNC2CT3Ipogz2ktqK+tonEIf45b3bHsAFEBxU=;
        b=OX7IqzV8WQEmbugS0+rz3d7YgH7uwBgdmxNzBXwN5V38ixgoNOjWgiLrDkqgByqKVw
         vrjRNiocb/WWhw/6JuG+Ge6NjW+YFxs9qIcbcHMM38lqkbyBwMCb45EvbL5YIOniKzPx
         pugjMJXc97eFJvfvK8BTepRppDc2Q6ETnwNt/pTjeP7+D/XEbtgyfAP6c2JQpqThuTKl
         BeCk1cWtYWaZNoCucBsGEr6BKamFbWkf1yQLGKRrTaOojvutd0FEvOR1Uc2NbCuI0uDb
         DulFwWY6eMnES660jDvqRt3Bum2xJMr4redlmn3nx9fIUiIqVCLcBMVZoQKUgWp0CmVB
         AZ2w==
X-Gm-Message-State: ACgBeo1cslQsZatiiqj9w7YMlEJXfBCaGdLDttUcraOOl2AdYjI0Egx6
        PnAJf0rmOS4CRagyF24sHuD1Vg==
X-Google-Smtp-Source: AA6agR7wyn4mb8cX3p67uFfHPU+JkbXoaTyVz81XLi4YVfOhv+6H5UDNEufviysPXbybIUB/Zcy+2w==
X-Received: by 2002:a05:651c:204d:b0:25e:3111:419f with SMTP id t13-20020a05651c204d00b0025e3111419fmr5492973ljo.320.1662017330935;
        Thu, 01 Sep 2022 00:28:50 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id m9-20020ac24249000000b00492f37e428asm2251246lfl.172.2022.09.01.00.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:28:50 -0700 (PDT)
Message-ID: <fea60b71-4623-43f5-d81c-a0250a63c697@linaro.org>
Date:   Thu, 1 Sep 2022 10:28:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/6] ASoC: codecs: wsa-macro: add support for sm8450 and
 sc8280xp
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
 <20220818134619.3432-3-srinivas.kandagatla@linaro.org>
 <20220818171222.GG1978870-robh@kernel.org>
 <9c9226d9-8470-6672-d8ce-3fb1e4df3fda@linaro.org>
 <5da6171a-4949-9cc7-2967-6cc39a7955c8@linaro.org>
 <a4562481-780b-585f-01a5-d447040fbd0a@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a4562481-780b-585f-01a5-d447040fbd0a@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 31/08/2022 13:37, Srinivas Kandagatla wrote:
> 
> 
> On 31/08/2022 10:19, Krzysztof Kozlowski wrote:
>> On 31/08/2022 12:17, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 18/08/2022 18:12, Rob Herring wrote:
>>>> On Thu, Aug 18, 2022 at 02:46:15PM +0100, Srinivas Kandagatla wrote:
>>>>> Add compatible for sm8450 and sc8280xp.
>>>>>
>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>> ---
>>>>>    sound/soc/codecs/lpass-wsa-macro.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
>>>>> index 27da6c6c3c5a..f82c297ea3ab 100644
>>>>> --- a/sound/soc/codecs/lpass-wsa-macro.c
>>>>> +++ b/sound/soc/codecs/lpass-wsa-macro.c
>>>>> @@ -2561,6 +2561,8 @@ static const struct dev_pm_ops wsa_macro_pm_ops = {
>>>>>    static const struct of_device_id wsa_macro_dt_match[] = {
>>>>>    	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
>>>>>    	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
>>>>> +	{.compatible = "qcom,sm8450-lpass-wsa-macro"},
>>>>> +	{.compatible = "qcom,sc8280xp-lpass-wsa-macro" },
>>>>
>>>> Looks like these are backwards compatible with the existing versions,
>>>> why not reflect that in the binding?
>>> Backward compatibility is not always true, some of the registers and
>>> there defaults tend to change across SoCs. Having SoC specific
>>> compatible could help us deal with this and also make code more inline
>>> with other codec macros in LPASS IP.
>>
>> I am not saying that there should be no SoC specific compatible. This
>> one is a must, but the question why duplicating the entries and not
>> using fallback?
> 
> You mean using fallback compatible "qcom,sc7280-lpass-wsa-macro" in 
> sc8280xp devicetree and not add new compatibles in the driver?
> 
> The reason for adding this new compatible strings is that macros in this 
> lpass codec that differ form each SoC.
> ex: [PATCH 6/6] ASoC: codecs: tx-macro: add support for sm8450 and 
> sc8280xp and there is a pending patch on va-macro that has soundwire 
> controller frame sync and reset control which is moved from tx-macro to 
> va-macro.
> 
> so DT might endup with mix of compatibles for same LPASS Codec like this:
> 
> "qcom,sc7280-lpass-wsa-macro"
> "qcom,sc8280xp-lpass-va-macro"
> "qcom,sc8280xp-lpass-tx-macro"
> "qcom,sc8280xp-lpass-rx-macro"
> 
> AFAIU, the fallback thing will work for things that are identical but in 
> this case they differ across SoCs, and having SoC specific compatibles 
> in now would help handle this.

Ahh, I see now. The true problem is that driver encodes compatibles in
several places. That's very confusing design - variants should be rather
customized via driver data, not via multiple of_device_is_compatible()
inside the code.

Best regards,
Krzysztof
