Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D160C51A1A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351008AbiEDOBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351074AbiEDOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:01:30 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1040B43EEE;
        Wed,  4 May 2022 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651672634; x=1683208634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=32DTrSFoB5STaJHIEVVCzkYM4SEkuLUEXAmueS3X3EM=;
  b=gqeg60DssZMNFWEvyuQCw0W/iXy1fk51OdlNw+eEvDcUsGUNDEqxsGlp
   HFO7gBmqSKiE1H632NXmKYfL4uhkrN3RwfK6C4ajqLDmOY2hQ6YDqNZwu
   2FzORgxmLzZ5LyZ8BsWHSyfcCqRc3K3J6T7P60BQPmgWbu64gjxS+sKh+
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 04 May 2022 06:57:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 06:57:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 06:56:52 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 06:56:46 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH 2/2] pinctrl: qcom: sc7280: Add lpi pinctrl variant data structure for adsp based targets
Date:   Wed, 4 May 2022 19:26:20 +0530
Message-ID: <1651672580-18952-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651672580-18952-1-git-send-email-quic_srivasam@quicinc.com>
References: <1651672580-18952-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string and lpi pinctrl variant data structure for adsp enabled
sc7280 platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
index 2add9a4..c9e85d9 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
@@ -134,6 +134,16 @@ static const struct lpi_function sc7280_functions[] = {
 	LPI_FUNCTION(wsa_swr_data),
 };
 
+static const struct lpi_pinctrl_variant_data sc7280_adsp_lpi_data = {
+	.pins = sc7280_lpi_pins,
+	.npins = ARRAY_SIZE(sc7280_lpi_pins),
+	.groups = sc7280_groups,
+	.ngroups = ARRAY_SIZE(sc7280_groups),
+	.functions = sc7280_functions,
+	.nfunctions = ARRAY_SIZE(sc7280_functions),
+	.is_clk_optional = false,
+};
+
 static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
 	.pins = sc7280_lpi_pins,
 	.npins = ARRAY_SIZE(sc7280_lpi_pins),
@@ -149,6 +159,10 @@ static const struct of_device_id lpi_pinctrl_of_match[] = {
 	       .compatible = "qcom,sc7280-lpass-lpi-pinctrl",
 	       .data = &sc7280_lpi_data,
 	},
+	{
+		.compatible = "qcom,sc7280-lpass-adsp-lpi-pinctrl",
+		.data = &sc7280_adsp_lpi_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
-- 
2.7.4

