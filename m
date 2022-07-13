Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343E3573ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiGMQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiGMQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:10:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FCE3F33C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:10:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so4406481pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TRU82Sf1j3xz6Sl53tbiO939FjAc/hvY1KmrQRS8SPY=;
        b=VY2GpKTU4YGyW9mc4FuozBl8sVwFA7ZZnoHQe3maUTiyxM7asSDVcqlce20cp20N0r
         sq2V6s74EacVJdF7uOeX30FWOXqbbFS/hXApNWhskAHdasoFSjDqbVCi6F+Kw/A6gPsg
         L83WumNhiEWd+vZIWAQwQaeH2dU7lQk4CfrrgChuhbowlxcCel60VJwJT0xkB53aKXNR
         5B5W2D5XXtAHw1pIEOZMld7/DBbJysPCoYH1ysKoSbKL9EpdnLIcQLMihRivVsxwgZHp
         ksto5iWmvloDqBb45wDPs+KuOhN7szrlTBYFTOZzLo5ZqIsq8uW9loikNbkxU2o9Vid5
         tKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TRU82Sf1j3xz6Sl53tbiO939FjAc/hvY1KmrQRS8SPY=;
        b=rynioHGmF0yLWb3jpXtC4B2ClAFTpxxC0F1vYskKa58WkKoJ3wJvpUxcLx2T9bfKaP
         KWp+kkhxmG3n6N4uLUtltyHmuM5HOZg0IX5tkdWJzeNB3xJyAsSIayQsS1VZ4TibSaeO
         k8g8Q0VPHrHc/EdbFjJqgP/qRQl38f8FdNupX7Hqfi0wXVSNA3nOayywSspmF6XCPsMd
         zmCp672IhrlQSGzDmWXrm4gwY7Rf7n2ij24+/dpDIEINLVexDBrc1FwkQQGMKM0dUu/O
         tFyHMy18zqjw/N3pZLyeSX7nhfkMP6oyoQNWw/DZqI1dVjJPH2oQryoen3paeem8ArGf
         hdmQ==
X-Gm-Message-State: AJIora/1lP3qwZ+plfUHwUX751Pv95D4kNRs4gmnjtkJjaslr73I/1nb
        jt5fidtrB5mu7UAiNxzAllA=
X-Google-Smtp-Source: AGRyM1s/D6gIwdH5QalivUFe6r5mxeuYLmgNqTHhclIjsZ696MeuNz8m5AbYY+0KNPuZTqKQNDHAmw==
X-Received: by 2002:a17:902:f092:b0:16c:37e4:af8 with SMTP id p18-20020a170902f09200b0016c37e40af8mr4062471pla.146.1657728654479;
        Wed, 13 Jul 2022 09:10:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e20-20020aa79814000000b00528c7ac7f27sm9039387pfl.81.2022.07.13.09.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:10:53 -0700 (PDT)
Message-ID: <5392c58e-d479-94c9-f025-099f99ae17ba@gmail.com>
Date:   Wed, 13 Jul 2022 09:10:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 1/8] ARM: debug: bcmbca: Replace ARCH_BCM_63XX with
 ARCH_BCMBCA
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <86444849-e80a-6e28-c060-cecb9f07ae75@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <86444849-e80a-6e28-c060-cecb9f07ae75@gmail.com>
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

On 7/13/22 08:39, Rafał Miłecki wrote:
> On 7.07.2022 08:57, William Zhang wrote:
>> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
>> DEBUG_BCM63XX_UART depending on ARCH_BCMBCA.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> ---
>>
>>   arch/arm/Kconfig.debug | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 9b0aa4822d69..792796a348c3 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -271,7 +271,7 @@ choice
>>       config DEBUG_BCM63XX_UART
>>           bool "Kernel low-level debugging on BCM63XX UART"
>> -        depends on ARCH_BCM_63XX
>> +        depends on ARCH_BCMBCA
>>       config DEBUG_BERLIN_UART
>>           bool "Marvell Berlin SoC Debug UART"
> 
> There is no such config symbol (ARCH_BCMBCA) in Linus's tree.
> 
> This patchset is going to break builds until code it depends on hits 
> Linus's tree.
> 
> All those patches should be hold until that.

There is, ARCH_BCMBCA was added to arch/arm/mach-bcm/Kconfig with 
b32c613b3fda3 ("arm: bcmbca: add arch bcmbca machine entry") which is in 
v5.19-rc1 and newer:

  git tag --contains b32c613b3fda3
arm-soc/for-5.19/devicetree-arm64-fixes
arm-soc/for-5.19/devicetree-fixes
arm-soc/for-5.19/drivers-fixes
arm-soc/for-5.19/maintainers-fixes
arm-soc/for-5.19/soc
arm-soc/for-5.20/defconfig
arm-soc/for-5.20/defconfig-arm64
arm-soc/for-5.20/devicetree
arm-soc/for-5.20/devicetree-arm64
arm-soc/for-5.20/drivers
arm-soc/for-5.20/maintainers
arm-soc/for-5.20/soc
ib-mfd-soc-bcm-v5.20
mips-fixes_5.19_1
mips-fixes_5.19_2
next-20220511
next-20220512
next-20220523
next-20220524
next-20220610
next-20220627
next-20220628
next-20220706
next-20220708
next-20220711
next-20220712
v5.19-rc1
v5.19-rc2
v5.19-rc3
v5.19-rc4
v5.19-rc5
v5.19-rc6

otherwise we would not have done it that way. Am I missing something?
-- 
Florian
