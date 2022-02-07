Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B26D4AC4C4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378933AbiBGQAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiBGP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:58:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37624C0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644249493;
        bh=YpdFCDbJxNT+5npMdVj4W7CRcAJgd8nS/UgVE5eC06Q=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QGVAKZZUPI6CCc8knY7+A565smNAO31WmcFvAtpKPiECeWA/bvNMPeIp9b7poaFWW
         E9WuJKOA5kKh1dNqIEiIiae4q7sKeHqmfofaDDcct+7AJcXjZHH8M9SRNFz/aOCrIA
         rNjs6+y+6WUc+I8ak1M8sIpdiTS9eiSPI1oLo2p4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.138.144]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1nYdHx16g4-00HgZp; Mon, 07
 Feb 2022 16:58:13 +0100
Date:   Mon, 7 Feb 2022 16:58:11 +0100
From:   Helge Deller <deller@gmx.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Helge Deller <deller@gmx.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: drivers/video/fbdev/core/fbcon.c:1028:6: warning: variable 'cap'
 set but not used
Message-ID: <YgFBk4PEdsH7ViII@p100>
References: <202202061640.zSayOYxO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202061640.zSayOYxO-lkp@intel.com>
X-Provags-ID: V03:K1:/TymiG6tnIWxhYnLOlfBkWfKgElz77XSnD6uUO420CmNZWJksPJ
 nf8t64l9PmS83Yt2PI2u9qwjxu7PlRjWSFkETbZQZv63IBj7gICNiqG3nBym6fL7R1YBKVP
 ETBAhSXBQfhr82qiZnTaHLW4hBaX1wWKm+C22Kl6ZzT2gQbL9uijJBHg+IfRX+6H8mXjeNJ
 BxJ/LXmZOZerYbOUMpgoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zq0nDKXJqgk=:t0NZ9TJBaiv963nUoFmVTC
 nIGo/NWRfdW1IJmivq7AFy5qlMPO0dXKhuMWwZF9M8qP8pu8N9QSpRU9NriZVI1NZY8Ychi0V
 SxMvAF9XNfcl4otkHL/qSbp7NlJ7aXYdjmm9UMGDnTe7TqBpDYCTm6J4jiY3EDzK2hbdBlazX
 PimxPp/epCsA0kNL8bxNBYMwbUSrv7zx3QvOj/MquXsjAXkeD+EycugOh+NU5KBXy1yazTDZt
 NkKxa9Mgw8DjArq1Alu1q1nV0OOfynAFKFU6aBbUQoOeGPT0BPVGQ/uhwrHIA3b65gwisfE+m
 CU88ExG5MBYBkjA+LPfpFaJ3W6Uls/xDGUiK16K7AbQORv+YegBRLdetzDwMgvTLOLZobH7C0
 +RCC3wRgSliSP7P1R/eS4eg+OhsZWE/Nl5EXQCZFdF/X28shac5Zyww424a7xHRTc02Q0QNjE
 q/XmHYmde+mCb5pj/7L39x+9+6Le1M2mg2qw7QwH5fHpsyL7we5YXCxFu1r1C/khmIEPrqqcM
 4daTzs34sPY1HM+EhhrVi3IjLFREJfQCZgnGoT7+qrBZjTbh0615txVIICFoZs4vaRB2LHJrD
 QrjwaGhYCxT5JDld7JN7H7aj2BGH/kU94GtUQ3LZLuGGO94Bw4aDt5ffn2jHHTyCnsCMzwCTC
 c/d4KS/PNzKQu6V0hk8Bfou6DKQu+8EttqoTc9uyg9VGNqfrua610yIbwJwZDaP1CBTp8sHPZ
 G9Z+bZtfRmPrbSSjn6wiKt3vJX3zgLIXdusFlFMGCrJBGu/PG0zEwk7eRiu+etTnz9HkD4UNp
 3gbSMY2IxKneSBN63pyAi6Ra6JsImhCAs42+NW2RZb2H8M0cvyv2W+pDMthtQEhPGLFut5lea
 3pND1X9gFFueW99Z+gxHHEQzmeVxIuAL/Mg5VrYNUqTzZun9Y6/TiacyBC6+QzZiBdtjFK4eN
 lxpkMMPluipaWRtirOvyvmuB8e6l1DEhiw/yBidS6p3y8UHVS8xaM+2Isr8dTCvWyyLSyL/OW
 d8RSOou2X8QPgkJAuow4WFYa1lGzhzWOsOkj8f3zfnr3X3tfc3NUpjuQyQM7L/RJx6WoeyB0D
 QT4I2Pk6XA/I+Q=
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

* kernel test robot <lkp@intel.com>:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
> head:   90c9e950c0def5c354b4a6154a2ddda3e5f214ac
> commit: a3f781a9d6114c1d1e01defb7aa234dec45d2a5f fbcon: Add option to en=
able legacy hardware acceleration
> date:   4 days ago
> config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20=
220206/202202061640.zSayOYxO-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=3D1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3Da3f781a9d6114c1d1e01defb7aa234dec45d2a5f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel=
/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a3f781a9d6114c1d1e01defb7aa234dec45d2a5f
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash drivers/v=
ideo/fbdev/core/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    drivers/video/fbdev/core/fbcon.c: In function 'fbcon_init':
> >> drivers/video/fbdev/core/fbcon.c:1028:6: warning: variable 'cap' set =
but not used [-Wunused-but-set-variable]
>     1028 |  int cap, ret;
>          |      ^~~

The patch below fixes the issue.
I'll send it to fbdev and dri-devel mailing lists for inclusion...

Helge


=46rom a6a058934de962836df540c93da802171bce00b4 Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Mon, 7 Feb 2022 16:49:21 +0100
Subject: [PATCH] fbcon: Avoid 'cap' set but not used warning

Fix this kernel test robot warning:

  drivers/video/fbdev/core/fbcon.c: In function 'fbcon_init':
  drivers/video/fbdev/core/fbcon.c:1028:6: warning: variable 'cap' set but=
 not used [-Wunused-but-set-variable]

The cap variable is only used when CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCEL=
ERATION
is enabled. Drop the temporary variable and use info->flags instead.

Fixes: 87ab9f6b7417 ("Revert "fbcon: Disable accelerated scrolling")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/f=
bcon.c
index f36829eeb5a9..2fc1b80a26ad 100644
=2D-- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1025,7 +1025,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	struct vc_data *svc =3D *default_mode;
 	struct fbcon_display *t, *p =3D &fb_display[vc->vc_num];
 	int logo =3D 1, new_rows, new_cols, rows, cols;
-	int cap, ret;
+	int ret;

 	if (WARN_ON(info_idx =3D=3D -1))
 	    return;
@@ -1034,7 +1034,6 @@ static void fbcon_init(struct vc_data *vc, int init)
 		con2fb_map[vc->vc_num] =3D info_idx;

 	info =3D registered_fb[con2fb_map[vc->vc_num]];
-	cap =3D info->flags;

 	if (logo_shown < 0 && console_loglevel <=3D CONSOLE_LOGLEVEL_QUIET)
 		logo_shown =3D FBCON_LOGO_DONTSHOW;
@@ -1137,8 +1136,8 @@ static void fbcon_init(struct vc_data *vc, int init)
 	ops->graphics =3D 0;

 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
-	if ((cap & FBINFO_HWACCEL_COPYAREA) &&
-	    !(cap & FBINFO_HWACCEL_DISABLED))
+	if ((info->flags & FBINFO_HWACCEL_COPYAREA) &&
+	    !(info->flags & FBINFO_HWACCEL_DISABLED))
 		p->scrollmode =3D SCROLL_MOVE;
 	else /* default to something safe */
 		p->scrollmode =3D SCROLL_REDRAW;





