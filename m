Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC45AA040
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiIATjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiIATjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:39:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559779A99F;
        Thu,  1 Sep 2022 12:39:17 -0700 (PDT)
Received: from fabians-envy.localnet ([217.234.194.43]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mw9Hm-1pLwgW1FR6-00s9J9; Thu, 01 Sep 2022 21:39:04 +0200
From:   Fabian Vogt <fabian@ritter-vogt.de>
To:     Andrew Davis <afd@ti.com>, Daniel Tang <dt.tangr@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] TI-Nspire cleanups
Date:   Thu, 01 Sep 2022 21:38:40 +0200
Message-ID: <5597784.DvuYhMxLoT@fabians-envy>
In-Reply-To: <CAPnH9d=HhPRVNkveEPBe01g-JK0K5bR7suiTZzmCwm80Vpo0sw@mail.gmail.com>
References: <20220822232046.1230-1-afd@ti.com> <CAPnH9d=HhPRVNkveEPBe01g-JK0K5bR7suiTZzmCwm80Vpo0sw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:q0MZYE1ez3SPDiKjT+yBGh94jYNaudKtIEAT0KUibGe61OaCJor
 0GV+r+WOERPPKC3hP58O32lTqSRZZBKRKvYid/fYmgkAAfilcMZhvjdgwSZ41deFb6aMx3f
 W3QkHfC3CgqrqCjrXI1No07BV65A7tvHzthQ4hCjAVKIMAbLtmBQNo+cIFSHf4UV51O/t7O
 sz5t2mwoel4rQQ2GtdBhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hfYIt94BQFE=:XxIMDUc2X/3OKPnipmQf5m
 w4uglJFMPLRH6wcsSv1/ObM7nJzCSOQclMAMgJWvZWM9Pti4hzI4eEYizNZOwuXpKtgqgEZjm
 stKs0A60WD54+h8dHIV/ZCzFLY0n9qAzxv/QT+o9u3qsRx8zw3epxMG38Efexo4x+dXHDrrHm
 2OreDYwWx7bOJMwUqqDr1RIpAV/cF5C5slqem6CvZKTSUIM/mkSJEXYGHzMjcMy0gAwkYjHBq
 OR/FANcG4L2dMreQAUUkscvwqXvdYafDuv1NfO87KzlI7OS9eisbgqM7EzQ8V49xcuv99tkWn
 jTqFm4FW7emwmF5mJindn5gW/n+iNLuDOrWl8g6vVqgMBIeNoPXsSNHhknpZXxAph47OH/dd3
 8aDW8siKCId24lN5PSd2/p/OGlc4eHOPd6xRwIn3uNCdnb4ExA2cASB/FhUTHS6lc5AAC3ACh
 BKBWE5QrNxGiSOJfaiZ4ePrAtWxOEpe2tkbTMEZAmhvQxNNcdG8a1BVL9NUnsIKMDR20TfJED
 pDABIe7PRSGN/yu3UUr4XzC1ihiTr6mb/ImxaaQS8AjCF477GUPjUgqfJxJMoQU+w2dP/FU6d
 AD0hGvK/oZPH3aOs9K0t+/WsFjmPYr67nY0xJd+Mcyd0n7mMB/U0MI/1YSKm05THLbfOOaLgO
 p1vNSVH0jYHaMq2zi7odboiaSjdqXxaW+qiEK/YmSELA4dXwQP2nzWx2vgPRf9h/16bmzD5GU
 8alLODAN9V3zMkXCd6PGfsSjbxPFcEYlCbfiIUfhYErx72iJ8OA+cVP2D+H+8+yrsIXFyNIw2
 Hkp32RcDvio3PFrThnHVfUaMHScnw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 23. August 2022, 11:16:17 CEST schrieb Daniel Tang:
> I've CC'd in Fabian, who has previously been able to assist testing
> kernel patches for this platform.
> 
> 
> On Tue, 23 Aug 2022 at 09:20, Andrew Davis <afd@ti.com> wrote:
> >
> > Hello all,
> >
> > I don't have the hardware to test this (yes I know who my current
> > employer is), but it does look right and this lets us remove the rest
> > of mach-nspire/ without losing any functionality.
> > Does anyone have one of these to test with?
> >
> > The second patch removes a couple defines that do not seem to have ever
> > been used, but if one want to implement it, then it should be a simple
> > generic syscon DT node.

I applied both patches on current master (c5e4d5e99162) and they work fine in
the emulator (including rebooting). On real HW the kernel does unfortunately
not boot, so I'll have to do some further testing and debugging. The changes
look good to me, so it's probably some other change which broke it though.

Cheers,
Fabian

> > Thanks,
> > Andrew
> >
> > Andrew Davis (2):
> >   ARM: nspire: Use syscon-reboot to handle restart
> >   ARM: nspire: Remove unused header file mmio.h
> >
> >  arch/arm/boot/dts/nspire.dtsi |  7 ++++
> >  arch/arm/mach-nspire/Kconfig  |  2 ++
> >  arch/arm/mach-nspire/mmio.h   | 16 ----------
> >  arch/arm/mach-nspire/nspire.c | 60 +++++++++++------------------------
> >  4 files changed, 27 insertions(+), 58 deletions(-)
> >  delete mode 100644 arch/arm/mach-nspire/mmio.h
> >  rewrite arch/arm/mach-nspire/nspire.c (61%)
> >
> > --
> > 2.36.1
> >


