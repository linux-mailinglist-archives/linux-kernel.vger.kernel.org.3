Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0185592C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiHOIOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiHOIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:14:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3831EEF4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:13:58 -0700 (PDT)
Received: from mail-ej1-f51.google.com ([209.85.218.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Ma0HM-1ntvfc3xuG-00VuO3 for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022
 10:13:56 +0200
Received: by mail-ej1-f51.google.com with SMTP id y13so12269187ejp.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:13:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo1ARMp25jLP2E+t5MrdBQGq4LjlcU4n1wdipJ3Ylak8fZuxxQ1q
        8bIYVWCyfIJhMZY0mGEE1a9xfOa57shl8KrN2f8=
X-Google-Smtp-Source: AA6agR7S85PUrUr8unnMyI7fXKSi4wDMedNezP2loGKQf10UBzJADK7p9/IVNVmBgfXLfYE7M9pHGxIephu0VG+V2nU=
X-Received: by 2002:a17:906:9b08:b0:730:5d3c:4b1b with SMTP id
 eo8-20020a1709069b0800b007305d3c4b1bmr9629412ejc.606.1660551236583; Mon, 15
 Aug 2022 01:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <202208151050.7pk4KSAG-lkp@intel.com>
In-Reply-To: <202208151050.7pk4KSAG-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Aug 2022 10:13:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0qM2edJCM2=M7kwnVcLmBiwEZH+JU-9sCeRNrz==3AZg@mail.gmail.com>
Message-ID: <CAK8P3a0qM2edJCM2=M7kwnVcLmBiwEZH+JU-9sCeRNrz==3AZg@mail.gmail.com>
Subject: Re: ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rR+K4CyhSywiaiUVvx2LOexVd+v+Gk2UcCi2tzccqHJmnoHuTBv
 VqNUciRJ23COEGvDjdWycJb4BPOECoDlw1l2OG7BmnpsIOQLW4rJlXCOp7kmqOhvlzRq4fI
 XzUNZQlXWuVqvt4Naunhu1+TuUvX9xM6lYM60Fjgacnwx0NELOPL4yLtJ+sEoIikDmH9I9o
 zfCI8bujJVdNYe2HK//lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nviWBLk0e+4=:r0d7HLqSoMBzo7JVeFMkRS
 6gX93W1wy7c5u5Vm5OQVuWB99eiwSWSLR0lQFztLadfUGq9MxqOXquYJXvx7DXMA/Rrp91Jjj
 w4iYkXiYCMSXXb8gpF9yA+fk+r6GWGqmNwKAwNm5ZoziPyfuMXuJgJO4kiBxpC5T6E5+z3jTQ
 xHb595pxQGr50V0yv1KEbXj7C4SlEx/s8ooPZb0/FgW0GZwSD7XRgTiqZMFIClM4gfMHxk3ih
 zpOkZBUxKF2XXmA3zC7GV3B3o1cWP+VoRMBvb13MWncy2RFE2nBLQ4vdT0nH/xcWh2V60W94e
 +B/abNRpYS0UhogkZbnRqG3D6w46d2hvHUS8Xdz3EDALMY9E1WU2XIk7tjihGOjFoAm9WyoCE
 egmVcUARF99cLIzbDihmq0i7YbAOVBrgvYF1OSVqKZYGkLw1mSo0hGc4NWo6cgfPA0RHUUftx
 aLg41N7NO/xkK6lF+uP06H7Qb+yhhaYNbzY6leQSMFv4iCIL+XR6koT9u3aZejvNNDAWfxVwQ
 tXyyIXgSq669840Q9ksq1XC+WAIZKuBlhspnTTBXuMpHS5TSJG7Wm/G6kxHE5YHAoPE9pdKyg
 I1t5aoL+35m2lxXlAIScy0rcp4jIAhp8q/t2maXZJRddKYKzIsvEIx8YIqBtq1P+hh+ZqXwE5
 KQDWMjbWLFtk9YTmQVroQWJM57B3skQGTfFu0kPbGP2MFaaflWSaiTY3vMeMfeyEVkghIEKkF
 WU9dO5COURNG8J4CEptk6tWogmZ0CMU3wQtBUdm+MsPE3FxYQvuN1xEh/MJSNvUXf8hk+zmEB
 0Ol3fPj1L2kcVI7DTd9w1lEZDVYmq1+62tuWFfWodGTRh+isG99jWRLrhRyqFTslYMN1OxPgu
 dohHf/NEwDUazPpFyHCQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 4:13 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arnd,
>
> First bad commit (maybe != root cause):

(Adding Dinh Nguyen to Cc)

Right, my patch is not the root cause. I see this link failure in lz4
was reported a
couple of times for the combination of nios2 with gcc-11.2:
https://lore.kernel.org/lkml/?q=__divsi3_table

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> commit: 606b102876e3741851dfb09d53f3ee57f650a52c drm: fb_helper: fix CONFIG_FB dependency
> date:   11 months ago
> config: nios2-randconfig-r034-20220814 (https://download.01.org/0day-ci/archive/20220815/202208151050.7pk4KSAG-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=606b102876e3741851dfb09d53f3ee57f650a52c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 606b102876e3741851dfb09d53f3ee57f650a52c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!

I analyzed this a while back but mixed up nios2 with xtensa:
https://lore.kernel.org/lkml/CAK8P3a0wboR0evmNGL_VEsNNdLd9x_v8k3APH70t5gfu9D=A6w@mail.gmail.com/

Looking more closely at it now, I see that this was broken by the addition
of the -O3 compiler flag in 4e1a33b105dd ("lib: update LZ4 compressor
module").

We have just removed the option to build the kernel itself with -O3 as
this is known to cause problems. gcc documents a number of options
that are contained in -O3 but not in -O2:

 -fgcse-after-reload -fipa-cp-clone -floop-interchange -floop-unroll-and-jam
 -fpeel-loops -fpredictive-commoning -fsplit-loops -fsplit-paths
 -ftree-loop-distribution -ftree-loop-vectorize -ftree-partial-pre
 -ftree-slp-vectorize -funswitch-loops -fvect-cost-model=dynamic
 -fvect-cost-model=dynamic -fversion-loops-for-strides

If I pass all those options along with -O2, I get the same output
as with -O3, except for the __divsi3_table reference, so we can
probably make it work, but what I don't know is which of the above
options (if any) actually make the object code better.

The upstream lz4 code has the same -O3 flag, so I assume this
was added purely for consistency. Sven Schmidt contributed the
patch that added back -O3, maybe he is interested in doing
some analysis of which of the options we actually want here.

Otherwise I'd suggest we just go with the default kernel flags
that are either -O2 or -Os depending on configuration, as we
do for all other code.

        Arnd
