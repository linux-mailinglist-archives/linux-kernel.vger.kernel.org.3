Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E44AAB80
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381595AbiBES4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:56:24 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:49191 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381197AbiBESzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:08 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B1A4924000A;
        Sat,  5 Feb 2022 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIMPCjtl/VFJr235X/YOqPgWGa/FOuNtQeET3E0lg1s=;
        b=hpuGgN7NRouDqr2x8yPimsw48LzDcqB53a7KwBHegH7IzA2HPHY0uC6ZI5ClRJt4bMKpFD
        QItxvOaUOLpFCNBurSZ+yJDuobyRoWgpZLS5q7GUM6yPtq91eVg5Lqj9f4+H+a8YwFVIyO
        eMlgEuZp1oQhBUsxiyy0MIz1W0MWiKVeB5EX6YuPx3jItsC2fPN9ZS67ChQPAiPAF0Dey7
        Ko/9EiR338iDLAo09qsV3VO+UchDNRNwgsXHoxt0J6Czmb1J7iy6dSYcg1zRHoTu0laZ+s
        oieN2cZay41Si2+l7VpoV9seZYRHk527bHngOblBRH9nXEBRIDwwdKLhepj14Q==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 14/66] MAINTAINERS: Add entry for the Allwinner A83T MIPI CSI-2 bridge
Date:   Sat,  5 Feb 2022 19:53:37 +0100
Message-Id: <20220205185429.2278860-15-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of the Allwinner A83T MIPI CSI-2 bridge media
driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 040c54b2d767..46582119e767 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -759,6 +759,14 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-mipi-csi2.yaml
 F:	drivers/media/platform/sunxi/sun6i-mipi-csi2/
 
+ALLWINNER A83T MIPI CSI-2 BRIDGE DRIVER
+M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml
+F:	drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/
+
 ALLWINNER CPUFREQ DRIVER
 M:	Yangtao Li <tiny.windzz@gmail.com>
 L:	linux-pm@vger.kernel.org
-- 
2.34.1

