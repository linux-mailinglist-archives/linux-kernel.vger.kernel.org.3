Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69E9573B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbiGMQYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiGMQYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:24:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AEDCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:24:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so4435415pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8trEXKpqs8PNonlHlRAj0tR6TlfRjpWV9U7p7xcA0cw=;
        b=WGwvYd9kHreU5ZrEeGCA0sowUoADCOxudKybzsDqSMmsHB+9t3kOg9Dn2R9xvYTVmg
         lcDYcpjy57SBFpalKnepSf1SpnRIxzEHMn53nje/Snz8kjxdd53DDVBwHw4KMed1hD+7
         KUzWdGE9wfk7FDMQ9e8x8z6aLoj9A+AcJoUIFllxIh5AwNAqNWvFyfXJKLhbaGvLML6h
         9MyZo4c3hbkiWcSIviRro83vHqzb1cw6UWHEUVNn+WALuLWMBnmdNbSTkgGfsB/aA7kc
         rhCgY3EZdYknY+K4nausWVjYJyUoD/xxDwU/pUzGelbdvVp4L583kTAMwyvB5N9dSs2S
         jsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8trEXKpqs8PNonlHlRAj0tR6TlfRjpWV9U7p7xcA0cw=;
        b=Frzdcax8baf3u9GYTn5gX6sqldrywo4K176/NmYx/PcGvCLDjl4CxGV0E8XbyLaLCg
         Mj/T00/giXnusqhMtq36JjRYERay+YerWGJHvVvVwJJ68MTrEnUYilIo8KUbwXEOvNUv
         aIyV5bpsrXlzmuYTlKezJSC18azX6m+ZkHYdOhStsTru/YJC+GjcGAxv06JOWF2MWjsx
         BmeQuueXkIVUloyHJf4RVtILcwKMrrK3T4xPHmaPRy923G91yyxVwAj6fEMgkJPn7GcZ
         BeLbCyIeY6Bu+yncATmpwWCudIg1pIea0rzi8Zf3psmmnuIusrqo522J7EBQRKCqbdqw
         /x1A==
X-Gm-Message-State: AJIora8a/ultAC/9NZbbfxAbK18qNrnKMW7Etg4z4XmZcSJ56KhH21na
        SZFGuXeCXWBVZvKb46fC3MCvg93PoF4=
X-Google-Smtp-Source: AGRyM1tYGrSKPhQN6SPtebAPI45F7srWaChNZhxj8UpJl7SxcZvORUheGZGOB4uPMqcJ+slgPzz2fg==
X-Received: by 2002:a17:902:e54e:b0:16c:56e:7a1e with SMTP id n14-20020a170902e54e00b0016c056e7a1emr3840246plf.30.1657729456930;
        Wed, 13 Jul 2022 09:24:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m10-20020a17090a5a4a00b001ef7e7548b8sm1764302pji.44.2022.07.13.09.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:24:16 -0700 (PDT)
Message-ID: <50982534-ae54-771c-3835-7a242b8c7124@gmail.com>
Date:   Wed, 13 Jul 2022 09:24:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/8] arm: bcmbca: Move BCM63138 ARCH_BCM_63XX to
 ARCH_BCMBCA
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20220707070037.261532-1-william.zhang@broadcom.com>
 <20220707070037.261532-6-william.zhang@broadcom.com>
 <f00dbaaf-bf92-11db-8a2b-ef78e0a91347@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <f00dbaaf-bf92-11db-8a2b-ef78e0a91347@gmail.com>
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

On 7/13/22 08:35, Rafał Miłecki wrote:
> On 7.07.2022 09:00, William Zhang wrote:
>> Remove ARCH_BCM_63XX Kconfig for BCM63138 and merge its selections to
>> ARCH_BCMBCA. Delete bcm63xx.c as it is no longer needed.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> ---
>>
>> (no changes since v1)
>>
>>   arch/arm/mach-bcm/Kconfig   | 26 +++++++++-----------------
>>   arch/arm/mach-bcm/Makefile  |  7 +------
>>   arch/arm/mach-bcm/bcm63xx.c | 17 -----------------
>>   3 files changed, 10 insertions(+), 40 deletions(-)
>>   delete mode 100644 arch/arm/mach-bcm/bcm63xx.c
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index f73a056bf560..25aa4ef4db07 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -182,23 +182,6 @@ config ARCH_BCM_53573
>>         The base chip is BCM53573 and there are some packaging 
>> modifications
>>         like BCM47189 and BCM47452.
>> -config ARCH_BCM_63XX
>> -    bool "Broadcom BCM63xx DSL SoC"
>> -    depends on ARCH_MULTI_V7
>> -    select ARCH_HAS_RESET_CONTROLLER
>> -    select ARM_ERRATA_754322
>> -    select ARM_ERRATA_764369 if SMP
>> -    select ARM_GIC
>> -    select ARM_GLOBAL_TIMER
>> -    select CACHE_L2X0
>> -    select HAVE_ARM_ARCH_TIMER
>> -    select HAVE_ARM_TWD if SMP
>> -    select HAVE_ARM_SCU if SMP
>> -    help
>> -      This enables support for systems based on Broadcom DSL SoCs.
>> -      It currently supports the 'BCM63XX' ARM-based family, which 
>> includes
>> -      the BCM63138 variant.
> 
> Oh, wait a second. This is actually going to totally break builds for
> people because there are a lot of Kconfig-s that depend on it!
> 
> I don't believe it can't be handled this way.
> 
> You need to first introduce a replacement / parent symbol.
> Then (in another release if needed) update all Kconfig-s.
> Then eventually you can get rid of ARCH_BCM_63XX.

This works because ARCH_BCMBCA was introdcuced in v5.19-rc1 with 
b32c613b3fda3 and in patch 8 the defconfig is updated to select ARCH_BCMBCA.
-- 
Florian
