Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001AB59930F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbiHSChB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHSCg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:36:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290DBCC313
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CKrpIC9UicO12gvCLgzg1YisGV2nQ8KKc9GDBljdtno=; b=s2qv2DW8TUzba6vu0OWg5HOlCQ
        kTxa5aTj2JaAUKJUQ3Wo6ZLAF1VHudAEhEJY70q6EDADlS1OB4ubh1mKT+CWWI6lm4lvVRKKOZ+Fp
        NlgEKxnD1akZX5T6yUtvOF+/4UDC+il1qqyuSyLu0kb7dIgH4tMoPbjVLf11e0RdR6yGA/g2FzJ5I
        +PvN3QP4PKsazr0b8az9jY2eSciOwa6hMSoLs41JLBzSppc2MYNerGQ2PZzFPiWPRpv7dtplq0fGb
        CYgY7Y9/hOG2gzwabhoNU/NK62yVKTuuru0KE8Vh68MmVbJjougkmCV1ZruNVhWybMR9OhukQ2wi9
        J3H3zpPA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOrsF-00Ef0B-Sl; Fri, 19 Aug 2022 02:36:40 +0000
Message-ID: <fe6636a1-19a3-2243-e22e-1a8bad8e23a4@infradead.org>
Date:   Thu, 18 Aug 2022 19:36:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: drivers/tty/serial/sunplus-uart.c:671: undefined reference to
 `uart_remove_one_port'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Qin Jian <qinjian@cqplus1.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <202208161624.f6SCFLBq-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202208161624.f6SCFLBq-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/22 01:59, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> commit: 0aa94eea8d955c82014e5368a843da93f1dc58f8 ARM: sunplus: Add initial support for Sunplus SP7021 SoC
> date:   6 weeks ago
> config: arm-randconfig-r012-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161624.f6SCFLBq-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0aa94eea8d955c82014e5368a843da93f1dc58f8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0aa94eea8d955c82014e5368a843da93f1dc58f8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

Fix is here:
https://lore.kernel.org/lkml/20220806025705.7759-1-rdunlap@infradead.org/

> 
> All errors (new ones prefixed by >>):


[snip]

> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS
>    Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && (ARCH_SUNPLUS [=y] || COMPILE_TEST [=y])
>    Selected by [y]:
>    - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]
>    WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS_CONSOLE
>    Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_SUNPLUS [=y]
>    Selected by [y]:
>    - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]

No, this is the primary problem. The build error happen due to this.
 

-- 
~Randy
