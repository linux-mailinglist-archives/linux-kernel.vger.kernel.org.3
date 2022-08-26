Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1CF5A2EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiHZShT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbiHZSeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:34:44 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FFE68E1;
        Fri, 26 Aug 2022 11:33:55 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3E976FF80C;
        Fri, 26 Aug 2022 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHlLsC7wm5dlu8Hc51TJ3WEVrNXAyh6gyEhOFtonpOE=;
        b=c3afAQPKQH5DcFtD66pvGn/eVFJ1n8ezIDZOTYUbwKttzBh/fiatSnyDZ/GtKHMc9ZJShS
        dOvbznKch9jhUyYaPxs9kBQvxQY5VCqbqByP2NOCED2/+j+F0zJtVzIQ9CthLkU4C6mAlt
        Z7FL15w6hjXfWJ6iw/8hHCnqL6KeoyIcriSkbDxCay2jSR/zK0NQI+IOpGkIQasSgM06pW
        41eqU45qPBD+p4Sx770yixoZrfscwBqzSwN5dA0DJr7pVCGL3gRkpkhl4g1zSzQx/1X6jt
        5+jyD2UdTXlEG/aSlgxfo5KcgFapz6N4PE6KnvtLbFIR5Y2kjcX22ImhRTaDHQ==
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
Subject: [PATCH v6 43/43] MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry
Date:   Fri, 26 Aug 2022 20:32:40 +0200
Message-Id: <20220826183240.604834-44-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 MAINTAINERS | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..0bd7b7d14f08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -778,6 +778,15 @@ T:	git git://linuxtv.org/media_tree.git
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
@@ -5458,14 +5467,6 @@ M:	Jaya Kumar <jayakumar.alsa@gmail.com>
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
 CTU CAN FD DRIVER
 M:	Pavel Pisa <pisa@cmp.felk.cvut.cz>
 M:	Ondrej Ille <ondrej.ille@gmail.com>
-- 
2.37.1

