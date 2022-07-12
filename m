Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9575716D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiGLKKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiGLKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:10:10 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E44ACECB;
        Tue, 12 Jul 2022 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1657620574; bh=RqYJd9WMWhQUUPRvy802P6+p3an2H7CBe1ZE7v+RG6w=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=El4ILC98AkU+I3Dq50xTlRQoOKxrSKTUcRVgbyv0OtHFG6I2NdOA4ZrUttZwuKfGw
         y6+AGHIt7sOVj4C433VdY7k/rVou4+pZ4DW55PPsD1+Ma52+s5q3dIi9DIsCDx8Hwc
         GVtB+uNMqnVvh+HyrydWTqQ6+pSIz9GFGCcrsdMU=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.207]
        Tue, 12 Jul 2022 12:09:34 +0200 (CEST)
X-EA-Auth: 1ZnJIAviytXjtFSUkRB449lCznmGB4XeZrGQZaNC9QK2ENtalrcSZv0MzIjhZzjrYoD5RKUJOwcskrzMzHvOgZS6RhqV+cds6nFq4/RRlwg=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        hns@goldelico.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 12/12] leds: is31fl319x: sort header inclusion alphabetically
Date:   Tue, 12 Jul 2022 12:08:38 +0200
Message-Id: <20220712100841.1538395-13-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712100841.1538395-1-vincent.knecht@mailoo.org>
References: <20220712100841.1538395-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sort header inclusion alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/leds/leds-is31fl319x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 52b59b62f437..f2d05ae91753 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -8,7 +8,9 @@
  * effect LEDs.
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
 #include <linux/mod_devicetable.h>
@@ -16,8 +18,6 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
 
 /* register numbers */
 #define IS31FL319X_SHUTDOWN		0x00
-- 
2.35.3



