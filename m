Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1099473499
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbhLMTCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:02:41 -0500
Received: from ixit.cz ([94.230.151.217]:46422 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242082AbhLMTCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:02:39 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 78BFA24AF0;
        Mon, 13 Dec 2021 20:02:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639422156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t5oYrk/jWKNH0SFWYuroNNJ0tQvcUiYr+wJENR3sEGY=;
        b=lBnmnPqW5oU7dEXeC4PuZIMQe68wvaIrjFGN3FDbBawddT224OFkuWYbmGZvEcK7gSUX1G
        jnlPxsXZb6tMd/LP9+R9g/ftQo2ET2tXlh54SplZVtvx6xSDJtyGbceYJD+XAAEZhCnUm5
        ZvLbIFcfHiupmyHwNaIwgsF3rbh00CY=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: add QFPROM chipset specific compatible
Date:   Mon, 13 Dec 2021 20:02:28 +0100
Message-Id: <20211213190228.106924-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use correct compatible according to dt-binding.

Fixes + few other lines of `make qcom/sdm845-oneplus-fajita.dtb`:
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: qfprom@784000: compatible: ['qcom,qfprom'] is too short
        From schema: Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ff344a9a81a6..cfdeaa81f1bb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1078,7 +1078,7 @@ gcc: clock-controller@100000 {
 		};
 
 		qfprom@784000 {
-			compatible = "qcom,qfprom";
+			compatible = "qcom,sdm845-qfprom", "qcom,qfprom";
 			reg = <0 0x00784000 0 0x8ff>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.33.0

