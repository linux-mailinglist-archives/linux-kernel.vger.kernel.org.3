Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14C94DB6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350407AbiCPQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbiCPQx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:53:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3548893
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90177B81A73
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78472C340EC;
        Wed, 16 Mar 2022 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647449558;
        bh=Ms3SdtmMym/ZVvEz4Mg4AybfC+tKlik66Ih1Bu21854=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmuGaGhTGM5RYI2B9+oSJZh4e7mtQ1SFXZJrZogBfAXcD9biIa9xDYy/KOQMcWPbd
         i/kkhaK7UHmbyozcQ0ijSECPu2YfQrvVPOfH20XdFZ2GTt+hK7hZXNA9oD1kSoJOwK
         9inXxeyumVktucHUxypg9gZHY/Wu5NV+ZvLUCD8dwo+56BUGqy6qIxSHhFSPKccgmM
         AHpkzbYz/B3S/mIKnYDuIf43thvB01QuPup0dUAnRpHGPJQ+JBhVljEhpz0byXuQIP
         sMnYOTlwk+36bPgyYCQ5KzFoqP1jmLB7dl/p2pt49a4L62Z0oTw0RsfFN/Gpjw61uv
         yDfVhIPKKLI0g==
Date:   Wed, 16 Mar 2022 09:52:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re:
 [ammarfaizi2-block:google/android/kernel/common/android-4.19-q-release
 5202/7636] ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line
 argument '-stack-alignment=8'.  Try: 'ld.lld --help'
Message-ID: <YjIVzw4JdSY4NcLz@dev-arch.thelio-3990X>
References: <202203160848.kydLIYip-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203160848.kydLIYip-lkp@intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 08:30:29AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-q-release
> head:   1a3500dc59324a85c20f025cfa6485a1a0debbdf
> commit: 205cde74877d624ef7d24a6692e6e9337b19a541 [5202/7636] ANDROID: x86: add support for CONFIG_LTO_CLANG
> config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220316/202203160848.kydLIYip-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/205cde74877d624ef7d24a6692e6e9337b19a541
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-q-release
>         git checkout 205cde74877d624ef7d24a6692e6e9337b19a541
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument '-stack-alignment=8'.  Try: 'ld.lld --help'
>    ld.lld: Did you mean '--stackrealign=8'?
> --
>    lib/irq_regs.o: no symbols
> >> ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument '-stack-alignment=8'.  Try: 'ld.lld --help'
>    ld.lld: Did you mean '--stackrealign=8'?

Already fixed:

https://android.googlesource.com/kernel/common/+/c1baa3321020cdd2ea9248d9b1ec512abf6f1c24

Bisecting an old tree with a new compiler is probably going to show
quite a few issues, given how often we have to add changes to the kernel
to get newer compilers to work.

Cheers,
Nathan
