Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FEA468D3D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbhLEU1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 15:27:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:54977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238568AbhLEU1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 15:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638735813;
        bh=WkWTELYlqFLAPcpyS4Agwyk51L87dWiMP28hI/XDwWw=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=HEjLvoNAq5vMyMJLe3B3vdYvZVv/vP6vfNU86hqbkYX25qxRVOOwC86p8Iw0EMp+x
         Xd5LfNMhiQZ7zHri3Tsp+Thyru8r1iMI4/sdwm57sd5pW261eUEpmXGrakqmK3tATC
         PtU+nrdKIjPQMoLwj+/aZiVM6HzzQJsvn2CwICPk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.186.88]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wyy-1mxFIn0gA0-005b7l; Sun, 05
 Dec 2021 21:23:33 +0100
Date:   Sun, 5 Dec 2021 21:23:23 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture bug and warning fixes for kernel
 v5.16-rc4
Message-ID: <Ya0fu9qlJFsBdjWF@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:YZUMYgukK6NS6kfAeeFrNDMMbVRJH3jqjpltzcu4Vs2xg2h2WJ7
 doCNN8NYJwUb7Doojqp06uN9YqKV28qoQHZQ4BE1V10Jxf3i70ILAiIb1yRq+3oR7ZBMv5H
 Qdu26sUoNCmRyl+0+kXpNChoI5sM88soDwZV1D7Jb1RjO4FCnpJi0CPZxUB/IcjuhLmmU/g
 6kaOJ/VkxDhctaHvamJtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tk0l419QZqU=:Ud3LD/XTaaytAREc5ExeSg
 UZ5wugEzqehdAEDWDtjD1IWAO1bk1G9IT/NtzMh8WOgcXTSQlLGhDby8vXBD1e1KSp0XjBKBX
 4qvf9l+sAkkHMZSJmMFXZNVg+6IKlD94KHjHU0QpC2zyzsbsrsdUEXlCLqtnA6YcWm6IkfUm5
 lASINhxz5e1wUsQpABkmlwAPJXHbnx38uduThBwAgItg+wXzVCcIkAWcdULTX/YTeTJuHA//Y
 vcXS87hW6idxQEao4gC3cBRlPzmKKHmrMnJgBlGe4701N3A3wqTJITGKLfjS5EBSAbtSdaqmQ
 KQxUxu8McQD6kLW4dSQUTR82hV6HoWHKewo2ps0iy0xdTjYme0RdjigsHQepczoxBGL6phgLZ
 AhcZ1JFXeqLK8xPy6P0CCYgJ1XdN5XF93uvcHoqpTxJqIH0jJsSYT566r4LXpClubza7sv0vj
 b/aZTNh7Gt81PyIIthZvD/qr426ywY+H5tUPvEmMD1CggpJA0ntAY8YvmO3cQZv+z7SQFGhzg
 FgcUeexxTUkyZMxQNnjofID7xXjiE4Y2R4FguNABsZDPHTGYDYLhxU/soUSE8PocK5Vlk5/w0
 x4DJT1T2kNQNydDcVfFe4JB79E+N5SFsWdYZWb2mbYpWBw5ESmKeJMseqFEMYhR2oFY4pCY1z
 59bsDI5sF2GCY5FBOUdY/tp4Xh+VAah337prkQcrQLSBck291IP3YY+ykGVTb0LQosjt9Cx/h
 J78ylITJVBDxpPp/Hf3Fsj5lFKbR61Nf2XDCJj4Byl4Gom+QPvhQpIWlLKbs4C8wgt5usSf5d
 hXruqtz7xi+VvLEOnV+oP8FfKo1JwEsDEhPR9TBv/9VmIyR/KczPh/Ed6wfoVpKC4lGUnTTDo
 OdMpBazgST5j5bdgM+3GHZyAP0l2uY4lq078E47ToenKq23WwEHKK66vHnYQvufmdTSKKjyrF
 RrtBt7ytbCOkYKDmfgfXF1E8MXNlzxROs8o0FTGXWrA8j06oqT5/PN/5Z1k415jals80GkaEW
 lWqoRs/iX5jRcZWgICubFW0A/0RtFl7nqqdE5NFfSCgoF6UbzOFDYMy0JvTALObfvfSRgXVow
 qV4yvmtspVvPdY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-6

for you to fetch changes up to afdb4a5b1d340e4afffc65daa21cc71890d7d589:

  parisc: Mark cr16 CPU clocksource unstable on all SMP machines (2021-12-04 21:36:04 +0100)

----------------------------------------------------------------
parisc architecture bug and warning fixes for kernel v5.16-rc4

Some bug and warning fixes:
- Fix "make install" to use debians "installkernel" script which is now in /usr/sbin
- Fix the bindeb-pkg make target by giving the correct KBUILD_IMAGE file name
- Fix compiler warnings by annotating parisc agp init functions with __init
- Fix timekeeping on SMP machines with dual-core CPUs
- Enable some more config options in the 64-bit defconfig

----------------------------------------------------------------
Helge Deller (5):
      parisc: Fix KBUILD_IMAGE for self-extracting kernel
      parisc: Enable sata sil, audit and usb support on 64-bit defconfig
      parisc/agp: Annotate parisc agp init functions with __init
      parisc: Fix "make install" on newer debian releases
      parisc: Mark cr16 CPU clocksource unstable on all SMP machines

 arch/parisc/Makefile                        |  5 +++++
 arch/parisc/configs/generic-64bit_defconfig | 14 +++++++++++++-
 arch/parisc/install.sh                      |  1 +
 arch/parisc/kernel/time.c                   | 30 ++++++++---------------------
 drivers/char/agp/parisc-agp.c               |  6 +++---
 5 files changed, 30 insertions(+), 26 deletions(-)

