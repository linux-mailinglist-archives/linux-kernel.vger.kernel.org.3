Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A40D47806B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhLPXTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:19:06 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48561 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234193AbhLPXTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639696745; x=1671232745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r5gDvMoc92iDL10QJcM/tNCFOMSxMcUv+DruqpznXEQ=;
  b=a8YI4Jru9DJ4ePaj/UU6k9Q3R0INP3HQ+II3ALqliqCqA6q/rkQ9rRoj
   Gx54L+cp1aQtGKt5Xfy5KtEm4o3NiILhiLwAAfQqJ6FZd5cHearTyvL7H
   rpIJGDw2Nv2INufiSHq9LajLIJcb10VuozkZGTC9r68wSSv3PizeW67Eg
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Dec 2021 15:19:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 15:19:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 16 Dec 2021 15:19:03 -0800
Received: from hu-vamslank-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 16 Dec 2021 15:19:03 -0800
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Subject: [PATCH v6 0/2] Add pinctrl support for SDX65 
Date:   Thu, 16 Dec 2021 15:18:44 -0800
Message-ID: <cover.1639696427.git.quic_vamslank@quicinc.com>
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

From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>

Hello,

Changes from v5:
 - Fixed pinctrl dt_binding comments from Bjorn and Rob 

Changes from v4:
 - Fixed dt_binding check errors

Changes from v3:
 - Addressed comments, fixed dt_binding check errors and collected reviewed
   by from Bjorn
 - Rebased on top of v5.16-rc1

Changes from v2:
 - Addressed comments from Bjorn
 - Collected Reviewed-by for the patches

Changes from v1:
 - Addressed all Bjorn's comments

This patch series adds pinctrl bindings and tlmm support for SDX65.

Thanks,
Vamsi

Vamsi Krishna Lanka (2):
  dt-bindings: pinctrl: qcom: Add SDX65 pinctrl bindings
  pinctrl: qcom: Add SDX65 pincontrol driver

 .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 191 ++++
 drivers/pinctrl/qcom/Kconfig                  |   9 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-sdx65.c          | 967 ++++++++++++++++++
 4 files changed, 1168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdx65.c


base-commit: 58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
prerequisite-patch-id: 93a6639086d56aaaf0c5d0e108a7a7690d39967f
prerequisite-patch-id: 889196dd8ff26aaa113c94ac27b67f708301cd22
prerequisite-patch-id: bca9c19611da01ed598f8645e6be49f8def4d683
prerequisite-patch-id: ba1594c6d524ae889dd4325d0912848f5542633b
prerequisite-patch-id: 6efd062dc77400d108f3f4a0c66010c69759d64a
prerequisite-patch-id: fb27c240bc512176c822e6f1c7cb5b8d65633c56
prerequisite-patch-id: 8125f49031bb5d9ebca1ca3e622080d6d3683bfb
prerequisite-patch-id: e6ecff6bfb4016b9118b2b25f4077355a1448220
prerequisite-patch-id: ba2f7d61be224484482d4910116ea69f1f5200ea
-- 
2.33.1

