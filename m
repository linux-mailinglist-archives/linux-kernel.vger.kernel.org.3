Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7566847F483
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 22:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhLYVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 16:20:04 -0500
Received: from ixit.cz ([94.230.151.217]:56254 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhLYVUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 16:20:04 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A3D672243C;
        Sat, 25 Dec 2021 22:20:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640467202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pISJI0ElBDXDwS7Sfz6V9y8oYPLnlOoFYh5uIb67+W4=;
        b=r5EjdcDhSPU7eZASu7jR22TMTVIjmFJlw2MT5Z4KPX1BafYO/43MThbcDzzWJ+pG9TiFpV
        UP7mB1Wf11E+Z7TvhaMCup4ySMHk/QWXTL1guqUNwoAEkuVmMMo2VcMlcSHSqv4t/5budj
        7Cyx5iNZ4pK17uOaoGaDlTsq2NaRj6Q=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: nexus7: remove vcss supply which never existed
Date:   Sat, 25 Dec 2021 22:20:00 +0100
Message-Id: <20211225212000.80459-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably got in by accident, search trough documentation and kernel code
didn't found any occurences.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index d51af8ee0a89..9d6167bc9610 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -250,7 +250,6 @@ dsi0: dsi@4700000 {
 			vdd-supply = <&pm8921_l8>;
 			vddio-supply = <&pm8921_lvs7>;
 			avdd-supply = <&pm8921_l11>;
-			vcss-supply = <&ext_3p3v>;
 
 			panel@0 {
 				reg = <0>;
-- 
2.34.1

