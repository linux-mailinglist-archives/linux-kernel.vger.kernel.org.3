Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC1D5343F5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbiEYTKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344222AbiEYTHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:07:45 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FFA12A86;
        Wed, 25 May 2022 12:07:13 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A73731C000D;
        Wed, 25 May 2022 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4qacAQk3l/h0ZQjqHQzK2KwWqLYZ6RBuLaYEReb3ic=;
        b=czJFZ3ms9jXaVb0R3HH8cvnjvkCoGYio4mSWOotOWFp29rpMpxKZfsySKl0OlqB+v6lNfv
        QdATd7I3/H7NY/cX2+K6JYWvnw32ISMZATi82lE18bcePbXxSu3PUJaHZzce5vu3we20YL
        1Cv6i3v4ll0kKpfVIQmyS6PEhjYVjRxsTRBZsp3/i3Hpm6bDfwdupG3hZytTbbaEWwjKV7
        0UluCQSJ/MRmZrrZTYi3lWO4DqmLnwslxyoKcs4Eb6ZVbdOYQT4n8MSQyv3MBZd73kmi7C
        q5/GdcY8gfgApptaS/mQpCS+CktfGZUmd3HanvfTf7grp0LnRqSvbw4Zl8vODQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 38/44] media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
Date:   Wed, 25 May 2022 21:06:11 +0200
Message-Id: <20220525190617.696344-39-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
References: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver is properly split between bridge and capture,
rename the video device to highlight its role and be in line with
the bridge entity naming.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c | 3 ++-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index a0131023a8b9..e5ebe7a50c6f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -1023,7 +1023,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 
 	/* Video Device */
 
-	strscpy(video_dev->name, SUN6I_CSI_NAME, sizeof(video_dev->name));
+	strscpy(video_dev->name, SUN6I_CSI_CAPTURE_NAME,
+		sizeof(video_dev->name));
 	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
 	video_dev->vfl_dir = VFL_DIR_RX;
 	video_dev->release = video_device_release_empty;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index a61db3bc72e5..59c57bcefeec 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -11,6 +11,8 @@
 #include <media/v4l2-dev.h>
 #include <media/videobuf2-core.h>
 
+#define SUN6I_CSI_CAPTURE_NAME	"sun6i-csi-capture"
+
 #define SUN6I_CSI_CAPTURE_WIDTH_MIN	32
 #define SUN6I_CSI_CAPTURE_WIDTH_MAX	4800
 #define SUN6I_CSI_CAPTURE_HEIGHT_MIN	32
-- 
2.36.1

