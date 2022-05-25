Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4A533E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiEYN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244532AbiEYN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:08 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFA09CF63;
        Wed, 25 May 2022 06:58:07 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q8so25048035oif.13;
        Wed, 25 May 2022 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LUB0awXMZiu8jQkcYS4v26EEkwncaXC0X8E7Z9PWUg=;
        b=HtjK7RGNb6WcX5YI6W9cyrl6xYozpT4vYxQ+097WahfnUOyongDMPSYP/StpGOcf7Q
         HtHtyBC0LVzMz9bkY1g7wdPNb43wwI1IVA7WvltrgT521dSbSjUFoYQVcSITyddQc0kA
         ITIcg5zjA28BHpL7J4E8oWaWnBLIRn6iYZkuYQPw8ApRtF2+Vbb/tNVyM95xGqTxwDDn
         HLxhLSS9Y3Yb1LYPg7ZdvAakpved3QMRD0VGmOnaao+YXL9EZA3hHYtbdpnlCbaQTgRv
         G+iP2w3nYintvf3bsZL7fWSCfBwhBVPN8QjAsEN/sFEm7rO4R9bBtII/Tf+kjHzVwjl3
         qHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5LUB0awXMZiu8jQkcYS4v26EEkwncaXC0X8E7Z9PWUg=;
        b=yZWm0nOF3uzIBggFiI6GpEstTtHSCEKO1OIgpTNviw9bkxuTEz/xFr0aavGKx9rmUZ
         J7Q2ofBs36vCg6g71U5PBF3rFs65VD62R+YghFvbtz3A1EhuneWtg5S3Gjlrq/Yw3Fem
         aBykAC2G6DpAE+6/P2Hl3VX+JLE/F93BDLqYIHGwdPvzqcFO8CcfVPO72LXvx4YST5Me
         F+NH/vGjqDGTGHSPw3PxZAV46LMz/nhX5mmhuFyATn8HhhTFaqz6ta3BGAJ7aD/patSc
         46ikdEp5CeNYO+tMY/EdjwMEFDgW0i6FpXRiwHHDSz4+lmh37cfGsZyewKAuddOXiH5m
         +c6g==
X-Gm-Message-State: AOAM531NZsti0mOeYsGlM2h+prnb9U8m/qfOQFa+3dx+Gg23xm1W9LwT
        7kzuqAYTCKjH+V35nq4f8vojK35BpiaHxA==
X-Google-Smtp-Source: ABdhPJyjK11BqTxFirz5fryD7zU6wwha9kafx8bCQ32asNGp5og/FuKZZR2LQjd3V6xN7rO7wI7lWQ==
X-Received: by 2002:a05:6808:2192:b0:32b:8790:e706 with SMTP id be18-20020a056808219200b0032b8790e706mr3801797oib.160.1653487087160;
        Wed, 25 May 2022 06:58:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000f2c0ec657asm634399oao.0.2022.05.25.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/40] hwmon: (lm90) Reorder include files in alphabetical order
Date:   Wed, 25 May 2022 06:57:21 -0700
Message-Id: <20220525135758.2944744-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

