Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F69467731
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380769AbhLCMYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:24:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53172 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380768AbhLCMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:24:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3CLKWd012644;
        Fri, 3 Dec 2021 06:21:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638534080;
        bh=zCUeNEPn/uK6GG1XOOeNrdU+6ouS9igMSIrag4Cq6YI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f0gBwy9E5oeHjyzYYYHy3H2eNF3TVEM/CLYg5iv2duKCjcmuwwAXM97Ub2sLp/sQR
         AT95uhc5kCxtb1OedUOg3BMVggntHFxgQtWbKiS+vZXWyPwdqHW9pNfMgoOjiUSuDy
         E/Ev/kHH6eoeKsyCo1DnWsP3SaE7RWdZ9B/JIprE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3CLKqn012032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 06:21:20 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 06:21:20 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 06:21:20 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3CLBWN011119;
        Fri, 3 Dec 2021 06:21:17 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v2 2/5] dt-bindings: pinctrl: k3: Introduce pinmux definitions for J721S2
Date:   Fri, 3 Dec 2021 17:51:07 +0530
Message-ID: <20211203122110.16736-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203122110.16736-1-a-govindraju@ti.com>
References: <20211203122110.16736-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl macros for J721S2 SoC. These macro definitions are
similar to that of J721E, but adding new definitions to avoid
any naming confusions in the soc dts files.

checkpatch insists the following error exists:
ERROR: Macros with complex values should be enclosed in parentheses

However, we do not need parentheses enclosing the values for this
macro as we do intend it to generate two separate values as has been
done for other similar platforms.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/pinctrl/k3.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
index e085f102b283..63e038e36ca3 100644
--- a/include/dt-bindings/pinctrl/k3.h
+++ b/include/dt-bindings/pinctrl/k3.h
@@ -38,4 +38,7 @@
 #define AM64X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM64X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
+#define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
+#define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
+
 #endif
-- 
2.17.1

