Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB83E594677
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 01:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352162AbiHOW5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351869AbiHOWy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:54:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A887F12D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8367DB81142
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DA6C433B5;
        Mon, 15 Aug 2022 19:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660593296;
        bh=JjXv2VYkFvnQB0QxswcyR4e5GR1lOOgi20sTkwj01Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyGBU3tFYPUXSJMh93qHz3c6aGJnaBF34wT5MoJZUZqjzHAHvr5ynEtIf18+qW6L5
         XqCKYTC7nLlBIOmHqTXSAg/77WYYz1KvP00PcTksp+o7XZq+UDvTdQ4nNSNyGfrY/x
         08zyjOwZxyvzRnH51ruNIDxalr0Wcx15f9JJyOtGoSpGbuP/qUBmULHRatO05lvhFm
         ntGa+x8EOvS4DEsNTz0A6eKqLhCR5mMTbTlArPbMaGAlX3Fe/CECuX29SAWleF/82p
         3yxuJjGjUUoc1WBwlNrvKYRkz6KUxu9ZBtfSxNQGer4ZFNjeRXYFjDPe0stzDlXJAS
         dydXU1BJBAdmQ==
Date:   Mon, 15 Aug 2022 12:54:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Dao Lu <daolu@rivosinc.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: arch/riscv/include/asm/jump_label.h:42:3: error: invalid operand
 for inline asm constraint 'i'
Message-ID: <YvqkjlUZ9DA/kA4H@dev-arch.thelio-3990X>
References: <202208141746.ABdEd5xo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208141746.ABdEd5xo-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 05:10:53PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
> commit: 8eb060e10185cfc97ef0200d197ec246ba0f9f8c arch/riscv: add Zihintpause support
> date:   3 days ago
> config: riscv-randconfig-r005-20220814 (https://download.01.org/0day-ci/archive/20220814/202208141746.ABdEd5xo-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8eb060e10185cfc97ef0200d197ec246ba0f9f8c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8eb060e10185cfc97ef0200d197ec246ba0f9f8c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <built-in>:4:
>    In file included from lib/vdso/gettimeofday.c:5:
>    In file included from include/vdso/datapage.h:17:
>    In file included from include/vdso/processor.h:10:
>    In file included from arch/riscv/include/asm/vdso/processor.h:7:
>    In file included from include/linux/jump_label.h:112:
> >> arch/riscv/include/asm/jump_label.h:42:3: error: invalid operand for inline asm constraint 'i'
>                    "       .option push                            \n\t"
>                    ^
>    1 error generated.
>    make[2]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
>    make[2]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
>    make[1]: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:219: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.

Just for the record, GCC 12.1.0 fails in the same way with the same
configuration (I didn't look into the problem beyond that):

  In file included from <command-line>:
  In function 'arch_static_branch_jump',
      inlined from 'cpu_relax' at arch/riscv/include/asm/vdso/processor.h:13:7:
  include/linux/compiler_types.h:285:33: warning: 'asm' operand 0 probably does not match constraints
    285 | #define asm_volatile_goto(x...) asm goto(x)
        |                                 ^~~
  arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
     41 |         asm_volatile_goto(
        |         ^~~~~~~~~~~~~~~~~
  include/linux/compiler_types.h:285:33: error: impossible constraint in 'asm'
    285 | #define asm_volatile_goto(x...) asm goto(x)
        |                                 ^~~
  arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
     41 |         asm_volatile_goto(
        |         ^~~~~~~~~~~~~~~~~
  make[3]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1

Cheers,
Nathan
