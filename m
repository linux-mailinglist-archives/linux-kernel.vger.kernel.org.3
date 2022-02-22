Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C14BF188
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiBVFho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:37:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiBVFhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:37:21 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF22B12752;
        Mon, 21 Feb 2022 21:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645508216; x=1677044216;
  h=from:to:cc:subject:date:message-id;
  bh=gkq4ET5LSzTZdmH2fPQsTBFW+lLqT0HQdhlrLZFcJmU=;
  b=c1tcvF3GEUFLnm5stkdS9VPcNv1RLmgo9SWlfFuyOWm9qqUa5HwOUjda
   SKYghdVrzu5yXrbr37vggjKGNFU5Cs9y3jPxsVoHD5Z50lQyI8BAWJEJa
   fF7YOv2nsL1acwbBaJuaiTotHSWv4bJP2DKv8UzkUIXWaoYVb+HvBUDs9
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2022 20:56:45 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Feb 2022 20:56:44 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 22 Feb 2022 10:26:29 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 4BCB344B1; Tue, 22 Feb 2022 10:26:28 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v4 0/5] Add APCS support for SDX65
Date:   Tue, 22 Feb 2022 10:26:20 +0530
Message-Id: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Changes from v3:
 - Removed the redundant patches after addressing Mani's comments.
 - Rebased on top of v5.17-rc5.

Changes from v2:
 - Addressed Stephen's comments and made necessary changes.
 - Rebased on top

Changes from v1:
 - Addressed Mani's comments and made necessary changes.
 - Removed the last patch from the series as it became redundant after making changes.

This series adds APCS mailbox and clock support for SDX65. The APCS IP in SDX65
provides IPC and clock functionalities.

Thanks,
Rohit

Rohit Agarwal (5):
  dt-bindings: clock: Add A7 PLL binding for SDX65
  clk: qcom: Add A7 PLL support for SDX65
  ARM: dts: qcom: sdx65: Add support for A7 PLL clock
  ARM: dts: qcom: sdx65: Add support for APCS block
  clk: qcom: Add SDX65 APCS clock controller support

 Documentation/devicetree/bindings/clock/qcom,a7pll.yaml |  2 +-
 arch/arm/boot/dts/qcom-sdx65.dtsi                       | 17 +++++++++++++++++
 drivers/clk/qcom/Kconfig                                | 12 ++++++------
 3 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.7.4

