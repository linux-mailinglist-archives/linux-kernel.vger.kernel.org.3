Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C520D47F333
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 13:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhLYMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 07:10:24 -0500
Received: from ixit.cz ([94.230.151.217]:55704 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhLYMKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 07:10:23 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id AB0EB2243C;
        Sat, 25 Dec 2021 13:10:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640434220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gb1Cw8Ow3mPZGftKt6JWGoHjiKpCALnGpFaSaVSeix0=;
        b=VfWDSEQpPI+jPCbQ9Xu6cAjBcq/fpv7HnjyMtCdUhQBhYKkh2tf4mosnsylryDeOsxiizq
        afh9MK9k2VSFee+aGaIUzTNvWJgvK0FOZO4skQ8qY9G6EmfkxFx6ulIvOTeFxJlZtw+SG4
        M/nrNuLUAzL7c7jrZO1PtndUFliHXIM=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: apq8064: fill missing power-domain-cells for clock controllers
Date:   Sat, 25 Dec 2021 13:10:18 +0100
Message-Id: <20211225121018.5569-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing #power-domain-cells to the clock controllers.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 562a292e75a3..5ae14c564c30 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -814,6 +814,7 @@ gcc: clock-controller@900000 {
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			#thermal-sensor-cells = <1>;
 		};
@@ -829,6 +830,7 @@ mmcc: clock-controller@4000000 {
 			compatible = "qcom,mmcc-apq8064";
 			reg = <0x4000000 0x1000>;
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 		};
 
-- 
2.34.1

