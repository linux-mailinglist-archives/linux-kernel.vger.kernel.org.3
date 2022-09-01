Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448B5A8B29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiIACDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIACDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260E11F18A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 285CA61D9F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DC4C433D6;
        Thu,  1 Sep 2022 02:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661997814;
        bh=hn26I+Z+QEEc80Mv6ZH9XPtHpiybQqe5cT3oqlrSiM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5RLfnN0Wf7tzizr4PkxiOfpeC9jX2yyzDrifB16+PNiN1bqRy4+XKLULHA29u4xU
         BSPTY+fs7K0SyO4s26nzLffav8nRpWPRDfK051McVRF8gyKj8dQjiIKTlrrsfMfvJz
         rOZiItRVsGMyWUKyY38lB6Or8/8+UunCgfTRaTpm4I9XhbHQ6Yt942sww/q3pxXpoR
         ghEyxhnApEzRhx1oUne2bEViw7bXk2H6tMXN2cMhScMtQx07KT/6Fg3Hbz2RqfGUbm
         Dtn74HJrz5bVFo006oC6LxZZtll4X4Uam6ijgvEIp2BkMEHAvSrRH0xTfytwCVTv3Z
         lvUlScOu+SRAA==
Date:   Wed, 31 Aug 2022 19:03:32 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] Re: powerpc-linux-objdump: Warning: Unrecognized
 form: 0x23
Message-ID: <YxAS9NBjBI/vi0XK@dev-arch.thelio-3990X>
References: <202208311414.4OPuYS9K-lkp@intel.com>
 <Yw+A+0BY26l0AC5j@dev-arch.thelio-3990X>
 <b0b8fecd-4041-d04e-9a11-2c7947e5d5a0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b8fecd-4041-d04e-9a11-2c7947e5d5a0@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rong,

On Thu, Sep 01, 2022 at 09:15:58AM +0800, Chen, Rong A wrote:
> 
> 
> On 8/31/2022 11:40 PM, Nathan Chancellor wrote:
> > On Wed, Aug 31, 2022 at 02:52:36PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
> > > commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
> > > date:   5 months ago
> > > config: powerpc-buildonly-randconfig-r003-20220830 (https://download.01.org/0day-ci/archive/20220831/202208311414.4OPuYS9K-lkp@intel.com/config)
> > > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # install powerpc cross compiling tool for clang build
> > >          # apt-get install binutils-powerpc-linux-gnu
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
> > >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >          git fetch --no-tags linus master
> > >          git checkout f9b3cd24578401e7a392974b3353277286e49cee
> > >          # save the config file
> > >          mkdir build_dir && cp config build_dir/.config
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > > > powerpc-linux-objdump: Warning: Unrecognized form: 0x23
> > 
> > Given this is clang 16.0.0 with
> > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y, which uses DWARF5 by
> > default instead of DWARF4, it looks like older binutils not
> > understanding DWARF5. What version of binutils is being used by the bot?
> 
> Hi Nathan,
> 
> We're using binutils v2.38.90.20220713-2
> 
> ||/ Name           Version            Architecture Description
> +++-==============-==================-============-==========================================
> ii  binutils       2.38.90.20220713-2 amd64        GNU assembler, linker and binary utilities

Thanks for chiming in! This looks like the output of 'dpkg -l', right? I
noticed on second glance that the tuple for the objdump warning above is
'powerpc-linux-', which leads me to believe that a kernel.org toolchain
(or a self compiled one) is being used. I would expect the tuple to be
'powerpc-linux-gnu-' if Debian's package was being used. Is that
possible?

Cheers,
Nathan

