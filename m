Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2D526279
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380493AbiEMM7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350313AbiEMM7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:59:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8AB9B1A0;
        Fri, 13 May 2022 05:59:44 -0700 (PDT)
Received: from mail-yw1-f176.google.com ([209.85.128.176]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MOzGc-1nQ7LG255Y-00PO9u; Fri, 13 May 2022 14:59:42 +0200
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f83983782fso89329807b3.6;
        Fri, 13 May 2022 05:59:42 -0700 (PDT)
X-Gm-Message-State: AOAM533ugw1vXDnFh1qGExbIEyR+Jg9QOQXm8TfspTOepPSqmivxzwtU
        VHrOLwMlrf7XfQ89Th6o8BCa6uETB3KQ6XXqfTo=
X-Google-Smtp-Source: ABdhPJwYgUxxwmOQBskkgrSY98ay2sDS+relT7TQw7BSt1pRcJYA5LmibAoQ6URJ51h0bdNcPeYCvyzSc/JJjPUle9M=
X-Received: by 2002:a0d:cd06:0:b0:2f8:f39c:4cfc with SMTP id
 p6-20020a0dcd06000000b002f8f39c4cfcmr5470076ywd.495.1652446781234; Fri, 13
 May 2022 05:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220513064952.3610672-1-gerg@linux-m68k.org> <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
 <2532419a-812b-c2de-ef56-849ec7dc16bc@linux-m68k.org>
In-Reply-To: <2532419a-812b-c2de-ef56-849ec7dc16bc@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 May 2022 14:59:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3RuOTidFpW7diHekJ6POV20SBb5PhSF943Ju1xAtOxNw@mail.gmail.com>
Message-ID: <CAK8P3a3RuOTidFpW7diHekJ6POV20SBb5PhSF943Ju1xAtOxNw@mail.gmail.com>
Subject: Re: [PATCH] m68knommu: fix undefined reference to `mach_get_rtc_pll'
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ojNKheXrGo0PVLfpCW4RkjBA3RA0otnmOfR40UZjp6IBeVMQBY7
 0yA8w4l9Xp444yabuT9q2lQzgTFEJyG9Egyu8mmthskbOgMqnTAt+9xyg4LVSwes7a+oTC5
 wxKuySmqKy84b2GoVnzauhNblpPNNbRX495Jl/EPP22Biz9weDpuJpx5O6BSnghUgdPJYxZ
 I9EdSONgYMwmTaPgl7NKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dn9NnXkhSC0=:rDLp5BdeTdajLI0gsH49Pn
 VeeoyZM4/KwPdFzXfvfzUl2qh2ppKD/RaWXkbYDcePZBC2cUFlfmqcq+NZ/t1bK27sudnh/0d
 ZKK+kWh9Ye042b9mq5IbEdcNzfVL6mZih5EMolx9qQceibZ3+y75JA6CcjriOXSTsS5Ze6ftb
 T3cJU687MpiLHqSLc2+T+y1WzD8upPuzK210OVeySo1btrL7nHPc8oYmxKtdFeVLTJAY1ztlT
 aCgP0UlN1eC8Xm/PFrK8p4kHMND16eUZGm755/ekwKnhsLrqHlMhCy4yMVzMhucT2MwKGof8Q
 zhoPxmFtfrSzkWtjH+DwC8VbTOzBGFBgBmcGVH8ebiaidwBa05VPVzwHr6y5BfbexqIGRKqaS
 yxHWCo4E3TVNRlFadnaANKJBtoz6eMPW8NLLy9J5gcgI9Euz3x7ha7BOyIbT2s8CaynF70Tg+
 oqOegRm/VUUdwm+GBtygoJDnTrsP0FyFryWjOSsGzhNB38WRITxgG/Lj2Hu/F9mHOe8UOLlkU
 gpXXAQNjdnTdGihlnkhrDHF6ejIVJj18RSh70hCu04srPecovLe8wL4s/hVvJF5iN3v7DcKX7
 4gEqWZmFeyYG+z8pmeb+CdjAAsk1PA9IpGWYE2qLFIH9yLox912Rstwa21+bqDXdGTkX+eJSP
 FXI0I02tsKlJ6du5g1WTGZ50W0lqqDGnHqf3JnvYARegU9Ocf8XJIeXOG3uqt6Wm0/7Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 2:25 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 13/5/22 17:12, Geert Uytterhoeven wrote:
> > read_persistent_clock64() uses mach_hwclk(), which is provided by
> > both setup_mm.c and setup_no.c, so it's always available?> Albeit not populated by coldfire or nommu platform code, so I see
> > the point in depending on MMU (no nommu Amiga support yet ;-).
>
> Yes, exactly. And even worse is that on ColdFire platforms it
> is never set, so will be the startup value of NULL. It is called
> without checking for NULL in both of rtc_generic_get_time() and
> rtc_generic_set_time().

I think that's ok because rtc_generic_{get,set}_time is only called
from the rtc_generic driver, but that is not registered when mach_hwclk()
is NULL.

With your patch to add the CONFIG_MMU check, you can actually
remove the mach_hwclk() symbol from setup_no.c, and move the
remaining RTC related symbols from setup_mm.c into the #ifdef.

       Arnd
