Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103A64D14E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbiCHKf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245490AbiCHKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:35:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A175B42483;
        Tue,  8 Mar 2022 02:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646735667; x=1678271667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FlcudMl4wt40GaXEm95OBt7epfsxqnaQwFMkE/EImQI=;
  b=TIZXuLaR06DMqARdlDW2ZbWEzw2MOIG84x2dPYyWYGtopQAuwnU5zd30
   hE//cYiVlhfDUbD4qB/w5QsilMs+iYibOcCEWoCQFeC8X2XW4mqj3M+Hk
   1yJTQEicU81xMkLcKL7RtczFZc/EXOUpjBJVXCM/eFf51VB6BJ+rtfR0m
   0X7/1+RK5IcY3CHqwY04/4wAimLfw/eIzUuHZqulK0wrm3BLeeoSQNRex
   GhVrEnyRrbE2MN8Ap4vPh5QGopF/S/mcBgqtHcYl4kKtjrGZlB/KH0P8M
   dVsiP4WTqdDXEpyMMYlRXrWLH52TA+Yb03sjjSNFPIseMKEEymsiwJWHx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234605596"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="234605596"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:34:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="643612232"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 02:34:23 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v4 1/3] dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
Date:   Tue,  8 Mar 2022 18:33:29 +0800
Message-Id: <20220308103331.4116-2-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308103331.4116-1-nandhini.srikandan@intel.com>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

