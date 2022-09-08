Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB125B17F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiIHJF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIHJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:05:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F8C6FF0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:05:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u18so14341521lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4EXeardeq9HpwiVCQZQ5lt38hZVTwtZGieJK0lljKM8=;
        b=GFV1PyuEpd72g7+F6AONP4m8l+4Mgx5vfZQ9e6eTMER3UWFHq95qsiLukvu+VyYFxW
         tlMKSUe9fSe9nzd/d30Yon2MLZdQkCnt5LMCZMrPXdC78fxMUVeglBOjYpl8v599VGZX
         VXZzIoUZPdxiJyJZ2UOY5VUhzgEmjuh1bn9Kd7D69+ZEt4rfqTdIONvAwC2QUvY5wk6u
         d3TE0jHXiKheTnqCDkgPA3uKt7VLbbd766PbtwDEvztO28L1uNy4MwObB6UdwoA8FgQv
         nmNYeEbfhxNDy6a8AJiOwjW0yMrFtB28+NAmZRc9U0+YOwSLaXmXJsAD6iMkw0eVbTE5
         CMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4EXeardeq9HpwiVCQZQ5lt38hZVTwtZGieJK0lljKM8=;
        b=yNegLEw8o35c0/pN5S4xM1rSSAiYfCrJo8+bIFeTni9aRbf+MnLHkG6TzN2HWq5wS9
         qFlqNjn69r5zC6zHTu2GMYRIeQjqEg3G/YyLgWMR1414KQamiEBnRlhywzHS9NVq/BOP
         fnNnLfJheBTeq5ZRMeEZrkBZcS4QKq/FYPq3M4D1C08aW9X4L0BlpFz/9cXOCofKaWjA
         TB1e5ZCSfx5Rz4bPmy0R0phRBfRkmHZ+fDViM9B9ZyfQxzQ9fMvVOc8bETk1jL9q+lRf
         Y0hWgzzf+C+hcTBtEH3IM0jFQgkdL5ZcGQA5wKgPH6xKsQNExXlPr50JjE7C5+agvouy
         2uqA==
X-Gm-Message-State: ACgBeo33NU76TlF2IUYPhGeVtlnZqHN7l2ywh0Zw96Gh6sswZL7UbkTq
        BGIAjk7G+UC7ow+KIzb+4dyewA==
X-Google-Smtp-Source: AA6agR7L93/MOoDYSIXBA6+h6lEC6mcSj4MEclyOVmbetSPM412RIRG/YwUgew+9bugh6qZXrUpMyQ==
X-Received: by 2002:a05:6512:1091:b0:491:f135:4633 with SMTP id j17-20020a056512109100b00491f1354633mr2712894lfg.553.1662627949452;
        Thu, 08 Sep 2022 02:05:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p15-20020a2eb98f000000b00268d84f8db1sm3086496ljp.92.2022.09.08.02.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 02:05:49 -0700 (PDT)
Message-ID: <ee9b8346-b0fc-8ca5-5858-26534d322362@linaro.org>
Date:   Thu, 8 Sep 2022 11:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 09/14] ASoC: dt-bindings:: qcom,q6asm: convert to
 dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
 <20220907101556.37394-10-krzysztof.kozlowski@linaro.org>
 <20220907175759.GA3791463-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907175759.GA3791463-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 19:57, Rob Herring wrote:
> On Wed, Sep 07, 2022 at 12:15:51PM +0200, Krzysztof Kozlowski wrote:
>> Convert Qualcomm Audio Stream Manager (Q6ASM) bindings to DT schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Expected warning because the qcom,apr.yaml is being fixed in next commit:
>>
>>   Documentation/devicetree/bindings/sound/qcom,q6asm.example.dtb: apr: service@7: 'dais' does not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'
>>     From schema: /home/krzk/dev/linux/linux/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
>>
>> Changes since v1:
>> 1. New patch.
>> ---
>>  .../devicetree/bindings/sound/qcom,q6asm.txt  |  70 -----------
>>  .../devicetree/bindings/sound/qcom,q6asm.yaml | 112 ++++++++++++++++++
>>  2 files changed, 112 insertions(+), 70 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
> 
> Should be qcom,q6asm-dais.yaml or you need to add qcom,q6asm compatible?

Right, it should be -dais.

> 
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>> deleted file mode 100644
>> index 0d0075125243..000000000000
>> --- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>> +++ /dev/null
>> @@ -1,70 +0,0 @@
>> -Qualcomm Audio Stream Manager (Q6ASM) binding
>> -
>> -Q6ASM is one of the APR audio service on Q6DSP.
>> -Please refer to qcom,apr.txt for details of the common apr service bindings
>> -used by the apr service device.
>> -
>> -- but must contain the following property:
>> -
>> -- compatible:
>> -	Usage: required
>> -	Value type: <stringlist>
>> -	Definition: must be "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
>> -		    Or "qcom,q6asm" where the version number can be queried
>> -		    from DSP.
>> -		    example "qcom,q6asm-v2.0"
> 
> Where is this compatible handled now? 

The "qcom,q6asm" is handled in:
Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml

The "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>" is not handled because
it seems it is not used anywhere. I did not find such usage also in
downstream sources, so it seems version can be always auto-detected (I
did not confirm it with datasheet, though).

I'll explain this in commit msg.



Best regards,
Krzysztof
