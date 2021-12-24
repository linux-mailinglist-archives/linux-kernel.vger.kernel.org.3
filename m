Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF25247F027
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353258AbhLXQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:31:13 -0500
Received: from ixit.cz ([94.230.151.217]:49682 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhLXQbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:31:10 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D67552243C;
        Fri, 24 Dec 2021 17:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640363469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RNEtzN3VfT1jCD3jgIcqPxGguH5LZ39PDpSxj+kjOYo=;
        b=wcW6sHWo68amxwKq57FXLY147X5ECNYPOr9eVU8w/0aSIHkiGz5+Rp8jb7TGfrRRhNOLJH
        zRUFH2MbUNxJHbabEDVk6zdl3j7fs1j/W8pWZPPMOm3/cbG9bwwdNXpyPSDLZtsf6b3eg5
        CChQscQ3oTBz8CoaJmCqZd5WzsjRuj8=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996: use standartized naming for spmi node
Date:   Fri, 24 Dec 2021 17:31:07 +0100
Message-Id: <20211224163107.53708-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following naming convention, rename qcom,spmi@ node to spmi@

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 722fdda54a54..ae09007866e8 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1546,7 +1546,7 @@ sram@290000 {
 			reg = <0x00290000 0x10000>;
 		};
 
-		spmi_bus: qcom,spmi@400f000 {
+		spmi_bus: spmi@400f000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0400f000 0x1000>,
 			      <0x04400000 0x800000>,
-- 
2.34.1

