Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A85A4DAA94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353877AbiCPGTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbiCPGTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:19:02 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1826BFA;
        Tue, 15 Mar 2022 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647411468; x=1678947468;
  h=from:to:cc:subject:date:message-id;
  bh=GXKf2MEsftgKvPPSsdXUv0GDFkd/Fk0rLqp0uafOgE8=;
  b=sCl9lq1Y+6ouTdV3KBsNNa7OZs8lQnAtk6X+xHK8J13jqwvrruLPaVng
   0zHCwHafxauDGwoIWWJ1pL51zD25ESHHI+/Za1XUO5jLzWJtYRlRFHjgw
   QNeIfVh6N8WNS8rCzN2xHw6ZhwXo7EFiW/+wd735ngGUkW9vx1KltWr/o
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 23:17:47 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 23:17:46 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 Mar 2022 11:47:34 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 5285B4495; Wed, 16 Mar 2022 11:47:33 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/6] Devicetree updates for SDX65 platform
Date:   Wed, 16 Mar 2022 11:47:21 +0530
Message-Id: <1647411447-25249-1-git-send-email-quic_rohiagar@quicinc.com>
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

This series adds all the devicetree nodes related to power domains
and regulators in SDX65 platform.

Thanks,
Rohit.

Rohit Agarwal (6):
  ARM: dts: qcom: sdx65: Add spmi node
  ARM: dts: qcom: sdx65-mtp: Add pmk8350b and pm8150b pmic
  ARM: dts: qcom: sdx65-mtp: Add pmx65 pmic
  ARM: dts: qcom: sdx65: Add rpmpd node
  ARM: dts: qcom: Add PMIC pmx65 dts
  ARM: dts: qcom: sdx65-mtp: Add regulator nodes

 arch/arm/boot/dts/qcom-pmx65.dtsi    |  32 ++++++
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 200 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-sdx65.dtsi    |  70 ++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-pmx65.dtsi

-- 
2.7.4

