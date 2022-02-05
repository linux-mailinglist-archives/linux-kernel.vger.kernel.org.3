Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9225C4AABFC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381653AbiBES6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:58:37 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:54347 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381630AbiBES4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:30 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E3959240002;
        Sat,  5 Feb 2022 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ne/+UpxTP8QSDv9vtv2k9kE96A5NFi5jBqXJJ11zruk=;
        b=bc9C2VQSJSyrWVrToOa/LAJ3ztKQr0jzzgYlF2LDqSwyefxoApYSSOlqriS4SSLW4pR5F6
        zBof+ryxROKIWUxRlVD24w1dq/grrrtK0gUzLLqeTv2ZqbDBww+UR/6fcA1v0AX5lb+x1D
        GIpy2lyxQKZtMaMcOntqjAnn7asShtFq8Wt/yS1c2bki9eM9YtoGwj+RfEQ4mhwv6v7wNg
        IvNdBiecfwNuzI2Jfxt3WHkFRx8EQd83vfP/0VZmp6+9514IRQVGEsvi0WWzBjIVW3osto
        inqfVbS2nc2y/4aoh33AZDHRSP/biiMYDqLOvrHmYwKNNQv7ZEMPL8aETewKCQ==
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
Subject: [PATCH v2 64/66] MAINTAINERS: Add entry for the Allwinner A31 ISP driver
Date:   Sat,  5 Feb 2022 19:54:27 +0100
Message-Id: <20220205185429.2278860-65-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of the Allwinner A31 ISP media driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e65b9e5123f..709cf8aa1a8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -760,6 +760,15 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
 F:	drivers/media/platform/sunxi/sun6i-csi/
 
+ALLWINNER A31 ISP DRIVER
+M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
+F:	drivers/staging/media/sunxi/sun6i-isp/
+F:	drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h
+
 ALLWINNER A31 MIPI CSI-2 BRIDGE DRIVER
 M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
 L:	linux-media@vger.kernel.org
-- 
2.34.1

