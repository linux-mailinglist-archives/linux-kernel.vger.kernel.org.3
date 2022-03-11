Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F224D63E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiCKOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349697AbiCKOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:38:17 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0611CA5C2;
        Fri, 11 Mar 2022 06:37:02 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F22AD24000C;
        Fri, 11 Mar 2022 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGe1fBLDVUFuRicfbGDrdMG7UD+cffaBQQk4odYtgqs=;
        b=UVKwKS07KcPK7PuqRebeYyaVf0xx5W8ON7Kk77bviCSdfC67Fj1zx5Zy5QPJfKjO0mAuBt
        5rYaaoEyQ/u+WeMIzlnBUItZeDWnfpSjGfKXKubIxTUEw2NeXPR+7zIFbESIcbY7bLWX8M
        ydOv9UbCYH7vb8Xr5MsslVb5rqT724C4PfuYK3K/BzwYcnw5a/6M3SHfbdSm/dYs1ptWR+
        dKsRq0GsnqlrjaTcU1Bi4P0txcMri1jyqW5vRYP3ZdBDhemIoKz/+KCLqqSUVjql9oi3Qb
        UzfBMWVPvqVrjrJSUHGTksvbpfHwxfMqQKbosJ2KOVxwfKc1mEbObND9bKuOvQ==
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
Subject: [PATCH v3 46/46] MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry
Date:   Fri, 11 Mar 2022 15:35:32 +0100
Message-Id: <20220311143532.265091-47-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given the substantial rework of the driver that I carried out and the
knowledge acquired about the hardware along the way, make myself a
maintainer of the sun6i-csi driver.

Also rename and move the entry while at it since the driver is not
specific to the V3s.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 MAINTAINERS | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed1758d194a5..164e1b57337f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -752,6 +752,15 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
 F:	drivers/media/platform/sunxi/sun4i-csi/
 
+ALLWINNER A31 CSI DRIVER
+M:	Yong Deng <yong.deng@magewell.com>
+M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
+F:	drivers/media/platform/sunxi/sun6i-csi/
+
 ALLWINNER A31 MIPI CSI-2 BRIDGE DRIVER
 M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
 L:	linux-media@vger.kernel.org
@@ -5115,14 +5124,6 @@ M:	Jaya Kumar <jayakumar.alsa@gmail.com>
 S:	Maintained
 F:	sound/pci/cs5535audio/
 
-CSI DRIVERS FOR ALLWINNER V3s
-M:	Yong Deng <yong.deng@magewell.com>
-L:	linux-media@vger.kernel.org
-S:	Maintained
-T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
-F:	drivers/media/platform/sunxi/sun6i-csi/
-
 CW1200 WLAN driver
 M:	Solomon Peachy <pizza@shaftnet.org>
 S:	Maintained
-- 
2.35.1

