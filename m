Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ACF5387D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbiE3Toe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiE3Toc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:44:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C37378B;
        Mon, 30 May 2022 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653939865;
        bh=9cmrvCRTdgXaup6Nc51jhXQLb5o1bU8es4kMpmpQUeU=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=PX4+QIVmbFbqVxJY9Upeo6loo+EQC9OILx1a6Eza4o/dm4wCBm51hLX+ihEd4RXFr
         tFV57Z9OCZ5lYgbEmfV147t4zcZi2ZxM3blpp3Bsb54NSujwhh4byZs6JbmQtGl/Qt
         tQw82dNvC6sKklfIsnZvM7voV3cvp0oqcsgyYz1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.163.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1nLs473SHH-00bGtt; Mon, 30
 May 2022 21:44:24 +0200
Date:   Mon, 30 May 2022 21:44:08 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev updates & fixes for v5.19-rc1
Message-ID: <YpUeiCcb0ntt7wct@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:NIiHrl8+99HDFndqQ4eAHjEOWGUJ6ZR9dfFwtTRsiV6jUjHuQM4
 98addmh+DJXAOrkJVdSKVLJGn/IeJsCP5VJQDnDvDHTJdOx7ntFwvfXOIjtXJJIEztgXxGb
 IDO2gWWAyLCiO1gbmj8chSL0sElA7+HhnodCHemBYPiToJdIL2CCMEhTLL0TKLahhJLxuZa
 MFvvxCmMHEymoEQ1vCjVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1qOfKNMH/l4=:l6l1bQdjImuctlhMGbESh4
 J8r8yCr3I/oezt0iAtFK9tvXbpv21Kwpu4+Fx3SOaEgk+kZefuP2bBRfhSwDl5p6m7Yk2R751
 XBB1yfy0I9vNs91OcCjOBnscx4H7akk9nNZDArzOgift8tBTRVHpea/B83GfxOXNnzH9uDhup
 bPXsYmTjOpDL/EBJMN8UcDM/OOibisvyW5+aKfjIdwwi8P+UzzEK+OH5DEjRFuMi7f7vY0S7G
 a66ai6kl+xVyK/FP+s8x88njXEk2YX0hunptr+M+BokmF+FU5T/CAevhVfFhUMRy8+ReT9C7b
 ty6imZRXK7WGHFKhPyAOUvzHQECIg5i+Ia2R+gljZaYWCg1wc10dXI1gKJJ9Spt/HYP4hkYNo
 vphzdLbHQVtlfiCJt9sS/hhMBcgbTMyz4jUPbs42cRQ3U71bm/LouurXY1SQE0KTXKxP+7/wL
 EMngrRYnPZGd5t5u5G6SMBDS6Yne3foNfFfHzP/b7U8vN1d8UsjDc7qtLVZAzumTnfekz228u
 MRIxpAkY+fyGbblLKGdepaS/YUT/UoGcWIePo0PQw14EpOBUDrnl0pI1yUUEbhVdRRNYUn4AU
 T1wdcFO+v5n4xd9DQjez1TTPM1eBu5gMg+MVvGANkXm7537MXqdGfZxaXM96UVWokkenmDYt0
 6k8QQVD14uTkbBdek2l57g1meglR5pFPoJJzVvgKoN0kxwclALMIE5wEP8gMaFBvCcNSyhLFe
 51gmlgPMuCojmLwjzioAZsUZS12d5dftcnxVDSHsO9WKgpzCMmgHBJyBzcN3ekVG4ohFIISsq
 kRb39aSWMO7YZbvMni53Clg9mv0Ig8GeUgMIeqa8n83dcmkDbG6yij7gHCzlnn0N0IKaFbpGV
 /h826F95xfRV5M4tduCHSqPX5CTPPNPJqFI6R2y0dubqhVrDZaSGJnIjFhnFKDsQa5hn+5Tuq
 4fsWVjXvfgAEoOscLL86oJxNLT/PJnIrnccokuvcsW/XhIKeMY+R7g27dNu71FuKTa4pO3HZA
 DnrDmI37ZOQLamBV5aNG5rslhPZ3C+LAdh2mI40PAch1LJtUzv0OKzzoo0vQ2VucAzipPIWiy
 ozrgbnE+tCKyvi4pFdPAvehwiWvlbLC+oKBgp9qhnJNlUMSPbhQxRFr6w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.19/fbdev-1

for you to fetch changes up to 79b66128f13f5c22dea03a2197495c4b96ab31f5:

  video: fbdev: omap: Add prototype for hwa742_update_window_async() (2022-05-29 10:20:15 +0200)

----------------------------------------------------------------
fbdev fixes and updates for kernel v5.19-rc1

A buch of small fixes and cleanups, including:

- vesafb: Fix a use-after-free due early fb_info cleanup
- clcdfb: Fix refcount leak in clcdfb_of_vram_setup
- hyperv_fb: Allow resolutions with size > 64 MB for Gen1
- pxa3xx-gcu: release the resources correctly in pxa3xx_gcu_probe/remove()
- omapfb: Prevent compiler warning regarding hwa742_update_window_async()

----------------------------------------------------------------
Helge Deller (1):
      video: fbdev: omap: Add prototype for hwa742_update_window_async()

Javier Martinez Canillas (1):
      video: fbdev: vesafb: Fix a use-after-free due early fb_info cleanup

Miaoqian Lin (1):
      video: fbdev: clcdfb: Fix refcount leak in clcdfb_of_vram_setup

Minghao Chi (2):
      video: fbdev: omapfb: simplify the return expression of dsi_init_pll_data()
      video: fbdev: omapfb: simplify the return expression of nec_8048_connect()

Saurabh Sengar (1):
      video: fbdev: hyperv_fb: Allow resolutions with size > 64 MB for Gen1

Tom Rix (1):
      video: fbdev: xen: remove setting of 'transp' parameter

Yang Yingliang (1):
      video: fbdev: pxa3xx-gcu: release the resources correctly in pxa3xx_gcu_probe/remove()

pengfuyuan (1):
      video: fbdev: radeon: Fix spelling typo in comment

 drivers/video/fbdev/amba-clcd.c                       |  5 ++++-
 drivers/video/fbdev/hyperv_fb.c                       | 19 +------------------
 drivers/video/fbdev/omap/omapfb.h                     |  4 ++++
 .../omap2/omapfb/displays/panel-nec-nl8048hl11.c      |  7 +------
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c       |  8 +-------
 drivers/video/fbdev/pxa3xx-gcu.c                      | 12 +++++++-----
 drivers/video/fbdev/vesafb.c                          |  5 +++--
 drivers/video/fbdev/xen-fbfront.c                     |  1 -
 include/video/radeon.h                                |  2 +-
 9 files changed, 22 insertions(+), 41 deletions(-)
