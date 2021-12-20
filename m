Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0853147AE19
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhLTO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:58:04 -0500
Received: from ixit.cz ([94.230.151.217]:43666 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239466AbhLTOzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:55:36 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 9705D2243C;
        Mon, 20 Dec 2021 15:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640012133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ixSxI9pWx1iftFiZPbKJ4dYsU9D8Bg10R9uW7sAAzrA=;
        b=NGZYH1IPDz/lhmlFcUcvRXkVF2mXoqc63TRPWluowRU1gR8avONCwEE+8+kzNyOkDquCAM
        t0esMpQUIlvFkR+Bk5LBdzAnrF+Fk4gpGUq/HqLLEqVEWjd7eYWZSe2k0CtiYLhmtKsW0d
        mflwt3TLVZLcRbRYaNJtZQZUG5o4qjE=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996: qcom,controlled-remotely is boolean
Date:   Mon, 20 Dec 2021 15:55:26 +0100
Message-Id: <20211220145526.49102-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM BAM parses property `qcom,controlled-remotely` as a boolean,
adjust dts to reflect that.

Discovered while converting text documentation into yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 7eff331572f2..722fdda54a54 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -713,7 +713,7 @@ cryptobam: dma@644000 {
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
 			qcom,ee = <0>;
-			qcom,controlled-remotely = <1>;
+			qcom,controlled-remotely;
 		};
 
 		crypto: crypto@67a000 {
-- 
2.34.1

