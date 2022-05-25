Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F11533EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiEYORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiEYORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:17:42 -0400
X-Greylist: delayed 1221 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 07:17:41 PDT
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56739C2CB
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:17:41 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 8CE0448FA1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:57:20 -0500 (CDT)
Received: from 162-215-252-169.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id trVonr8sRpk0JtrVonGP9g; Wed, 25 May 2022 08:57:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5LUB0awXMZiu8jQkcYS4v26EEkwncaXC0X8E7Z9PWUg=; b=VtMUDDSp1odfYSN6zngsMlO1KW
        39Qfou/QfHbqhGoKH/DecuZiuF3Tt+gpuG++GiWfTBH1mD5kf6ZTOJPFCYYrtbN9d06EdD5wka3ET
        s8fyachKXzYZ/cE7wGpTm1N1hX9Bd0f8p6vZvozT7rkEPJFqcPfh21Z++TNIT0EWlL3OY0dMbWxcz
        NWhhXQSdUzUd623HC/LHvcdJsEngsZWHMBBjwZJ4ix7+9k3yMS6LdaQQcVTWu+9FdM99TT1bd6l+T
        nRz8O/aUJz5dODBI/L+u8RtdBf9amJ+GiKtcBRVQWSbyTZiI2EXNB3vtUM0jpnXYcz6IdsGqC4PXp
        IpmQKqPQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58270 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1ntrVn-000P7D-QZ; Wed, 25 May 2022 13:57:19 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/40] hwmon: (lm90) Reorder include files in alphabetical order
Date:   Wed, 25 May 2022 06:56:32 -0700
Message-Id: <20220525135709.2899592-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135709.2899592-1-linux@roeck-us.net>
References: <20220525135709.2899592-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1ntrVn-000P7D-QZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:58270
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 15
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder include files in alphabetical order to reduce the chance of
duplicates and to make it clear where new include files should be
added. Drop the unnecessary include of linux/sysfs.h. Include
linux/device.h instead because that is what is actually used.

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 63ada2d0d839..b7f5b743c9f5 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -80,18 +80,18 @@
  * concern all supported chipsets, unless mentioned otherwise.
  */
 
-#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/slab.h>
+#include <linux/interrupt.h>
 #include <linux/jiffies.h>
-#include <linux/i2c.h>
 #include <linux/hwmon.h>
-#include <linux/err.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
-#include <linux/sysfs.h>
-#include <linux/interrupt.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/workqueue.h>
 
 /*
-- 
2.35.1

