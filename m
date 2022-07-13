Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA220573DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiGMUTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGMUTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:19:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAECF58F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:19:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b11so21793921eju.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=u7gD4gCqUf7Ekz0Vd5GHvB7q31WTnikpOx7hctY493c=;
        b=FNlnHG9IWiGoiFp/vAaMFuPPH72UNwp458pl7evjqhG4JW7Qq/WGYIQLpdzrT+PbEd
         23nSLB3nj/33q78CjUt1x7+g1oWBzs4J5xRFxkGxbw6fis5EWpLO3MyZI9fT/A82Uib1
         w7Abet7l2OqhOblWISZ8/AxhJjQIlUWHb7gT46bgDQgn1t7EsKm6h/cEX/uT37mLSe2M
         tANl4IgDk3yHcol9Ho10wC5QQtM4d+cpU4WeHGmFI6v8TN5XonD7ASVCC6f5s/Jo7WOZ
         QLHRIOBJdc6OA5TQO/IkP4mHlWDRr/xSadeRaKeTC2I15zzyyZOzctbGykwbpp6sUP8E
         n5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u7gD4gCqUf7Ekz0Vd5GHvB7q31WTnikpOx7hctY493c=;
        b=co4xX+mLGUuSoMlGqC460/OQcIb1ZsINZWRVM+ssKGETvX9UaPIRbjPYz5KscUKk0O
         MzyXCFRoW3yhWv1LWOmRozpe9hZ9KMye8og/VGqNR7xb6smV+WJ4MnXofG3rL7Huygle
         eIMR7inuidc44EAx5Wa625AZe9zkSmthA+HB6YeQjn8aTY3Se6tH28DifsAKIORvupRS
         NcD7UXApafJzBLalqMX0DWa4AZUKsgZiNT4uLA3edLyUWrCzRh3tML7fGScuIknsYqVo
         U6gtwREH92eEsr/MerA9l3N2aiS62gA+Ivq4x+Wxe9FohhNIzCWgVqzQVl0WrgZWClSU
         gyrQ==
X-Gm-Message-State: AJIora8CGUli6YxtdRbcZQXYRh/J5xa/DglVN8B/TjLQFUFSFGalmvxO
        kQpT3qLiza+2d5T44bZuK7s=
X-Google-Smtp-Source: AGRyM1teipoatooqTjtJm5Hfy9atUyPNCY/kS7I5+w5si8t9Nb/pWWc/dK/5l1RPmYaOJZZRvtOzFA==
X-Received: by 2002:a17:906:8a5b:b0:72b:50a1:a72c with SMTP id gx27-20020a1709068a5b00b0072b50a1a72cmr5327103ejc.152.1657743556741;
        Wed, 13 Jul 2022 13:19:16 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id i20-20020aa7c714000000b0043580ac5888sm8575040edq.82.2022.07.13.13.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 13:19:16 -0700 (PDT)
Message-ID: <fced7f47-985b-7ef8-431b-051353a56d30@gmail.com>
Date:   Wed, 13 Jul 2022 22:19:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [RESEND PATCH 1/8] ARM: debug: bcmbca: Replace ARCH_BCM_63XX with
 ARCH_BCMBCA
To:     Florian Fainelli <f.fainelli@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        Ard Biesheuvel <ardb@kernel.org>,
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
 <5392c58e-d479-94c9-f025-099f99ae17ba@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <5392c58e-d479-94c9-f025-099f99ae17ba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.2022 18:10, Florian Fainelli wrote:
> On 7/13/22 08:39, Rafał Miłecki wrote:
>> On 7.07.2022 08:57, William Zhang wrote:
>>> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
>>> DEBUG_BCM63XX_UART depending on ARCH_BCMBCA.
>>>
>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>> ---
>>>
>>>   arch/arm/Kconfig.debug | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>>> index 9b0aa4822d69..792796a348c3 100644
>>> --- a/arch/arm/Kconfig.debug
>>> +++ b/arch/arm/Kconfig.debug
>>> @@ -271,7 +271,7 @@ choice
>>>       config DEBUG_BCM63XX_UART
>>>           bool "Kernel low-level debugging on BCM63XX UART"
>>> -        depends on ARCH_BCM_63XX
>>> +        depends on ARCH_BCMBCA
>>>       config DEBUG_BERLIN_UART
>>>           bool "Marvell Berlin SoC Debug UART"
>>
>> There is no such config symbol (ARCH_BCMBCA) in Linus's tree.
>>
>> This patchset is going to break builds until code it depends on hits Linus's tree.
>>
>> All those patches should be hold until that.
> 
> There is, ARCH_BCMBCA was added to arch/arm/mach-bcm/Kconfig with b32c613b3fda3 ("arm: bcmbca: add arch bcmbca machine entry") which is in v5.19-rc1 and newer:

Oops, my tree updating script failed me. Sorry!

OK then, maybe this migration wasn't handled flawlessly but it's half
done now and remaining things should be fixed with all pending work.
Looks OK!
