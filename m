Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7674A4D1D96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347842AbiCHQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348599AbiCHQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:41:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E696251E7D;
        Tue,  8 Mar 2022 08:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646757614;
        bh=Fho49uNGHXrjkDqL2Zd43Us7RILgLH8PK5c7wbh+2iE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a1anfpCFjprsBJecwuUdttDpSP7OjniphoJULZyzDPooa5vldIx2gL68sT6YsIBV+
         sNfAI0sJb7E+gVr3osOjPp11k9upPmo3Jy9jNrUdhfUSKVlG3o/HibPRh9zW+62orH
         qB6TXrtNkI95oDX6DzmKG6RHZmgf1sHIfxh1K0+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.180.167]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1o8lIr2iY7-010d8u; Tue, 08
 Mar 2022 17:40:14 +0100
Date:   Tue, 8 Mar 2022 17:40:13 +0100
From:   Helge Deller <deller@gmx.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: hppa vDSO and compiler (non-)support
Message-ID: <YieG7XxeM8B83AbP@ls3530>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
X-Provags-ID: V03:K1:V4v9y6JKOakEFg8H6nVyPytTWKwWdvWEVpeSvbhE9yQoR52ohDM
 0p30sc4JangSVLB+t/7gMCEDffQ5msKP1zyM/1zP8Kvr0HYBjsIDK45E+BBN+lpvTvywRuP
 vkvo/j3/BwxdL0+2/6vKoOc+hMZax+vzfhBXI8+22WJlB9CL0+rxiZiAT3nSDwJikE/EmZ/
 Vm7NrhXL1M/BBOLfnShog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0X4/MLsWD1Y=:1zavGvfPaMlwgaf1ga+C79
 W7njnbCUCADn80Bc6uvOeXi7hsASNg4J1vqHmAEHm+qcjLv4vMweAFVSzfxl+0YhUrgUTbOhZ
 xYa0LxgnkueZND+0fcr3naIFowqpPrvai3gfTSZWd7MVaV97djuJBg5OEQelFX/3ivLsVKl1J
 Ec6FaiIpax1fw6J4og8l/ecnXuoB+5C8BAoXl60WOCcos+mCLhSDgBtFGSySd1PhTHxDVQDO2
 kow5CxOgG+so9wENVHsqTEZX25FOkzLfTfyiCuC/u3zVKF9yvpPXmPwsUoEvNt18Dkn5y0mmC
 xaxNc2Uk8uzBAeglaY3KH8PUVHGGZdfXSxzpDlQRmHOAayVKiy+tfCsKaxXx6dUAgYRzyhVGi
 oq6tL3CLywN2Tg9Fi8n7d9X6IjKdkrCf/7wvupfbM50L3DWB8nZWMW4l1/w/f8/HiJv8k05Gd
 0zp3vwdeYRXbzjYeFfOJcgP03/JF+cAVo2kMm/S9EjBXrxkI/i58PtOQ3txAJmcYbCvLt+iHN
 5ELBBy5VhwMH6RQPX+Nt9ybJCgKkbD1/1Gh72WAsJy8uvge9V3EgstoFanYtSErx9ycyb9yIy
 exwIGzM8cBBr2OrBuUqQF3ClWhxnQNQ9eduOkrfxIVV3JA7VuL/S2u+Z3PI6XGM8iWOlEo7gl
 LsJtjXvxfhdWZ/xrxgMf0yRuCo9WCEspyBJ7253yiBSucRGnzE9AWi1o3EpFE/QnpkA8VLjq1
 1+EpnVBRLE7SRfiFitYu0QIyvZVmzmuOaUN1Ys+SQexrXjdJgEcX1Vs1cQSbAF271b2NGaHM5
 ryQ3KH50oILTbt6ekKxErSPT+rOfQGXrxmXRlXvi3zb6Dubi/o5au494JJCBFTIvJCS/Asu1G
 AyE5Go+UsD5ePgJ8i8VC57cperIBKnNN6gJi4KRKtHFM82CH4gc7qeOypS8imn7geQQuQEeTK
 9iUVBqnmA151KxUFX+UYis48vKE5E1/Yax6yiqMoqUv9wqhGbipURmUiwE+9kXbyOR/ZH6FQv
 ABAHSf7bv3y60Q3wyPW/FPg/8EZ2wLVUgGuJOACZk63SxK4ACekvXiaVFXsjAPAZFLntV5ozC
 ehwMpeGNcDEi1I=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Helge Deller <deller@gmx.de>:
> Hi Jiri,
>
> Thanks for testing on parisc!
>
> On 3/8/22 12:06, Jiri Slaby wrote:
> > since the "parisc: Add vDSO support" commit, I can no longer cross-bui=
ld a hppa kernel. I see two issues:
> >
> > 1) CROSS32_COMPILE detection doesn't work here, as openSUSE provides h=
ppa-suse-linux-* binaries. It's easy to overcome by "CROSS32_COMPILE=3Dhpp=
a-suse-linux-"
>
> How is it handled for other platforms like s390x?
> Would it make sense to add the detection for SUSE too?
>
> > 2) openSUSE doesn't provide any libc for hppa. So gcc doesn't provide =
libgcc.a and the build of vDSO fails.
>
> libgcc.a comes with the compiler, I don't think you need libc for that.
> I'm currently installing opensuse to try myself though...
>
> > So could vDSO be optional on hppa via KConfig?
> The vDSO is one of the first things which is built during kernel build p=
rocess.
> This is why you fail.
> Making it optional doesn't make sense, because then the kernel wouldn't =
be able
> to start the user space processes.
>
> > I used to use the cross compiler to at least compile-check the followi=
ng =A0tty drivers:
> > arch/parisc/kernel/pdc_cons.o
> > drivers/tty/serial/mux.o
> > drivers/tty/serial/8250/8250_gsc.o
>
> I assume you never built a full kernel, but stopped when building those =
modules?
> Without libgcc.a the kernel itself wouldn't have linked before either.

Below is a hackish patch which should allow you to build at least until
those modules. The make will still fail when linking the vmlinux file,
because libgcc.a provides the necessary low level symbols.

I'm currently not planning to include this patch, because it simply
doesn't make sense. Maybe you could nevertheless try/use it?
I'm open to any other ideas you may have.

IMHO, the only solution is, that libgcc.a gets included into the suse cros=
s
compiler rpm package.

Helge


diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 2a9387a93592..3e62527db749 100644
=2D-- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -165,6 +165,7 @@ vmlinuz: bzImage
 	$(OBJCOPY) $(boot)/bzImage $@

 ifeq ($(KBUILD_EXTMOD),)
+ifdef CONFIG_VDSO
 # We need to generate vdso-offsets.h before compiling certain files in ke=
rnel/.
 # In order to do that, we should use the archprepare target, but we can't=
 since
 # asm-offsets.h is included in some files used to generate vdso-offsets.h=
, and
@@ -177,6 +178,7 @@ vdso_prepare: prepare0
 		$(build)=3Darch/parisc/kernel/vdso64 include/generated/vdso64-offsets.h=
)
 	$(Q)$(MAKE) $(build)=3Darch/parisc/kernel/vdso32 include/generated/vdso3=
2-offsets.h
 endif
+endif

 PHONY +=3D vdso_install

diff --git a/arch/parisc/include/asm/vdso.h b/arch/parisc/include/asm/vdso=
.h
index ef8206193f82..d667cddd700d 100644
=2D-- a/arch/parisc/include/asm/vdso.h
+++ b/arch/parisc/include/asm/vdso.h
@@ -2,6 +2,7 @@
 #ifndef __PARISC_VDSO_H__
 #define __PARISC_VDSO_H__

+#ifdef CONFIG_VDSO
 #ifndef __ASSEMBLY__

 #ifdef CONFIG_64BIT
@@ -15,6 +16,12 @@
 extern struct vdso_data *vdso_data;

 #endif /* __ASSEMBLY __ */
+#else /* CONFIG_VDSO */
+
+#define VDSO64_SYMBOL(tsk, name) (0)
+#define VDSO32_SYMBOL(tsk, name) (0)
+
+#endif /* CONFIG_VDSO */

 /* Default link addresses for the vDSOs */
 #define VDSO_LBASE	0
diff --git a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
index d579243edc2f..461dd4a85e99 100644
=2D-- a/arch/parisc/kernel/Makefile
+++ b/arch/parisc/kernel/Makefile
@@ -41,6 +41,8 @@ obj-$(CONFIG_KEXEC_CORE)		+=3D kexec.o relocate_kernel.o
 obj-$(CONFIG_KEXEC_FILE)		+=3D kexec_file.o

 # vdso
+ifdef CONFIG_VDSO
 obj-y			+=3D vdso.o
 obj-$(CONFIG_64BIT)	+=3D vdso64/
 obj-y			+=3D vdso32/
+endif
