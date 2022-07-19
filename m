Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0FE579450
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiGSHfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbiGSHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:34:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403C333E35
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:34:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m9so13736103ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lo9T0CevCQg3oDP4vfcp2Mw2HsO8mehETjg/lVyDcfY=;
        b=ujOHcdJmYVsYhfNNqPcA/dd4wzJFt5tWMnScCWNWXxq5OQH0NSu7uVHVgwdsQrk/9y
         op/Hw+GxTyOnF4SHBB+MVYf21XW6XxJLZrPmiT1VJg/njbDmhYBoR2ezx8+vdZScFCvf
         TScwqv44LcO851ZzM/7D+Cp49thHpgdkBd3aehzzO+JBWj38A019iUjegdlz3sPDvxwD
         RXF3I8clp64+x59rKF414sPh6YwwYHBuyHrRO0Ip39xmm4lBuPz6Fv8nTnsL1GQCkpS3
         e9SycSsdzCB1zyCztyGCSdvEkd7bIC1B5DmiiIcYf33fZDjnUcYqeaRPR0LELanji2f4
         YRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lo9T0CevCQg3oDP4vfcp2Mw2HsO8mehETjg/lVyDcfY=;
        b=vk7j0056Pn5VnxrGydfavzrz2AUPCHdShBN3FZLn3j/CSoAI4eEZu0p3cEj+UkcMvS
         3+M4Q/5DHUssn720YEui8rInFqL9b3HUxG4BrYwGDT75jd8nHTET/wjO5iuIHAXkjFoM
         1Ni/p/dwDjn+IByiMo0ASCQYeo+lSyF3jtF3OJYKcILs7bKm2QTpKI1CYqczhWBkq+YT
         p3r4HqijovGyXFxq3S4B8qgKn1BJ6cuM6/0/bFHweXIy6hMKdHGKxd6xWlW++NBlsAGX
         sMfBYQlzpSRW4JsjwtXHOg7H/XOPkvA7QFmKuurlfzypAco/j7tJfAu4V5IjIFoENMnX
         VIZg==
X-Gm-Message-State: AJIora/O+w58xOkI9FyRCeB8zk9ljkrwHXiF9P4sLxoeZ9QL/VBXmzMx
        AtvVZwQDNirameYzuyac8wUAKg==
X-Google-Smtp-Source: AGRyM1vWdi/tW4c6Hzt77zEWrErAi9tPR28pFblEHqUOtlAeDCDOfkkAE8WAktYM/O1PwhVa1M79TA==
X-Received: by 2002:a2e:b007:0:b0:25d:82ab:6a6c with SMTP id y7-20020a2eb007000000b0025d82ab6a6cmr14797420ljk.88.1658216064478;
        Tue, 19 Jul 2022 00:34:24 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id b12-20020a056512024c00b00479307e4a1bsm3039531lfo.135.2022.07.19.00.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:34:24 -0700 (PDT)
Message-ID: <9e137bb2-0543-ce18-4967-792c8fa13841@linaro.org>
Date:   Tue, 19 Jul 2022 09:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: leds: lp50xx: fix LED children names
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220624111325.96478-1-krzysztof.kozlowski@linaro.org>
 <CAL_JsqKHviWcynOu5AYJxtJ5xbQU6cU+r6tHy=ao+Wt4mE1aVQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqKHviWcynOu5AYJxtJ5xbQU6cU+r6tHy=ao+Wt4mE1aVQ@mail.gmail.com>
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

On 18/07/2022 17:18, Rob Herring wrote:
> On Fri, Jun 24, 2022 at 5:13 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> The lp50xx LEDs expects to have single-color LED children with unit
>> addresses.  This is required by the driver and provided by existing
>> DTSes.  Fix the binding to match actual usage.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Fixes: dce1452301e7 ("dt: bindings: lp50xx: Introduce the lp50xx family of RGB drivers")
>> ---
>>  Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
>> index f12fe5b53f30..c274a10bbde6 100644
>> --- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
>> +++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
>> @@ -65,8 +65,14 @@ patternProperties:
>>            for the child node.  The LED modules can either be used stand alone
>>            or grouped into a module bank.
>>
>> +      '#address-cells':
>> +        const: 1
>> +
>> +      '#size-cells':
>> +        const: 0
>> +
>>      patternProperties:
>> -      "(^led-[0-9a-f]$|led)":
>> +      "^led@[0-9a-f]+$":
> 
> Looks like you forgot to update the example. Now failing with
> 'unevaluatedProperties' fixed:

Yeah, this was fixed in my other patch:
https://lore.kernel.org/all/20220607075247.58048-1-krzysztof.kozlowski@linaro.org/

and I assumed Pavel will also pick it up... It has been waiting for more
than one month.


Best regards,
Krzysztof
