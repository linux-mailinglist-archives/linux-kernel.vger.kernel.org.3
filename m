Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0BF530DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiEWJXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiEWJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:23:42 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A31E48301;
        Mon, 23 May 2022 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653297821; x=1684833821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=v/D8zMWy4Alg5Irt/BF+bg36S5bWE2swa2yE/oIjQBI=;
  b=wc/+ndxOiYj/mQJfXAOhu9bp0uOVawAC2M21De68hEZVBS4BL9nkvDan
   HugIXDbPYLs99/+tA8PC7HnOZIoESVCCFEFxhtU4aVw/QUHLun4N/XQjZ
   gNvoreZvp4hL7tMXTgCnsscTda38GVvY9zLrL+6QAYsWeNR0kfyzrlC5q
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 May 2022 02:23:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 02:23:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 02:23:39 -0700
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 02:23:35 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v2 2/3] dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
Date:   Mon, 23 May 2022 14:53:13 +0530
Message-ID: <20220523092314.14252-3-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220523092314.14252-1-quic_tdas@quicinc.com>
References: <20220523092314.14252-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Support external mclk to interface external MI2S clocks for SC7280.

Fixes: 57405b795504 ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h b/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
index 28ed2a07aacc..0324c69ce968 100644
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
2.17.1

