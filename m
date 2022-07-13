Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F662573B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiGMQf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiGMQf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:35:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E31DFF6;
        Wed, 13 Jul 2022 09:35:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f11so10065571pgj.7;
        Wed, 13 Jul 2022 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o7YYzHzRtbkclJ1dhZwxcUPrq4NvCPI4BIS17oQmiyI=;
        b=BwgbUAj/rkUIu2N2il8kHNbl6Q0K7fIysaUmm4b+GjM4gsFOf4XnBWRDPqi8nQUffZ
         N/VXTsZgtTLDTC+dZpacjUrWZBdgGnJ2zpxMb2IZNZ8bFUkIdPzVLQsb3p+1L0061XWe
         7JO4S+zA/nRBk13FC2YWbzkHfWl3T2GhIi8TeyEQLEm6V5g/h1R9m87H7wH99TjIgG1W
         8Bod0ZIZJxTcibMCY3//3vzroI37D2IH3mz1fpMoH+wlsx00qI8uq5e6HMpOtCHI2RVV
         MnwYvLPqD9U9bztJreGWk5sed1/FEvKVQvi/90k3JCQ/EjDHcopUV/u4wXdUi53ocxff
         6NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o7YYzHzRtbkclJ1dhZwxcUPrq4NvCPI4BIS17oQmiyI=;
        b=bBXf7CbG2Aw/BSNaSB7kSneVgIzSZllXcZSHH14fA52CKv/ZPsoWT5/ocAcYJcclTT
         vWgN2dClFUFY+gOkgs46iVRbM/SkvNqTZ2DL2lJ1a8OmnhBzaY+7LPt4RqiVSkZ95i5e
         h911HRxUqIcKQwfEVHedW3Mn2vGqXxOSgevhZxGnzja/Mfl2P5zHNhhxWSF1mDsrw0b1
         OkCP71C/lWMKJGgZ5uYz6LPFcohT/DVwxx1J7bWbk66fYnbXOEgJiNjHqZnLcWVsyzE2
         ofA979BGrVEgU+pazyJFcy7JS2TEHWwXuQSk7r1cKF+IcUtbjIo3KBmuoESCe+2kv6Ij
         EY0g==
X-Gm-Message-State: AJIora8Q3dSBhgyTTHDba/dJAZV0OUlUKpFk3SfQHu99b/AIaN7N+ivQ
        /R95q2XFjckNOu7+pydC8KM=
X-Google-Smtp-Source: AGRyM1tO0SKrl38orlze+qkf0akSz/oeJOz4cBwMOq1GXUHj2ao1hhrmhxBTyJJ7VwOa+P0mfN+ArA==
X-Received: by 2002:a63:4711:0:b0:415:ff46:ba5 with SMTP id u17-20020a634711000000b00415ff460ba5mr3675367pga.133.1657730125871;
        Wed, 13 Jul 2022 09:35:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r29-20020a63a55d000000b00412a9c2217asm8095477pgu.64.2022.07.13.09.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:35:25 -0700 (PDT)
Message-ID: <8b11eac7-cabe-a0bc-061f-7b9936c3696f@gmail.com>
Date:   Wed, 13 Jul 2022 09:35:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/8] ARM: dts: Move BCM963138DVT board dts to
 ARCH_BCMBCA
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
References: <20220707070037.261532-1-william.zhang@broadcom.com>
 <20220707070037.261532-3-william.zhang@broadcom.com>
 <304678bb-f49c-9c3b-e15e-df6c9e8a4ea2@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <304678bb-f49c-9c3b-e15e-df6c9e8a4ea2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 08:26, Rafał Miłecki wrote:
> On 7.07.2022 09:00, William Zhang wrote:
>> Use CONFIG_ARCH_BCMBCA to build all the BCMBCA SoC dts and remove
>> CONFIG_ARCH_BCM_63XX from the makefile
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> ---
>>
>> (no changes since v1)
>>
>>   arch/arm/boot/dts/Makefile | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 38d9c60aece7..1bf8e2f8ee68 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -147,8 +147,6 @@ dtb-$(CONFIG_ARCH_BCM_53573) += \
>>       bcm47189-luxul-xap-810.dtb \
>>       bcm47189-tenda-ac9.dtb \
>>       bcm947189acdbmr.dtb
>> -dtb-$(CONFIG_ARCH_BCM_63XX) += \
>> -    bcm963138dvt.dtb
>>   dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
>>       bcm911360_entphn.dtb \
>>       bcm911360k.dtb \
>> @@ -184,6 +182,7 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
>>       bcm7445-bcm97445svmb.dtb
>>   dtb-$(CONFIG_ARCH_BCMBCA) += \
>>       bcm947622.dtb \
>> +    bcm963138dvt.dtb \
>>       bcm963148.dtb \
>>       bcm963178.dtb \
>>       bcm96756.dtb \
> 
> Do we want to mix all that DT files? Are ARCH_BCM_63XX (ex-)users
> interested in compiling all of them?
> 
> For IPROC SoCs we have separated symbols: ARCH_BCM_CYGNUS / ARCH_BCM_HR2
> / ARCH_BCM_NSP / ARCH_BCM_5301X and we compile arch specific DT files
> only.

I am fine with that and build systems (buildroot and OpenWrt at least) 
typically offer a way to produce a device specific image that will 
contain a single DTB fit for the target device.

What we would be optimizing for would be build time vs. coverage, as a 
maintainer I favor coverage as it allows me to build everyone in one 
sweep. We could make the building of the 63138 conditional upon 
BCMBCA_CORTEXA9 if that bothers you.
-- 
Florian
