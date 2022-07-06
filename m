Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2654567D4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiGFE0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiGFE00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:26:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E737C1BE86;
        Tue,  5 Jul 2022 21:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657081585; x=1688617585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FlcudMl4wt40GaXEm95OBt7epfsxqnaQwFMkE/EImQI=;
  b=Yxok1eHBcv5InlmWCvnxMaV53IF64K6WCmeY6r8NaHksBpkKAzlcZUJ3
   6IPFeeqOaJUPKOgxz+j1q9SSQOzfbRsiNUcWbdazR0gUNuIyuXatGQOnh
   mYFheIaGy0aUWGcdp4ApKg0iF/jnM9sNiEepHR32X31FNjm4PA5BcilPG
   HPkinghzKpNkgXr2UmNl4yDasrPtvpOWQXnsUiM/2yvOIcBdA3NFK8ERL
   KBx8/rfUmkvhYofMQgsp0Afs8vyJHKriyISx1/1jF/vqgTH8Xjwpl03TN
   wds1dFs8nB24r+eyJJoX2hnx5bNu7sGvL9IQQVANwZ5Xb5g8vy7tPcXxz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="283663251"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="283663251"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 21:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="769895435"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2022 21:26:22 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v5 2/4] dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
Date:   Wed,  6 Jul 2022 12:20:37 +0800
Message-Id: <20220706042039.5763-3-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220706042039.5763-1-nandhini.srikandan@intel.com>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add documentation for SPI controller in Intel Thunder Bay SoC.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
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

