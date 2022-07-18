Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C873578C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiGRVDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGRVDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:03:43 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB331DF1;
        Mon, 18 Jul 2022 14:03:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id EB216DFD77;
        Mon, 18 Jul 2022 14:03:41 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TJIjcO-j1qqr; Mon, 18 Jul 2022 14:03:41 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658178221; bh=SopZheUpeX2P7XiNueg8i93IAxi7p5txI7TxjcREDHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NM3TjqxKIAV3RadRloyPN95LAsH3yuDJjJ8FP0R+rH3ta6Ne+EN8VbQ6mB1Mo9hq2
         ZXiBX3Y+y7xffyZjGHpXCwT234LbMZYj0JvnLe8QAIfL92QRgkum9av2V5TROUMYpM
         s4cYoAk8eaQArINOUIpsnPxR85X1Qg7oThLgXbyEP9tEhBEehtxw8qKSc8DRlfNrSm
         dHBmHOWyipyWexx8TKhcIiQe5qGJHpU0oFuCepPKTnydA3FNeD9AjTjDqWm2Z+xf2G
         lOg62kGd1P8zzGduuyOfU6EQgcfO41dHKHzV4oivi+KCrsnWU87RwH/ZGtSvVpboio
         VHehKOT0+5WUA==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 2/2] PM: domains: fix indentation and use BIT macro for flags
Date:   Mon, 18 Jul 2022 23:03:02 +0200
Message-Id: <20220718210302.674897-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220718210302.674897-1-martin.kepplinger@puri.sm>
References: <20220718210302.674897-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 2 tabs for indentation in order to simplify and make room
for longer flag names.

Also, use the BIT macro for bit flags.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 include/linux/pm_domain.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index bcceaf376f36..36887f110ca9 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_PM_DOMAIN_H
 #define _LINUX_PM_DOMAIN_H
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
@@ -66,14 +67,14 @@
  *				Use the outer suspend/resume callbacks instead
  *				of noirq for example.
  */
-#define GENPD_FLAG_PM_CLK	 (1U << 0)
-#define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
-#define GENPD_FLAG_ALWAYS_ON	 (1U << 2)
-#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
-#define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
-#define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
-#define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
-#define GENPD_FLAG_IRQ_POWER_SUPPLY (1U << 7)
+#define GENPD_FLAG_PM_CLK		BIT(0)
+#define GENPD_FLAG_IRQ_SAFE		BIT(1)
+#define GENPD_FLAG_ALWAYS_ON		BIT(2)
+#define GENPD_FLAG_ACTIVE_WAKEUP	BIT(3)
+#define GENPD_FLAG_CPU_DOMAIN		BIT(4)
+#define GENPD_FLAG_RPM_ALWAYS_ON	BIT(5)
+#define GENPD_FLAG_MIN_RESIDENCY	BIT(6)
+#define GENPD_FLAG_IRQ_POWER_SUPPLY	BIT(7)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.30.2

