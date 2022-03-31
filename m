Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD6B4EE204
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiCaTnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbiCaTnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:43:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF72C133650
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:41:35 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z6so814457iot.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pc/jYTnFP9mAV1+7e43JSOoZseHW1bH2+TqqY9lrlfo=;
        b=ewHfLWMxsJZKEk520LS5HNZAbZ6cCC8NzmC23l7/cQkxKBXQPs2scHe5O3amIPLxnU
         GZKu+0ZpKR2RAZ5rzdUsvoYM+i85OmUNY/9FEj3a16+P+TgsUPr/30eWQzK29tu7wp0S
         Ly/XaRsczyDio3iRzflclWFrTEgJpEqx1Rv2mHZatI92RfR4yliThAdgZ7cpX/Cp7qiP
         B65GVGh2ear75wvt4XPqetywdc0r4n+tVLjgvHux5xZjxljCQzcBO1hfaORGVOKiz9rS
         y9gqVQRchINJKJvxCtd4ZxO4l7KjkFSMI8DTfGLV6Sa5KvRQRYYH82dM24U5uGMFxNAT
         YOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pc/jYTnFP9mAV1+7e43JSOoZseHW1bH2+TqqY9lrlfo=;
        b=D3tMepSvdfUk22Nv3oOcmxPyc+XXPV3X/LE9bo5bl0J2CLDOBw+FUf4OVjXxRLrRAC
         tuVYvL7WVZ0acSF2xciW8GXNzpdCsIE27fSC5jopmXtuVio2yO4I7akYvGM0hPq/X/KH
         n6eXC26cgS6x8BnFwFZ9K6GHJ+RtmNOOFtH7TKSUP1TqKz0gNGG/IARl8I1tLLo1Q7mh
         1k7+5HBTjqmlsakMRwk7Dtlmu4aSHfm8DoeEFqJMEoBisNmAhMmm6Hb8/UTiLzLf3Ez3
         NGsXHkrmFQC0ro605snrwKOHQ5O6nOhyXNd64osJdKmZ/t3/w7kgv8A9TzreQyM/CvN8
         ukFA==
X-Gm-Message-State: AOAM531PzKuKpCzXtUCxR832uTQdLQbdcP+LPIlJ9zcSr3TzYBjIMLKv
        8+jxjgGT2baccW6NtyXsZbqopjyYBf3ij5fkvC1oKn616hb4Ww==
X-Google-Smtp-Source: ABdhPJyBpvsqKpmKpdNlGBhsOGe9f7R1AvOyEMHGm+vjWHHZiy9iLNMMx+OoQTefeTTo2JLktOLkbLoX/ek0dwFVB7w=
X-Received: by 2002:a02:6a60:0:b0:315:4758:1be1 with SMTP id
 m32-20020a026a60000000b0031547581be1mr3720092jaf.316.1648755694986; Thu, 31
 Mar 2022 12:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <202203311842.wFWvHrHn-lkp@intel.com> <CAJuCfpEObhCKuJeHNqxna1=N1+f738dTDnUjGPFST1PqqAqcVQ@mail.gmail.com>
In-Reply-To: <CAJuCfpEObhCKuJeHNqxna1=N1+f738dTDnUjGPFST1PqqAqcVQ@mail.gmail.com>
From:   =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@google.com>
Date:   Thu, 31 Mar 2022 12:41:22 -0700
Message-ID: <CAK26GQ3JAzaVDkYzXMD1mEV3kUyp20gqY0vT_4FsQGudbX9HrA@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 1060/5872] arch/arm64/mm/mmu.c:1499:5: warning: no previous prototype for 'check_range_driver_managed'
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:12 PM Suren Baghdasaryan <surenb@google.com> wro=
te:
>
> On Thu, Mar 31, 2022 at 3:17 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Sudarshan,
> >
> > FYI, the error/warning still remains.
>
> The warnings has been fixed in later patch:
> https://android-review.googlesource.com/c/kernel/common/+/1668705
> android12-trusty-5.10 needs to rebase to the latest android12-5.10 to fix=
 this.
>

This branch is meant to be merged into vendor kernels that need the
trusty driver. We should not rebase it as that could create merge
conflicts. We could merge android12-5.10 but we don't have a good
reason to do so at this time as downstream branches already merge
android12-5.10 directly. The android12-trusty-5.10 branch itself is
only used to build the linux kernel for our emulator tests.

Arve Hj=C3=B8nnev=C3=A5g

> >
> > tree:   https://github.com/ammarfaizi2/linux-block google/android/kerne=
l/common/android12-trusty-5.10
> > head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
> > commit: 1b4aca7d82ae9b40145484fa09ceab38a6a06062 [1060/5872] ANDROID: a=
rm64/mm: implement {populate/depopulate}_range_driver_managed
> > config: arm64-buildonly-randconfig-r005-20220331 (https://download.01.o=
rg/0day-ci/archive/20220331/202203311842.wFWvHrHn-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/ammarfaizi2/linux-block/commit/1b4aca7d82a=
e9b40145484fa09ceab38a6a06062
> >         git remote add ammarfaizi2-block https://github.com/ammarfaizi2=
/linux-block
> >         git fetch --no-tags ammarfaizi2-block google/android/kernel/com=
mon/android12-trusty-5.10
> >         git checkout 1b4aca7d82ae9b40145484fa09ceab38a6a06062
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.c=
ross O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash arch/arm64/mm/ drivers/gp=
u/drm/hisilicon/kirin/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> arch/arm64/mm/mmu.c:1499:5: warning: no previous prototype for 'chec=
k_range_driver_managed' [-Wmissing-prototypes]
> >     1499 | int check_range_driver_managed(u64 start, u64 size, const ch=
ar *resource_name)
> >          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >    In file included from include/linux/printk.h:7,
> >                     from include/linux/kernel.h:16,
> >                     from arch/arm64/mm/mmu.c:11:
> >    arch/arm64/mm/mmu.c: In function 'check_range_driver_managed':
> >    include/linux/kern_levels.h:5:25: warning: format '%lx' expects argu=
ment of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long =
long unsigned int'} [-Wformat=3D]
> >        5 | #define KERN_SOH        "\001"          /* ASCII Start Of He=
ader */
> >          |                         ^~~~~~
> >    include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN=
_SOH'
> >       11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions =
*/
> >          |                         ^~~~~~~~
> >    include/linux/printk.h:343:16: note: in expansion of macro 'KERN_ERR=
'
> >      343 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> >          |                ^~~~~~~~
> >    arch/arm64/mm/mmu.c:1509:17: note: in expansion of macro 'pr_err'
> >     1509 |                 pr_err("%s: couldn't find memory resource fo=
r start 0x%lx\n",
> >          |                 ^~~~~~
> >
> >
> > vim +/check_range_driver_managed +1499 arch/arm64/mm/mmu.c
> >
> >   1498
> > > 1499  int check_range_driver_managed(u64 start, u64 size, const char =
*resource_name)
> >   1500  {
> >   1501          struct mem_section *ms;
> >   1502          unsigned long pfn =3D __phys_to_pfn(start);
> >   1503          unsigned long end_pfn =3D __phys_to_pfn(start + size);
> >   1504          struct resource *res;
> >   1505          unsigned long flags;
> >   1506
> >   1507          res =3D lookup_resource(&iomem_resource, start);
> >   1508          if (!res) {
> >   1509                  pr_err("%s: couldn't find memory resource for s=
tart 0x%lx\n",
> >   1510                             __func__, start);
> >   1511                  return -EINVAL;
> >   1512          }
> >   1513
> >   1514          flags =3D res->flags;
> >   1515
> >   1516          if (!(flags & IORESOURCE_SYSRAM_DRIVER_MANAGED) ||
> >   1517              strstr(resource_name, "System RAM (") !=3D resource=
_name)
> >   1518                  return -EINVAL;
> >   1519
> >   1520          for (; pfn < end_pfn; pfn +=3D PAGES_PER_SECTION) {
> >   1521                  ms =3D __pfn_to_section(pfn);
> >   1522                  if (early_section(ms))
> >   1523                          return -EINVAL;
> >   1524          }
> >   1525
> >   1526          return 0;
> >   1527  }
> >   1528
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
