Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6892F4DAAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353953AbiCPGTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353879AbiCPGTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:19:14 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D82183;
        Tue, 15 Mar 2022 23:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647411471; x=1678947471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FIrvkil500o1PdSCRXvsNurD8KwexitS8f+fJQNePe8=;
  b=eigEuQv8DFsIvpSHxWQ6IIpd1becHWNsP0r4zFntRj0ZcdeWsEq3epsN
   IVuMnh+oQXaZgwAcVjY4o3Uh1klsWisIG+UcYBr/uDvmN8rBzp5D4kPjO
   Dhw4TGgLeBVpbbE8kap0pKqIwOKcoe9V5jxDYcYPsnTXt9OKgi3soVwEw
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 23:17:51 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 23:17:50 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 Mar 2022 11:47:36 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 3AC16478E; Wed, 16 Mar 2022 11:47:35 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/6] ARM: dts: qcom: sdx65-mtp: Add pmk8350b and pm8150b pmic
Date:   Wed, 16 Mar 2022 11:47:23 +0530
Message-Id: <1647411447-25249-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647411447-25249-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1647411447-25249-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDX65-mtp features PMK8350b and PM8150B pmic, so include the dts as well

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 59457da..9fa251a 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -5,6 +5,8 @@
 /dts-v1/;
 
 #include "qcom-sdx65.dtsi"
+#include <arm64/qcom/pmk8350.dtsi>
+#include <arm64/qcom/pm8150b.dtsi>
 
 / {
 	model = "Qualcomm Technologies, Inc. SDX65 MTP";
-- 
2.7.4

