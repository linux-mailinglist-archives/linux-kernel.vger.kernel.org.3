Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9746EB57
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbhLIPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:36:29 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:2095 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239760AbhLIPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639063954; x=1670599954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vjtelNuAG8gFi5r3mSXGiJCP8HhpHSnH7lShGO1xBR4=;
  b=ES5tcxXmO1tXH9IOH1dyLHNziRadyCtoVjjGfn23+SCYiP1keTwZhqu2
   eiCh/XV4KOevE+CUD90naR/B6EHfXD/Zn5Pk3zz33Wwc38ocyKX2FZ14V
   a4XUMjMDzW7Arv9yh32TbxmsLfg7ZFWj/dh+Ov4IEa1WkRjb4NZ0do3Le
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Dec 2021 07:32:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 07:32:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 07:32:33 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 07:32:30 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v3 4/4] soc: qcom: rpmhpd: Sort power-domain definitions and lists
Date:   Thu, 9 Dec 2021 21:01:57 +0530
Message-ID: <1639063917-9011-5-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639063917-9011-1-git-send-email-quic_rjendra@quicinc.com>
References: <1639063917-9011-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort all power-domain defines and the SoC specific lists in
alphabetical order for better readability.
No functional changes.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 drivers/soc/qcom/rpmhpd.c | 122 +++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 60 deletions(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 6360204..58f1dc9 100644
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
@@ -134,6 +97,26 @@ static struct rpmhpd cx_ao_w_mx_parent = {
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
@@ -164,6 +147,25 @@ static struct rpmhpd mmcx_ao_w_cx_parent = {
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
@@ -180,15 +182,15 @@ static struct rpmhpd mxc_ao = {
 
 /* SDM845 RPMH powerdomains */
 static struct rpmhpd *sdm845_rpmhpds[] = {
-	[SDM845_EBI] = &ebi,
-	[SDM845_MX] = &mx,
-	[SDM845_MX_AO] = &mx_ao,
 	[SDM845_CX] = &cx_w_mx_parent,
 	[SDM845_CX_AO] = &cx_ao_w_mx_parent,
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
@@ -198,9 +200,9 @@ static const struct rpmhpd_desc sdm845_desc = {
 
 /* SDX55 RPMH powerdomains */
 static struct rpmhpd *sdx55_rpmhpds[] = {
+	[SDX55_CX] = &cx_w_mx_parent,
 	[SDX55_MSS] = &mss,
 	[SDX55_MX] = &mx,
-	[SDX55_CX] = &cx_w_mx_parent,
 };
 
 static const struct rpmhpd_desc sdx55_desc = {
@@ -225,17 +227,17 @@ static const struct rpmhpd_desc sm6350_desc = {
 
 /* SM8150 RPMH powerdomains */
 static struct rpmhpd *sm8150_rpmhpds[] = {
-	[SM8150_MSS] = &mss,
-	[SM8150_EBI] = &ebi,
-	[SM8150_LMX] = &lmx,
-	[SM8150_LCX] = &lcx,
-	[SM8150_GFX] = &gfx,
-	[SM8150_MX] = &mx,
-	[SM8150_MX_AO] = &mx_ao,
 	[SM8150_CX] = &cx_w_mx_parent,
 	[SM8150_CX_AO] = &cx_ao_w_mx_parent,
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
@@ -272,11 +274,11 @@ static struct rpmhpd *sm8350_rpmhpds[] = {
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
@@ -294,11 +296,11 @@ static struct rpmhpd *sm8450_rpmhpds[] = {
 	[SM8450_LMX] = &lmx,
 	[SM8450_MMCX] = &mmcx_w_cx_parent,
 	[SM8450_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[SM8450_MSS] = &mss,
 	[SM8450_MX] = &mx,
 	[SM8450_MX_AO] = &mx_ao,
 	[SM8450_MXC] = &mxc,
 	[SM8450_MXC_AO] = &mxc_ao,
-	[SM8450_MSS] = &mss,
 };
 
 static const struct rpmhpd_desc sm8450_desc = {
@@ -311,11 +313,11 @@ static struct rpmhpd *sc7180_rpmhpds[] = {
 	[SC7180_CX] = &cx_w_mx_parent,
 	[SC7180_CX_AO] = &cx_ao_w_mx_parent,
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
@@ -329,11 +331,11 @@ static struct rpmhpd *sc7280_rpmhpds[] = {
 	[SC7280_CX_AO] = &cx_ao,
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

