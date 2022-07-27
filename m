Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB9B58221F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiG0I2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiG0I2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:28:43 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137A459B6;
        Wed, 27 Jul 2022 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658910517; x=1690446517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hDK80vDpkuXPJNz0zWKF4J/lc/t8yhaBiwQSS2Kg5Do=;
  b=bwoyGWvW4dFAl3KyX0+Rwm+zJiCN3pP7BLiMzuVN+aYJ4Ks1v8chvpX+
   BX4upNRC3i68lVu7Yp7rPxKFVuA5+sEDXYx5nMLjhjSdcF9BOzdTWqFE9
   8s9PwzeflO0eyN9uHinekHPJrR+xotcYaEF6Qo6p9YhBvvNHhwhIYXvF1
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jul 2022 01:28:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 01:28:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 01:28:31 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 01:28:27 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH V7 4/5] dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
Date:   Wed, 27 Jul 2022 13:57:56 +0530
Message-ID: <1658910477-6494-5-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658910477-6494-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1658910477-6494-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

Support external mclk to interface external MI2S clocks for SC7280.

Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h b/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
index 28ed2a0..0324c69 100644
--- a/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
+++ b/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
@@ -19,6 +19,8 @@
 #define LPASS_CORE_CC_LPM_CORE_CLK			9
 #define LPASS_CORE_CC_LPM_MEM0_CORE_CLK			10
 #define LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK		11
+#define LPASS_CORE_CC_EXT_MCLK0_CLK			12
+#define LPASS_CORE_CC_EXT_MCLK0_CLK_SRC			13
 
 /* LPASS_CORE_CC power domains */
 #define LPASS_CORE_CC_LPASS_CORE_HM_GDSC		0
-- 
2.7.4

