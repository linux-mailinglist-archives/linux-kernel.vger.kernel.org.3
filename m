Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB1246B87B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhLGKMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:12:30 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38473 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234794AbhLGKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638871740; x=1670407740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2wlf03yC2u4Z5U4R6YZ5A8eUNM3Xlv8+aqVofmRrz18=;
  b=gGF2YGlenA45jXb6ZEjI95DHvJ8wvGqiMzPnSUc/xgCRpDg/Y1Jn5ZF0
   O0mVYboyB/mx45+QQCEhqwXtM7anz+SeecMYPEkBtTmMtFh0+AkBPBEXE
   eGJITdws5xS+s4jVDATeIcKWZ+8rX8c96B+kd6rj5nxzuob8bCogYgl0Q
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Dec 2021 02:08:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:08:59 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 02:08:59 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 02:08:56 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 3/3] soc: qcom: rpmhpd: Sort power-domain definitions and lists
Date:   Tue, 7 Dec 2021 15:38:32 +0530
Message-ID: <1638871712-18636-4-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
References: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort all power-domain defines and the SoC specific lists in
alphabetical order for better readability.
No functional changes.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 drivers/soc/qcom/rpmhpd.c | 120 +++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 59 deletions(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 4599efe..4df851f 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -65,46 +65,9 @@ static DEFINE_MUTEX(rpmhpd_lock);
 
 /* RPMH powerdomains */
 
-static struct rpmhpd ebi = {
-	.pd = { .name = "ebi", },
-	.res_name = "ebi.lvl",
-};
-
-static struct rpmhpd lmx = {
-	.pd = { .name = "lmx", },
-	.res_name = "lmx.lvl",
-};
-
-static struct rpmhpd lcx = {
-	.pd = { .name = "lcx", },
-	.res_name = "lcx.lvl",
-};
-
-static struct rpmhpd gfx = {
-	.pd = { .name = "gfx", },
-	.res_name = "gfx.lvl",
-};
-
-static struct rpmhpd mss = {
-	.pd = { .name = "mss", },
-	.res_name = "mss.lvl",
-};
-
-static struct rpmhpd mx_ao;
-static struct rpmhpd mx = {
-	.pd = { .name = "mx", },
-	.peer = &mx_ao,
-	.res_name = "mx.lvl",
-};
-
-static struct rpmhpd mx_ao = {
-	.pd = { .name = "mx_ao", },
-	.active_only = true,
-	.peer = &mx,
-	.res_name = "mx.lvl",
-};
-
 static struct rpmhpd cx_ao;
+static struct rpmhpd mx;
+static struct rpmhpd mx_ao;
 static struct rpmhpd cx = {
 	.pd = { .name = "cx", },
 	.peer = &cx_ao,
@@ -134,6 +97,26 @@ static struct rpmhpd cx_ao_no_parent = {
 	.res_name = "cx.lvl",
 };
 
+static struct rpmhpd ebi = {
+	.pd = { .name = "ebi", },
+	.res_name = "ebi.lvl",
+};
+
+static struct rpmhpd gfx = {
+	.pd = { .name = "gfx", },
+	.res_name = "gfx.lvl",
+};
+
+static struct rpmhpd lcx = {
+	.pd = { .name = "lcx", },
+	.res_name = "lcx.lvl",
+};
+
+static struct rpmhpd lmx = {
+	.pd = { .name = "lmx", },
+	.res_name = "lmx.lvl",
+};
+
 static struct rpmhpd mmcx_ao;
 static struct rpmhpd mmcx = {
 	.pd = { .name = "mmcx", },
@@ -148,6 +131,25 @@ static struct rpmhpd mmcx_ao = {
 	.res_name = "mmcx.lvl",
 };
 
+static struct rpmhpd mss = {
+	.pd = { .name = "mss", },
+	.res_name = "mss.lvl",
+};
+
+static struct rpmhpd mx_ao;
+static struct rpmhpd mx = {
+	.pd = { .name = "mx", },
+	.peer = &mx_ao,
+	.res_name = "mx.lvl",
+};
+
+static struct rpmhpd mx_ao = {
+	.pd = { .name = "mx_ao", },
+	.active_only = true,
+	.peer = &mx,
+	.res_name = "mx.lvl",
+};
+
 static struct rpmhpd mxc_ao;
 static struct rpmhpd mxc = {
 	.pd = { .name = "mxc", },
@@ -164,15 +166,15 @@ static struct rpmhpd mxc_ao = {
 
 /* SDM845 RPMH powerdomains */
 static struct rpmhpd *sdm845_rpmhpds[] = {
-	[SDM845_EBI] = &ebi,
-	[SDM845_MX] = &mx,
-	[SDM845_MX_AO] = &mx_ao,
 	[SDM845_CX] = &cx,
 	[SDM845_CX_AO] = &cx_ao,
-	[SDM845_LMX] = &lmx,
-	[SDM845_LCX] = &lcx,
+	[SDM845_EBI] = &ebi,
 	[SDM845_GFX] = &gfx,
+	[SDM845_LCX] = &lcx,
+	[SDM845_LMX] = &lmx,
 	[SDM845_MSS] = &mss,
+	[SDM845_MX] = &mx,
+	[SDM845_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sdm845_desc = {
@@ -182,9 +184,9 @@ static const struct rpmhpd_desc sdm845_desc = {
 
 /* SDX55 RPMH powerdomains */
 static struct rpmhpd *sdx55_rpmhpds[] = {
+	[SDX55_CX] = &cx,
 	[SDX55_MSS] = &mss,
 	[SDX55_MX] = &mx,
-	[SDX55_CX] = &cx,
 };
 
 static const struct rpmhpd_desc sdx55_desc = {
@@ -209,17 +211,17 @@ static const struct rpmhpd_desc sm6350_desc = {
 
 /* SM8150 RPMH powerdomains */
 static struct rpmhpd *sm8150_rpmhpds[] = {
-	[SM8150_MSS] = &mss,
-	[SM8150_EBI] = &ebi,
-	[SM8150_LMX] = &lmx,
-	[SM8150_LCX] = &lcx,
-	[SM8150_GFX] = &gfx,
-	[SM8150_MX] = &mx,
-	[SM8150_MX_AO] = &mx_ao,
 	[SM8150_CX] = &cx,
 	[SM8150_CX_AO] = &cx_ao,
+	[SM8150_EBI] = &ebi,
+	[SM8150_GFX] = &gfx,
+	[SM8150_LCX] = &lcx,
+	[SM8150_LMX] = &lmx,
 	[SM8150_MMCX] = &mmcx,
 	[SM8150_MMCX_AO] = &mmcx_ao,
+	[SM8150_MSS] = &mss,
+	[SM8150_MX] = &mx,
+	[SM8150_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sm8150_desc = {
@@ -256,11 +258,11 @@ static struct rpmhpd *sm8350_rpmhpds[] = {
 	[SM8350_LMX] = &lmx,
 	[SM8350_MMCX] = &mmcx,
 	[SM8350_MMCX_AO] = &mmcx_ao,
+	[SM8350_MSS] = &mss,
 	[SM8350_MX] = &mx,
 	[SM8350_MX_AO] = &mx_ao,
 	[SM8350_MXC] = &mxc,
 	[SM8350_MXC_AO] = &mxc_ao,
-	[SM8350_MSS] = &mss,
 };
 
 static const struct rpmhpd_desc sm8350_desc = {
@@ -273,11 +275,11 @@ static struct rpmhpd *sc7180_rpmhpds[] = {
 	[SC7180_CX] = &cx,
 	[SC7180_CX_AO] = &cx_ao,
 	[SC7180_GFX] = &gfx,
-	[SC7180_MX] = &mx,
-	[SC7180_MX_AO] = &mx_ao,
-	[SC7180_LMX] = &lmx,
 	[SC7180_LCX] = &lcx,
+	[SC7180_LMX] = &lmx,
 	[SC7180_MSS] = &mss,
+	[SC7180_MX] = &mx,
+	[SC7180_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sc7180_desc = {
@@ -291,11 +293,11 @@ static struct rpmhpd *sc7280_rpmhpds[] = {
 	[SC7280_CX_AO] = &cx_ao_no_parent,
 	[SC7280_EBI] = &ebi,
 	[SC7280_GFX] = &gfx,
-	[SC7280_MX] = &mx,
-	[SC7280_MX_AO] = &mx_ao,
-	[SC7280_LMX] = &lmx,
 	[SC7280_LCX] = &lcx,
+	[SC7280_LMX] = &lmx,
 	[SC7280_MSS] = &mss,
+	[SC7280_MX] = &mx,
+	[SC7280_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sc7280_desc = {
-- 
2.7.4

