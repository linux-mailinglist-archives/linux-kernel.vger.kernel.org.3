Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A3D4DD41F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiCRFRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiCRFRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:17:33 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90505181783;
        Thu, 17 Mar 2022 22:16:14 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 22I5FovW001056;
        Fri, 18 Mar 2022 14:15:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 22I5FovW001056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1647580551;
        bh=FRaQi6toG6y41cZl4bwLMsymBKFQ6HbocfhziKr6tpw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QwkYvxzCIKxmWLontgZjsE8gpOH8R7gkXp81qPUEstldu/Feq1j2/zbjSrMvDUDHB
         9AXhOCZljIpgNgDxgez4w3gir5/QoRtcqYqjN73FvfRXF0i+RZJww2Uqzeot7BOz/b
         +br/bIiBsRVdYc5lIUZQzW8s1Exv0eaGDRd68DJYT0P1m9AeB294tBOX9sRlycNLum
         Az875ADdxuZ9R/9arXK92iPX21ar6BvyoR0M3fQ1csHpHX9m7GB78ytZ1iDhqrnpT9
         8zMEtnsaIYoV7N9Ex+FkiqhIKVUiMy+Xe4TctuS4gkSU4PWOv73AumFdyJfzVbaddV
         bPBYOGhzwfMOA==
X-Nifty-SrcIP: [209.85.214.176]
Received: by mail-pl1-f176.google.com with SMTP id i11so5500337plr.1;
        Thu, 17 Mar 2022 22:15:51 -0700 (PDT)
X-Gm-Message-State: AOAM533YapWzK+DQcJt0zg81zVI+S9633qoma5MY0v7u8wWWR0Jnj46i
        rT/AXaXNAIvlQcp91CmbxKXXD3vxNuLHTeVKq7Q=
X-Google-Smtp-Source: ABdhPJwlJEecYzAmeCCUR+2o70hp6UpG6Qk3jNtGA7IZWlX2cfpoTPaoBBeeVcdoXPVQ2mrDQjT19v1Vp8iApiWi0vo=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr8457060plp.162.1647580550504; Thu, 17
 Mar 2022 22:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <202203160508.k7vz4ZxC-lkp@intel.com> <YjIYxWkVzT0/XYf+@sirena.org.uk>
In-Reply-To: <YjIYxWkVzT0/XYf+@sirena.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 18 Mar 2022 14:15:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASsiYHK3QW5aOg016_XwD-MmOOcJ6UA=f95BxEZ-p+gSw@mail.gmail.com>
Message-ID: <CAK7LNASsiYHK3QW5aOg016_XwD-MmOOcJ6UA=f95BxEZ-p+gSw@mail.gmail.com>
Subject: Re: [broonie-misc:arm64-sysreg-gen 6/9] arch/arm64/include/asm/sysreg.h:125:10:
 fatal error: 'generated/asm/sysreg.h' file not found
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 2:05 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Mar 16, 2022 at 05:56:39AM +0800, kernel test robot wrote:
>
> Not deleting context for the benefit of the kbuild people I just CCed...
>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-sysreg-gen
> > head:   72b2ee21681c0c515c6a8bb62bd289766ce324a1
> > commit: caf0e02eaa9ed9bfa50642f0bc2ee008b1c138ff [6/9] arm64/sysreg: Enable automatic generation of system register definitions
> > config: arm64-randconfig-r006-20220313 (https://download.01.org/0day-ci/archive/20220316/202203160508.k7vz4ZxC-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=caf0e02eaa9ed9bfa50642f0bc2ee008b1c138ff
> >         git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
> >         git fetch --no-tags broonie-misc arm64-sysreg-gen
> >         git checkout caf0e02eaa9ed9bfa50642f0bc2ee008b1c138ff
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from kernel/bounds.c:10:
> >    In file included from include/linux/page-flags.h:10:
> >    In file included from include/linux/bug.h:5:
> >    In file included from arch/arm64/include/asm/bug.h:26:
> >    In file included from include/asm-generic/bug.h:22:
> >    In file included from include/linux/printk.h:9:
> >    In file included from include/linux/cache.h:6:
> >    In file included from arch/arm64/include/asm/cache.h:8:
> >    In file included from arch/arm64/include/asm/cputype.h:173:
> > >> arch/arm64/include/asm/sysreg.h:125:10: fatal error: 'generated/asm/sysreg.h' file not found
> >    #include "generated/asm/sysreg.h"
> >             ^~~~~~~~~~~~~~~~~~~~~~~~
> >    1 error generated.
>
> This looks like a kbuild thing which as far as I can see only exists for
> O= builds and possibly only with bounds.s - if I look at the full log I
> see that we correctly generated asm/sysreg.h:
>
>   GEN     arch/arm64/include/generated/asm/sysreg.h
>
> but that's only passed to CC (at least for bounds.s) via an
> -I./arch/arm64/include/generated so won't be found with the generated/
> prefix.  While this can be avoided by renaming the header and not
> referencing it with the prefix I do see a bunch of other headers
> throughout the tree being included with an explicit generated/ prefix so
> I'm not sure this is what's supposed to be happening, it does seem like
> a landmine somehow.


Do not add 'generated/' prefix.

Let's think about this scenario.
First foo.h was hard-coded, but sometime later,
somebody noticed it is better to generate it by scripting.
Why do we need to fix up #include <foo.h>  to #include <generated/foo.h>
in all the call sites?
Or do we need to have foo.h to wrap <generaged/foo.h> ?

No, users of foo.h do not need to know if it is
a checked-in header of a generated one.







>
> >    make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
> >    make[2]: Target '__build' not remade because of errors.
> >    make[1]: *** [Makefile:1191: prepare0] Error 2
> >    make[1]: Target 'prepare' not remade because of errors.
> >    make: *** [Makefile:219: __sub-make] Error 2
> >    make: Target 'prepare' not remade because of errors.
> >
> >
> > vim +125 arch/arm64/include/asm/sysreg.h
> >
> >    118
> >    119        /*
> >    120         * Automatically generated definitions for system registers, the
> >    121         * manual encodings below are in the process of being converted to
> >    122         * come from here. The header relies on the definition of sys_reg()
> >    123         * earlier in this file.
> >    124         */
> >  > 125        #include "generated/asm/sysreg.h"
> >    126
> >
> > ---
> > 0-DAY CI Kernel Test Service
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Best Regards
Masahiro Yamada
