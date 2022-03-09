Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2423E4D3916
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiCISpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiCISph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:45:37 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727241A39C4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:44:38 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 12so3548270oix.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 10:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GzeUrmmuWHgosSXEZvaiJ6fiMFBDvmNqArc7pVhUdmw=;
        b=ClMUF32qhbiWve6kYgskziTxmhZ7Brsa9mqUDFdshCXbEDjBm84JMaju5LoB+7/bOD
         nMMMsSUwMUv5/5oUsBSyzTYvTgYZkzsOpFPMYGAxBIjWZxKOhIW6ShOzwgNWJWY3c+w8
         nhL3dlCX4ZoQuQsiNCuoC5/JeSZhBgX6+1LU/X8Tqrbx+VV1vA0psLFgK5kUULUfSWbR
         Xb4aUlegUj9unYzzQahxzEeQ2m/MJYh0/3RNu7mqsnEo0l2ImhYK63VLGZp2G+mDvAh9
         gN9EKvUK3km0kd2k84g1etzpz1KD+0I8V0Yr9ZLQTSMborilFdYhj+OtMvz2WJ66txes
         4hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GzeUrmmuWHgosSXEZvaiJ6fiMFBDvmNqArc7pVhUdmw=;
        b=LK4gLM8Idknl/9pNlrJUHEoCD/ObrmXH7X0yNQIGZwVdnTpOFzdEM0daS1VALU+aef
         pt2JJy5NGero/E0h0oNiLE0/cn/RXC9dNsHRZE2DO/N3YEm2ZDgyGbtRb/0HlXydH6GE
         2xglNZKHydHMeVwitAVpnux0sV5JbzqGmGXml6hRPWclPGhbPxW9RpSJ9pb88jCk0q9+
         aiY9GMH/p7xcC6jg4Z7lIBntoVY2JswL7NaWBWuUnf7fsE7G6ydZTzOjjVr+5JvVe/jg
         28Kppcl06L5FbjId3ii1Kj1ibQebOtK9E/m5jcm7QRikbvM87nKutTbv9o87QDXQXMGf
         nuIw==
X-Gm-Message-State: AOAM533J6px+jQod0Pa4DCcunICwDukv8eJfN4Uw48S/1o4xGDlG7zC7
        JonRug6SjjZeBgRWxifsDjWYPQ==
X-Google-Smtp-Source: ABdhPJw3xe5kwsc8CBSNTcJFUsMyL0+atOL+7H6yn+T9qqhqw8AlcyYWCQdvxGtb6mJNoZm0SK7hUw==
X-Received: by 2002:a05:6808:bc1:b0:2d9:a01a:48a9 with SMTP id o1-20020a0568080bc100b002d9a01a48a9mr6847416oik.244.1646851477762;
        Wed, 09 Mar 2022 10:44:37 -0800 (PST)
Received: from [192.168.17.16] ([189.219.74.147])
        by smtp.gmail.com with ESMTPSA id h18-20020a4a6b52000000b003212884f3e1sm1303655oof.19.2022.03.09.10.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 10:44:37 -0800 (PST)
Message-ID: <249f3f06-5486-5988-dedb-3ba7eed580f3@linaro.org>
Date:   Wed, 9 Mar 2022 12:44:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4.14 00/18] 4.14.271-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
References: <20220309155856.090281301@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20220309155856.090281301@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 09/03/22 09:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.271 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Mar 2022 15:58:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.271-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Regressions found.

The following Arm combinations failed to build:
- arm-gcc-8-bcm2835_defconfig
- arm-gcc-8-imx_v6_v7_defconfig
- arm-gcc-8-omap2plus_defconfig
- arm-gcc-9-bcm2835_defconfig
- arm-gcc-9-imx_v6_v7_defconfig
- arm-gcc-9-omap2plus_defconfig
- arm-gcc-10-bcm2835_defconfig
- arm-gcc-10-imx_v6_v7_defconfig
- arm-gcc-10-omap2plus_defconfig
- arm-gcc-11-bcm2835_defconfig
- arm-gcc-11-imx_v6_v7_defconfig
- arm-gcc-11-omap2plus_defconfig

Messages look like this:

   /builds/linux/arch/arm/kernel/entry-common.S: Assembler messages:
   /builds/linux/arch/arm/kernel/entry-common.S:164: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/kernel/entry-common.S:173: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   make[2]: *** [/builds/linux/scripts/Makefile.build:430: arch/arm/kernel/entry-common.o] Error 1
   /builds/linux/arch/arm/mm/cache-v7.S: Assembler messages:
   /builds/linux/arch/arm/mm/cache-v7.S:63: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/mm/cache-v7.S:136: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/mm/cache-v7.S:170: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/mm/cache-v7.S:298: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   make[2]: *** [/builds/linux/scripts/Makefile.build:430: arch/arm/mm/cache-v7.o] Error 1
   /builds/linux/arch/arm/mm/tlb-v7.S: Assembler messages:
   /builds/linux/arch/arm/mm/tlb-v7.S:88: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   make[2]: *** [/builds/linux/scripts/Makefile.build:430: arch/arm/mm/tlb-v7.o] Error 1
   /builds/linux/arch/arm/kernel/entry-armv.S: Assembler messages:
   /builds/linux/arch/arm/kernel/entry-armv.S:1121: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/kernel/entry-armv.S:1144: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/kernel/entry-armv.S:1167: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/kernel/entry-armv.S:1190: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/kernel/entry-armv.S:1229: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   make[2]: *** [/builds/linux/scripts/Makefile.build:430: arch/arm/kernel/entry-armv.o] Error 1
   /builds/linux/arch/arm/mm/proc-v7-2level.S: Assembler messages:
   /builds/linux/arch/arm/mm/proc-v7-2level.S:58: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/mm/proc-v7-2level.S:60: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   /builds/linux/arch/arm/mm/proc-v7.S:62: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   make[2]: *** [/builds/linux/scripts/Makefile.build:430: arch/arm/mm/proc-v7.o] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [/builds/linux/Makefile:1053: arch/arm/mm] Error 2


Greetings!

Daniel Díaz
daniel.diaz@linaro.org
