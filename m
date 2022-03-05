Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B514CE5E3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiCEQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiCEQWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:22:11 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233DD3464A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 08:21:20 -0800 (PST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 225GKf6o001491
        for <linux-kernel@vger.kernel.org>; Sun, 6 Mar 2022 01:20:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 225GKf6o001491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646497242;
        bh=OQaHUsCK31E2885i0/6iI0cNC8O73o+D08L86QnBoLg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zo2q6xUQ04UcQv+Sm0g6q/3ndqA7rl8xUFHswEBDER4XP6KWNb1aY1Vo2+GezArOc
         C9vPRzLfORk4gNu1fmBJKHe5qP2Ta4Z1RmVRGBzWj5EaAWmI5z21Wky6yDViC1GAsc
         DNReYtrjjyP4tiltkSAH/52Fzr5ObIL68p40JgOzNj6Tt1Qdb1CTy++p0vvEmORGNx
         8aCIhZ6zmfJN5J6/l0By5NftjmRHkZLP97Gi1narKYsygSQJ6JHKJsLPNKPdd+nCFg
         TPIq8MHUhPopTR7z5YMRFZ1K0B5TrzYG/LwR4tNBFi3RI0L+moORYjw6BOzivCIt9l
         42itokx4XZt0g==
X-Nifty-SrcIP: [209.85.215.181]
Received: by mail-pg1-f181.google.com with SMTP id 6so5483726pgg.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 08:20:42 -0800 (PST)
X-Gm-Message-State: AOAM5327pQkwwPIIbbebUff/RDw9gRZmDDkDGYhbexyJtpC/dHnr8fre
        NOZKvKoR4wz5dKoFDTrSRFyaz2lO1j3B/mWi2/8=
X-Google-Smtp-Source: ABdhPJwd7LcS9o5BzbJzElgGRsdtBBsodn0+ZXvGx2+oMyjBzI5Yjs4ONk4h3NRFGXw3OvUGPbzQgKbVuXAjSez4eMk=
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr3203326pgb.616.1646497241154; Sat, 05
 Mar 2022 08:20:41 -0800 (PST)
MIME-Version: 1.0
References: <202203032027.8qFpOWlq-lkp@intel.com>
In-Reply-To: <202203032027.8qFpOWlq-lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Mar 2022 01:19:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASwGU=-KWfYbcHjEP=pyRvcwY5rmWk_X0a6wMz20s2Pqw@mail.gmail.com>
Message-ID: <CAK7LNASwGU=-KWfYbcHjEP=pyRvcwY5rmWk_X0a6wMz20s2Pqw@mail.gmail.com>
Subject: Re: [masahiroy:kbuild 9/9] include/linux/byteorder/big_endian.h:8:2:
 error: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Kolpackov <boris@codesynthesis.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 9:33 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild
> head:   55de8686df7ed2b5237867b130e30c728bbd9db4
> commit: 55de8686df7ed2b5237867b130e30c728bbd9db4 [9/9] kconfig: change .config format to use =n instead of "is not set"
> config: arc-randconfig-r005-20220302 (https://download.01.org/0day-ci/archive/20220303/202203032027.8qFpOWlq-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=55de8686df7ed2b5237867b130e30c728bbd9db4
>         git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>         git fetch --no-tags masahiroy kbuild
>         git checkout 55de8686df7ed2b5237867b130e30c728bbd9db4
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash lib/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/arc/include/uapi/asm/byteorder.h:14,
>                     from include/asm-generic/bitops/le.h:6,
>                     from arch/arc/include/asm/bitops.h:192,
>                     from include/linux/bitops.h:33,
>                     from include/linux/log2.h:12,
>                     from include/asm-generic/div64.h:55,
>                     from ./arch/arc/include/generated/asm/div64.h:1,
>                     from include/linux/math.h:5,
>                     from include/linux/math64.h:6,
>                     from include/linux/time.h:6,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:13,
>                     from lib/test_bitops.c:9:
> >> include/linux/byteorder/big_endian.h:8:2: error: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Werror=cpp]
>        8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>          |  ^~~~~~~
>    cc1: all warnings being treated as errors
>
>
> vim +8 include/linux/byteorder/big_endian.h
>
> ^1da177e4c3f41 Linus Torvalds 2005-04-16   6
> e9ef073a0796e4 Babu Moger     2017-09-08   7  #ifndef CONFIG_CPU_BIG_ENDIAN
> e9ef073a0796e4 Babu Moger     2017-09-08  @8  #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
> e9ef073a0796e4 Babu Moger     2017-09-08   9  #endif
> e9ef073a0796e4 Babu Moger     2017-09-08  10
>
> :::::: The code at line 8 was first introduced by commit
> :::::: e9ef073a0796e46c24f037237291efe56fc28ad9 include: warn for inconsistent endian config definition
>
> :::::: TO: Babu Moger <babu.moger@oracle.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


I cannot reproduce this.

Maybe, this was a bug in make.cross
(but already fixed??)



-- 
Best Regards
Masahiro Yamada
