Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA451C0BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379655AbiEENeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347880AbiEENeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740756FA5;
        Thu,  5 May 2022 06:30:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i1so4392810plg.7;
        Thu, 05 May 2022 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SM9i76rzlNMMohIuFLToG7B0unnUzDqCDVvWZiGt2yk=;
        b=nmCrClc6I7B/c+cxpGO+mFyf9Qe+in9qQSW7aCB19p3VLwa44gR1RFxw4PB30AEOKQ
         AAWE5wtJJRafPr90FZcq9H+j3JVjNge3U6Ylq71tkyUO4/ZHGjW+OYagyeVCscy+tAHB
         AciV79jq1eqSm5t3pMmocT+fH+mrE8NJAerLjYZB0QQJzpCWTa7VmZn6xO8yUK7e0+uf
         mbalSVD8w256qB3uiBfDyooaFP7MYVE1u5TgKfQFzDG4OtkYFmLlWB4DUAOZvuofIEF3
         yJVGsE2x/PfGg1SXEwdDC8kZhNJB4BRdr/TwAsXHoGMFrO/ztX3VWO3cfS1G5q0xlfKt
         o9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SM9i76rzlNMMohIuFLToG7B0unnUzDqCDVvWZiGt2yk=;
        b=7n0jPHA6eDJh+DnaEHXSpb5yLNHUp67UXPRdVqM+X24HzMYv9lvGP24RrE73bjkqxO
         C0SSdVm8IVzJxEcK2HT13GXfCwh/VU+DpyTwXKvrd4bVhPQ28JHZvBlaVFh9aBvmxrRF
         V8bagHxTiuXjk7/OILX5yuLiuoEG0jG1+cXmLoODZWvzIu4DNHdoE9I70GECFwfyKtan
         shZ8HLWZPNSMkfDc0SB52y34dF+rcquvYnMKhDpk2RiKZQSUlb4y8wk2hm6G5rFPR/Hy
         YoGAoRNqXwNI3TPTKbr+WetsufqK1C8rG9aaVQ6T2ktj4RHK0anYymBDLLQU5m0cVN2F
         OTSw==
X-Gm-Message-State: AOAM532uKdp6wFkuI+LgakQIS6NNyUpXYFF1ImcYEO4b1GIGnIVfFz98
        qbJ4LGuND1XzXYTAqtdWvyk=
X-Google-Smtp-Source: ABdhPJzUmTCAtgJFSOMDrOHGgHWNEH/LwXsbyzPk6V11VCzSw6wKQlPIG9DpMJU9FQ7LS792KcIQGw==
X-Received: by 2002:a17:90a:7acb:b0:1d9:85a5:e1e3 with SMTP id b11-20020a17090a7acb00b001d985a5e1e3mr6138961pjl.172.1651757430611;
        Thu, 05 May 2022 06:30:30 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:30 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/10] iio: accel: bma400: Reordering of header files
Date:   Thu,  5 May 2022 19:00:13 +0530
Message-Id: <20220505133021.22362-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505133021.22362-1-jagathjog1996@gmail.com>
References: <20220505133021.22362-1-jagathjog1996@gmail.com>
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

