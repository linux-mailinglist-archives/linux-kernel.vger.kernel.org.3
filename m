Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553D94A9EC8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377428AbiBDSQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:16:28 -0500
Received: from mail-40138.protonmail.ch ([185.70.40.138]:57520 "EHLO
        mail-40138.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377455AbiBDSQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:16:23 -0500
Date:   Fri, 04 Feb 2022 18:16:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643998581;
        bh=JAxZQH38X2RSQCAIWu1MiYgqJ5mWwl2CQgXP3NvKv8w=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc;
        b=W8Y65dMIw7mP66VctbXY92uS9u21pL0fw6JuWpKGeraHLcOlnb4XqUq8E0TKjzWjI
         21WaZ+B6cevVEE07YjRAigVRIv151I4mnRTxGj88gvPhhEO76Cazlqsx6245TKNIvl
         WElbdzxqv65CatJ0LeQQ7HrsEa+7J7i3Df7hnABuUYyx7pctZMdTe2vDx4uvpw+pZF
         nXiNo0OhiBkl/6JX55rcImXC4ABabnm02KkcinQy928phCLsyiHcGqyDq2HuSRTX3x
         Zu2++sZmF8TXt4plZGTLUXB6qrP7c8Z2OWi8GLROXqS5IQRyaqu6n2NAkYuJTyuicM
         m4t9NRCY1eFbQ==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   2b57 <2b57@protonmail.com>
Reply-To: 2b57 <2b57@protonmail.com>
Subject: kernel 5.15 and 4.19 sparc64 boot panic
Message-ID: <MATvZjhNEuZXikTCiMjeFa0ZnaP_6YQUazM2bG1n22tUlY99aDe0kVy4LP1qaR60AMm9M66anIeMUeJIAB9Du6PNDwJoDgfIlvIGoYMM_ek=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,T_SCC_BODY_TEXT_LINE
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to boot 5.15 kernel (Gentoo) on sparc64 machine (Sun Netra X1), =
and it crashes right in the beginning; same happens with Debian 10 (which s=
hould be using 4.19). There was something similar described here already: h=
ttps://lkml.org/lkml/2012/2/13/64 , but it was almost 10 years ago. I don't=
 believe it's the same issue, but it should be related:

PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.18 2002/05/23 18:22'
PROMLIB: Root node compatible: sun4u
Linux version 5.15.16-gentoo-sparc64 (root@catalyst) (sparc64-unknown-linux=
-gnu-gcc (Gentoo 11.2.0 p1) 11.2.0, GNU ld (Gentoo 2.37_p1 p0) 2.37) #1 SMP=
 Sat Jan 29 07:50:57 UTC 2022
printk: bootconsole [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:36:42:cc
MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits =3D=3D 40)
MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel...
done.
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 0000000000000000
tsk->{mm,active_mm}->pgd =3D fffff8005f002000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.16-gentoo-sparc64 #1
TSTATE: 0000008880e01607 TPC: 0000000000764bc0 TNPC: 0000000000764bc4 Y: 00=
000000    Not tainted
TPC: <strchr+0x0/0x60>
g0: 0000000000000000 g1: 0000000000000001 g2: 000000000000002f g3: 00000000=
0000006c
g4: 0000000000ca3940 g5: 0000000000000000 g6: 0000000000c34000 g7: 00000000=
00000000
o0: 0000000000000000 o1: 000000000000003a o2: 0000000000000022 o3: 00000000=
00000001
o4: fffff8005febe4d9 o5: fffff8005febe4d0 sp: 0000000000c37211 ret_pc: 0000=
0000008f62e8
RPC: <of_find_node_opts_by_path+0x8/0x160>
l0: 00000000000286c4 l1: 0000000000c37b50 l2: 0000000000000049 l3: 00000000=
00000080
l4: 0000000000000013 l5: 0000000000000000 l6: 0000000000000000 l7: 00000000=
00000000
i0: 0000000000000000 i1: 0000000000000000 i2: 0000000001010101 i3: 00000000=
80808080
i4: fffff8005febe488 i5: 0000000000000000 i6: 0000000000c372c1 i7: 00000000=
008f7140
I7: <of_alias_scan+0x100/0x240>
Call Trace:
[<00000000008f7140>] of_alias_scan+0x100/0x240
[<0000000000dd6bf0>] prom_build_devicetree+0x18/0x38
[<0000000000ddae9c>] paging_init+0xa4c/0xdb8
[<0000000000dd602c>] setup_arch+0x284/0x6e4
[<0000000000dd2660>] start_kernel+0x54/0x6a0
[<0000000000aa0480>] tlb_fixup_done+0x4c/0x6c
[<000000000016b398>] 0x16b398
Disabling lock debugging due to kernel taint
Caller[00000000008f7140]: of_alias_scan+0x100/0x240
Caller[0000000000dd6bf0]: prom_build_devicetree+0x18/0x38
Caller[0000000000ddae9c]: paging_init+0xa4c/0xdb8
Caller[0000000000dd602c]: setup_arch+0x284/0x6e4
Caller[0000000000dd2660]: start_kernel+0x54/0x6a0
Caller[0000000000aa0480]: tlb_fixup_done+0x4c/0x6c
Caller[000000000016b398]: 0x16b398
Instruction DUMP:
 913a2000
 81c3e008
 913a2000
<c20a0000>
 852a6018
 83286018
 80a08001
 0240000e
 8738a018

Kernel panic - not syncing: Attempted to kill the idle task!
Press Stop-A (L1-A) from sun keyboard or send break
twice on console to return to the boot prom
---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

