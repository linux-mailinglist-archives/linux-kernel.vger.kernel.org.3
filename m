Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31D3514333
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355109AbiD2HZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344662AbiD2HZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:25:47 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F59BF949
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651216950;
  x=1682752950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eoadti+FXbHTDxNJiKrNmCrJcfdQH+IgsCTuKB5C8z0=;
  b=mQatHb6kX6aOcAfAyYAageftOYAF/Uhv27rrHdJuOTZ1OYA/V5fnbT0e
   7jrOxuMXitKptpbe69XnUV+pGCpIDDhZsgPn0qkpwxfvm2QycftsSL1Ql
   UMCAJsM8nA3u/DQxJm5KRMcMszRcKHs1MDAOhKNceW5tfnEJzPEOBsL6O
   +DBAZisrYDzpZpyIA19tSuOSdcO7BKyay7n1aKiuHsnbLVyIv1dS/M/5C
   VMcu1cw7jBI2b89S5G5YxGOX7xaFJiAhs/uUNk/oEbmw18vZXwdKR/Jbj
   PiIM3Iqb5F2rWCGeTbc2RIzIe2cU2XE3EEB+yJ6pj2TUMoHF5Ib3RnMj0
   A==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rickaran@axis.com>, <rickard314.andersson@gmail.com>,
        <perdo@axis.com>
Subject: [PATCH v2 3/5] dt-bindings: regulator: Add property for WDOG_B warm reset
Date:   Fri, 29 Apr 2022 09:22:09 +0200
Message-ID: <20220429072211.24957-3-rickaran@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220429072211.24957-1-rickaran@axis.com>
References: <20220429072211.24957-1-rickaran@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rickard x Andersson <rickaran@axis.com>

Make it possible to do warm reset on WDOG_B assertion.

Signed-off-by: Rickard x Andersson <rickaran@axis.com>
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml           | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index e723f8cf6d74..b539781e39aa 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -97,6 +97,12 @@ properties:
     description:
       Indicates that the I2C Level Translator is used.
 
+  nxp,wdog_b-warm-reset:
+    type: boolean
+    description:
+      When WDOG_B signal is asserted a warm reset will be done instead of cold
+      reset.
+
 required:
   - compatible
   - reg
-- 
2.20.1

