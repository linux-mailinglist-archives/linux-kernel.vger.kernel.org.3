Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6469F59E96B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiHWR13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiHWRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:25:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A01BCCF3;
        Tue, 23 Aug 2022 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661267042;
        bh=7bJP14sFItK6YJZyN6IGs69JI9dSphEw3bIjj5uY7Js=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=EwsWS/sRoKg/7FY7tpMg5Ys1QxcY3SuUeoG0+Z+rZ32Hf0ErkPXZocs8Es7sgbpxc
         LL6h1ZCFA+iit0Zbazh+iGSDw7AKLadw4PdSG5fWPTQD3qa4Xs0xz41JT6Q3m8OCFp
         9Wec7KEBDg7Il4ge4X9yl1HkqhrXL2MT1JiSC7eM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.140.137]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1pCCGK15NO-00oBkR; Tue, 23
 Aug 2022 17:04:02 +0200
Date:   Tue, 23 Aug 2022 17:03:59 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes and updates for v6.0-rc3
Message-ID: <YwTsX8zR7x09qWP5@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:bFY2MFMKeDDjoBohbmha6DvTZHUNu3OimL202WcU5RYkE1Qisma
 pseYFOi/y1NY5VFsaOLOqZZAzsWHXL3M0t0fSEXClucsjtAqV84jno7ckWSn/G9iilhUXJv
 ijvQcVX2IXLThQlZGrmssL4KwfdenjXDHoQXX2vqcnrsBmHT0tX4IvZ0Qwj03L6EP5Fpcgx
 +nmb8iGppC4rmaa8CArAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oe//FWAw0tc=:FHJeuJGPFgj/98+MgPtevy
 9lzKmzQePeuJm94DMf24zZz5iXcn5k99L5g2MAko6DHUZMg0RFU9h/eeyR6SAiLTXSVWsNaDY
 UVfdejflIJCXWi5vQz4d4yo/XNKl4ZDKBhSRqQCLUzFBWOkF+UNdMw056rg8KXruD/HbO5/Ad
 FWHGHZnbSBfv6WQl2vPytIIwTxpfuEOEqHrdqEpfnQJM2Ez0KEFbun+K/n9xsMEOHRofX/luH
 tMmRVfGJL6LLRVte/b+u2Vf2Fsap7BUC+OFQ/FasRoyIGYRLMbGWkQ9l/n+8IDTOMEjd3Um50
 NFP0LJJrkp7kOWBoVQ6L1F9gf//Sj/lvb8mZnZrRfirVOGn4fWoCCHkN+dKcH80rObJ5gFaMS
 pTeZeHOr/cYtk312amHy1R1fKn+dLXW/ArMXPlu9xUqi3Mg0zqqeJH0XudWliR45zOiOehZv8
 FfQtp9eBajZwaryNKk4vyn9AQA0YMJT+6EJBYEX1Wm/8HXwCoPkaSLeupzr8ce3HC63Z+Cf/q
 vaPx4c9+QIITUWdzMgwbUbpekB6SafMcR/3ZnaDIkTdfYb3+UB6ZYbLtghL+usqCLz70jk0yy
 JH4dabAFagz3SPn7bkkHFMkLwWBBCGZCfAKDJLTJ68yx3PfsolheZa7PXIptzVzHXzahp8u6U
 aZxs/XqmZninue8hFqldydFDJT67dtkcSmhJ3o8F/+utdv0PS3szbqtz0UJzaMBxLs7Ma4j7K
 kKejJQbz2l9AJI1yQSyNXesSkIfNFPm5FZF78J8qUCHApGunqJSDxxZ0vNSbXxaqP/VYdYzFq
 lA0vPPj2tnNFKANGDf/V76ry5cILZBkQTRkbquk6dxce6veWCM0Zk19co1P21Z2/vA8Uf5Pi9
 FmgADpJaOw9PG0VL92E+02k2RdL1tVyuBbsrlK+nh7f5Vw16rcbUQvScxB6HLJFS5A6tZy5TT
 qwFsz5mXg/g7lgxAyLszNgC6AeX6WmBEjt+qdwRrypKAxp1+RxN7ONbF+89PI7a2DwyIoWy/G
 aRMiTy84pZgdmD0ByRIujiiMNWB8qS9VrbEF/j6MKFQABCwhIiekwcD/vF/l6CYlcezV8vPgL
 6EKRQSQNt/6Y7dEcMU4s3yhGzsSWaYw0mF+zld8BIZkDd/HCMBEJHadLg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the next set of patches for the parisc architecture for 6.0-rc2.

Some interesting background to the current patchset:

It turned out that the fldw instruction (which loads a 32-bit word from memory
into one half of a FP register) failed on unaligned addresses and even trashed
some other random FP register instead. It's a trivial one-liner fix in the
exception handler but this failure dates back to the very beginnings of the
parisc-port. It's strange that it was never noticed before.

Another patch fixes an annoyance noticed by Randy Dunlap. Running "make
ARCH=parisc64 randconfig" always returned a 32-bit config, although one would
expect a 64-bit config.  Masahiro Yamada suggested to mimik sparc Kconfig code,
which fixed the issue nicely. This allowed to drop some compiler build checks
too.

Third, it's possible to build an optimized 32-bit kernel for PA8X00 (64-bit)
CPUs, which then wouldn't start on 32-bit-only (PA1.x) machines. I've added a
bootup check which prevents that and which prints a message to the console.
This can be tested with qemu, which currently only supports 32-bit emulation.

The other patches are usual clean-up stuff like added return value checks and
typo fixes in comments.

Thanks,
Helge

-----

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.0-2

for you to fetch changes up to 591d2108f3abc4db9f9073cae37cf3591fd250d6:

  parisc: Add runtime check to prevent PA2.0 kernels on PA1.x machines (2022-08-22 11:09:17 +0200)

----------------------------------------------------------------
parisc architecture fixes and updates for kernel v6.0-rc3:

* Fix emulation of fldw instruction on unaligned addresses
* Fix "make ARCH=parisc64 randconfig" to return a 64-bit config
* Prevent boot if trying to boot a 32-bit kernel compiled for PA8X00
  CPUs on 32-bit only machines
* ccio-dma: Handle kmalloc failure in ccio_init_resources()

----------------------------------------------------------------
Helge Deller (4):
      parisc: Fix exception handler for fldw and fstw instructions
      parisc: Make CONFIG_64BIT available for ARCH=parisc64 only
      Revert "parisc: Show error if wrong 32/64-bit compiler is being used"
      parisc: Add runtime check to prevent PA2.0 kernels on PA1.x machines

Jason Wang (1):
      parisc: ccio-dma: Fix typo in comment

Li Qiong (1):
      parisc: ccio-dma: Handle kmalloc failure in ccio_init_resources()

Wolfram Sang (1):
      parisc: led: Move from strlcpy with unused retval to strscpy

 arch/parisc/Kconfig              | 21 ++++++--------------
 arch/parisc/include/asm/bitops.h |  8 --------
 arch/parisc/kernel/head.S        | 43 +++++++++++++++++++++++++++++++++++++++-
 arch/parisc/kernel/unaligned.c   |  2 +-
 drivers/parisc/ccio-dma.c        | 13 ++++++++----
 drivers/parisc/led.c             |  2 +-
 6 files changed, 59 insertions(+), 30 deletions(-)
