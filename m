Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DC14E3042
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352323AbiCUSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiCUSxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:53:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1224A27E8;
        Mon, 21 Mar 2022 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647888695;
        bh=5JyzedBmD+44aohVscSNbOQGpmKvS2TbVaPWaZX6bLU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Sae8Zt2yMwr+Jhx7rQCNef453VtRhAxpUicR494vSecpWFKqkSh94Xlf4L5cwHiqT
         yhSP6ED1YfY8EpPttEvbIFwUvNQTHbQZIi9squ3F6BgCVYV65SkNtfL8qx7T7lUzIG
         bTc0hQImO+8WTnZrC5gaOoEMduFNgeh3AiNBsoss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.171.242]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1nVXeE0GaL-003i88; Mon, 21
 Mar 2022 19:51:35 +0100
Date:   Mon, 21 Mar 2022 19:51:33 +0100
From:   Helge Deller <deller@gmx.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Martin =?iso-8859-15?Q?Li=A8ka?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: hppa vDSO and compiler (non-)support
Message-ID: <YjjJNb0D/b+ZXBVZ@ls3530>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
 <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
 <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org>
X-Provags-ID: V03:K1:5XcSiZ3xe6YNxAdoIM2jmgWCByD/B+xrNfeZGBuvdRTR6d/EM5i
 rNblh7LlBW33FHP3C+NqN3McJiQ9Fc9QxvQrHfGik5gK6JD1T/ZA7gcdSNu7Tb3NlMdg32n
 699yJ1tDonxQTHlUcxAlkMPEb+XlQhTCK1IvthBNkBfHh2q+reY0obdyLo5eKeEbPuD+9Ac
 zvsbl3pp41w+PElnpDlag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jKslkREYM5M=:d9/iQ89zItDiiJ80adcBmH
 dNcoD6qfIXQafboy1PYgHiXNPVkkapkX9vBMAdtEHHNp/WNhwPgI4G7E3+FooD+1C+uis6rLg
 D7WqG/kXY/shF4z00o+daHKtGx2bcSPsVumAcewWNjXLTMYQXxqnS/pafzobpW6AFmjEXYhp7
 3RWWUDx7FG0ZbPyX1rGrs2knxAgWfVtly10jDwiQ3OZECn0rNObGyQiOctcWTa7GU4rm887Dn
 /5O1bN8Dqvz7vt8SDRA3YRx5s6fHY5GbdyyFyo7qobj/Vrxg2NFAODWiuosGOYO8v1aJm1jfp
 OT2MpNtB7xoYvJYW0ioq3JF6SsJHEoSoRHBmY+ml2Z6qlFF5T3kIt5KPClnkXgFRD+KiZFqt9
 lCjUXxTfn61xHC2cyINLdQI5gsiCUcO7c3I3/8kGn9U7ICWLMz0QJMxS7GQVDMWNfnki6DwKI
 avzfb3uYqPpVqr56kIZe7/9tgj57csq+AUj6EYjEFHgpTsn5O6JVxJ8OBjpob4HvcmXIvgXXK
 IyHO9OaKBIxvonJs9SdTlbj1OHr0Pb34Bu8h78HdPrbWdTfC7ClKBYxaHxtQCt+HcIeorDdKU
 rh2Y1p7YMrwwsPR+tfM6jwWvpPijECwsMfSN06X/JC3yi72+Uq55GOOga4CyuFk+EiKOcJrFz
 KH8R8kemIvX+d3LZ8oNTHrhCvbFQpOFmOTbmSemfIJ8pVufJx22QwPsb8u16qtyJAd0x/jBYH
 pG/3zmbE+QBbP9Rppablale6srdGxJP2VUBs+eGbvSIs0HwwEwNZzExbnn1id4gAlHgjWSPQZ
 AMxiynnj/RoCNVvgVbr4AxoY9D8bmIBWehRavySPj7r7LMvqt4jM4sOYsVWGnfOs9RcwU4Rlx
 73JXd5AR4O3B87WPF61j3TSGZ1rEl8PeJ53lQ57hil0iut/QqYcAuErLs6RgK2xWAJfvLioqI
 3Bg9Y9aOA8kJxrpUKdU3tpI73iBTy2doeM47eqTdCn4mn89tPezQxBtX4UIUCOs1G+MLasLVA
 sLl9uGf7UhOPRCsgeJncVe3SxmChovLktlLu45K72XymbAya1oMqaua4uj1jvFHG6BjR4S4s1
 Ukbkv1+HT8J/1U=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiri,

* Jiri Slaby <jirislaby@kernel.org>:
> On 09. 03. 22, 6:48, Jiri Slaby wrote:
> > On 08. 03. 22, 15:51, Helge Deller wrote:
> > > On 3/8/22 12:06, Jiri Slaby wrote:
> > > > since the "parisc: Add vDSO support" commit, I can no longer
> > > > cross-build a hppa kernel. I see two issues:
> > > >
> > > > 1) CROSS32_COMPILE detection doesn't work here, as openSUSE
> > > > provides hppa-suse-linux-* binaries. It's easy to overcome by
> > > > "CROSS32_COMPILE=3Dhppa-suse-linux-"
> > >
> > ...
> > > Would it make sense to add the detection for SUSE too?
>
> So, could 1) be fixed on the Kconfig side? Or should I (people running S=
USE)
> use "CROSS32_COMPILE=3Dhppa-suse-linux-"?

Could you please try if this patch fixes it for you?

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 2a9387a93592..7583fc39ab2d 100644
=2D-- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -42,7 +42,7 @@ export LD_BFD

 # Set default 32 bits cross compilers for vdso
 CC_ARCHES_32 =3D hppa hppa2.0 hppa1.1
-CC_SUFFIXES  =3D linux linux-gnu unknown-linux-gnu
+CC_SUFFIXES  =3D linux linux-gnu unknown-linux-gnu suse-linux
 CROSS32_COMPILE :=3D $(call cc-cross-prefix, \
 	$(foreach a,$(CC_ARCHES_32), \
 	$(foreach s,$(CC_SUFFIXES),$(a)-$(s)-)))
@@ -52,7 +52,7 @@ export CROSS32CC
 # Set default cross compiler for kernel build
 ifdef cross_compiling
 	ifeq ($(CROSS_COMPILE),)
-		CC_SUFFIXES =3D linux linux-gnu unknown-linux-gnu
+		CC_SUFFIXES =3D linux linux-gnu unknown-linux-gnu suse-linux
 		CROSS_COMPILE :=3D $(call cc-cross-prefix, \
 			$(foreach a,$(CC_ARCHES), \
 			$(foreach s,$(CC_SUFFIXES),$(a)-$(s)-)))


>
> > > > 2) openSUSE doesn't provide any libc for hppa. So gcc doesn't
> > > > provide libgcc.a and the build of vDSO fails.
> > >
> > > libgcc.a comes with the compiler, I don't think you need libc for th=
at.
> >
> > I was told glibc is needed to build libgcc.a.
>
> 2) was fixed on the compiler (SUSE) side. cross-hppa-gcc12-bootstrap was
> introduced -- note it's known to be a misnomer -- it should have been li=
ke
> s/-bootstrap/-baremetal/.

Great!

Helge
