Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141D457C389
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiGUEgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGUEgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:36:50 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239EA201B3;
        Wed, 20 Jul 2022 21:36:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 476ECDFFAB;
        Wed, 20 Jul 2022 21:36:48 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rt96Whpz_ydo; Wed, 20 Jul 2022 21:36:47 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658378207; bh=21EHlEvYJ6/Hi/7Okv0PsHmdiPx2MiVdNJTM4K+9T7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcgBqctdO+R5QYITj7P7JRPdKewFqcxz1PIBaQds19XfW7g1C4VjyGg4+1TpqSWZp
         c2nQ0vMeeJ74adQHFGkCy4XX565D7Ys8UPoKFEaRrTGTI0sHBMa2z/SGbzY2Ska9b7
         SPNXY89YH8wq9w4+Yeaw6ktWYyOfhqy89TGZlLAyK7SfsGK9TfFkRnIOONnN9dnj1H
         4GVFzYI6EjzjaUh7iCz2TXEsPM9rkIJNx+rJVSRp0Tj1mCg6AvFTpip/puJox/Wwyj
         FRDl6OWPlPD3DseaMaqIzTKRgttBotMAG+atMjdlJfvoZOdlK/cFO88OOJyzwt7/OM
         RF594h3GxcB+g==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v5 1/3] PM: domain: fix indentation and use BIT macro for flags
Date:   Thu, 21 Jul 2022 06:36:06 +0200
Message-Id: <20220721043608.1527686-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220721043608.1527686-1-martin.kepplinger@puri.sm>
References: <20220721043608.1527686-1-martin.kepplinger@puri.sm>
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

