Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765954CA176
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbiCBJ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiCBJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:57:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA768BA756;
        Wed,  2 Mar 2022 01:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646215031; x=1677751031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9pJEOrD73oAQCPOOwxMD+qRqXz+/orCAtrsg7UcYRhU=;
  b=LLq/+P4qaELxm6qe/F5bdE6a8c8gaijIng74eWbre6G2gSu04d3a8+q6
   Vp2IHtQuq4T9gz+g65AJ6IY+HjLTBal7AXr7Yr6nAmRecWFcHGeDQdj2o
   Rpb7cqgnRg2a4nazs70CYVwnku/yBHpEMXiBud5GphU60gi5Pzfyqd6Jj
   GQhFSEgNN02jjWiX5akFQGbApO/xdiR8Zeic8snD1rIz428mZm6ymIx7J
   4Zm+WPSfg56N/bBsiNpap9mu2C7Xy6HvF770KBZOwiBimxT4PgDK/XNnR
   oUEAxK40JuT2OUPl0eNQ9U5lPYYkSd9T7spBtCj7WYEMneea8K5vBM/Xf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="339794569"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="339794569"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:57:11 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="551182126"
Received: from abotoi-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.218.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:57:07 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 4/7] dt_bindings: snps-dw-apb-uart: Add RS485
Date:   Wed,  2 Mar 2022 11:56:03 +0200
Message-Id: <20220302095606.14818-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RS485 enable & line polarity properties.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../bindings/serial/snps-dw-apb-uart.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 12137fe80acf..8d440afabb1f 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -103,6 +103,23 @@ properties:
       register. Define this if your serial port does not use this pin.
     type: boolean
 
+  snps,rs485-interface-en:
+    description: Use true RS-485 DE and RE signals (in contrast to RS-485
+      emulation using RTS). Requires IP version 4 or above.
+    type: boolean
+
+  snps,de-active-high:
+    description: Defines the polarity of driver enable (DE_EN) signal.
+      Meaningful only with snps,rs485-interface-en. True indicates active
+      high.
+    type: boolean
+
+  snps,re-active-high:
+    description: Defines the polarity of receiver enable (RE_EN) signal.
+      Meaningful only with snps,rs485-interface-en. True indicates active
+      high.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.30.2

