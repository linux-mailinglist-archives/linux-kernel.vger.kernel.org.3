Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844D94AC538
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381907AbiBGQPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiBGQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:10:00 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED36C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:09:56 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id s21so15354324ejx.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 08:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HfNUL5JKH3kDf9qcQKKwHP/7+N+j2kYmXhkm2NxXJsQ=;
        b=Kh+ybRx1xV6ff6veBinDOzkV/xXydZSytkis1APfHweV0B2UrsES5yzfbcc4sh1QMB
         yG9AbmtZ/57dZyzJpouKbe4HraTI6tYSXh11YimgLqlzTqA451nS3ypBQrzKCpPKtvPk
         MoXJvWiC/YKllsHkezK0hpqWzROGguxj23lNBHg/smpQskTYQQa1J3opFjMtRyNjfi5N
         3+0Y5/83tGGuDO11vLNxVDIoskVgjT6gTp+li0L2TdgSSCgNjebMLQ/i1ICVwMwYCpuP
         e+58/FpfSqSzABq7K/V1T4L8tmner6paOwEKJVZAJBmAfJ2gfEHCvHI7Dm52PfpFBPYc
         neUQ==
X-Gm-Message-State: AOAM5315jCeExvxTZo/h4Z2enY+3g+PTYLznqpvY/YX75l0cW4ZhNPCK
        bhC1UDr1bodzn4HJKp/JXdOrB2vdSKs=
X-Google-Smtp-Source: ABdhPJxqFokTQR6V5JB0DhCIYgiAiKptMY6dcJVRueO91WZ4xHF2FzIjEh+Q/tU8n1/nJVpU/LkqMg==
X-Received: by 2002:a17:906:c105:: with SMTP id do5mr338028ejc.165.1644250194581;
        Mon, 07 Feb 2022 08:09:54 -0800 (PST)
Received: from [192.168.0.90] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id p19sm3826870ejc.42.2022.02.07.08.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 08:09:53 -0800 (PST)
Message-ID: <48e41893-d7de-fdc1-d988-9331c2de22f4@kernel.org>
Date:   Mon, 7 Feb 2022 17:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: ld.lld: error: undefined symbol: socfpga_reset_init
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
References: <202202050539.Mtk9I4Ef-lkp@intel.com>
 <67f432e2-1bfd-29dc-f2ed-051b47ef0844@kernel.org>
 <YgBtAdhl8dZVTAV+@dev-arch.archlinux-ax161>
 <8c315714-ea7b-d3ec-f131-6beded67b479@kernel.org>
 <a141e090-7049-d693-1dc2-7c0a593b9682@infradead.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <a141e090-7049-d693-1dc2-7c0a593b9682@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 17:06, Randy Dunlap wrote:
> 
> 
> On 2/6/22 23:55, Krzysztof Kozlowski wrote:
>> On 07/02/2022 01:51, Nathan Chancellor wrote:
>>> Hi Krzysztof,
>>>
>>> On Sun, Feb 06, 2022 at 12:55:57PM +0100, Krzysztof Kozlowski wrote:
>>>> On 04/02/2022 22:12, kernel test robot wrote:
>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>>> head:   dcb85f85fa6f142aae1fe86f399d4503d49f2b60
>>>>> commit: 4483397b03536506535d611b0cb28a81a69e8edf ARM: socfpga: drop ARCH_SOCFPGA
>>>>> date:   11 months ago
>>>>> config: arm-socfpga_defconfig (https://download.01.org/0day-ci/archive/20220205/202202050539.Mtk9I4Ef-lkp@intel.com/config)
>>>>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
>>>>> reproduce (this is a W=1 build):
>>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>         chmod +x ~/bin/make.cross
>>>>>         # install arm cross compiling tool for clang build
>>>>>         # apt-get install binutils-arm-linux-gnueabi
>>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4483397b03536506535d611b0cb28a81a69e8edf
>>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>         git fetch --no-tags linus master
>>>>>         git checkout 4483397b03536506535d611b0cb28a81a69e8edf
>>>>>         # save the config file to linux build tree
>>>>>         mkdir build_dir
>>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>>>>>
>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>
>>>>> All errors (new ones prefixed by >>):
>>>>>
>>>>>>> ld.lld: error: undefined symbol: socfpga_reset_init
>>>>>    >>> referenced by socfpga.c
>>>>>    >>>               socfpga.o:(socfpga_init_irq) in archive arch/arm/mach-socfpga/built-in.a
>>>>>    >>> referenced by socfpga.c
>>>>>    >>>               socfpga.o:(socfpga_arria10_init_irq) in archive arch/arm/mach-socfpga/built-in.a
>>>>>
>>>>
>>>> This looks like a false positive. On the socfpga defconfig arm build,
>>>> the socfpga_reset_init() (drivers/reset/reset-socfpga.c) is built.
>>>>
>>>> I also could not reproduce it with GCC.
>>>
>>> I can reproduce this error with the configuration that the bot provides
>>> at both 4483397b03536506535d611b0cb28a81a69e8edf and v5.17-rc3, even
>>> with GCC:
>>>
>>> $ curl -LSso .config https://download.01.org/0day-ci/archive/20220205/202202050539.Mtk9I4Ef-lkp@intel.com/config
>>>
>>> $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- olddefconfig all
>>> ...
>>> arm-linux-gnueabi-ld: arch/arm/mach-socfpga/socfpga.o: in function `socfpga_init_irq':
>>> socfpga.c:(.init.text+0x104): undefined reference to `socfpga_reset_init'
>>> ...
>>>
>>> Whether or not this reproduces with the in-tree socfpga_defconfig, I am
>>> not sure.
>>
>> Thanks for checking - it seems I misread (and find it confusing...) the
>> report - that it is socfpga defconfig. It clearly says "config:
>> arm-socfpga_defconfig"...
> 
> Aha, I did the same thing and could not reproduce it. :(
> 
>> I can reproduce it with the config from the URL. I'll work on fix.

FYI, patch sent:
https://lore.kernel.org/linux-arm-kernel/20220207084404.212017-1-krzysztof.kozlowski@canonical.com/


Best regards,
Krzysztof
