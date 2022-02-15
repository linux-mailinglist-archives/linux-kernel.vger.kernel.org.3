Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2714B70CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiBOPCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:02:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbiBOPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:02:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175351EAEA;
        Tue, 15 Feb 2022 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644937342;
        bh=wa0JzlxCJP6FT5B/WCabwme/3GDUXb4BZx1q77XkiJo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=SiTvSscv6dsdawlwf4tFoOkjjTPVTbRjj0QB6vLWukFyKr5wWNtUY6annljpvpmFP
         CVm9ZKEXV6b1+qsH5fPHBiE8Azi1Lg5J4gFa5b3FbXSbkcMEpXS4cYMmy82VGvlBW5
         4cS28SVa36iP5bQ/+AsU+Vg3emvXJKr+YmRvyvsc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.185.100]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1nvH661irQ-00g0c6; Tue, 15
 Feb 2022 16:02:22 +0100
Date:   Tue, 15 Feb 2022 16:02:13 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] parisc architecture fixes for v5.17-rc5
Message-ID: <YgvAdaab22aRk18r@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:DthRBr0+MoN09uePx4rSBjbxJokAu2S8IlkuYcCYYFARHNUAbKy
 wp4L2PL+wr4lhHp0w+0xRq0hPodpMEbUhnP+PbWh5Fqij6V0jZeN4anS8PCeNENbjJjhc68
 DVfIg5YGY7gnSkG7biN7cVBVztGn9yLLljLvqzHnnaKs9VB/irbMZGP6fFl4tUGX/gJFNFC
 01QWimEyQXjDskCDNGaXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:27VC9SX74C4=:6H6fUQrVJQp9H0Y1RavvB0
 VdWbD6a5+2pigzcLDa6kyTAG5IxFeZhdU9QOWeWUNmgbPyid8iSkfEm7R5D8woc+S3qZyxDVz
 sHAA/sManypw+g2BnWeqvrXfB2Dpiy73YGcwc5o6/7akFHQTXm/L05JexqCRE4ZhdhMfXtBak
 XJ6FMLknTbQrtNBiUu36Mpn29NeqLdYy5ydzsPeoj0AJx8xlib9RtaORuZQvcpX1qJix7Szqd
 4N3lm1HqE/V9+JKAd6Lo1k9P1CxYV8CYVaU2F6wOun0JwESdYyOM3bJvhptPmo1aCOvA5Fgc3
 ARhA4aZQKlBWZiu+f/uhk8PKVnTfud5Muz/uG8uuYy75YQn+sZS9QLVI3sBFcFxcxcwGFuyZU
 4Q3998pphriykn/XT2PRuBbA5danZuU2ArYOHWHYx3hs3JSRWmchlHgOpYtm6wMeC4EHwLWZl
 x5x8ZhgynQdrTvQUV+U+KB63sabRRlY0GHVbvsfgGkq6J70Y93siQf6l+SHE7W/ulI0VN6ePu
 ZkvyYT6MRcN0djJ3HiDGc4m202PdZ7QUD/RrIFJu7JC0z/ikksngDcaitmoIxm10Kb+/EmUxi
 uo6rUXHMYnNKhFwBnK6fLPiBQrdjRoHsi2uSuCQ0OuFbnXrSmM7Igkh4POElY27FyEJeANKcI
 DFC0IjycWOdy7LwnZD2DGIZiUq1xWV4XY8taXlyPGK4aJSTyrr95u2KYKNaGwoaiZEV2h2AI6
 J4+18lNu9YMGIcqw1t7dMzBMBIKKGewEKG3yPbBF/IS0kQU6hV8XNYF85tbRZic/qbWOTkaVU
 HeY/Lkw9z/x4vIee+AIwP/5LBZDo01zIv1EFWlWDKcJTLYdZAUFvDkyq4fp+jVGrz9csv4GSv
 zbPi9QEnMd5+iaecB0pA/3gzMVFbDBjj/lXevld9q40o3JMWk6Iz2JAFVWsnznpp4i3uy/nFp
 lUSs0O+v/iCN0Rp664cpcFVR3+2rkOxCMxVXzwi5+WCdTuzkhewzlpV8Z+LAhLg2uk22ornB3
 BqdpsOrl82tpfgmpA97347FbGM76eqq6ww+GXIjD4/OgPUhELytIa+8w4musSH8KLMbhaDMXp
 nwmviLutDGsvxI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-3

for you to fetch changes up to 6e8793674bb0d1135ca0e5c9f7e16fecbf815926:

  serial: parisc: GSC: fix build when IOSAPIC is not set (2022-02-14 19:34:42 +0100)

----------------------------------------------------------------
parisc architecture fixes for kernel v5.17-rc5

- Fix miscompilations when function calls are made from inside a
  put_user() call
- Drop __init from map_pages() declaration to avoid random boot crashes
- Added #error messages if a 64-bit compiler was used to build a 32-bit
  kernel (and vice versa)
- Fix out-of-bound data TLB miss faults in sba_iommu and ccio-dma
  drivers
- Add ioread64_lo_hi() and iowrite64_lo_hi() functions to avoid kernel
  test robot errors
- Fix link failure when 8250_gsc driver is built without CONFIG_IOSAPIC

----------------------------------------------------------------
Andy Shevchenko (1):
      parisc: Add ioread64_lo_hi() and iowrite64_lo_hi()

Helge Deller (2):
      parisc: Show error if wrong 32/64-bit compiler is being used
      parisc: Fix some apparent put_user() failures

John David Anglin (3):
      parisc: Drop __init from map_pages declaration
      parisc: Fix data TLB miss in sba_unmap_sg
      parisc: Fix sglist access in ccio-dma.c

Randy Dunlap (1):
      serial: parisc: GSC: fix build when IOSAPIC is not set

 arch/parisc/include/asm/bitops.h   |  8 ++++++++
 arch/parisc/include/asm/uaccess.h  | 29 +++++++++++++++--------------
 arch/parisc/lib/iomap.c            | 18 ++++++++++++++++++
 arch/parisc/mm/init.c              |  9 ++++-----
 drivers/parisc/ccio-dma.c          |  3 ++-
 drivers/parisc/sba_iommu.c         |  3 ++-
 drivers/tty/serial/8250/8250_gsc.c |  2 +-
 7 files changed, 50 insertions(+), 22 deletions(-)
