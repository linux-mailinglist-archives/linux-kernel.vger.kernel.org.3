Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F9C4FCE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347548AbiDLFKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiDLFKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:10:14 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531D9205FB;
        Mon, 11 Apr 2022 22:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649740078; x=1681276078;
  h=from:to:cc:subject:date:message-id;
  bh=Q1LisC+ybM0o+PHGaH+yX3N3J4FLQNdqM8TUd8eQFg8=;
  b=js3ipdQ4mQoVe2qdAijfWY8IVppMZtBxgc+xE9W9Tk8RXmdr/gEAGlnl
   8AD48kVmSkTnNBNxn+ByvjLq2Jtj+yDORjSQEO//eWvO+PlhiaJqSPsFf
   D30EucNKu9QJFLmbv0QCnYe+b5lAwY7If4zSiG2rL7+EUbFuBVAOVdtK5
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 22:07:58 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Apr 2022 22:07:56 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Apr 2022 10:37:42 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 23281372A; Tue, 12 Apr 2022 10:37:41 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/2] Add interconnect driver for SDX65
Date:   Tue, 12 Apr 2022 10:37:31 +0530
Message-Id: <1649740053-14507-1-git-send-email-quic_rohiagar@quicinc.com>
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

Hello,

This series adds interconnect driver support for SDX65 platform 
for scaling the bandwidth requirements over RPMh.

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: interconnect: Add Qualcomm SDX65 DT bindings
  interconnect: qcom: Add SDX65 interconnect provider driver

 .../bindings/interconnect/qcom,rpmh.yaml           |   3 +
 drivers/interconnect/qcom/Kconfig                  |   9 +
 drivers/interconnect/qcom/Makefile                 |   2 +
 drivers/interconnect/qcom/sdx65.c                  | 231 +++++++++++++++++++++
 drivers/interconnect/qcom/sdx65.h                  |  65 ++++++
 include/dt-bindings/interconnect/qcom,sdx65.h      |  67 ++++++
 6 files changed, 377 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sdx65.c
 create mode 100644 drivers/interconnect/qcom/sdx65.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx65.h

-- 
2.7.4

