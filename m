Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9189A48F97F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 22:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiAOVJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 16:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiAOVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 16:09:14 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C37C061574;
        Sat, 15 Jan 2022 13:09:14 -0800 (PST)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E400622246;
        Sat, 15 Jan 2022 22:09:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642280952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E3bZN+tCtpj0s3950gxxED/Fb6Z7y2Jy3Qm5SKVqIzg=;
        b=UF4nZDHiJBnqMHdC9AvR6yxp1ztp46Rh3sMFLLOamRtkhhEeNEAr9GAGgo3pearaoN0LMT
        gRwZ35I3NqDnHiMq/E0mk2GZxFxWAceppO5G1p0SRqoWrJpZodV8+jMpAhhTdZyRVNiVQI
        mYbxlsm1uH0qppFQJva6HEY2XLhmIlI=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Biwen Li <biwen.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] Revert "arm64: dts: ls1028a-rdb: enable pwm0"
Date:   Sat, 15 Jan 2022 22:09:06 +0100
Message-Id: <20220115210907.451189-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to revert commit 71799672ea24d ("arm64: dts: ls1028a: add
flextimer based pwm nodes"). To not break the LS1028A-RDB board dts, we
also need to revert this commit.

This reverts commit b2e2d3e02fb60f4d45843ceebef0465c59c8d392.

Fixes: b2e2d3e02fb6 ("arm64: dts: ls1028a-rdb: enable pwm0")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 68c31cb8eead..6d26b010187c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -286,10 +286,6 @@ &optee {
 	status = "okay";
 };
 
-&pwm0 {
-	status = "okay";
-};
-
 &sai4 {
 	status = "okay";
 };
-- 
2.30.2

