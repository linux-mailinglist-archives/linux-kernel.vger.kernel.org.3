Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741C04C2566
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiBXINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiBXIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:12:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EFA22018F;
        Thu, 24 Feb 2022 00:11:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C736F1509;
        Thu, 24 Feb 2022 00:11:42 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 916623F70D;
        Thu, 24 Feb 2022 00:11:40 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: opp: Add "opp-microwatt" entry in the OPP
Date:   Thu, 24 Feb 2022 08:11:28 +0000
Message-Id: <20220224081131.27282-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224081131.27282-1-lukasz.luba@arm.com>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
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
 .../devicetree/bindings/opp/opp-v2-base.yaml      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 15a76bcd6d42..433164186a98 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -93,6 +93,21 @@ patternProperties:
         minItems: 1
         maxItems: 8   # Should be enough regulators
 
+      opp-microwatt:
+        description: |
+          The power for the OPP in micro-Watts.
+
+          Entries for multiple regulators shall be provided in the same field
+          separated by angular brackets <>. If current values aren't required
+          for a regulator, then it shall be filled with 0. If power values
+          aren't required for any of the regulators, then this field is not
+          required. The OPP binding doesn't provide any provisions to relate the
+          values to their power supplies or the order in which the supplies need
+          to be configured and that is left for the implementation specific
+          binding.
+        minItems: 1
+        maxItems: 8   # Should be enough regulators
+
       opp-level:
         description:
           A value representing the performance level of the device.
-- 
2.17.1

