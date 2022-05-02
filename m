Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750BD516C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380002AbiEBIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383815AbiEBIln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:41:43 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9417B193C0;
        Mon,  2 May 2022 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651480695; x=1683016695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4sArmmPqK1fpsAra+ctcw1Mg8/kPFO/JwQ40cELNy00=;
  b=qh+ah4/9QoDHWWb7zFUkIjNRkbR+FW9GZPCB6Q0IFgAtE5aAOX4yaVd0
   thfGTglA03Qi/bJuN0XcAYCoO3KBGeZd6i9LOUgQ8C6MDUbeY13O/YBvg
   mEs7Tt4HCwU96mLGDSBjJAjeoilqJ1CNc7BT6DInPtuipvOCt8PHm/do5
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 01:38:15 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 01:38:13 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 14:07:50 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 9621E3BE9; Mon,  2 May 2022 14:07:49 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        bhupesh.sharma@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 3/4] dt-bindings: arm-smmu: Add binding for SDX65 SMMU
Date:   Mon,  2 May 2022 14:07:44 +0530
Message-Id: <1651480665-14978-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Qualcomm SDX65 SMMU.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index da5381c..1f99bff 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,sc8180x-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
+              - qcom,sdx65-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
-- 
2.7.4

