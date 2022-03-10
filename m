Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F34D53E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbiCJVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiCJVuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:50:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477C01045B1;
        Thu, 10 Mar 2022 13:49:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n18so3381950plg.5;
        Thu, 10 Mar 2022 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QKOxkvxNzD7rxqxwBmHmJb7NgshPzc0L9/lBDGQCjyU=;
        b=O5d5uCrqYq7WukFMaJ8slLI7O6P4WY+YopJ/77d9opSsWI7j5XeBsvJIVqgYAZ00s9
         W7N/rFOKRuM4rQRMn4+qZfBm6DiZFjAWHMj3cKVZw5pDMdZYqmBz3qj3aJTriEQu3vYu
         GnTyV98e6yHCpx/iVDqrwKWMre1w5IJ7j0gfeONqqrerif+P8Wgr/SdqkWYHvpfN8JgU
         yfa2GFFdpUFIJmG8SO2qr/BWSSVQ0bP1bxai9q/NM5ngw0Lhgkx9k0zpRk611RVLurKO
         jPoYTk0/pcfEJwRp7pSncRO+t2AdaiiWQrQF6a/JJm+R5DdtNb7Q3qN5zcmypWF8E/Hr
         HOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QKOxkvxNzD7rxqxwBmHmJb7NgshPzc0L9/lBDGQCjyU=;
        b=QXlA/qjyTQyOJD2YXHmFOjOx184q5zJJJv90FlTMRp8hKNyvLizkg2xSZrny3lWEG3
         C7Jn3LCMGOziX3yOLSlfzhT2EXurPhtpzGCp7WfFXsNpfh3FO1asW1XEQawUJdMK9N8P
         hW/VbeYS6sbwwQ3vxjW3Q0PCKqRYCoKQ6gFmp0/EeEMbRpa2GaU9R/ZWG+e4U2qysab8
         WXVyS0gdo5qG1uVPB6HR0SFK5Nzn9c043VvESg38Sr75dmkFxXaTEwW7+npQt9SBsNhf
         B1I2kc1G/h8CGD+37IGZds7n0LwQyPR/k28spe25BEbbhv5p/WppoT3eKI80IV+k3hIM
         IPPg==
X-Gm-Message-State: AOAM533UkAAybw4tgKZetvLypjlM52vM+A5Bn7FgWX/xWotw5pQS76X4
        2oAdxlsc86WlsgtncXrAvRg=
X-Google-Smtp-Source: ABdhPJzboM3rEgvQCQKv/g+HA0Z2B1g0bc1GanHYDtklV31AgS45ZvWFHZZWx/u+AYWntUOOxKSRQA==
X-Received: by 2002:a17:90a:c504:b0:1bf:6d9f:65a6 with SMTP id k4-20020a17090ac50400b001bf6d9f65a6mr7470086pjt.204.1646948989657;
        Thu, 10 Mar 2022 13:49:49 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p186-20020a62d0c3000000b004f6fa49c4b9sm7483756pfg.218.2022.03.10.13.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 13:49:49 -0800 (PST)
Subject: Re: [PATCH] tty: serial: bcm63xx: use more precise Kconfig symbol
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kevin Cernekee <cernekee@gmail.com>
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
 <145c66e0-2ba5-712c-57de-82378328ec3f@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7d7ed784-f01f-44a0-4387-cd7a76a8abe4@gmail.com>
Date:   Thu, 10 Mar 2022 13:49:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <145c66e0-2ba5-712c-57de-82378328ec3f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 3/10/22 12:33 AM, Rafał Miłecki wrote:
> On 10.03.2022 09:19, Geert Uytterhoeven wrote:
>> On Thu, Mar 10, 2022 at 8:22 AM Rafał Miłecki <zajec5@gmail.com> wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> Patches lowering SERIAL_BCM63XX dependencies led to a discussion and
>>> documentation change regarding "depends" usage. Adjust Kconfig entry to
>>> match current guidelines. Make this symbol available for relevant
>>> architectures only.
>>>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Ref: f35a07f92616 ("tty: serial: bcm63xx: lower driver dependencies")
>>> Ref: 18084e435ff6 ("Documentation/kbuild: Document platform
>>> dependency practises")
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>
>> Thanks for your patch!
>>
>>> --- a/drivers/tty/serial/Kconfig
>>> +++ b/drivers/tty/serial/Kconfig
>>> @@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
>>>   config SERIAL_BCM63XX
>>>          tristate "Broadcom BCM63xx/BCM33xx UART support"
>>>          select SERIAL_CORE
>>> -       depends on COMMON_CLK
>>> +       depends on MIPS || ARM || ARM64 || COMPILE_TEST
>>> +       default ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC
>>
>> So ARCH_BCM4908 covers ARM64, and BCM63XX || BMIPS_GENERIC
>> cover MIPS.  Is there some symbol covering ARM so we can change the
>> depends to
>>
>>      depends on FOO || ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC ||
>> COMPILE_TEST
>>
>> ?
> 
> Florian, Kevin: do you know what other platforms need that driver?

Yes that would be ARCH_BCM_63XX.
-- 
Florian
