Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CFC56D226
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 02:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGKAWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 20:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKAWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 20:22:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4971B1581F;
        Sun, 10 Jul 2022 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2XKbdPJjnxVplVpIW0prOE5SMVdMJp4Cpi9zvSg2mgQ=; b=UkEhP6uA3PGlJ5MzM0WCIlpRQ6
        7LzZR50E9K+rf3H2brNn7tlRR1aJFoZ/S22jmHR3b9jwAWBBBSo5Y1SJiE/xleeZKmjfkfDg+h1mH
        +jWWsgDpD0XMnll5fN7AAs7pKlXHRTlQVfAikSyhSf7vpdpvONQbt7TJsDW83AdWPn3hCft0t8jNO
        HGCCfusjZW7rwcMGbCv+BFsmh2c6dU60PqewycFhZ3sf3uZP+9iI0ix2RpC/qh0pKeOOIby6ItMJ7
        p0/qZYckJttsJZ3Hl2RMKMQlt5mPq/+ZJ8ExIoz51lrmPTOp34B2lPN21Vfb5BASPORXcwlejeIqn
        JjswkT9Q==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAhBW-00Eg6K-O0; Mon, 11 Jul 2022 00:21:58 +0000
Message-ID: <fdd9bf58-4b9e-8843-c669-9550ada614c5@infradead.org>
Date:   Sun, 10 Jul 2022 17:21:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: ld.lld: error: undefined symbol: omap_set_dma_priority
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org
References: <202207080322.DnumSqh8-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202207080322.DnumSqh8-lkp@intel.com>
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



On 7/7/22 12:17, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee
> commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
> date:   5 weeks ago
> config: arm-randconfig-r035-20220706 (https://download.01.org/0day-ci/archive/20220708/202207080322.DnumSqh8-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7036440eab3e2d47a775d4616909f8235488d714
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7036440eab3e2d47a775d4616909f8235488d714
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: omap_set_dma_priority
>    >>> referenced by omapfb_main.c:1706 (drivers/video/fbdev/omap/omapfb_main.c:1706)
>    >>>               video/fbdev/omap/omapfb_main.o:(omapfb_do_probe) in archive drivers/built-in.a

(also happens with gcc)

Discrepancy between arch/arm/Kconfig and arch/arm/mach-omap1/{Kconfig,Makefile},
drivers/video/fbdev/omap/Kconfig, and <linux/omap-dma.h>.

Kernel .config has

CONFIG_ARCH_OMAP1=y
# CONFIG_ARCH_OMAP730 is not set
# CONFIG_ARCH_OMAP850 is not set
# CONFIG_ARCH_OMAP16XX is not set
CONFIG_ARCH_OMAP=y

FB_OMAP_DMA_TUNE depends on FB_OMAP, which
depends on ARCH_OMAP1 || (ARM && COMPILE_TEST), all of which are 'y'.

<linux/omap-dma.h> expects omap_set_dma_priority() to be defined
elsewhere (not inline) for this .config:

#if defined(CONFIG_ARCH_OMAP1)
extern void omap_set_dma_priority(int lch, int dst_port, int priority);
#else
static inline void omap_set_dma_priority(int lch, int dst_port, int priority)
{
}
#endif

but arch/arm/mach-omap1/Makefile only builds omap-dma.o for
ifdef CONFIG_ARCH_OMAP1_ANY, which is not set.


-- 
~Randy
