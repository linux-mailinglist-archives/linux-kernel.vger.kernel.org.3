Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEFE537014
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiE2GsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiE2GsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:48:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4247857B09;
        Sat, 28 May 2022 23:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653806887;
        bh=p1d8gsvdZRJvpdzFJmwIHUfdLza0gG/lornWj/O9A0s=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=GGwBExcfGkL1sh9oeYKf1qDYdRDyiN0c5hL8Aj5WJBqoZoP+s9WTY59CGcxafpGwj
         VEe3h8qPYLzG2vpkkuzHyIRN1UgGeWPiK0OVXav9Oqzdaz9urcSzd9nT6E3h54HVbF
         +taf/YmzCwZBP0PzXJdXKCCxo/pSE6uytj7kfyMQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.164.227]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1ngHvs0J6F-00v5M9; Sun, 29
 May 2022 08:48:07 +0200
Date:   Sun, 29 May 2022 08:47:51 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-omap@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Imre Deak <imre.deak@solidboot.com>,
        Trilok Soni <soni.trilok@gmail.com>
Subject: [PATCH] video: fbdev: omap: Add prototype for
 hwa742_update_window_async() to avoid build warning
Message-ID: <YpMXF9luBc4Sjr9h@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:FQb6lV/lgtWGi2gKjPz07Vslk0s1gCvq650guPHsNS97s10CCmF
 knxWpCyOY+gOAN5vFh6NjPmJadgrrS37YPARbom/08c+CldDAjK6D32IjlDtl3z5y8Iy6i7
 xBvUGGn26Kg0cYVzrANxZLMGqSxIIrFVATNA56yE7eIXH3N0NpKjN7Y6WNmozCaMeOnzw/0
 Ip1gXRwkd5fEo9mTGig0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vd2rMaVrGb4=:GEyCfahcwao0DK5RE6qCkA
 YxyXP5yVGGaNvc4VsKgWnguSEIFnM6yVA9n8ljEIFVN284bfRzqK/FEPAFkgEQUNKxArxdh22
 UqQutrJYJJ/KmFWkNaT9zc+BqVNekNqkoiZQ2zwF+SYRASY76X+CavD5kvzSHjRXqGkEH9NS3
 sLW07NoXroAmJaWhabGZl2IgrWVTiUCSwiVd+aWl9zerXWKPO4pDT68pnzw8fqKJ0jR2RcARn
 L0X7JwwAMOIyNlw2xe2KqV77E5ZoU+QJflB9h1/myHzEDmH/huZ2Dwd+tAljEmyDevRUbhWJf
 54CK8KphaZ3Y/sLzeOP/OO9Md88fmPMcjLNvfi8mqyMeA1IYZ/800SBbCcWg8mJTqp7XwoJhJ
 fLcvLEmnjjgr4xMGJXhNQyMhA7oTkJS2hjha8mwgQkl6PC4FnUhMg6hOJ81tZ7mDEQJbvw/kg
 4LEHaa//Ji49eby/8WVdTlwrM7EsX8OnysSleYWVTBLqKL1Eg5sC0f4lk/afrTLS00wYMNQNt
 i86neGHdwe+MnS/RkGoxRXJ36nsWIzHHFuX2onmGbnGjFjOp3YkoLswMvxKG/lfpB/AqpRCbe
 yqL9JZ5iwCax9NcQnLcWJXVX4KFZiOrDjh5uBRtC6NgNwc4ZJJ3LT7EdDycFJrhllnn3zZEVt
 fmhxtV6ZUEFD3WZ+pAT4ZdedJ4x8nNKn1ZIdKbY0WgGacO3CSISuwLQQaGhcbtzuNmc9YeLzg
 DTHTC6yl7V/PY42SoHP2jGc1D9EORK+628L4RzAqB2AJR/mWk4H600oejukyMORCJnUf2s40E
 On1w9WayGJ68RaqctcxPESPGRHNnWHpQdIs3oXkpjLVlTPYuY9Xg4QrvHu7qdKLA74TFcLX8l
 XhUEhQdQKkYGZnk4+JQL9E+wFf4ks73rp3XYPRceZtvvjfJ2uDEkKmzokNk7HIawjlON5mhtK
 gkOeZWZ3LLglc3oMkbHhDtpeApgIJR5rm52029NJuKW4cVr76YkSY+fXVjNvsfiShhNVusCSy
 SOTqCUXWdrYq1mkhvmAve2luXhXJC1JBzCRbAeFyNRXTMY5H/eGjYZr5lYx7GJLJTwf3eX+SR
 112n0D8S6E6kWAoeXWuMeV4BP0JUcsO0GxdAEBhMHvqKE4OOYRF+8Vc3g==
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

The symbol hwa742_update_window_async() is exported, but there is no
prototype defined for it. That's why gcc complains:

drivers-video-fbdev-omap-hwa742.c:warning:no-previous-prototype-for-hwa742=
_update_window_async

Add the prototype, but I wonder if we couldn't drop exporting the symbol
instead. Since omapfb_update_window_async() is exported the same way,
are there any users outside of the tree?

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/omap/omapfb.h b/drivers/video/fbdev/omap/=
omapfb.h
index d930152c289c..0c753ccbc1c0 100644
=2D-- a/drivers/video/fbdev/omap/omapfb.h
+++ b/drivers/video/fbdev/omap/omapfb.h
@@ -229,5 +229,9 @@ extern int  omapfb_update_window_async(struct fb_info =
*fbi,
 				       struct omapfb_update_window *win,
 				       void (*callback)(void *),
 				       void *callback_data);
+extern int  hwa742_update_window_async(struct fb_info *fbi,
+				       struct omapfb_update_window *win,
+				       void (*callback)(void *),
+				       void *callback_data);

 #endif /* __OMAPFB_H */
