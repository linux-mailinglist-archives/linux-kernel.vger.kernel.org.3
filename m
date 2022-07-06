Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244FF56892A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiGFNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiGFNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:16:26 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2725F1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:16:24 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id rpGL2700W4C55Sk06pGLll; Wed, 06 Jul 2022 15:16:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o94tA-002L9t-35; Wed, 06 Jul 2022 15:16:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o94t9-009enR-L2; Wed, 06 Jul 2022 15:16:19 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Simon Ser <contact@emersion.fr>
Subject: [PATCH v2] drm/fb: Improve drm_framebuffer.offsets documentation
Date:   Wed,  6 Jul 2022 15:16:18 +0200
Message-Id: <33fda13b500b39645e7363806c6e458e915b581e.1657113304.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix various spelling and grammar mistakes in the kerneldoc comments
documenting the offsets member in the drm_framebuffer structure:
  - s/laytou/layout/,
  - Add missing "is",
  - s/it/its/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Simon Ser <contact@emersion.fr>
---
v2:
  - Add Acked-by, Reviewed-by.
---
 include/drm/drm_framebuffer.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index f67c5b7bcb68654a..0dcc07b68654844b 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -154,10 +154,10 @@ struct drm_framebuffer {
 	 * drm_mode_fb_cmd2.
 	 *
 	 * Note that this is a linear offset and does not take into account
-	 * tiling or buffer laytou per @modifier. It meant to be used when the
-	 * actual pixel data for this framebuffer plane starts at an offset,
-	 * e.g.  when multiple planes are allocated within the same backing
-	 * storage buffer object. For tiled layouts this generally means it
+	 * tiling or buffer layout per @modifier. It is meant to be used when
+	 * the actual pixel data for this framebuffer plane starts at an offset,
+	 * e.g. when multiple planes are allocated within the same backing
+	 * storage buffer object. For tiled layouts this generally means its
 	 * @offsets must at least be tile-size aligned, but hardware often has
 	 * stricter requirements.
 	 *
-- 
2.25.1

