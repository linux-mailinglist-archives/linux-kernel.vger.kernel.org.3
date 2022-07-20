Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AE057B00D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiGTEfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTEfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:35:39 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766120BF8;
        Tue, 19 Jul 2022 21:35:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 7452ADF456;
        Tue, 19 Jul 2022 21:35:38 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qwdJKEvluK8Y; Tue, 19 Jul 2022 21:35:37 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658291737; bh=21EHlEvYJ6/Hi/7Okv0PsHmdiPx2MiVdNJTM4K+9T7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qX0ldwsiE19jOVKlsa3YGJWhCA88bEzN/ErndtjGqEMjtGL2AvAASabdxLXT4Egj3
         1vAUmo82JK6Hl8SNwrnV5wvNjo16xzw1vV8c6An/X+mDl3eQBO+6kuFZqSwy44WxM/
         Fh+pMXhy0rhbWVU+OmrCMIw8eyAS+etgudu1nixouizB6E9P5VCPM/A/Hz+CcX7Y80
         jSpcIrvfBcwojvF+IZhVa9Vx9ay/8HJDL4xOU3Mjd81Va2JvQNHn8sfJVevKnYhUNG
         ycrTBAwHu6YkecSQG8bu9/vZ3A2xMsQ2Ode8GkqOg63NXaLSNyIwp89/gzhBnDNIzd
         T8ex3n9Mv/4qg==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 1/3] PM: domain: fix indentation and use BIT macro for flags
Date:   Wed, 20 Jul 2022 06:34:42 +0200
Message-Id: <20220720043444.1289952-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220720043444.1289952-1-martin.kepplinger@puri.sm>
References: <20220720043444.1289952-1-martin.kepplinger@puri.sm>
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

Use the BIT macro for flags and simply do 2 tags indentation.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 include/linux/pm_domain.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ebc351698090..76bc9e3ef5ff 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_PM_DOMAIN_H
 #define _LINUX_PM_DOMAIN_H
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
@@ -61,13 +62,13 @@
  *				components' next wakeup when determining the
  *				optimal idle state.
  */
-#define GENPD_FLAG_PM_CLK	 (1U << 0)
-#define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
-#define GENPD_FLAG_ALWAYS_ON	 (1U << 2)
-#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
-#define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
-#define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
-#define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
+#define GENPD_FLAG_PM_CLK		BIT(0)
+#define GENPD_FLAG_IRQ_SAFE		BIT(1)
+#define GENPD_FLAG_ALWAYS_ON		BIT(2)
+#define GENPD_FLAG_ACTIVE_WAKEUP	BIT(3)
+#define GENPD_FLAG_CPU_DOMAIN		BIT(4)
+#define GENPD_FLAG_RPM_ALWAYS_ON	BIT(5)
+#define GENPD_FLAG_MIN_RESIDENCY	BIT(6)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.30.2

