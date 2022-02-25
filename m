Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2D4C453E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiBYNEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240846AbiBYNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:04:27 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4051DA032;
        Fri, 25 Feb 2022 05:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645794236; x=1677330236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fsfEpXp/R6vgIl41E1AMEPl55k+ufZpqMJPFBg1XTm8=;
  b=f9GXGW6+ethldR76MtIqBX5SfqyFW03xyAdxcCUTJMVKWncL9udv77D7
   Bv0SZyIQV1fcd/4yF5ywDXY6tR39R68dO6oremCu78dWrhQnDCJ7nQ29J
   3yWULs5ex5PPE+9eUpxrt9kFJLYFI/WH4dN9E1jLmt4QFVVcKSzuATVt/
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Feb 2022 05:03:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 05:03:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 05:03:54 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 05:03:51 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_rjendra@quicinc.com>,
        <quic_saipraka@quicinc.com>, <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 1/2] Revert "arm64: dts: qcom: sc7280: Set the default dr_mode for usb2"
Date:   Fri, 25 Feb 2022 18:33:00 +0530
Message-ID: <87008876afb33d8e1b7fd78d2fd5b6d9ec343d7d.1645793187.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1645793187.git.quic_schowdhu@quicinc.com>
References: <cover.1645793187.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c18553956f34819e224a79c9890eba2ba0604e15.

Revert the change to set dr_mode for usb2 in case of
Embedded USB Debugger(EUD). This change needs to be
reverted as the DT changes for QCOM should go through
the QCOM tree and not the USB tree.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index f40eaa5..9b991ba 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -61,10 +61,6 @@
 	modem-init;
 };
 
-&usb_2_dwc3 {
-	dr_mode = "otg";
-};
-
 &pmk8350_rtc {
 	status = "okay";
 };
-- 
2.7.4

