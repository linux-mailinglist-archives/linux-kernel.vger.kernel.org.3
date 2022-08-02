Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6E5877D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiHBH3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiHBH3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:29:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A174A829
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:29:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z20so7587581ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9eL3ozzpdYGnXljmtE3B0oE/ZBoqe/H9leB+5agQkkE=;
        b=wC+qP5+HGTy+fuizLQf2DiyhUZm80LVyo8+ty0odcrlB3PjezFJOUPrO8KKpPFnrL1
         +t7igyvhqz8kWpIXL16shFwOMyc2e/LeFcwR4fant9pvOcuZB9newf2+kfk5369UwQ5C
         QxV2qwpGydkHdJz/8B4iAYXQgQN8Loe/VJSGTmnD9P8QKW/d4iie/QcQYWvTXV5X6JPJ
         TFjLqoHZFwvi+gKu/MqVv5koVTTqnBKVBA5biimgUkSUs9peAEu3IYy+6CBvNfF/YGds
         ZAyq2uDgYnAYQkiaTiiG2VEDR/WY9UfZUioLk6ilORqGFpfYRgH0+n20RgXYh2lnyzH7
         EJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9eL3ozzpdYGnXljmtE3B0oE/ZBoqe/H9leB+5agQkkE=;
        b=zy2z23a91K5BqLbZXiraM4nsZvB8PjuiT0XdxDJmdAZgocd929FA2MiQuqitu3YPzC
         dlM/KA1IWVm/CfyPO+AMXl68uQl1Qz5njl9tOuv5d+6OIBfPBsSeUUlc98cvMXK86ggY
         6JL2DZMF3r1x9xqgRsMjv/3S3GkoR2JAF2lP7QtoS+ToOshqGSVXi0yCThSOW0xarRCg
         +3Hq0jBkDKma+YRfJqbvjpa7OeW+NI4GATcjs6Cp3NsRWwnQeI+8z5nza3087/cOj3GE
         zQjONvgM6DFEN9OjyY4OMR0xzLzfBsrgaOjn26qHBiQTiroCPIoGbP+Nj+LdJe3qv0Kd
         D3Sw==
X-Gm-Message-State: AJIora+tTv5IR/+hP+TjL0I/yxV0sblPD0kaz1ixiapyJKIStizY58YF
        T+eTeKmjvfJIcNedWtnnMqgHEBHnIzo9rSX4
X-Google-Smtp-Source: AGRyM1sdLmYNCHf5av9MgkI7xr5qL4TvIAUM7wLB2ixaP+zWDtepKvjs8u1mOXcExhMJ7SL3vn/Ttg==
X-Received: by 2002:a2e:9444:0:b0:25d:91c1:caa3 with SMTP id o4-20020a2e9444000000b0025d91c1caa3mr6340734ljh.190.1659425344943;
        Tue, 02 Aug 2022 00:29:04 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id k6-20020a2ea266000000b0025d75995a07sm996497ljm.24.2022.08.02.00.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:29:04 -0700 (PDT)
Message-ID: <b6e7d391-904a-170c-b398-c049ea2c8a0c@linaro.org>
Date:   Tue, 2 Aug 2022 09:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add sample format conversion
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1658931983-31647-1-git-send-email-spujar@nvidia.com>
 <1658931983-31647-2-git-send-email-spujar@nvidia.com>
 <c801afa4-a40d-9363-1ebd-9e8e30c21df5@linaro.org>
 <fbe773df-7a92-df52-740e-41bb2f47c1f7@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fbe773df-7a92-df52-740e-41bb2f47c1f7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2022 06:11, Sameer Pujar wrote:

>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
>> index b261d49..6decd73 100644
>> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
>> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
>> @@ -77,6 +77,17 @@ definitions:
>>       description: CPU to Codec rate channels.
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>
>> +  convert-sample-format:
>> +    description: CPU to Codec sample format.
>> +      Value    Format
>> +        0        S8
>> +        2        S16_LE
>> +        6        S24_LE
>> +        10       S32_LE
>> +        32       S24_3LE
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> Wait, you now put the same property in four different places. Don't you
>> have something which could be shared?
>>
> There is no shared schema between simple-card.yaml and others. I will 
> have to create a new doc to share these definitions.

OK


Best regards,
Krzysztof
