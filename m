Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5A51D225
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389487AbiEFHZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243147AbiEFHZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:25:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AEA5C37E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:21:49 -0700 (PDT)
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N2VGj-1nxPvP1T6F-013yDP for <linux-kernel@vger.kernel.org>; Fri, 06 May
 2022 09:21:48 +0200
Received: by mail-wm1-f52.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso3380519wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:21:48 -0700 (PDT)
X-Gm-Message-State: AOAM531TsDKv3ttXX4aD3CK57QuxDfABwanWwCsXzwAGtKzsKrV9ul7Y
        qyYv1WYm/69bP+QVUtzwYd2KSYuyXxxYxWheilI=
X-Google-Smtp-Source: ABdhPJyeXRviCLSUh2I0KNK/yMG89LasVM2Ytf59KFCkkmL5+X89Y78FZFnlcIcPVQxuGGr52qPuestt2sGq7FOq9/Q=
X-Received: by 2002:a7b:cc93:0:b0:394:2622:fcd9 with SMTP id
 p19-20020a7bcc93000000b003942622fcd9mr2047099wma.20.1651821707989; Fri, 06
 May 2022 00:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <202205041720.i8wJ8uXq-lkp@intel.com> <CAK8P3a3F3Z1NyhVcK6wN+b6Es3gqiYGee8a+pAPsaer4hhHDbQ@mail.gmail.com>
 <CAMuHMdVHUvbembVU92CZ+SXhfb8i8F_==d9rcH18pc=O-F8WOQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVHUvbembVU92CZ+SXhfb8i8F_==d9rcH18pc=O-F8WOQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 May 2022 09:21:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3EUPL_WiVPvWdsN7eaDWK9KbbT7VjnGfMzV1_nXLhU3Q@mail.gmail.com>
Message-ID: <CAK8P3a3EUPL_WiVPvWdsN7eaDWK9KbbT7VjnGfMzV1_nXLhU3Q@mail.gmail.com>
Subject: Re: time.c:undefined reference to `mach_get_rtc_pll'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Daniel Palmer <daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:deKrt8Rgq0PXQpL5zz8rAVd3FT7raZL1x58GGvyWSVD6eQta1uc
 aqxeMXQ6PUpIrswJBi26fMn9RM8TED7sG5wfyjZ8bfY/tek/Fldf+Q3fuJO7qfodtXXOvoX
 BcACxso/00CiqzOgLTxv/9kti9F08oCXmUW+HZspeoeLdSxW2wPn3vPTxrqrWFU2qWHuV+u
 iJ54Qk3pK4A08fURWHXkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:il0LCCVwoMA=:Z+d+ukfBc+El40Cs8DaQs3
 +58G5onbVX8Trcujlycixey76xrWCM+eOIG8E4lh98KoHUuOjvv05+1KtKOozijpRdWKrnSS/
 P+vNdNxZffpujRH7gM+4DvANMGKwmyBihE5XHplch0l2vCrBMBERDQQxINj31nkbqk5J8zDAr
 V8O3nAv+2gUkiyycVq2+dQGm1SfhbPvc6rRF0wVMdM4fThfkeKZVqgUAJFjbxNoqzvLFD4u8K
 /33xRXhWFR5zPcrvZp5dhbQzLb3Z7zS7q9fatBD3oDGAJMbC0RQ80gQbKv1cd10nodZ2M3AhB
 UG1ptYzpDKCor2Nn/mqKon+t0IjIqRTFkKDweVWj4eYX0NVDFXzuPT8iOsHUYWKPDPSaAp1uS
 mBzsUtP8tveNk+TstIiRtVxkONg3gSO479DJmfGSqQIBMf2owQ4szvdBKl3JUxm/GO+j9SX/N
 AUI39wlZd9qq0pSgg8i1GE0y4s7UrDTZ2iJNslcasrm82zK8IL+RsXZ3ReXcgh3HiaWAU1QsC
 fk6NtsthbqgkfdzQB9rqhkjELORniU5XQdNIEE2bdr+HbMyHTJMBGWj0ncfctoMlkNIHmhxav
 i9nzd/14J2ZvEMqEV7YVZpN2+Tn/wYLrimCJMqZqKG1JBW2o8qmFed5De8HUoVx7nqol02V25
 JQ8bYFui6XE/Q/98NXXQqVO70EbF/60dherr60WY1exMJE04EMLTjYjt4wz4YjQomFFoqE4nP
 9e6UVNdgam5vZPf2NxD9/i7kthqUVb4EktQKjt3rZq5MvWtW/MN2UYiqm7TrbT5pfbcBaOC2A
 luyVNszssuXbctIkmiNUmv4iC0XruIO7jJt525p2JBL9BN593o=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 3:33 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, May 4, 2022 at 2:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, May 4, 2022 at 11:14 AM kernel test robot <lkp@intel.com> wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   107c948d1d3e61d10aee9d0f7c3d81bbee9842af
> > > commit: 8b22820efb35f93d98638563b0a8f4094e8ee399 m68k: m68328: remove duplicate code
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
> > > >> time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
> > >    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
> > >    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
> > >
> >
> > I think this is just another build failure that was hidden before my patch,
> > not caused by my patch.
>
> That's an m68knommu kernel build with CONFIG_RTC_DRV_GENERIC=y,
> I guess?

Correct, the  .config file is linked in the original report, just double-checked
that. More importantly, it's a nommu M68KCLASSIC (dragonball) config,
so the existing #ifdef CONFIG_M68KCLASSIC check in
arch/m68k/kernel/time.c is insufficient.

       Arnd
