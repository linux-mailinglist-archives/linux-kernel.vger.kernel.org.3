Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84F517156
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385517AbiEBOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiEBOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:18:27 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15615830;
        Mon,  2 May 2022 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651500899; x=1683036899;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=t9A0/owut74r5wrIreSk8Ef8X68zNYGXFoWQAifley0=;
  b=JW/tKRKTFGEilYxb7bi6QZ2DQH3qmy8RNOCzy4CpkOrw9O4y5V/eZa7U
   3ha8wrAWodW1dIVzT1wRGccvq4LnAQ5y2TwY5JSWexQp/+t1f4fMnZ475
   syrvxZ+G6ZBsOucIERe6vS0j/l+U2DJ1klhqxygCYbv7HuWpflvHVqkMl
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 May 2022 07:14:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 07:14:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 07:14:57 -0700
Received: from kaushalk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 07:14:53 -0700
From:   Kaushal Kumar <quic_kaushalk@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>,
        "Kaushal Kumar" <quic_kaushalk@quicinc.com>
Subject: [PATCH v2 0/4] Add QPIC BAM and QPIC NAND devicetree support for SDX65
Date:   Mon, 2 May 2022 07:14:34 -0700
Message-ID: <1651500878-10244-1-git-send-email-quic_kaushalk@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

Hello,

This series adds and enables devicetree nodes for QPIC BAM
and QPIC NAND for Qualcomm SDX65 platform.

Changes since v1:
 - Sort the nodes added for sdx65-mtp in alphabetical order.
 - Rebased on top of 5.18-rc5.

Kaushal Kumar (4):
  ARM: dts: qcom: sdx65: Add QPIC BAM support
  ARM: dts: qcom: sdx65: Add QPIC NAND support
  ARM: dts: qcom: sdx65-mtp: Enable QPIC BAM support
  ARM: dts: qcom: sdx65-mtp: Enable QPIC NAND support

 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 27 +++++++++++++++++++++++----
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

--
2.7.4

