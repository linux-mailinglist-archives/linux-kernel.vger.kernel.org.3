Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A355A7B68
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiHaKhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHaKhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:37:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C62B24A9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:37:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so5004276wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qmSDVvWPmXjsEoLB/yy4dBeFNE6LDECdPTKFlVF1PoE=;
        b=sjv1ud0NJToWCCz5mpoI1XXv7VRN42nSodi+vU6HqC3fe4/RDdH9q78MztUStUg3tz
         Xc2VH//pGT74lRB34bGeve8JkG1qnn0+IqPnock9NFdhh6qZlnaCkIyowzKTRT7FJxji
         z/GR4fNB9q+235VImiHhUj3qtbmxYAGPA6OWg32iyZY+RWa1WOllcMXAW5Ypa+UHJ8jW
         8xs5JdrK3PiKkOFMlLV0DL+qhh48j42QQnv6mKDYipwbJKuU6YxKUw7q3wlwpZcq+q8X
         TT/+nZgkSnsztlClPhtaZpJBrpVs5ezXDDOxx5Tro2hYIsNMiKVkIvoSrdqaMCZkKMyS
         wVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qmSDVvWPmXjsEoLB/yy4dBeFNE6LDECdPTKFlVF1PoE=;
        b=LVO47FSKV3gSvtaGvlwwtPbfDhcz6giVtPvZketNcwwDipTfySSRFUwBWf3gj6D6Y+
         NFkdZJ8x9oRuEbINpyuQIbQkX2u/jBhPm3hMFzpm5UngJ8Vcr3rtJwqDro0oOyzZ9XxF
         MTwdratv4Wbf7w3Y8VtYqfR9acE/8+3wY6s2ZDaKIsykzk0XXAGisGgI0HAseHnQlRy/
         TuQosXiwgvFe4Vgg9ppphA+T4ZZsuUsPUaupK/WvT2vXIaNLKE14w4UMMUtMeCmvRruH
         LeJqNEsz9sL5WeKCX5ZxZCYmQC1WvJJI+OIoT+WxEMp8dTCAumfdYupDjwLT7sthKhv8
         gt0g==
X-Gm-Message-State: ACgBeo2uDb2kEdKpfG1iE7zqjiwdjVuZMwvYeIzjxsucWyTO8A0zbYVt
        OCDm1TVUNhRqyWwTwW4V8yRSBg==
X-Google-Smtp-Source: AA6agR7zq/2i3kOzfh+ND3aVSosKcimESlsCtfJ9TPLHCMLrzMvYwqw/Dz65I9sh80Ti/NbGaa+m0w==
X-Received: by 2002:a05:6000:144a:b0:220:7181:9283 with SMTP id v10-20020a056000144a00b0022071819283mr10935127wrx.158.1661942237422;
        Wed, 31 Aug 2022 03:37:17 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id e3-20020adfe383000000b0021ef34124ebsm12377427wrm.11.2022.08.31.03.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 03:37:16 -0700 (PDT)
Message-ID: <a4562481-780b-585f-01a5-d447040fbd0a@linaro.org>
Date:   Wed, 31 Aug 2022 11:37:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/6] ASoC: codecs: wsa-macro: add support for sm8450 and
 sc8280xp
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <5da6171a-4949-9cc7-2967-6cc39a7955c8@linaro.org>
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



On 31/08/2022 10:19, Krzysztof Kozlowski wrote:
> On 31/08/2022 12:17, Srinivas Kandagatla wrote:
>>
>>
>> On 18/08/2022 18:12, Rob Herring wrote:
>>> On Thu, Aug 18, 2022 at 02:46:15PM +0100, Srinivas Kandagatla wrote:
>>>> Add compatible for sm8450 and sc8280xp.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>    sound/soc/codecs/lpass-wsa-macro.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
>>>> index 27da6c6c3c5a..f82c297ea3ab 100644
>>>> --- a/sound/soc/codecs/lpass-wsa-macro.c
>>>> +++ b/sound/soc/codecs/lpass-wsa-macro.c
>>>> @@ -2561,6 +2561,8 @@ static const struct dev_pm_ops wsa_macro_pm_ops = {
>>>>    static const struct of_device_id wsa_macro_dt_match[] = {
>>>>    	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
>>>>    	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
>>>> +	{.compatible = "qcom,sm8450-lpass-wsa-macro"},
>>>> +	{.compatible = "qcom,sc8280xp-lpass-wsa-macro" },
>>>
>>> Looks like these are backwards compatible with the existing versions,
>>> why not reflect that in the binding?
>> Backward compatibility is not always true, some of the registers and
>> there defaults tend to change across SoCs. Having SoC specific
>> compatible could help us deal with this and also make code more inline
>> with other codec macros in LPASS IP.
> 
> I am not saying that there should be no SoC specific compatible. This
> one is a must, but the question why duplicating the entries and not
> using fallback?

You mean using fallback compatible "qcom,sc7280-lpass-wsa-macro" in 
sc8280xp devicetree and not add new compatibles in the driver?

The reason for adding this new compatible strings is that macros in this 
lpass codec that differ form each SoC.
ex: [PATCH 6/6] ASoC: codecs: tx-macro: add support for sm8450 and 
sc8280xp and there is a pending patch on va-macro that has soundwire 
controller frame sync and reset control which is moved from tx-macro to 
va-macro.

so DT might endup with mix of compatibles for same LPASS Codec like this:

"qcom,sc7280-lpass-wsa-macro"
"qcom,sc8280xp-lpass-va-macro"
"qcom,sc8280xp-lpass-tx-macro"
"qcom,sc8280xp-lpass-rx-macro"

AFAIU, the fallback thing will work for things that are identical but in 
this case they differ across SoCs, and having SoC specific compatibles 
in now would help handle this.


thanks,
srini

> 
> Best regards,
> Krzysztof
