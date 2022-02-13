Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69364B3DFC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiBMW0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:26:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiBMW0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:26:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454D5468C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 14:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644791176;
        bh=PkPEqnUS4wzkx4V/HY7d57+dXLEwDX9GsZzHBnqqN/g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=X344IlEHMEu4Y1MYShQFNevVd3szBs9Uk2KuuWWKIRLf+z2CH8OaQiSqObP9ZBTrL
         xIp3Ptkjpwfn9LicTu1Vm9cQZ9zy8dOTjPicH/niAWay9osoYOZCh4HEyhWbVn5T5F
         h7nvHrL2879/QUPdWYoWNUqkKYEiFBY9fulPbZ/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.238]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95iR-1oOj2F3BSR-0164UR; Sun, 13
 Feb 2022 23:26:16 +0100
Message-ID: <a7181772-ff49-fd35-2e9d-cfc2c2ce653e@gmx.de>
Date:   Sun, 13 Feb 2022 23:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: gcc: error: unrecognized command-line option '-mno-space-regs'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202202131837.mZeWy9J4-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202202131837.mZeWy9J4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XRIUVZkaZnkuvXw2wYQkQ/t0oHCTyDq67NU4uvSunetWZOEyevJ
 IMhE02ZHKtS0AP0XaHCbiyxOX3eSWzxuKDOmdvHj+X/1gbp2LrWpUZm994ZWQirf/F4pWaw
 A3+eKU+WTqg+EkxZK13V3pqOKEkvIx06zYGDDXeP/XJuooiSjxtnrQzAmUvysV7MuMiV4R4
 nz2QJv8XgXQ0fSkam0Usw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yi88Mzzz2EI=:wCOulxOCpl2MQLwv/JB6aG
 vjnEdk1QgTQYBsWpUHByHDpxeX364XaOywXH7rx0bYFhLXUpyG7LjPZMiAO0nxa8L4h2xyMw1
 6Owp/ib8FINyNnDIL85UCqY8TaTOMJGqsGbzd06VLf713nPRyMbiwMoOqwty+bUvNFLj1tS+2
 Ou4ZG4KNQULcP/wjIjOLvqlrQvFD2aWbIqOKzGC+ehfIJNiGcr0Ak2gRNL6wE20RkTxOIeVYA
 gDxQDz7Q3ej0lBVwRrkbIocv4ljACTkq8K+bjGARRg9tPHO7MmzXui9VH/uKSNnveSnt/BAw/
 D6jfB8biQyr30Iki++5tjrzq29WQhZkO7hM9k2mKVOxn2U2pegiG4TDFErgg9jFI0lqrYdgJS
 xDoXZtn96cGGVF9xB+oZ35ltn9Jjv6JvIZZSkHL07/SJjAVuvy+JYskhLVzyorp0o1jv7MmX+
 ZUjYUL0d9SzuLnFIzxHHwwHve5m0eWjojJBRu6Ih6Eh7cKwmh7ZwBVTdKMGqKsrKpIEiucWnT
 RfYllCiHPEObqI5ghju0eYM2Qq/ENo4zHFe/zMMOjfkvzj/jF0myV81XFAQz+M+PG97W1SYCZ
 /W9S9vQdPDiLGZaskCX5pCtHDjLsn6Ve9PLVAp9Ysdmf1aEkzgZOYL9/V6qsZPV89QjURaHrJ
 BPuq+ec/UxFNA4+ijGKpV9W7/SnM/D5fDgAZEtslxkvMTRnbOht5LwARSjKUiycP8ZFAxq3YO
 QWC5yt6WS/BRZ7XnpZvAYlSyUwmDM2Itj578huCHpGZCdYbrLPl27/abts0RzZi6Aeet0+jGw
 o7V7ZuzI5BTRpc/3J1vPx0/lMwWUPly07MIaWUlxMS4GNue1C9BbcDtM6Mda40urMRWNnV9tj
 9E2GqSMxBpZi+GJlEF8c5EA9HSDfSDunlY+datI/gi4HT7ep90/te00m8z62R/nFE2MIgWCYv
 8HpJud9hJZyUoDXMj6grz51neGn0POx3+utmuOgUYTG2afNA4s4hTZYQ6tcFNWz5+eRbDV9+Y
 WwGeBfAz5BbRcjvKfAleI3O3xcb1GjmD96O7pX9ht81cfzIBo9t7IoUSx4uX0G1wLPOKwj8vW
 uBCGUSeR078Mvw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/22 11:39, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
> head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
> commit: 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e parisc: Fix compile fai=
lure when building 64-bit kernel natively
> date:   6 months ago
> config: parisc64-randconfig-r035-20220213 (https://download.01.org/0day-=
ci/archive/20220213/202202131837.mZeWy9J4-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3D5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel=
/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dparisc64 prepare
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconfli=
cts-sr]
>    scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconfl=
icts-rr]
>>> gcc: error: unrecognized command-line option '-mno-space-regs'
>>> gcc: error: unrecognized command-line option '-mno-space-regs'
>>> gcc: error: unrecognized command-line option '-mfast-indirect-calls'; =
did you mean '-mforce-indirect-call'?
>>> gcc: error: unrecognized command-line option '-mfast-indirect-calls'; =
did you mean '-mforce-indirect-call'?
>>> gcc: error: unrecognized command-line option '-mdisable-fpregs'
>>> gcc: error: unrecognized command-line option '-mschedule=3D7200'

Same issue as the other error.
Here a 64bit compiler was used to build a 32-bit kernel...

I've queued up a patch in for-next which should give a better error messag=
e if
someone uses such a wrong combination:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3Db160628e9ebcdc85d0db9d7f423c26b3c7c179d0

Helge

>    make[2]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-off=
sets.s] Error 1

>>> gcc: error: unrecognized command-line option '-mdisable-fpregs'
>>> gcc: error: unrecognized command-line option '-mschedule=3D7200'
>    make[2]: *** [scripts/Makefile.build:271: scripts/mod/empty.o] Error =
1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1216: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:220: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

