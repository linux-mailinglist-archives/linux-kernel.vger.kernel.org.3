Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3019A4FCEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiDLFUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347941AbiDLFUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:20:14 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0034667;
        Mon, 11 Apr 2022 22:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649740678; x=1681276678;
  h=from:to:cc:subject:date:message-id;
  bh=6TerQcObOlqr8tjuxzxffI/r6EQpo7j9Xxg9/OaAWcE=;
  b=cV3G9L67BdLYBOXNltog99gbgwtZr6jxva3qzl2ga+uRGX30BuPu16ut
   ABKvRotlFThyAN2vsHMFA+bPLhptql0zlf4XAs54cRCaV+xKKcCoULsLS
   jutNcnp5HXzdBrsafFyoSQSxYpKdpK3xUuIEXsmpmus5H9pGq8wpBLVIq
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 22:17:58 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Apr 2022 22:17:57 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 Apr 2022 10:47:39 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 87F4E372A; Tue, 12 Apr 2022 10:47:37 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/2] Add support for USB3 PHY on SDX65
Date:   Tue, 12 Apr 2022 10:47:30 +0530
Message-Id: <1649740652-17515-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds USB3 PHY support for SDX65 platform. The USB3 PHY is of
type QMP and revision 5.0.0.

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: phy: qcom,qmp: Add SDX65 USB PHY binding
  phy: qcom-qmp: Add support for SDX65 QMP PHY

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |  2 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 76 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)

-- 
2.7.4

