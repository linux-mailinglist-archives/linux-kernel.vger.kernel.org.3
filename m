Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C425091CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382381AbiDTVOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382365AbiDTVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:14:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58E93B556;
        Wed, 20 Apr 2022 14:11:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5so3126888pjr.0;
        Wed, 20 Apr 2022 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SM9i76rzlNMMohIuFLToG7B0unnUzDqCDVvWZiGt2yk=;
        b=NLwhTJBJXzAYGpisF+wKI09cW0hajVJDOqvJ4Q5rknjHXlu0rzvHf2fSF0uxqQqOhR
         6HI+ribLLXelZI5jK3+DlRlLXFI3f5Y0AxKu/i6wb6Lj2rYCASJ4ZGq18Vh8tjsATwwk
         rCN7veSls1QEz4QnJNKtau1jRRjgUh7QFZu77l/vl/U9pYN7jYkHL0K+sP4zFTse0hXV
         ZIMxpBV3Da5nEPmdM3F9Uw3E6x1iYr1edqLTPFJBe5b12wTWE2oTlQfl/vDh6yzkeDC8
         FV/Tm072sTXanefzOhlRAlKoKiOncJOv6oHkFY2G7LblHz9FT/bOo89MX5jK3FKfXD0a
         SmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SM9i76rzlNMMohIuFLToG7B0unnUzDqCDVvWZiGt2yk=;
        b=Ymd2ei+1T8CxD2D1Ifl4ebCngaaQqlYYafFXi10cd3oZPJSUsWkvAz2VDNHuHdSdso
         M78xoRrP+FBuQPQ+Mdf3YHsdFOJ9kLANVOwVFOO4f4aP4e0qVe+V4nTbmxYlVkxahKQz
         5k+ylnejtEhW4ShHc7neXgNhMWVh2SnSx+hmxhMGhiFS1QO8Be+iPOdJh5JNcBwJBb3d
         4MIDuvGFkWWlT7aONk9FFqzgJq3rC8j/leFcB55EKuzBL+aYmRENb9Mkrx/N5CGk9uj6
         fXDU6+kUGCLDXfSdpvMy7ow+p1wBTJzVTW/+yDodB3jPQv/Wjgf9NetcMz48t7KepPm6
         1UzQ==
X-Gm-Message-State: AOAM532mBJnZuHvHohH3E7PvaNoCmStYHCIWYxqJIr/OvQA9X8v1ma6s
        lSj0p9ePr3+M4bRUGA6a/Vw=
X-Google-Smtp-Source: ABdhPJxZdomhYSJJl4Qu6izE+4I0Zzm0XYzeON0sHdxN+3ikBLr2pc/qBtOrN1AnYMHam3x2SXO9/g==
X-Received: by 2002:a17:902:c792:b0:158:ba0c:cf6d with SMTP id w18-20020a170902c79200b00158ba0ccf6dmr22599298pla.131.1650489074176;
        Wed, 20 Apr 2022 14:11:14 -0700 (PDT)
Received: from localhost.localdomain ([27.7.104.83])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001cd4989fee4sm106652pjd.48.2022.04.20.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:11:13 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] iio: accel: bma400: Reordering of header files
Date:   Thu, 21 Apr 2022 02:40:58 +0530
Message-Id: <20220420211105.14654-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420211105.14654-1-jagathjog1996@gmail.com>
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reordering of header files and removing the iio/sysfs.h since
custom attributes are not being used in the driver.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

