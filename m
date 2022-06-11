Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F25473B4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 12:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiFKKYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 06:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiFKKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:24:41 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7822434BB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 03:24:39 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id zyIHnBJD02ovCzyIHn2tpT; Sat, 11 Jun 2022 12:24:38 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 11 Jun 2022 12:24:38 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: em28xx: Remove useless license text when SPDX-License-Identifier is already used
Date:   Sat, 11 Jun 2022 12:24:32 +0200
Message-Id: <724ee7d0c2a1f2550cefb7a37b6164a64faf51b2.1654943064.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An SPDX-License-Identifier is already in place. There is no need to
duplicate part of the corresponding license.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/usb/em28xx/em28xx-audio.c  | 10 ----------
 drivers/media/usb/em28xx/em28xx-camera.c | 10 ----------
 drivers/media/usb/em28xx/em28xx-cards.c  | 10 ----------
 drivers/media/usb/em28xx/em28xx-core.c   | 10 ----------
 drivers/media/usb/em28xx/em28xx-dvb.c    |  4 ----
 drivers/media/usb/em28xx/em28xx-i2c.c    | 10 ----------
 drivers/media/usb/em28xx/em28xx-input.c  | 10 ----------
 drivers/media/usb/em28xx/em28xx-v4l.h    |  9 ---------
 drivers/media/usb/em28xx/em28xx-vbi.c    | 10 ----------
 drivers/media/usb/em28xx/em28xx-video.c  | 10 ----------
 drivers/media/usb/em28xx/em28xx.h        | 10 ----------
 11 files changed, 103 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-audio.c b/drivers/media/usb/em28xx/em28xx-audio.c
index 4d5ab1433b44..ce1b0d9e0741 100644
--- a/drivers/media/usb/em28xx/em28xx-audio.c
+++ b/drivers/media/usb/em28xx/em28xx-audio.c
@@ -10,16 +10,6 @@
 //
 // This driver is based on my previous au600 usb pstn audio driver
 // and inherits all the copyrights
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by
-// the Free Software Foundation; either version 2 of the License, or
-// (at your option) any later version.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
 
 #include "em28xx.h"
 
diff --git a/drivers/media/usb/em28xx/em28xx-camera.c b/drivers/media/usb/em28xx/em28xx-camera.c
index d1e66b503f4d..b5f58dc6dd0f 100644
--- a/drivers/media/usb/em28xx/em28xx-camera.c
+++ b/drivers/media/usb/em28xx/em28xx-camera.c
@@ -4,16 +4,6 @@
 //
 // Copyright (C) 2009 Mauro Carvalho Chehab <mchehab@kernel.org>
 // Copyright (C) 2013 Frank Schäfer <fschaefer.oss@googlemail.com>
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by
-// the Free Software Foundation; either version 2 of the License, or
-// (at your option) any later version.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
 
 #include "em28xx.h"
 
diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index ae25d2cbfdfe..4d037c92af7c 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -8,16 +8,6 @@
 //		      Mauro Carvalho Chehab <mchehab@kernel.org>
 //		      Sascha Sommer <saschasommer@freenet.de>
 // Copyright (C) 2012 Frank Schäfer <fschaefer.oss@googlemail.com>
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by
-// the Free Software Foundation; either version 2 of the License, or
-// (at your option) any later version.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
 
 #include "em28xx.h"
 
diff --git a/drivers/media/usb/em28xx/em28xx-core.c b/drivers/media/usb/em28xx/em28xx-core.c
index c837cc528a33..61d7bf701d57 100644
--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -7,16 +7,6 @@
 //		      Mauro Carvalho Chehab <mchehab@kernel.org>
 //		      Sascha Sommer <saschasommer@freenet.de>
 // Copyright (C) 2012 Frank Schäfer <fschaefer.oss@googlemail.com>
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by
-// the Free Software Foundation; either version 2 of the License, or
-// (at your option) any later version.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
 
 #include "em28xx.h"
 
diff --git a/drivers/media/usb/em28xx/em28xx-dvb.c b/drivers/media/usb/em28xx/em28xx-dvb.c
index 471bd74667e3..185e89c18d68 100644
--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -16,10 +16,6 @@
 // Based on cx88-dvb, saa7134-dvb and videobuf-dvb originally written by:
 //	(c) 2004, 2005 Chris Pascoe <c.pascoe@itee.uq.edu.au>
 //	(c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by
-// the Free Software Foundation version 2 of the License.
 
 #include "em28xx.h"
 
diff --git a/drivers/media/usb/em28xx/em28xx-i2c.c b/drivers/media/usb/em28xx/em28xx-i2c.c
index b9a8d3fbad1a..a7eb11f7fb34 100644
--- a/drivers/media/usb/em28xx/em28xx-i2c.c
+++ b/drivers/media/usb/em28xx/em28xx-i2c.c
@@ -7,16 +7,6 @@
 //		      Mauro Carvalho Chehab <mchehab@kernel.org>
 //		      Sascha Sommer <saschasommer@freenet.de>
 // Copyright (C) 2013 Frank Schäfer <fschaefer.oss@googlemail.com>
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by
-// the Free Software Foundation; either version 2 of the License, or
-// (at your option) any later version.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
 
 #include "em28xx.h"
 
diff --git a/drivers/media/usb/em28xx/em28xx-input.c b/drivers/media/usb/em28xx/em28xx-input.c
index 0b6d77c3bec8..5f3b00869bdb 100644
--- a/drivers/media/usb/em28xx/em28xx-input.c
+++ b/drivers/media/usb/em28xx/em28xx-input.c
@@ -6,16 +6,6 @@
 //		      Markus Rechberger <mrechberger@gmail.com>
 //		      Mauro Carvalho Chehab <mchehab@kernel.org>
 //		      Sascha Sommer <saschasommer@freenet.de>
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by
-// the Free Software Foundation; either version 2 of the License, or
-// (at your option) any later version.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
 
 #include "em28xx.h"
 
diff --git a/drivers/media/usb/em28xx/em28xx-v4l.h b/drivers/media/usb/em28xx/em28xx-v4l.h
index 6216cdd182f3..8455dcfdaf81 100644
--- a/drivers/media/usb/em28xx/em28xx-v4l.h
+++ b/drivers/media/usb/em28xx/em28xx-v4l.h
@@ -4,15 +4,6 @@
  *		    video capture devices
  *
  * Copyright (C) 2013-2014 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 int em28xx_start_analog_streaming(struct vb2_queue *vq, unsigned int count);
diff --git a/drivers/media/usb/em28xx/em28xx-vbi.c b/drivers/media/usb/em28xx/em28xx-vbi.c
index 63c48361d3f2..b253c44c9724 100644
--- a/drivers/media/usb/em28xx/em28xx-vbi.c
+++ b/drivers/media/usb/em28xx/em28xx-vbi.c
@@ -5,16 +5,6 @@
 // Copyright (C) 2009 Devin Heitmueller <dheitmueller@kernellabs.com>
 //
 // This work was sponsored by EyeMagnet Limited.
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by
-// the Free Software Foundation; either version 2 of the License, or
-// (at your option) any later version.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
 
 #include "em28xx.h"
 
diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 6b84c3413e83..8181c0e6a25b 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -11,16 +11,6 @@
 //
 //	Some parts based on SN9C10x PC Camera Controllers GPL driver made
 //		by Luca Risolia <luca.risolia@studio.unibo.it>
-//
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by
-// the Free Software Foundation; either version 2 of the License, or
-// (at your option) any later version.
-//
-// This program is distributed in the hope that it will be useful,
-// but WITHOUT ANY WARRANTY; without even the implied warranty of
-// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-// GNU General Public License for more details.
 
 #include "em28xx.h"
 
diff --git a/drivers/media/usb/em28xx/em28xx.h b/drivers/media/usb/em28xx/em28xx.h
index 7fc0b68a4a22..db18dd814a67 100644
--- a/drivers/media/usb/em28xx/em28xx.h
+++ b/drivers/media/usb/em28xx/em28xx.h
@@ -8,16 +8,6 @@
  * Copyright (C) 2012 Frank Schäfer <fschaefer.oss@googlemail.com>
  *
  * Based on the em2800 driver from Sascha Sommer <saschasommer@freenet.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _EM28XX_H
-- 
2.34.1

