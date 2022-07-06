Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794B4568947
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiGFNUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiGFNUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:20:22 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EE25F7B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:20:21 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id rpLL2700B4C55Sk06pLLLQ; Wed, 06 Jul 2022 15:20:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o94x1-002LC2-P3; Wed, 06 Jul 2022 15:20:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o94x1-009ewI-F5; Wed, 06 Jul 2022 15:20:19 +0200
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
Subject: [PATCH v3] drm/mode: Improve drm_mode_fb_cmd2 documentation
Date:   Wed,  6 Jul 2022 15:20:18 +0200
Message-Id: <536de72eab09242e1faf22fa58d91c9005d6ea51.1657113597.git.geert@linux-m68k.org>
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

Fix various grammar mistakes in the kerneldoc comments documenting the
drm_mode_fb_cmd2 structure:
  - s/is/are/,
  - s/8 bit/8-bit/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Simon Ser <contact@emersion.fr>
---
v3:
  - Add Reviewed-by.

v2:
  - Add Acked-by,
  - Rebase on top of commit a3574119826d9a4e ("drm: document struct
    drm_mode_fb_cmd2") in v5.18.
---
 include/uapi/drm/drm_mode.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 0a0d56a6158e6327..fa953309d9ce5775 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -675,11 +675,11 @@ struct drm_mode_fb_cmd {
  *   fetch metadata about an existing frame-buffer.
  *
  * In case of planar formats, this struct allows up to 4 buffer objects with
- * offsets and pitches per plane. The pitch and offset order is dictated by the
- * format FourCC as defined by ``drm_fourcc.h``, e.g. NV12 is described as:
+ * offsets and pitches per plane. The pitch and offset order are dictated by
+ * the format FourCC as defined by ``drm_fourcc.h``, e.g. NV12 is described as:
  *
- *     YUV 4:2:0 image with a plane of 8 bit Y samples followed by an
- *     interleaved U/V plane containing 8 bit 2x2 subsampled colour difference
+ *     YUV 4:2:0 image with a plane of 8-bit Y samples followed by an
+ *     interleaved U/V plane containing 8-bit 2x2 subsampled colour difference
  *     samples.
  *
  * So it would consist of a Y plane at ``offsets[0]`` and a UV plane at
-- 
2.25.1

