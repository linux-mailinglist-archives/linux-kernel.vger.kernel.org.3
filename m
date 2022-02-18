Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A7B4BB71F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiBRKpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:45:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiBRKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:45:26 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718D25A97C;
        Fri, 18 Feb 2022 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645181109; x=1676717109;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=PyusTaFdH1hjIYp8YUpy2ulfjwpj8H2e2xRoOTVv3lo=;
  b=SaOIQkQcYrX7Soxt3SQ7CvjWVUj9RDZKYVShwyk6NqkMd/DJ6KxFk2oY
   xK6c8GSKhX4DpfHBBUxvQhp8D9rVAuKZHrWv9+pZ4Yfmrp3RAdb6+Op1Q
   11uBrTIqsScPoMNk00s1jKtQUW9NK61Y+AIK+D0D1so+wivcvecZ5j5mx
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Feb 2022 02:45:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 02:45:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 02:45:08 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 02:45:04 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_rjendra@quicinc.com>,
        <quic_saipraka@quicinc.com>, <quic_schowdhu@quicinc.com>
Subject: [Resend PATCH V1 0/2] Revert device tree changes for EUD
Date:   Fri, 18 Feb 2022 16:13:44 +0530
Message-ID: <cover.1645177190.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

Revert the device tree changes for Embedded USB Debugger(EUD)
from the usb tree to avoid conflicts as device tree changes
for EUD are supposed to go from qcom Tree.

Changes in this patch

*Fixed the issue with revert statement.
*Added the signed-off tag.

Souradeep Chowdhury (2):
  Revert "arm64: dts: qcom: sc7280: Set the default dr_mode for usb2"
  Revert "arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector"

 arch/arm64/boot/dts/qcom/sc7280-idp.dts |  4 ----
 arch/arm64/boot/dts/qcom/sc7280.dtsi    | 36 ---------------------------------
 2 files changed, 40 deletions(-)

--
2.7.4

