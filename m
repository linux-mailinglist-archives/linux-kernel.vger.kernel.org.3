Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8984464851
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347431AbhLAHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347439AbhLAHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62CCC061746;
        Tue, 30 Nov 2021 23:28:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F9A3CE1D7B;
        Wed,  1 Dec 2021 07:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C4FC56747;
        Wed,  1 Dec 2021 07:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343702;
        bh=C38brKdWsmgfc5PNBBGCSNZfQghFdnJ/M9AOlulZ1v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAQyTpaGcsnHbZiXls0laE9J4zH6bV4klleJdlAWxoVAtSsMlK1Co0eaagUpfMoa5
         0U1/2JcQ25+7mAYtax+W/NR369yzyU5L+qCytbrzyFZHxOlzX0E6dP2DzoDqlo0Flq
         mXErMY8+i8EuSJjYdrv60lzF1CAIodX2MSY1EIAxDOxDEfxJGImwg+WpNQbKP0Q8se
         n/eFy5Tz5gfI24LZc6tJodAt767T/UlxAuLuxN5D2n8vQvpP1+BoLSCUP9psasiHmd
         rbAgz7FgzfaO6tgjP0ls+pOmDaeVmbz3uyMY+8dqG4X3KCCGbFDsfTmkAmP+Ml7fTh
         lT+CI6KzRRsvw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5/7] dt-bindings: power: rpmpd: Add SM8450 to rpmpd binding
Date:   Wed,  1 Dec 2021 12:57:43 +0530
Message-Id: <20211201072745.3969077-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072745.3969077-1-vkoul@kernel.org>
References: <20211201072745.3969077-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Add compatible and constants for the power domains exposed by the RPMH
in the Qualcomm SM8450 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml     |  1 +
 include/dt-bindings/power/qcom-rpmpd.h            | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index e810480e3eb7..a51f7d6c58b7 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -36,6 +36,7 @@ properties:
       - qcom,sm8150-rpmhpd
       - qcom,sm8250-rpmhpd
       - qcom,sm8350-rpmhpd
+      - qcom,sm8450-rpmhpd
 
   '#power-domain-cells':
     const: 1
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 960f7976a807..535d7addd382 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -68,6 +68,21 @@
 #define SM8350_MXC_AO	11
 #define SM8350_MSS	12
 
+/* SM8450 Power Domain Indexes */
+#define SM8450_CX	0
+#define SM8450_CX_AO	1
+#define SM8450_EBI	2
+#define SM8450_GFX	3
+#define SM8450_LCX	4
+#define SM8450_LMX	5
+#define SM8450_MMCX	6
+#define SM8450_MMCX_AO	7
+#define SM8450_MX	8
+#define SM8450_MX_AO	9
+#define SM8450_MXC	10
+#define SM8450_MXC_AO	11
+#define SM8450_MSS	12
+
 /* SC7180 Power Domain Indexes */
 #define SC7180_CX	0
 #define SC7180_CX_AO	1
-- 
2.31.1

