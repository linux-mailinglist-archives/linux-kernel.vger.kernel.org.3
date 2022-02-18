Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671EA4BB88D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiBRLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:44:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiBRLoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:44:09 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEBF13D2A;
        Fri, 18 Feb 2022 03:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2XxsiK92ajTqs46b9089NxLucidVFVpIJiUHsplfle8=; b=WuyCmhF77fhLnfvhgij+hUCZ14
        SMqaxYKi4+t0lS536/HHtA/faGxpnHnrMtYOLZc/ltcEhYUSFX/V6TLCkGn//1YZhrZbJPNdviNDH
        FGLA2c7P4rs2np3rcgr49GAA0q3U7aDn7YfpVvvu8m80NIHo5LW8FFyISXiobkXq6F3qMlE2bqJSH
        0jtnCLv3oD+gDKHVLTvkpJh4igZZSp16K1J7ulb0Bl5wbxDBqkdGAvUtDTcgRWEhaNrkk/EUWtYCM
        JIq0SVMkqBP/QtZWfGaPOlot2NkXsWS/B4j8+NnkW4tk88jTcDiePoRuP8hU7vR/RaPXd+LhZgIXg
        Oc32ZZNw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mperttunen@nvidia.com>)
        id 1nL1fp-0006eP-RF; Fri, 18 Feb 2022 13:43:41 +0200
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 1/9] dt-bindings: host1x: Add memory-contexts property
Date:   Fri, 18 Feb 2022 13:39:44 +0200
Message-Id: <20220218113952.3077606-2-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220218113952.3077606-1-mperttunen@nvidia.com>
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add schema information for the memory-contexts property used to
specify context stream IDs. This uses the standard iommu-map property
inside a child node.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v3:
* New patch
---
 .../bindings/display/tegra/nvidia,tegra20-host1x.yaml  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
index 4fd513efb0f7..3ac0fde54a16 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
@@ -144,6 +144,16 @@ allOf:
         reset-names:
           maxItems: 1
 
+        memory-contexts:
+          type: object
+          properties:
+            iommu-map:
+              description: Specification of stream IDs available for memory context device
+                use. Should be a mapping of IDs 0..n to IOMMU entries corresponding to
+                usable stream IDs.
+          required:
+            - iommu-map
+
       required:
         - reg-names
 
-- 
2.35.0

