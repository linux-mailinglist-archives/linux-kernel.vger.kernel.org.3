Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634B5474067
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhLNKZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:25:03 -0500
Received: from ixit.cz ([94.230.151.217]:50014 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbhLNKZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:25:02 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 5BFCB24AF0;
        Tue, 14 Dec 2021 11:24:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639477498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KkE7Nfnr8jW/EIQ5AgAa4MvzHf9ta7Po9dg+ts2Qm4c=;
        b=XPtEFpH/nv+GlvJcer59kF8bdIPmi99yL0TZ2Z+Oudx2MJb00DChvNM2QnJLS0qODnJNoy
        OYM8ZBmf3zq9VJ4q6CZCvep++wzNIavK28q73/kFizil86WyztVPjmxNT769CAdDwCucLz
        jfDH5HrK7DLOZjCijG30rMNadjsqWso=
From:   David Heidelberg <david@ixit.cz>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: update qcom,domain property
Date:   Tue, 14 Dec 2021 11:24:50 +0100
Message-Id: <20211214102451.29084-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'qcom,apr-domain' is deprecated in favor of 'qcom,domain',
update accordingly.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 91bc974aeb0a..01643a1f574d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3054,7 +3054,7 @@ apr {
 					power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
 					compatible = "qcom,apr-v2";
 					qcom,smd-channels = "apr_audio_svc";
-					qcom,apr-domain = <APR_DOMAIN_ADSP>;
+					qcom,domain = <APR_DOMAIN_ADSP>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 9217c3a51f79..240293592ef9 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2160,7 +2160,7 @@ glink-edge {
 				apr {
 					compatible = "qcom,apr-v2";
 					qcom,glink-channels = "apr_audio_svc";
-					qcom,apr-domain = <APR_DOMAIN_ADSP>;
+					qcom,domain = <APR_DOMAIN_ADSP>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1bb4d98db96f..5d1d38eb1dfb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -787,7 +787,7 @@ glink-edge {
 			apr {
 				compatible = "qcom,apr-v2";
 				qcom,glink-channels = "apr_audio_svc";
-				qcom,apr-domain = <APR_DOMAIN_ADSP>;
+				qcom,domain = <APR_DOMAIN_ADSP>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				qcom,intents = <512 20>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 5617a46e5ccd..2272efd1506b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4320,7 +4320,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				apr {
 					compatible = "qcom,apr-v2";
 					qcom,glink-channels = "apr_audio_svc";
-					qcom,apr-domain = <APR_DOMAIN_ADSP>;
+					qcom,domain = <APR_DOMAIN_ADSP>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-- 
2.33.0

