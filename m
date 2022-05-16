Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD0528261
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiEPKms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbiEPKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:40:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A3261C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:40:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bx33so17538744ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PIStbMHPtan1KLlc0XW15FaN5Q5q5/G9moSTVEJOKR8=;
        b=Okry26+6WYZDBL/wyrImejHnErmgQv2VjJ3jxlPsOdX4tWoDQ0KeVWRt3ereejd+P+
         l+zojoW4rovfwGTHTaxCqbsItDrqLt4TsrXgsqA4EvvM5/JkYxncPvSfhKyEhjmbASZQ
         TibF4DIkzbDmuy0xtgyjkkgUOdyUb27/kr9dXc3rzbncMVJyYudJD0o5udiVuAEQxY/I
         5rzowjS35jGcEV/2e/UK+/sj7+IRhOMQANzlqR59j9MGraRJ6MnQvrJJBTDfrf82S9Pp
         UH/Rnn2AJGZRxLprskHloIEFc1kh4AIDEMX+wordKF8SmSST+s4U96TB9CeldPcYSWND
         Q8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PIStbMHPtan1KLlc0XW15FaN5Q5q5/G9moSTVEJOKR8=;
        b=usJeDRFepUvPSHV7HjVSaIROz7nm3en6aIedk70ygpUp0aAELWwWjMoNAQwuwlb6xv
         m7Oi56gdZN6h6acIkUzEaRMfEOshJW8KUoSIKfSQx4HI9pN4D074twGyOg05vVWWE0i2
         BcfShbVuZf8mJx5wYbzmhUiLtLciyAzx3PmCMVxYX04YmnoPoagBuf5lLSMgAfNx5S8W
         YKeWho8b2LSlB0QY+SgwVXstTbTUNId/C3+wOE1Wn0cKjhG5ea74sTkKtdt94cLJ8q6X
         0UjaxiF3w/f/DTcwHlDoYGRG/xwskDMYXUY2hQk6WzK8WQWNzv/XQlciBtm1PG9Dwrcj
         ruNQ==
X-Gm-Message-State: AOAM532o+eSeQnrsXW85zpJOBFQK0zLBTtLZxYARCTnz41iN1lB4grm0
        Pp56QEjHux3uC5ylRwxolopi3g==
X-Google-Smtp-Source: ABdhPJy1QZ8BxVhQaPE0U/RAWQGsWQF8ytlTewjrJGbgoAmLSxr4qWAyDEMSN3A6btYEAhDImT/3Rw==
X-Received: by 2002:a05:651c:105a:b0:250:c5ec:bc2d with SMTP id x26-20020a05651c105a00b00250c5ecbc2dmr10737190ljm.321.1652697646673;
        Mon, 16 May 2022 03:40:46 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t28-20020ac243bc000000b0047255d21195sm1265267lfl.196.2022.05.16.03.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 03:40:46 -0700 (PDT)
Message-ID: <9a94cf23-430e-56e2-1260-92a162d608e7@linaro.org>
Date:   Mon, 16 May 2022 12:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220511110657.16305-1-j-keerthy@ti.com>
 <20220511110657.16305-2-j-keerthy@ti.com>
 <4568653d-706e-8621-3fee-d4a853517256@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4568653d-706e-8621-3fee-d4a853517256@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 12:32, Daniel Lezcano wrote:
> 
> Cc'ing krzysztof.kozlowski@linaro.org

Eh, I wished people used automatically scripts/get_maintainers.pl, so
there will be no need to Cc someone. It's actually a bit weird because I
was reviewing v6...

> 
> On 11/05/2022 13:06, Keerthy wrote:
>> Add VTM bindings documentation. In the Voltage Thermal
>> Management Module(VTM), K3 J72XX supplies a voltage
>> reference and a temperature sensor feature that are gathered in the band
>> gap voltage and temperature sensor (VBGAPTS) module. The band
>> gap provides current and voltage reference for its internal
>> circuits and other analog IP blocks. The analog-to-digital
>> converter (ADC) produces an output value that is proportional
>> to the silicon temperature.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>


In any case this misses all the review-tags, so I don't know what we are
supposed to do here.


Keerthy,
Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L543

If a tag was not added on purpose, please state why and what changed.

>> ---
>>   .../bindings/thermal/ti,j72xx-thermal.yaml    | 64 +++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
>> new file mode 100644
>> index 000000000000..83f8f444a133
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/ti,j72xx-thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments J72XX VTM (DTS) binding
>> +
>> +maintainers:
>> +  - Keerthy <j-keerthy@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - ti,j721e-vtm
>> +          - ti,j7200-vtm

No items, you have only one item.


Best regards,
Krzysztof
