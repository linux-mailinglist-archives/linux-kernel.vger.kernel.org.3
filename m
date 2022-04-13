Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41C44FF735
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiDMM4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiDMM43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:56:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81053B4C;
        Wed, 13 Apr 2022 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649854448; x=1681390448;
  h=from:to:cc:subject:date:message-id;
  bh=5xRQ8goNdbg3PNC/HfjumOMnpeRAm6Z/VpX0ULTu4M4=;
  b=eek9xqWVrKjt6YOIxYzczxQpGBp71a9cP8v4qIQExTKGP0dhRCjCECB5
   W9yn/U+1DRGU+xDCTDIwqfj2arl2zKlWjfDuvRxUsDJdg9Ycbx1pDQOyu
   gZhj9veMuBLiY31OiOQWI1nWiR9bh+00nKJRrXh/RwakhFGeKRjr0xsu9
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 05:54:08 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Apr 2022 05:54:06 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 13 Apr 2022 18:23:49 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id A583E3AC2; Wed, 13 Apr 2022 18:23:47 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 0/2] Add interconnect driver for SDX65
Date:   Wed, 13 Apr 2022 18:23:33 +0530
Message-Id: <1649854415-11174-1-git-send-email-quic_rohiagar@quicinc.com>
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

This series adds interconnect driver support for SDX65 
platform for scaling the bandwidth requirements over RPMh.

Changes from v1:
 - Addressed Krzysztof's comments and made necessary changes.

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

