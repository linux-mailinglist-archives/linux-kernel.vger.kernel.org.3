Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27704BFA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiBVOJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiBVOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:09:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36B2215F09A;
        Tue, 22 Feb 2022 06:08:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 033D4106F;
        Tue, 22 Feb 2022 06:08:54 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B91C93F5A1;
        Tue, 22 Feb 2022 06:08:51 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [[PATCH v2 1/2] dt-bindings: opp: Add 'opp-microwatt' entry in the OPP
Date:   Tue, 22 Feb 2022 14:07:45 +0000
Message-Id: <20220222140746.12293-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222140746.12293-1-lukasz.luba@arm.com>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new entry for the OPP which provides information about power
expressed in micro-Watts. It is useful for the Energy Model framework.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 15a76bcd6d42..3f07a279ed2a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -93,6 +93,13 @@ patternProperties:
         minItems: 1
         maxItems: 8   # Should be enough regulators
 
+      opp-microwatt:
+        description:
+          Power for the OPP
+
+          A value representing power for the OPP in micro-Watts.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
       opp-level:
         description:
           A value representing the performance level of the device.
-- 
2.17.1

