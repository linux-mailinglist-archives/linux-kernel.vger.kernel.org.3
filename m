Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A49513615
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345814AbiD1OFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiD1OF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:05:26 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83CDAC06A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651154529;
  x=1682690529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eoadti+FXbHTDxNJiKrNmCrJcfdQH+IgsCTuKB5C8z0=;
  b=cAMo2ztw3jFn7vGldLyhRLs9QvTcV2hFjoeqWsKSWoMzDzCLVmnTGQjP
   Ghz3dJjyn+LoOFUYnFeqYAisaquFdQt7X0uVLgUKGW6UCxqOdX3xGAFli
   SwKuHV7V0lgRR6osxO9kjb0r8GrkTSadC+3SvRVoPfK/J41ltWrGBasRK
   AZavwG0HSxFMuyWte2lRQ6eEsCyD3FqRMnK7FvufCMljhDqhxf0aLf5d4
   c8vU6uG+AzFeeWdlSCmfo2/d+xsHaMwlC9FbTQyeS4LM7AOfKUY/SHHA4
   Emq81ISzLh+NRcInILgX6kYxGbIGMs9uKy2FwIl/QBwWXCtRkp3ShQTaR
   w==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yibin.gong@nxp.com>
CC:     <rickaran@axis.com>, <rickard314.andersson@gmail.com>,
        <perdo@axis.com>
Subject: [PATCH 3/5] dt-bindings: regulator: Add property for WDOG_B warm reset
Date:   Thu, 28 Apr 2022 16:01:37 +0200
Message-ID: <20220428140139.7349-3-rickaran@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220428140139.7349-1-rickaran@axis.com>
References: <20220428140139.7349-1-rickaran@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail06w.axis.com (10.20.40.12) To se-mail03w.axis.com
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

