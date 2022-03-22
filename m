Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4544E3A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiCVIdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiCVIdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:33:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0462A1D;
        Tue, 22 Mar 2022 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647937914; x=1679473914;
  h=from:to:cc:subject:date:message-id;
  bh=dhrHqCr8JpnzGj5k2QqDNMs8JfQ6cFepyudJYMAsdpk=;
  b=StMV+Mci0nQ6kAZViwtm7esBZGM5jDL6Mn8jcNlziC/suh275RmaNB7E
   Tu4Z0IG5iyAyH2WlqwuQafT0pkte3p3J3ORnEiaV0Np4d5t6iom74qL7M
   Ep3MVteztEZ1mrAEzfjAgTlImKbZEVxp8MdesvfPAFeAp49bhy2dZZxh1
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 22 Mar 2022 01:31:54 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Mar 2022 01:31:36 -0700
X-QCInternal: smtphost
Received: from hyd-lablnx377.qualcomm.com ([10.204.178.226])
  by ironmsg01-blr.qualcomm.com with ESMTP; 22 Mar 2022 14:01:18 +0530
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id 55842216FA; Tue, 22 Mar 2022 14:01:17 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        quic_rjliao@quicinc.com, mcchou@chromium.org,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [RESEND v3] arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD platforms
Date:   Tue, 22 Mar 2022 14:01:04 +0530
Message-Id: <1647937864-25661-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IO regulator handler in SC7280 CRD based platforms.
As IO regulator varies in different SC7280 platforms
updating this handler in individual platform bluetooth node.

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
---
v3: Updated commit text to reflect the change
v2: updated reviewer comments.
v1: intial patch
---
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index cd2755c..53ea3b4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -23,6 +23,10 @@
 	};
 };
 
+&bluetooth {
+	vddio-supply = <&vreg_l18b_1p8>;
+};
+
 ap_tp_i2c: &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

