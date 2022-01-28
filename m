Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B666549F49A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346976AbiA1Hrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:47:40 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:56931 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346951AbiA1Hrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643356056; x=1674892056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c9Am6qH8JLyj1WRxdU6JExADb+ukurj3xhJlMoIyOTM=;
  b=Xh0JbzjtTZIkn68ptpLXM3U3LzAVJf2ei9/MunKuHhQlZC5WzkyoR06J
   tkZ7qSeBKCqSvC47tuTwcKP/b/JD9fv5GpLXsqNnO7YOUCep0N1A7i7k1
   sv8hOgPDcb/dFFLjF07dclfsGQyjkHx6H9kP01Dah9+ddlqSP/CRpCY1d
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 27 Jan 2022 23:47:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:47:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:35 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:31 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasad <quic_psodagud@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv2 0/9] soc: qcom: llcc: Add LLCC support for SM8450 SoC
Date:   Fri, 28 Jan 2022 13:17:07 +0530
Message-ID: <cover.1643355594.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for LLCC on SM8450 SoC. It mainly
consists of LLCC driver changes to incorporate newer LLCC HW found
on SM8450 SoC and the corresponding DT bits to enable LLCC.
Based on qcom/for-next branch.

Changes in v2:
 * Fix version assignment to drv_data.

Huang Yiwei (1):
  soc: qcom: llcc: Add support for 16 ways of allocation

Sai Prakash Ranjan (8):
  soc: qcom: llcc: Update the logic for version info extraction
  soc: qcom: llcc: Add write-cache cacheable support
  soc: qcom: llcc: Add missing llcc configuration data
  soc: qcom: llcc: Update register offsets for newer LLCC HW
  soc: qcom: llcc: Add configuration data for SM8450 SoC
  dt-bindings: arm: msm: Add LLCC compatible for SM8350
  dt-bindings: arm: msm: Add LLCC compatible for SM8450
  arm64: dts: qcom: sm8450: Add LLCC/system-cache-controller node

 .../bindings/arm/msm/qcom,llcc.yaml           |   2 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   7 ++
 drivers/soc/qcom/llcc-qcom.c                  | 102 +++++++++++++++---
 include/linux/soc/qcom/llcc-qcom.h            |   9 +-
 4 files changed, 105 insertions(+), 15 deletions(-)

-- 
2.33.1

