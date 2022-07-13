Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992B4572C95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiGME33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiGME26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:28:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5DF32B85;
        Tue, 12 Jul 2022 21:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657686531; x=1689222531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mb8fOeDMOUQ3s+b4ghuFSAs0by4vPak2ZcTmVb4tKqU=;
  b=OeFStukkIhKjRHkquwEdHJJXhxrtsJMdPtidfphUVf9Op0GlUIw1iP6g
   wsApkgtaf5wcYlMdqdI9IUE0F39MsP2d/DHFvQjTtdz7Ahcosq99iw++E
   3d2eOgeTJWxRSZdyCBuNGXkW3RprT4+pjk34IKpcry8HFogDLSenY2PjF
   dCoSE0Y593ePwM+ROgs3D4iB+O8/RkQBYv2m0Mk+XvTJ7kDMs46/tglhX
   e22LPhiLgsTuZKZX+KeKHraa74O8EIL/KdBNOGzqcgoLynPESwS6wkrgN
   SuiMEzalxJOwqfupGQ1TLM3G1AJ+YChT4cznibNRPnIXn6p/kuWfpxBxv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="264894386"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="264894386"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 21:28:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570463243"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2022 21:28:47 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v6 2/4] dt-bindings: spi: Add bindings for Intel Thunder Bay SOC
Date:   Wed, 13 Jul 2022 12:22:21 +0800
Message-Id: <20220713042223.1458-3-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713042223.1458-1-nandhini.srikandan@intel.com>
References: <20220713042223.1458-1-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add documentation for SPI controller in Intel Thunder Bay SoC.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index d7e08b03e204..5ecd996ebf33 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -61,6 +61,8 @@ properties:
           - const: snps,dw-apb-ssi
       - description: Intel Keem Bay SPI Controller
         const: intel,keembay-ssi
+      - description: Intel Thunder Bay SPI Controller
+        const: intel,thunderbay-ssi
       - description: Baikal-T1 SPI Controller
         const: baikal,bt1-ssi
       - description: Baikal-T1 System Boot SPI Controller
-- 
2.17.1

