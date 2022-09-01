Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC25A9D94
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiIAQzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiIAQzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:55:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35257201AE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02CE4CE2902
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977CEC433D6;
        Thu,  1 Sep 2022 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662051309;
        bh=C4hLcy/GChnctsZot7rMHIwTtugnUggmaB1mtjRQYX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFFpntlUbwvAS9vJVvb9UEZUs3LOUeOAnid9JaVs9JFbGA+5sdzE0gg8qbDavjOvA
         a4cnG4ExUfY+Lw1H3cx736feGa/usHnE/vvKEnjk+llSxItabxk6eLFA+/JK3P549T
         rlZNeTKH0l5quUnSkxK6SwqdivJPqHsOwGE35e1wjYLJMCUAxtXuzWqyilFNxqw4Be
         hwCPquPn/uegPijdXsvzpS1nYMr+OtVHYmhjt1X+HbNajGjwfxMUhq4H6hlhQw1GEl
         UcJKN0j69dwCgF1jSWXVJcrFezZDeHGx4QRClPCl9SJ/t43jMAQhz0Zdn8vEH2x9Kk
         NJEDv5pwDlmMQ==
Date:   Thu, 1 Sep 2022 09:55:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] Re: powerpc-linux-objdump: Warning: Unrecognized
 form: 0x23
Message-ID: <YxDj6v5p+wHop0Wm@dev-arch.thelio-3990X>
References: <202208311414.4OPuYS9K-lkp@intel.com>
 <Yw+A+0BY26l0AC5j@dev-arch.thelio-3990X>
 <b0b8fecd-4041-d04e-9a11-2c7947e5d5a0@intel.com>
 <YxAS9NBjBI/vi0XK@dev-arch.thelio-3990X>
 <8d2c3aef-aa4f-1f4d-dc89-622554ffda31@intel.com>
 <9d77cb93-2eff-d87d-6554-1636d5e7d5ec@csgroup.eu>
 <0acfb209-a792-a47b-0261-9fb29824e4b9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0acfb209-a792-a47b-0261-9fb29824e4b9@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:52:42PM +0800, Chen, Rong A wrote:
> 
> 
> On 9/1/2022 1:45 PM, Christophe Leroy wrote:
> > 
> > 
> > Le 01/09/2022 à 06:59, Chen, Rong A a écrit :
> > > 
> > > 
> > > On 9/1/2022 10:03 AM, Nathan Chancellor wrote:
> > > > Hi Rong,
> > > > 
> > > > On Thu, Sep 01, 2022 at 09:15:58AM +0800, Chen, Rong A wrote:
> > > > > 
> > > > > 
> > > > > On 8/31/2022 11:40 PM, Nathan Chancellor wrote:
> > > > > > On Wed, Aug 31, 2022 at 02:52:36PM +0800, kernel test robot wrote:
> > > > > > > tree:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > > > > master
> > > > > > > head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
> > > > > > > commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug:
> > > > > > > make DEBUG_INFO selectable from a choice
> > > > > > > date:   5 months ago
> > > > > > > config: powerpc-buildonly-randconfig-r003-20220830
> > > > > > > (https://download.01.org/0day-ci/archive/20220831/202208311414.4OPuYS9K-lkp@intel.com/config)
> > > > > > > compiler: clang version 16.0.0
> > > > > > > (https://github.com/llvm/llvm-project
> > > > > > > c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
> > > > > > > reproduce (this is a W=1 build):
> > > > > > >            wget
> > > > > > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > > > >            chmod +x ~/bin/make.cross
> > > > > > >            # install powerpc cross compiling tool for clang build
> > > > > > >            # apt-get install binutils-powerpc-linux-gnu
> > > > > > >            #
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
> > > > > > >            git remote add linus
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > > > >            git fetch --no-tags linus master
> > > > > > >            git checkout f9b3cd24578401e7a392974b3353277286e49cee
> > > > > > >            # save the config file
> > > > > > >            mkdir build_dir && cp config build_dir/.config
> > > > > > >            COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang
> > > > > > > make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> > > > > > > 
> > > > > > > If you fix the issue, kindly add following tag where applicable
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > 
> > > > > > > All warnings (new ones prefixed by >>):
> > > > > > > 
> > > > > > > > > powerpc-linux-objdump: Warning: Unrecognized form: 0x23
> > > > > > 
> > > > > > Given this is clang 16.0.0 with
> > > > > > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y, which uses DWARF5 by
> > > > > > default instead of DWARF4, it looks like older binutils not
> > > > > > understanding DWARF5. What version of binutils is being used by the
> > > > > > bot?
> > > > > 
> > > > > Hi Nathan,
> > > > > 
> > > > > We're using binutils v2.38.90.20220713-2
> > > > > 
> > > > > ||/ Name           Version            Architecture Description
> > > > > +++-==============-==================-============-==========================================
> > > > > ii  binutils       2.38.90.20220713-2 amd64        GNU assembler,
> > > > > linker and binary utilities
> > > > 
> > > > Thanks for chiming in! This looks like the output of 'dpkg -l', right? I
> > > 
> > > Hi Nathan,
> > > 
> > > oh, yes, I misunderstood, it's not related to this package.
> > > 
> > > > noticed on second glance that the tuple for the objdump warning above is
> > > > 'powerpc-linux-', which leads me to believe that a kernel.org toolchain
> > > > (or a self compiled one) is being used. I would expect the tuple to be
> > > > 'powerpc-linux-gnu-' if Debian's package was being used. Is that
> > > > possible?
> > > 
> > > you are right, we used a self-compiled toolchain, we'll try the binutils
> > > from debian package.
> > 
> > Can you first tell us the version you are using ?
> > 
> > 	powerpc-linux-objdump -v
> > 
> > That will tell you the version.
> 
> Hi Christophe,
> 
> the version is v2.38:
> 
> $ ./powerpc-linux-objdump -v
> GNU objdump (GNU Binutils) 2.38
> Copyright (C) 2022 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or (at your option) any later
> version.
> This program has absolutely no warranty.

Thanks! I did some research and it seems like this warning is expected
with binutils older than 2.39. The warning appears to come from
read_and_display_attr_value() in binutils/dwarf.c. 0x22 and 0x23 are
DW_FORM_loclistx and DW_FORM_rnglistx, which were only recently
supported in that function.

https://sourceware.org/bugzilla/show_bug.cgi?id=28981
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=19c26da69d68d5d863f37c06ad73ab6292d02ffa

That change shipped in binutils 2.39. I am not really sure how we should
work around this in the kernel, other than maybe requiring binutils
2.39+ for CONFIG_DEBUG_INFO_DWARF5. Unfortunately, that will not fix
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT when DWARF5 is the default
version... Alternatively, switching to llvm-objdump for clang builds
would help :) I am not aware of any issues that would affect that switch
for PowerPC:

https://github.com/ClangBuiltLinux/linux/labels/%5BTOOL%5D%20llvm-objdump

Cheers,
Nathan
