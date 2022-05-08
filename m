Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66CA51EE07
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiEHOaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiEHOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:30:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284E60D7;
        Sun,  8 May 2022 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652019986; x=1683555986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7k1HLML8EiHrtt/rP2Re4XQ7J53RxaR/YSDTSazTTZk=;
  b=mDNZBk/F6ymbScrrn2zRqqte+YSrNAxqxvXfQ09ZG46lUqfoldFm39u2
   BDogJ4OGDtoTB+JHrhaqkF8XFag/9g8XnZMvV0JyEM62Bvyhu0sb3G4RX
   mh6lODgctFbdDKyXGJu1nI7R6Ju5GC9Q9975XRKXC0rX3Rxz6HCrYhAVo
   UJRUQV4tEbepKmYZKb3vQlTKELYE0GxrZ4VgHbIiczsMxIQ+HI7/Y0CW3
   BlWiPDYbugg5mPHNduhtFZrPB6Wx5o777yrhhuoXYk2Fh+JZx0S5Bq811
   comdZzkhI13uIGpBKEfRQOyvg6/stDDdvWGzuNV19SsY3O09lKITYaMZy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="268488488"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="268488488"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 07:26:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="737738698"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 07:26:25 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/3] dt-bindings: intel: add binding for Intel n6000
Date:   Sun,  8 May 2022 07:26:23 -0700
Message-Id: <20220508142624.491045-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add the binding string for the Agilex based Intel n6000 board.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3:
  - added Acked-by
---
 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index 6e043459fcd5..61a454a40e87 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -18,6 +18,7 @@ properties:
         items:
           - enum:
               - intel,n5x-socdk
+              - intel,socfpga-agilex-n6000
               - intel,socfpga-agilex-socdk
           - const: intel,socfpga-agilex
 
-- 
2.25.1

