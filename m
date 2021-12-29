Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12F0481666
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhL2Thy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:37:54 -0500
Received: from ixit.cz ([94.230.151.217]:55808 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhL2Thy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:37:54 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 5DC4B2243C;
        Wed, 29 Dec 2021 20:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640806667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DgV9xPKb2w2jHvv35RGL7rSSJedYG/dEfkvEofORMo4=;
        b=GT+1Fzn1MdsvKPASqlOn6HK7lQveXsgsujimHUcxAZd9P+qPG/RViwIHjOdw8o7/Wa4RJC
        XOdoYZ8iMIsiYQJnyzRGf84S++ggTPOYW85ZrSwHdEQuKZWdPVUFANfrHlNJgvDalzo83N
        KCW0zJe9kfG1By15mgR+gMOj0QE18bI=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8916: improve usb hs node formating
Date:   Wed, 29 Dec 2021 20:37:31 +0100
Message-Id: <20211229193731.72690-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom,init-seq registers are in pairs

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 41897eb3736a..0a0be43529f6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1731,8 +1731,10 @@ usb_hs_phy: phy {
 					clock-names = "ref", "sleep";
 					resets = <&gcc GCC_USB2A_PHY_BCR>, <&usb 0>;
 					reset-names = "phy", "por";
-					qcom,init-seq = /bits/ 8 <0x0 0x44
-						0x1 0x6b 0x2 0x24 0x3 0x13>;
+					qcom,init-seq = /bits/ 8 <0x0 0x44>,
+								 <0x1 0x6b>,
+								 <0x2 0x24>,
+								 <0x3 0x13>;
 				};
 			};
 		};
-- 
2.34.1

