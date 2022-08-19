Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFA59A593
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350328AbiHSSJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349986AbiHSSJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:09:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA276D9F3;
        Fri, 19 Aug 2022 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660931899;
        bh=LtW6M/ZUPq1Opl8pyRUIA2iryjiKgkljrq5i0Br2P0s=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jadZQR7rMi0AixAIvX4jEiJNOdfplZoHdhQa3yMpXGC4QcTM3pz2jQfFZacTc4eA4
         DGIdepboLlUws2ur0yySoO+MMuHFRughYNDMLrz8Y//Q8QuqAJXXsJA67anc8HfEuG
         3dOhJs0sf7jFdfevL2WACsrFBkpM6tKMfXqP7Ayw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.153.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1nd8Rp1mb0-00m3ga; Fri, 19
 Aug 2022 19:58:19 +0200
Date:   Fri, 19 Aug 2022 19:58:15 +0200
From:   Helge Deller <deller@gmx.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: linux-parisc compile failure in current git
Message-ID: <Yv/PLFLga51+T9xg@p100>
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
 <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
 <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de>
 <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
 <YNOafsB81ZcP2r7z@ls3530>
 <f599c358-815f-088e-f2aa-b064ccb64e44@infradead.org>
 <CAK7LNAREcSW2Hn3Ty_zTVzTCLgYnFfo=ZcibE2zif1mBWp==4A@mail.gmail.com>
 <39ee0ca2-48a0-755b-605c-3ce1205b9715@gmx.de>
 <CAK7LNAQceFhO1-vupRAJy3rU+p+MK97vRuswVXvVEgF7q0akDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQceFhO1-vupRAJy3rU+p+MK97vRuswVXvVEgF7q0akDA@mail.gmail.com>
X-Provags-ID: V03:K1:RX2sYvylV5aO8psxFgZSvazuogg7TGWCv8J6u2uglsi9YDhPAYa
 elfWokC5d6d1/cuNzrWBg2MMxectitNoQ3gC0O9Zhg/C9VTuFDxZ2S9p9HOUNv9/joTNEo+
 Fv1kRfze0VaIoXRn8FUXZrWgluNd0+Vpx1kAVgPhEUfvOTc5ycd6SUq3vQO52UaCIp/wH0E
 +YvlLE7vNWuHc812KY0Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5UkWiUGHQO0=:CG6RcWcpyDMMQBYkiWG/qy
 g3MqinanWxyNvr7bpRhOVNpaLJ/o7Y30L6M3dgc5kblx5hXEFAMaxAE9z/I+aSvvVW1bAKCFH
 IIqfM8jEhowKgvQwPmrf+uA9ra9kcADyuYuzZPpk76U3K00Mysv30VydOX6mFhmt3rSx1fUYs
 mHrBwDrSw5+VlqsiOl7PUi7nhixJLi4YJUu/AwSwovVFtFN9YHgpPTT5i3Chtq1vcmnr+KV90
 mgz5X0EMHk3S8jYSgE4EisR1OAD5U0zIBgCjTGx4jKT3/yHDwdba+AWhqRY0s0Lgd8zmCl3Dc
 AwOYP7QIVMdic70l//CDfZp2QSApEVnXMCaECfxmthZGw38hU/WQhRyFz0cT4qB3wOzUMO6GS
 L7Ev4CpYbV6JUJTDGfMODFOx3Q8uz1BzJCm+uBh2FF7grKOVGiJAYg7OqfukZ8sL6t4/T40jx
 Apn3ceQ/QFZip+KWDbtHXHXbQHsOo61OcbYVBdxdC8exBdRWgGYAgnw04qucg7FyjsdE1yJEx
 w4zEyLcMN1bJ9DlvgFm0AZuLPz4/6KPGYfLyOa8ixTGpxIBSjeAz+02Ck7uW4DZe4BlajEkA7
 GdX8uAs9slW8L4QEwbc8zk9HupDRCGFUmTp8UXOd5jMM6OnY8W3Pa1hWHHBLKSCtXS66Bz+mE
 S5NwOeFj63DNxJ0KmEav164/+nBTNyP0j2UYMRCbqaM2OAl7RQ//EScpHrvl0ijIfatvZDsFh
 zBTj6k1066wckCeTrtOZNSfztCDQvKye/pSbc36H3JDD5PjSu2hKNRAFWv+zLG/aWyZDmy94k
 qwBac3+5O1Pe9MhBRVX/WWF1RW3NiCEbc1dfRLbfIZPK4sQ0NEFkxCBqvZPeiUL7JuE2SBHjo
 YDD1u4F/FlBy+BrosSdCzCoBmG4i4h8p/JeVd3Sn1Q9eKhWp+bAajTZsy8bo7oz3nO236EKLX
 Jox7xm+V5tFXiAmxLDv3+qxYKQwT93MSpKW73Ldi75sB7ZxsbEq1IG7M/jzmeJjWwmBlxFxdL
 G9kGzeA3RoIfxogcPyLbkxlWI7IK7hJTvyBhP/IZWiUKlKqBTxZRJN+xKGSoWMUVY9MW7YUaW
 A47J72IfTrq3GR27cY7UEdzSvP2OheCl1VRR2zr4AN8zSX64tImvAhtHQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masahiro Yamada <masahiroy@kernel.org>:
> > > The reason is 64BIT depends on PA8X00.
> > >
> > > allmodconfig chooses PA7000 instead of PA8X00
> > > in the "Processor type" choice since
> > > PA7000 is the default.
> > >
> > >
> > > If you apply this patch,
> > >
> > >
> > >
> > > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > > index 7f059cd1196a..458b8e22e240 100644
> > > --- a/arch/parisc/Kconfig
> > > +++ b/arch/parisc/Kconfig
> > > @@ -146,7 +146,7 @@ menu "Processor type and features"
> > >
> > >  choice
> > >         prompt "Processor type"
> > > -       default PA7000
> > > +       default PA8X00
> > >
> > >  config PA7000
> > >         bool "PA7000/PA7100"
> > >
> > > allmodconfig will start enabling CONFIG_64BIT,
> > > but it is up to Helge.
> >
> > That patch "partly" works, in the sense that with:
> > make ARCH=3Dparisc64 randconfig
> >
> > you randomly end up with a 32- or 64-bit kernel.
> > Since "ARCH=3Dparisc64" was given, one probably would expect a 64-bit-=
enabled kernel randconfig,
> > and with "ARCH=3Dparisc" a 32-bit randconfig.
> > But, I'm not sure if this intended or not and works that way on other =
arches as well.
>
>
> Ah, OK.
>
> Then, you can mimic sparc code.
>
> In the top Makefile:
>
>
> ifeq ($(ARCH),sparc32)
>        SRCARCH :=3D sparc
> endif
> ifeq ($(ARCH),sparc64)
>        SRCARCH :=3D sparc
> endif
>
>
>
>
> In arch/sparc/Kconfig:
>
>
> config 64BIT
>         bool "64-bit kernel" if "$(ARCH)" =3D "sparc"
>         default "$(ARCH)" =3D "sparc64"
>
> "make ARCH=3Dsparc32 randconfig" always disables
> CONFIG_64BIT, and randomizes the rest of options.
>
>
> "make ARCH=3Dsparc64 randconfig" always enables
> CONFIG_64BIT, and randomizes the rest of options.
>
>
> "make ARCH=3Dsparc randconfig" randomizes all options,
> including CONFIG_64BIT.

Ah, cool.
Thank you!

> I suggest to introduce ARCH=3Dparisc32

No need. We already have ARCH=3Dparisc64 or ARCH=3Dparisc.

The patch below fixes it nicely and I've pushed it into the parisc
for-next git tree.

@Randy: Maybe you could try it as well. With that approach
you get what you want. Maybe that's a better approach for riscv64 as
well?

Helge



=46rom a529c0a388f74a243363976af8535b10d3d69d20 Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Fri, 19 Aug 2022 19:30:50 +0200
Subject: [PATCH] parisc: Enable CONFIG_64BIT for ARCH=3Dparisc64 only

With this patch the ARCH=3D parameter decides if the
CONFIG_64BIT option will be set or not. This means, the
ARCH=3D parameter will give:

	ARCH=3Dparisc	-> 32-bit kernel
	ARCH=3Dparisc64	-> 64-bit kernel

This simplifies the usage of the other config options like
randconfig, allmodconfig and allyesconfig a lot and produces
the output which is expected for parisc64 (64-bit) vs. parisc (32-bit).

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 7f059cd1196a..9aede2447011 100644
=2D-- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -146,10 +146,10 @@ menu "Processor type and features"

 choice
 	prompt "Processor type"
-	default PA7000
+	default PA7000 if "$(ARCH)" =3D "parisc"

 config PA7000
-	bool "PA7000/PA7100"
+	bool "PA7000/PA7100" if "$(ARCH)" =3D "parisc"
 	help
 	  This is the processor type of your CPU.  This information is
 	  used for optimizing purposes.  In order to compile a kernel
@@ -160,21 +160,21 @@ config PA7000
 	  which is required on some machines.

 config PA7100LC
-	bool "PA7100LC"
+	bool "PA7100LC" if "$(ARCH)" =3D "parisc"
 	help
 	  Select this option for the PCX-L processor, as used in the
 	  712, 715/64, 715/80, 715/100, 715/100XC, 725/100, 743, 748,
 	  D200, D210, D300, D310 and E-class

 config PA7200
-	bool "PA7200"
+	bool "PA7200" if "$(ARCH)" =3D "parisc"
 	help
 	  Select this option for the PCX-T' processor, as used in the
 	  C100, C110, J100, J110, J210XC, D250, D260, D350, D360,
 	  K100, K200, K210, K220, K400, K410 and K420

 config PA7300LC
-	bool "PA7300LC"
+	bool "PA7300LC" if "$(ARCH)" =3D "parisc"
 	help
 	  Select this option for the PCX-L2 processor, as used in the
 	  744, A180, B132L, B160L, B180L, C132L, C160L, C180L,
@@ -224,17 +224,8 @@ config MLONGCALLS
 	  Enabling this option will probably slow down your kernel.

 config 64BIT
-	bool "64-bit kernel"
+	def_bool "$(ARCH)" =3D "parisc64"
 	depends on PA8X00
-	help
-	  Enable this if you want to support 64bit kernel on PA-RISC platform.
-
-	  At the moment, only people willing to use more than 2GB of RAM,
-	  or having a 64bit-only capable PA-RISC machine should say Y here.
-
-	  Since there is no 64bit userland on PA-RISC, there is no point to
-	  enable this option otherwise. The 64bit kernel is significantly bigger
-	  and slower than the 32bit one.

 choice
 	prompt "Kernel page size"
