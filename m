Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1648FD05
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiAPMuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiAPMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:50:04 -0500
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE87C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:50:03 -0800 (PST)
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id BC55F2C45F;
        Sun, 16 Jan 2022 12:49:25 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 9B6855FEA8;
        Sun, 16 Jan 2022 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1642337362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cp8maleWJkAj3g8Rqy87pKYRY7/YmFrFYofmm6M7tfU=;
        b=xzLeV7bVOOFZ7CBlwJE6aCx1/VkZeVGsF5RYElMDSZUNUG0C6auhUttPlFF9zWQ0szLJPr
        xMxC5tXrfKixwHMEmbzjSP40zVrsvNDsaDsJtD+iSq+d/wfO53YRaU07uCX2z+Q03997Bl
        0WTvyiZJe7yGytAwI2EH7ZC/bGcplFA=
Received: from localhost.localdomain (fttx-pool-80.245.74.150.bambit.de [80.245.74.150])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 18F213604B2;
        Sun, 16 Jan 2022 12:49:22 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: rockchip: Add BananaPi R2 Pro Board
Date:   Sun, 16 Jan 2022 13:49:10 +0100
Message-Id: <20220116124911.65203-3-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220116124911.65203-1-linux@fw-web.de>
References: <20220116124911.65203-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: aa82c877-1a69-41ec-acbd-896dca2beb05
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add Devicetree Binding for Bananapi R2 Pro Board based on rk3568 SoC

Co-developed-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4aed16176434..33d6423fe6c3 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -651,6 +651,11 @@ properties:
           - const: rockchip,rk3568-evb1-v10
           - const: rockchip,rk3568
 
+      - description: Rockchip RK3568 Banana Pi R2 Pro
+        items:
+          - const: rockchip,rk3568-bpi-r2pro
+          - const: rockchip,rk3568
+
 additionalProperties: true
 
 ...
-- 
2.25.1

