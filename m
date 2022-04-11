Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05704FC5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349875AbiDKUeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349840AbiDKUd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:33:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D1135DD4;
        Mon, 11 Apr 2022 13:31:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 2so16330906pjw.2;
        Mon, 11 Apr 2022 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5KLzKGdd8LV7gQ18kh9kvdDgQJKmqje3cmp4naYrraY=;
        b=Q3QbFzfI60oebxR9Q15Lz1ZK3ABmd+DU55agMXrZq5s+nmemFrEo9gEHxcWRp2b/xb
         JwmEh8KDzPyO81G2zK/J5bbvdC4D+xzloEskKAFmkyG4ojCJKaL4Af6Sbce1W/cYMXk9
         uZXtWpGlD23kubvxBtUCYHbHHPwUBDWlAYhy4KnsyZ80gW/vlp2tdjIZH74SHldP14kt
         BIrGd6h4IeCNfXT2o83loYBW8w5Gz9ROSwMWMngvXPWmk4zPrOFtOUG5CAxTYJ/7Y8+U
         n7I/ThGHyb5450OuoK6g72noAuN5iH9uZ4xYz8clxG1HYXmNPJJ4DFwLFBERuTNZ5KGr
         iT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5KLzKGdd8LV7gQ18kh9kvdDgQJKmqje3cmp4naYrraY=;
        b=llNPvt6l3lNDcHg22m2Stf4p+W1JjHdaDgNCyiPga3qGXY6i9gQ71oGkFWf173585A
         /vm2oMa9eT23ohGRcHfFdVfXlX/WdS/VGdRzuj2MIMtyQLRdBgPJSmQ5wRmU5tpbMw9v
         AOGFZ2urvAawMoVsxKCoLTNkKJf+8ReT7cQSIoMsKi1ro8Is6OOF0t/cvzqhHAtbpYQv
         4mOZCnUFxW7lviCod45KELjxlH91fIrpwlC10vL+3jRlNf2hs3812O33E9bazzWqqRts
         iHH2NvcpVHLiuujtZwuiPKQ5weazPMogCd0HAY+LhIkVqwaEoyixZHGSTc6DU9fBJ/n/
         4ykg==
X-Gm-Message-State: AOAM5336Acgg0AkVva2BMdRFNZwothegjheFJgJbe0pht1/3+T5yJABN
        hh1lMcyHNIgSXcTq4REM8MNFrfhJkXM=
X-Google-Smtp-Source: ABdhPJxNIUc3kuuGLDE83Tl/3vyAMcpRLkw4diFbiR/hUr12amgBmX64Tv3la2ProziLoipCDBI+Yw==
X-Received: by 2002:a17:90a:6393:b0:1bf:70e7:27d2 with SMTP id f19-20020a17090a639300b001bf70e727d2mr1005552pjj.1.1649709103334;
        Mon, 11 Apr 2022 13:31:43 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:43 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] iio: accel: bma400: Reordering of header files
Date:   Tue, 12 Apr 2022 02:01:26 +0530
Message-Id: <20220411203133.19929-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411203133.19929-1-jagathjog1996@gmail.com>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reordering of header files and removing the iio/sysfs.h since
custom attributes are not being used in the driver.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 043002fe6f63..25ad1f7339bc 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -13,14 +13,14 @@
 
 #include <linux/bitops.h>
 #include <linux/device.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/iio/iio.h>
+
 #include "bma400.h"
 
 /*
-- 
2.17.1

