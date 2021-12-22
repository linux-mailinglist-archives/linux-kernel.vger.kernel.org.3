Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1CD47D4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhLVQH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:07:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:52681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhLVQH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640189238;
        bh=ncE+mOXnSthAcQ1KZXNycs2z3ZclDM18WgWWRTJcbc0=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Bh4l5IMNScrxXomC+fgn8pp6kKNVpTAK4AgSJ+HeKe4poDqR4X8aww5HTXRKnPGCl
         634r1FCGVP9Ssod0TXyR4hvjze2ozMFfsvfyKRqFDSNF9QeiJauhHweczGRRrDzMsg
         uQLcTCuesx2Ws/XW6n2zzABg1d7jx3j93JTBS2m0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.131.34]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWics-1mxqAA1IgC-00X0Yl; Wed, 22
 Dec 2021 17:07:18 +0100
Date:   Wed, 22 Dec 2021 17:07:09 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture late bug fixes for kernel v5.16
Message-ID: <YcNNLXIZbUl/jvwX@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:jVVGh4lBPWuACTelezXPj2n3gMlQeEoGodDyokJjimylOLujhDW
 9HOKd8aBfDdRFzNTCtmzyzSdgM/zNxx9IRmx4RnedLqJictwNBIpq2L4JV8mjbaNT3yTlbU
 CXumFZGs9EgzQBmIe3NgalFwqPzszKOYtx3O3jGMS/hJJavur+1BQXNCsyxepiHCkdawHxu
 znk8ZAgHwlhDmz7Va9VLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q8xI/0Yup8A=:NXlLU6OJHKAb5utiecRpnc
 RaUHONGueq46keLsVbHIVmVuI3mfITC7D8ZJugOmbThbVe30xzTd7R7HNEw69nQVL0oZGVOnj
 DH9TK8z2ZbaWpw1Dr91qs1CLeycJJW4S0ketQbGLEt3H2DLEbH5+MFQ8QFgU0FNFXohXg8pL7
 IB1oKmEY4P3Mb+TwqzoOOYOh4aeo0fOS6LzNi971zS4RZ6L2sP7QU8sPIFNgTZztp+v3q2G28
 FQeB1UAe1HNWsqNMm+7Vlxz1nNo5XvSUiFzmn/aZcHbmJ1AP6+crzERoUtdDZ/SVPbEXcIitd
 5vmsZOIrufBsrCwi8H3HgUkDLp00m1sld1UquV8kP1Nwl+ITRqzrTemdFXVue28lHx0bE4x2q
 rLx+VXXcSvnK1HGcpKPrW6oxPRM4CcCv30CsmfrPu6NLfxXRmWXIgh5czf9BBDp5IsYsvcyTm
 nV/WuJK6gzdl6MaPDwdMIIzBIJeOjqvoZgkL2aJUcIcl4woPIahCpsAH4bvkfoPuVEGimNlP5
 rAAPSbarPz7ogxpp6h9up/LMRzHX0BxXXfHP4tdQOgQvX4N5C2aixVWZTMSrwZ9kYUUf5XGPq
 +f19GF54RzLeMqNrFyj5npUEQ9l5wlfkgpJT/kIfV08dJkdLq6JTdciIEjQ4BAmmXJLucf5IQ
 yzIVvfOA7/kU1n5FZfly8mEQodJpxlV2D0tsj/iJZhpS9FyWEIV0Q/JWRbhH5rcerU1dPjNa5
 tAmbYB5OPGJc7+Po2gRdYbyixxd04VyKhQM3ZefQMxMefuBHKoRrztNsHPamnuchhCPWbxpJ3
 xXqVAaymaE88Qzxoq+ufaYxuAn9s6pUjFyAAG2xRhSbeVTZ/XpaOzUSl9iN4vSLV+ttwuhaRT
 jyTsKpeHBq0UEn2P6NfsyVvasLleRA7I9/uc3eHy7DTe2y0GcVvLXSFoRd1JYTDdeuZfN2VpE
 DsnSHwUcpxCKecLEY2NdFPHJ1AkG7Q3/DLrwo+hWLgVAID+Z6jRO9dVC85gyFCM2/HEeLOI3X
 AEHTexyATD2N4gp/3WYibrARtIvklGz/BfDNWk5MHkuKaJbUXZRW7SH7oJosJQFinVzEpS/Ym
 VAkunw+WYdTa2M=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:

  Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-7

for you to fetch changes up to aacb2016063dfa6da9378d76734cd9dc1e977619:

  parisc: remove ARCH_DEFCONFIG (2021-12-22 09:02:10 +0100)

----------------------------------------------------------------
parisc architecture late bug fixes for kernel v5.16

- Fix a bug in the C code which calculates the relevant futex spinlock based on
  the futex virtual address. In some cases a wrong spinlock (compared to what
  is calculated in the assembly code path) was choosen which then can lead to
  deadlocks.

- The 64-bit kernel missed to clip the LWS number in the Light-weight-syscall
  path for 32-bit processes.

- Prevent CPU register dump to show stale value in IIR register on access rights traps.

- Remove unused ARCH_DEFCONFIG entries.

----------------------------------------------------------------
Helge Deller (1):
      parisc: Clear stale IIR value on instruction access rights trap

John David Anglin (2):
      parisc: Correct completer in lws start
      parisc: Fix mask used to select futex spinlock

Masahiro Yamada (1):
      parisc: remove ARCH_DEFCONFIG

 arch/parisc/Kconfig             | 5 -----
 arch/parisc/include/asm/futex.h | 4 ++--
 arch/parisc/kernel/syscall.S    | 2 +-
 arch/parisc/kernel/traps.c      | 2 ++
 4 files changed, 5 insertions(+), 8 deletions(-)
