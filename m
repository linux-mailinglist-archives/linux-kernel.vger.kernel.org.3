Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124DA5332AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbiEXU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiEXU4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:56:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1253B10FE2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=x0ETksflVZigcIVkU0HLK0p3rGL2Xh3mtq7gP4huqAE=; b=hdIfUeITUVqORPi1YsA7D4NGCv
        ORWXPaSA9UJ7FXS3UBuv8cfxcE2S+Pml23zRWxsqq01js07dMWXAzQd32SFr6luJvD+FLZrXXKJdR
        v6Q+ThWflMaJ2k7+41mMjJs5SmDhoQxfzYuKc1IxlufVnGjLKMZomibJj3pWQ7e8VFZdI0mKrT0ei
        D2wpJgTVcB7gjgPDYI5VUVFJskbGZoT2FiqkcPp2gJw6iYrXBtuXf6TGsnq8SCCIsZa5Ym5PngbOQ
        CzU2PS2jWv49xjTnsD5er+/DihoxO23xGHaXVag/XYB4jWLfoUTNDwwVH+b7NAIfVnPrC2+XT4ilQ
        SDc9/tGw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntbZk-00HPVt-3K; Tue, 24 May 2022 20:56:20 +0000
Message-ID: <8aa4094d-2a15-bab4-13be-eb064beac942@infradead.org>
Date:   Tue, 24 May 2022 13:56:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: arch/riscv/mm/init.c:782:83: warning: suggest braces around empty
 body in an 'if' statement
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
References: <202205230554.bQhtkCTA-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202205230554.bQhtkCTA-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 5/22/22 14:19, kernel test robot wrote:
> Hi Qinglin,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> commit: 677b9eb8810edc6c616a699018a83e24ed0cccab riscv: mm: Prepare pt_ops helper functions for sv57
> date:   3 months ago
> config: riscv-randconfig-r042-20220522 (https://download.01.org/0day-ci/archive/20220523/202205230554.bQhtkCTA-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=677b9eb8810edc6c616a699018a83e24ed0cccab
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 677b9eb8810edc6c616a699018a83e24ed0cccab
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/riscv/mm/init.c: In function 'create_fdt_early_page_table':
>>> arch/riscv/mm/init.c:782:83: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
>      782 |                                    (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
>          |                                                                                   ^
>    arch/riscv/mm/init.c:786:83: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
>      786 |                                    (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
>          |                                                                                   ^
>    arch/riscv/mm/init.c: At top level:
>    arch/riscv/mm/init.c:813:13: warning: no previous prototype for 'pt_ops_set_early' [-Wmissing-prototypes]
>      813 | void __init pt_ops_set_early(void)
>          |             ^~~~~~~~~~~~~~~~
>    arch/riscv/mm/init.c:835:13: warning: no previous prototype for 'pt_ops_set_fixmap' [-Wmissing-prototypes]
>      835 | void __init pt_ops_set_fixmap(void)
>          |             ^~~~~~~~~~~~~~~~~
>    arch/riscv/mm/init.c:853:13: warning: no previous prototype for 'pt_ops_set_late' [-Wmissing-prototypes]
>      853 | void __init pt_ops_set_late(void)
>          |             ^~~~~~~~~~~~~~~

What is the status of your patch for this build warning?

[PATCH v2 1/4] RISC-V: Avoid empty create_*_mapping definitions

Thanks.

-- 
~Randy
