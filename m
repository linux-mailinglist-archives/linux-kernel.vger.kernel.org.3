Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575B5475E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbhLORVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbhLORVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:21:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D62C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 09:21:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1010BB82026
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 17:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70D3C36AE2;
        Wed, 15 Dec 2021 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639588909;
        bh=5kw5d/dJmPzKVkRoB5LKQamLyO243vfdE9NF/V8TtsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWrV/EiGznIzhs5lwHJfEXtffgY2NeUaRr7i2F+yyxfvUdi5E5PZH8LhxdNnL0YSH
         BTn6ii0Rzh8zF2kWe6R/WqtZygnZM7ZyDPgb3w/1e28BxOFEna4BM/bknhhwJygDhT
         HcarbJQtmlCViCoj9EUHxN19Ot4IQpszrgIMShunJxuTKVQypiyMuzA+aJDGhiIVbG
         E3xvQGhiurqW59+sdJ1Krk1YEjLThrj/fJDQONn17v+vNuPIjct7ywwrF+zxiludTG
         UJp1CmtzhFt3c0UNCpd3v2O1aRco/GnsWDVQdsux3pHG/MdKAOYfk3+98HAfR8NOEA
         zKW2zb7SvdjAA==
Date:   Wed, 15 Dec 2021 10:21:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:queue/5.10 6492/9999] ERROR: modpost:
 "raid6_2data_recov" [fs/btrfs/btrfs.ko] undefined!
Message-ID: <YbokKLRVkIDCnE8F@archlinux-ax161>
References: <202112151422.M34sDTRZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112151422.M34sDTRZ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 02:49:44PM +0800, kernel test robot wrote:
> Hi Nathan,
> 
> First bad commit (maybe != root cause):

Indeed, pre-existing issue :)

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
> head:   a0e5648b46a984339e8c472bfe5da299dd65fc3b
> commit: f7121692795c654b52b460a11107a87285bb1dcd [6492/9999] hexagon: handle {,SOFT}IRQENTRY_TEXT in linker script
> config: hexagon-randconfig-r041-20211215 (https://download.01.org/0day-ci/archive/20211215/202112151422.M34sDTRZ-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=f7121692795c654b52b460a11107a87285bb1dcd
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc queue/5.10
>         git checkout f7121692795c654b52b460a11107a87285bb1dcd
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
> ERROR: modpost: "__raw_readsl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!

This is fixed in linux-5.10.y head, commit 0854c9ff2151 ("hexagon:
export raw I/O routines for modules").

> >> ERROR: modpost: "raid6_2data_recov" [fs/btrfs/btrfs.ko] undefined!
> >> ERROR: modpost: "raid6_datap_recov" [fs/btrfs/btrfs.ko] undefined!
> >> ERROR: modpost: "raid6_call" [fs/btrfs/btrfs.ko] undefined!
> >> ERROR: modpost: "xor_blocks" [fs/btrfs/btrfs.ko] undefined!
> >> ERROR: modpost: "__compiletime_assert_963" [fs/btrfs/btrfs.ko] undefined!
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for BTRFS_FS
>    Depends on BLOCK && !PPC_256K_PAGES && !PAGE_SIZE_256KB
>    Selected by
>    - TEST_KMOD && RUNTIME_TESTING_MENU && m && MODULES && NETDEVICES && NET_CORE && INET && BLOCK

The rest of the errors should be fixed by my series here, which is
currently in -mm:

https://lore.kernel.org/r/20211129230141.228085-1-nathan@kernel.org/

I can backport it once it lands in mainline.

Cheers,
Nathan
