Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B68A4BE3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351959AbiBUQQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:16:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380052AbiBUQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:16:43 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E4A27B2B;
        Mon, 21 Feb 2022 08:16:19 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id n185so17361223qke.5;
        Mon, 21 Feb 2022 08:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=0//CVz6gk3WJBaFfbakgy/AkhXMrrOJmbYrtOzjKFkE=;
        b=N/JFzI/+U+wnEsmJb7DivTCxpnLwNBrtF95c3bX5Xxy01+suQFUHC/HxctxMu1wW2P
         e4MMh9JeVtPoc8QEw6mvP7LAVf6swYi/rp3uYu/sM25J8tH4ngeahei3orV6dHkPUI1S
         TBGONE6vwWh5fsiyA/rLugS7SiSJyyIpcStMF9WFM9yE3b4Vnwq2yies4KdzZJc9Cdux
         /YHxvtZbZQD0HMEN93mAuXISuFTkSzQTjbx4UPqrAgc+EotwC55p5+oxcylXN6RN31oO
         ErswE/PEFJMrYnCwoxyexgcLinTbvFHDXyj2ntTPHjDKtEMKQxAYOt4WsO5IkZrOyGFA
         ELmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=0//CVz6gk3WJBaFfbakgy/AkhXMrrOJmbYrtOzjKFkE=;
        b=0nLFd+AaHmlfzNcMtPhfrvk45c7q8hSCdnD5rAp67tt3T8boITzZVPLaQ5SDCG4H2s
         T0lvbu96Aw+MmCUwxGl3LoeHYvWrwIXGZxInNEHYbor5sSUZtoZaI3crTz4oNVHUj4PY
         EoJt5qDh2dCQHM3z4AyfHYUAomxvum5Tb6dRdy9aKmRjx4QANzajizHLcaXXdmLiJxWm
         Fk70GoV+Qm+DShdSu71RyQtlW4Rdfu1HO8QAKYMgGOk9sjFQd11sA3/8mokVzqO0J/h3
         iWBTBo8f64+1n/+p+t9Y/ALVAnbkSgJ3tQYuGRdqSht65KapnCJbdP2dJCdAbCkv6uYy
         /Z0g==
X-Gm-Message-State: AOAM532TjHTg7skkXq0YueYTvjwknRljka4Xg85GtjZRVc2+pSHyhhLX
        wJuPYR2e6rQNzm1pHYOBAVnjJeL0N3v1tw==
X-Google-Smtp-Source: ABdhPJwoEOTVBrQQIyosl5WPPTTmhHfA/ViqBve4fuHNiKzkl3QtZ10AyQ61BippJHp6qpKmyYD5Qg==
X-Received: by 2002:a37:6712:0:b0:49b:4bb0:ea32 with SMTP id b18-20020a376712000000b0049b4bb0ea32mr12662896qkc.132.1645460178673;
        Mon, 21 Feb 2022 08:16:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o10sm2154992qtk.84.2022.02.21.08.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:16:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <66e6b131-274f-454b-44f6-17df879d71a9@roeck-us.net>
Date:   Mon, 21 Feb 2022 08:16:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc:     linux-hwmon@vger.kernel.org, Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220218150908.1947772-1-linux@roeck-us.net>
 <YhNWVLHYVtCvdGhi@localhost.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: add tmp464.yaml
In-Reply-To: <YhNWVLHYVtCvdGhi@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 01:07, Krzysztof Adamski wrote:
> Dnia Fri, Feb 18, 2022 at 07:09:07AM -0800, Guenter Roeck napisał(a):
>> From: Agathe Porte <agathe.porte@nokia.com>
>>
>> Add basic description of the tmp464 driver DT bindings.
>>
>> Signed-off-by: Agathe Porte <agathe.porte@nokia.com>
>> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v5:
>> - Dropped ti,n-factor from channel@0 example. Added additional
>>  channel to examples to show positive ti,n-factor property.
>>
>> v4:
>> - No changes
>>
>> v3:
>> - Addedd support for TMP468.
>> - Changed number of channels from 0..3 (which was wrong anyway) to 0..8.
>> - Changed value range for ti,n-factor to int8, with an example for
>>  a negative value.
>> - Added myself as driver maintainer.
>>
>> .../devicetree/bindings/hwmon/ti,tmp464.yaml  | 114 ++++++++++++++++++
>> MAINTAINERS                                   |   7 ++
>> 2 files changed, 121 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
>> new file mode 100644
>> index 000000000000..14f6a3412b8c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
>> @@ -0,0 +1,114 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/ti,tmp464.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TMP464 and TMP468 temperature sensors
>> +
>> +maintainers:
>> +  - Agathe Porte <agathe.porte@nokia.com>
>> +
>> +description: |
>> +  ±0.0625°C Remote and Local temperature sensor
>> +  https://www.ti.com/lit/ds/symlink/tmp464.pdf
>> +  https://www.ti.com/lit/ds/symlink/tmp468.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,tmp464
>> +      - ti,tmp468
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +patternProperties:
>> +  "^channel@([0-8])$":
>> +    type: object
>> +    description: |
>> +      Represents channels of the device and their specific configuration.
>> +
>> +    properties:
>> +      reg:
>> +        description: |
>> +          The channel number. 0 is local channel, 1-8 are remote channels.
>> +        items:
>> +          minimum: 0
>> +          maximum: 8
>> +
>> +      label:
>> +        description: |
>> +          A descriptive name for this channel, like "ambient" or "psu".
>> +
>> +      ti,n-factor:
>> +        description: |
>> +          The value (two's complement) to be programmed in the channel specific N correction register.
>> +          For remote channels only.
>> +        $ref: /schemas/types.yaml#/definitions/int8
>> +        items:
>> +          minimum: -128
>> +          maximum: 127
> 
> I still thing we should have the same format here and in tmp421, for
> consistency. If use the same property name, "ti,n-factor" but on tmp421
> you have use 32bit value while here you have to use 8bit (which is weird
> in DT, BTW), it might be confusing.
> Back when we did this for TMP421, there was some discussion and we
> settled on this approach, why do it differently now?
> 

I seem to recall from that discussion that there was supposedly no way to
express negative numbers in devicetree. Obviously that is incorrect.
In addition to that, I strongly suspect that the tmp421 code as written
does not work. Its value range is specified as 0..255, but it is read with
	err = of_property_read_s32(child, "ti,n-factor", &val);
and range checked with
	if (val > 127 || val < -128) {
                 dev_err(dev, "n-factor for channel %d invalid (%d)\n",
                        i, val);
                 return -EINVAL;
         }

That just looks wrong. Either the value range is 0..255 and checked
as 0 .. 255, or it is -128 .. 127 and must be both checked and specified
accordingly. This made me look into the code and I found how negative
numbers are supposed to be handled.

We can go either way, but whatever it is should be correct and be confirmed
to work. Rob, any thoughts ?

Guenter
