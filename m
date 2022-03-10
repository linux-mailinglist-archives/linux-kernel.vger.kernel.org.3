Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79ED4D4293
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiCJIeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiCJIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:34:11 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DCC5C864;
        Thu, 10 Mar 2022 00:33:09 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s25so6675227lji.5;
        Thu, 10 Mar 2022 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=5kbIEXrorz/H9DvUKGpzubyMEhfXDoMfMqyoxlkwx5s=;
        b=UrjYq2/KyC3hvwORoAq2rAi9RMIsuR0umGHAz3DXdsGHU46VPLPpRZ7oxHgbMoZzfP
         TpJPe7CbBMnfx/r97HrJIw8EChbICBje8UAdC9Xur7ScmBVscc+jU56Vbgzb0NFuyZ3L
         Yr3DRddja/lhGnlemyu7O8ubgNs5p3fxjkfcF9hpjCvEkIDhWBW7Hb4SHkDbe9ZR3sKe
         JSLTPqNPtGssgo/N6E/lV8jQE4RiK2pu5k5MCrEjkdKQGSt6kEugPFgkbIDoRlYVB0sl
         u+5CMCvl2xxZtIiEx+I8NV02zzxhBW9yTYM3QTD8161ihrXzLxtgEfWnTWwBF8jH6EzQ
         PARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5kbIEXrorz/H9DvUKGpzubyMEhfXDoMfMqyoxlkwx5s=;
        b=5Sh4abJehEyo0VSM39lvJygbENY3Nnhzu7pS7NqESB+Y0beRufDihnkM32zLB8ja2g
         73a4PDMGbWsa4yrnizk34viClI8fdhjSngsK8+7q5yQnD7yaG7oMw94Am/ElGOpnVTfM
         KOvV3EbnzhPDVC+dgqlz+urpLNB1yQiQN59HVAdETBLTrRo0yM+6DKVFBb9gqRUEMtmv
         9JwDrdExcwBZ+O2BcGBmf5YpZ9P3TrAtBGqttSFZ020V54crHQsexaBh6e+GBbvZlhpA
         cUYKE0fdcppNja9lY8EXYdfCB1SAg6nafGTV0YveLIIiQpU8g8newNS9KTy8gT+v3AmY
         2JMw==
X-Gm-Message-State: AOAM531E6ZhOwLRiE3ZyxIAjUBDxoE/DKD+Ofncibdhm8nI69ypf5j2G
        o09l+pEoLyp6K0TaaslMsqA=
X-Google-Smtp-Source: ABdhPJxzhyaNeFJBtRmOqugCqJRepynC1ipQE7qbVJiJc/tZWrPO6G4gzHfE6PWCrhciUe6CBTBY2w==
X-Received: by 2002:a2e:54b:0:b0:248:744:b859 with SMTP id 72-20020a2e054b000000b002480744b859mr2331586ljf.37.1646901187276;
        Thu, 10 Mar 2022 00:33:07 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id j7-20020a2e3c07000000b00247fd2f7f46sm926039lja.47.2022.03.10.00.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 00:33:06 -0800 (PST)
Message-ID: <145c66e0-2ba5-712c-57de-82378328ec3f@gmail.com>
Date:   Thu, 10 Mar 2022 09:33:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] tty: serial: bcm63xx: use more precise Kconfig symbol
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220310072239.4489-1-zajec5@gmail.com>
 <CAMuHMdWQNDABuT9uwAugrzdQM31wFtXX_9F8MviC-BRc-YngKw@mail.gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <CAMuHMdWQNDABuT9uwAugrzdQM31wFtXX_9F8MviC-BRc-YngKw@mail.gmail.com>
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

On 10.03.2022 09:19, Geert Uytterhoeven wrote:
> On Thu, Mar 10, 2022 at 8:22 AM Rafał Miłecki <zajec5@gmail.com> wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Patches lowering SERIAL_BCM63XX dependencies led to a discussion and
>> documentation change regarding "depends" usage. Adjust Kconfig entry to
>> match current guidelines. Make this symbol available for relevant
>> architectures only.
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Ref: f35a07f92616 ("tty: serial: bcm63xx: lower driver dependencies")
>> Ref: 18084e435ff6 ("Documentation/kbuild: Document platform dependency practises")
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> Thanks for your patch!
> 
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
>>   config SERIAL_BCM63XX
>>          tristate "Broadcom BCM63xx/BCM33xx UART support"
>>          select SERIAL_CORE
>> -       depends on COMMON_CLK
>> +       depends on MIPS || ARM || ARM64 || COMPILE_TEST
>> +       default ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC
> 
> So ARCH_BCM4908 covers ARM64, and BCM63XX || BMIPS_GENERIC
> cover MIPS.  Is there some symbol covering ARM so we can change the
> depends to
> 
>      depends on FOO || ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC || COMPILE_TEST
> 
> ?

Florian, Kevin: do you know what other platforms need that driver?

Ref: c0ec3fd123e9 ("tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other platforms")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c0ec3fd123e9e64e095fb221ace841e00c04e40b
