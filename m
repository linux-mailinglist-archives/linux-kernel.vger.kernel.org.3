Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CFF4CA3BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiCBLai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbiCBLaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:30:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76F9675E40;
        Wed,  2 Mar 2022 03:29:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EBD013D5;
        Wed,  2 Mar 2022 03:29:40 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 076C53F70D;
        Wed,  2 Mar 2022 03:29:37 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 5/5] Documentation: EM: Describe new registration method using DT
Date:   Wed,  2 Mar 2022 11:29:17 +0000
Message-Id: <20220302112917.27270-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302112917.27270-1-lukasz.luba@arm.com>
References: <20220302112917.27270-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new registration method allows to get power values from the DT OPP
definition. The new OPP entry property "opp-microwatt" contains total
power expressed in micro-Watts. Align the EM documentation with this
new possible registration method of EM.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 5ac62a7b4b7c..49549aab41b4 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -113,6 +113,16 @@ to: return warning/error, stop working or panic.
 See Section 3. for an example of driver implementing this
 callback, or Section 2.4 for further documentation on this API
 
+Registration of EM using DT
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The  EM can also be registered using OPP framework and information in DT
+"operating-points-v2". Each OPP entry in DT can be extended with a property
+"opp-microwatt" containing micro-Watts power value. This OPP DT property
+allows a platform to register EM power values which are reflecting total power
+(static + dynamic). These power values might be coming directly from
+experiments and measurements.
+
 Registration of 'simple' EM
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.17.1

