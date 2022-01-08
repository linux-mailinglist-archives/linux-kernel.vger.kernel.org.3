Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E94884E4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiAHRP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:15:56 -0500
Received: from ixit.cz ([94.230.151.217]:50996 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232419AbiAHRPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:15:55 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id F0A362243C;
        Sat,  8 Jan 2022 18:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1641662153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZdMtUqzoGvtlw13MLMD1SKcSARMz4+Jv1iswxoYMeY8=;
        b=oNuV0wkaMWzPYJu7LSh5pRTzJHKPqZjUGlzDO4Q4X9Rwh4EO6GWw0Xrur3Z16jJUWxr7eP
        2AKJPUt5CBdKg2QS45mEhMRGJXpp1kg307D8cKCBLyubYx4TRwoGJcsAzOzXDBboV6yeZ5
        f+ovU9QUPMJd52XlD1Fowf7wADSxwlo=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: rename eth node to ethernet
Date:   Sat,  8 Jan 2022 18:15:35 +0100
Message-Id: <20220108171535.55536-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comply with dt-schema requirements.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index 4af01039c3b2..d1fd0fe12ffe 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -279,7 +279,7 @@ gsbi@16000000 {
 			pinctrl-0 = <&spi1_default>;
 			spi@16080000 {
 				status = "okay";
-				eth@0 {
+				ethernet@0 {
 					compatible = "micrel,ks8851";
 					reg = <0>;
 					interrupt-parent = <&msmgpio>;
-- 
2.34.1

