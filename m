Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1430B5441B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbiFIC5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFIC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:57:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ADE1A40B1;
        Wed,  8 Jun 2022 19:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654743426; x=1686279426;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DWdTmomDdHvDa03AdXAl+EdQlsJVgcEVxjeDSDWI6GE=;
  b=KEHhg83gXUFPRx1+U1+LYTkm5bC5SCIcYgPzV7t0NJFFCxswh+f9BpSI
   3DGeQc1qFEbRLMt4TFKapP0cojzT6crqhj2XBwCkbPRJQCZO1fvA9QTjH
   Z3xkxwBpeAOzPKcm//wHSfaxpTPr4W7Y/34zS3tV15VrdjJ5qXYjd+GYW
   k6W1MDfPkk8cv9JM63Rdz+ALbTdVDuCprrWldsLDHppQJ6dWfwL9IoX9R
   jNRXs3d+f+X7GbKUsOfOu5EMEVF36ciaeuqWKbsU1OFOrFO5YNaPdQwb5
   BdiEEbMpzSbxks5EdHZnIQAfe1t/OUild8mL9tuLBK9RiNbiUN43g6DgM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="278284863"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="278284863"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:57:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="566189797"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2022 19:57:04 -0700
From:   wen.ping.teh@intel.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Teh Wen Ping <wen.ping.teh@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: altera: document Stratix 10 SWVP compatibles
Date:   Thu,  9 Jun 2022 10:56:47 +0800
Message-Id: <20220609025647.400998-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teh Wen Ping <wen.ping.teh@intel.com>

Add compatible strings for Stratix 10 Software Virtual Platform

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 5e2017c0a051..d9037e4bbf73 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -47,6 +47,7 @@ properties:
         items:
           - enum:
               - altr,socfpga-stratix10-socdk
+              - altr,socfpga-stratix10-swvp
           - const: altr,socfpga-stratix10
 
       - description: SoCFPGA VT
-- 
2.25.1

