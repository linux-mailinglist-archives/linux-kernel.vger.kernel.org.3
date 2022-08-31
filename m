Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6E5A81F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiHaPnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiHaPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:42:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505B130F51
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41B261767
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BFEC433C1;
        Wed, 31 Aug 2022 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661960445;
        bh=NQugEGtQ4q90YCzbEoB+KnxOf7m4Ztpm79HaE8a8dU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOxm7a+iGDfywGpkPlXXYJ298bt5HcmnF1KpFrxRYy1GJPv9qNcdQipLS5+3ztKQY
         N1cWe2o9OKCiRxxij8fMAhseHIK9p9YTcFRx4VSLVsanpAIgErN2Q3aVwRU//SsEAI
         yBBdF+1wZDGj7gU9vF5tEmZIpttzFYITKzXR8ty5f4xhIHfkVjGp2aiTQ7B0qhybuN
         HJsOaouabf+OjuGxDVLti2onqWKCWpFMg03OePEae/Ff1tYER4uRO+75gYhgoyXVaw
         J2j857HpuPLSltAPST9rX/LurOKQj+zLOJvizmsCNkM5GSmEcP5fp0uX17NEq7naEr
         OpHJPV523uPHw==
Date:   Wed, 31 Aug 2022 08:40:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: powerpc-linux-objdump: Warning: Unrecognized form: 0x23
Message-ID: <Yw+A+0BY26l0AC5j@dev-arch.thelio-3990X>
References: <202208311414.4OPuYS9K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208311414.4OPuYS9K-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 02:52:36PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
> commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
> date:   5 months ago
> config: powerpc-buildonly-randconfig-r003-20220830 (https://download.01.org/0day-ci/archive/20220831/202208311414.4OPuYS9K-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout f9b3cd24578401e7a392974b3353277286e49cee
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> powerpc-linux-objdump: Warning: Unrecognized form: 0x23

Given this is clang 16.0.0 with
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y, which uses DWARF5 by
default instead of DWARF4, it looks like older binutils not
understanding DWARF5. What version of binutils is being used by the bot?
CONFIG_DEBUG_INFO_DWARF5 requires 2.35.2, it seems like it might be
worth trying to extend those dependencies to
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT to avoid issues like this,
especially in lieu of Nick's series here, which is already codifying the
implicit default DWARF version of the compiler.

https://lore.kernel.org/20220826181035.859042-1-ndesaulniers@google.com/

Cheers,
Nathan
