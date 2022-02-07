Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4F4AB40D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbiBGFvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiBGE1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:27:24 -0500
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 20:27:23 PST
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF6BC043183;
        Sun,  6 Feb 2022 20:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644208043; x=1675744043;
  h=from:to:cc:subject:date:message-id;
  bh=pXQ7LkOBiXdg1mQC9sP2hejVjWSd8jyBBgp1P3TOblY=;
  b=uzPgaGlKudtQ+4oC5hDoOswWVo+jEaGlY+17B00qFZFaER2bvpMPB/jg
   9ByLR5A3MSPS1aYSZRzEHYRPwMhbXDp3XyCNCmFe/0Z5o7BFwf0y2Jb00
   Gkc44MRV3nabnHImb7smRtIJja3NLiC3KRG2JVIju2N7/QYN3LwEQl7cX
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 06 Feb 2022 20:25:20 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Feb 2022 20:25:18 -0800
X-QCInternal: smtphost
Received: from hyd-lablnx377.qualcomm.com ([10.204.178.226])
  by ironmsg01-blr.qualcomm.com with ESMTP; 07 Feb 2022 09:55:01 +0530
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id 87A482152F; Mon,  7 Feb 2022 09:55:00 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_rjliao@quicinc.com, quic_hbandi@quicinc.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 crd board
Date:   Mon,  7 Feb 2022 09:54:38 +0530
Message-Id: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
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

Add Bluetooth SoC WCN6750 node for SC7280 crd board

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>

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

