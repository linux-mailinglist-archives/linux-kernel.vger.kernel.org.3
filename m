Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B177F4B8F01
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiBPRTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:19:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiBPRTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:19:04 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03191C0866;
        Wed, 16 Feb 2022 09:18:48 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21GHIbJN021061;
        Wed, 16 Feb 2022 11:18:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645031917;
        bh=Yy4jGpPS3fEMb8Kl9RYaMpOjJs6HLhtsyLS//EUljlg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TPzwddYz/8VMr9mYSBqIhKQBqgVQhCaE7utc2smTik+ZH5TH7HTJzC1tSNYOkxFyE
         lLI+K6UTj1Fa/ip3YEfr0h/GHBEs4hy1QW9IWshafeH48sKp7xSdhRrKCCk2NF3lhs
         4DSGifDFF3LZ6oLIaJn06PmLQQUdalcgypxQNNdE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21GHIb86102821
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 11:18:37 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 11:18:37 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 11:18:37 -0600
Received: from ula0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21GHIJjR056750;
        Wed, 16 Feb 2022 11:18:33 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] dt-bindings: pinctrl: k3: Introduce pinmux definitions for AM62
Date:   Wed, 16 Feb 2022 22:48:13 +0530
Message-ID: <20220216171815.384377-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216171815.384377-1-vigneshr@ti.com>
References: <20220216171815.384377-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Add pinctrl macros for AM62x SoCs. These macro definitions are similar
to that of previous platforms, but adding new definitions to avoid any
naming confusions in the SoC dts files.

checkpatch insists the following error exists:
ERROR: Macros with complex values should be enclosed in parentheses

However, we do not need parentheses enclosing the values for this
macro as we do intend it to generate two separate values as has been
done for other similar platforms.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/pinctrl/k3.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
index 63e038e36ca3c..a5204ab91d3ec 100644
--- a/include/dt-bindings/pinctrl/k3.h
+++ b/include/dt-bindings/pinctrl/k3.h
@@ -41,4 +41,7 @@
 #define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
+#define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
+#define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
+
 #endif
-- 
2.35.1

