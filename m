Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED0658AF39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbiHERy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbiHERy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:54:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781E192A2;
        Fri,  5 Aug 2022 10:54:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h13so4038646wrf.6;
        Fri, 05 Aug 2022 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CY7nj4Dbn5hG1eBgbsltcEsXWXjhhaj6B7nXDjf979E=;
        b=J3Zfz+3MyGk5EyyiedXaWblx79/zzFn200lbKGskp7tykjV1usM/FZeJXZm143HN9l
         rtwZUsJtGTQr8tsIsouEGMn1ue8Q0TVXTY2x3ueSOxpRY1WWPXPA73jK4JzG5LhB5GLh
         kLXa+PoUPofh1IpAu6KBJoAoPwjv32RJK8dfEiOokUBGozp7rmt5MnXQ6oC1DPrMZhls
         jKhXAsIBQuiEji1KKITNgB2RBzMq3qT1rP8CRUjlM6l/DuRiGYiTAkNOrNkbg1FPk/af
         NtW7H7EPmDfxNc4QFJlc4tL3WGi0IBO++Umy3dRNt94hPUNI0M+BEfPcvkNFcRnIK7Qy
         UNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CY7nj4Dbn5hG1eBgbsltcEsXWXjhhaj6B7nXDjf979E=;
        b=AkxUxPqalygayHK0OgFP6GX++QLILLYPjQiOB+SWf8DwCfiQvxvSJH2N8Du1e4mz4N
         h/JH5Wu/ltI9gXXCgtB8iOMlpmXPYUNy1D2UOa3L5+e5xC515Igit18mx5mGvSM+5wlF
         Ky2JCruSeIem3dUin4RIbOccXAtPgLvwzvcXj1Z6FhIxjoNI1ioe/8cIKHyjL9d1ZsN9
         z6B0AHrydvqLx4+omCiN7L1rQEuM3piw+N3Zx3q0NLugAcz5VIPN+oZL0uKAXqlg2RbE
         2b9fi3Q0bmllR8+D+KKTRq0cz8RWpftK0SUioU4g0eGiMYcFBNR3DDpcuUjs6a+zrRNf
         lcYg==
X-Gm-Message-State: ACgBeo08T3zKYVmvkb8yoQkUNtjZ2OFXrHQrbAgCpOS7ca5wWSpDiRe4
        DChHGqaL6K949ugHeuqwDzo=
X-Google-Smtp-Source: AA6agR7IiagAGZEP+xy/ZTMuCnaTw0jJTWp9G2mTqeewCjcDgMi6F/ihKED6uVAMwi8rYhLR9Eyyjw==
X-Received: by 2002:a05:6000:1689:b0:220:8a04:69f6 with SMTP id y9-20020a056000168900b002208a0469f6mr5280368wrd.357.1659722064238;
        Fri, 05 Aug 2022 10:54:24 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d4b48000000b0021e4edba1e5sm4373353wrs.111.2022.08.05.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:54:23 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: devices: docg3: Use correct function names in comment blocks
Date:   Fri,  5 Aug 2022 18:54:23 +0100
Message-Id: <20220805175423.2374939-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The incorrect function name is being used in the comment for functions
doc_set_reliable_mode, doc_read_seek and docg3_probe. Correct these
comments.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/devices/docg3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 5b0ae5ddad74..a7bddf80751b 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -300,7 +300,7 @@ static void doc_write_data_area(struct docg3 *docg3, const void *buf, int len)
 }
 
 /**
- * doc_set_data_mode - Sets the flash to normal or reliable data mode
+ * doc_set_reliable_mode - Sets the flash to normal or reliable data mode
  * @docg3: the device
  *
  * The reliable data mode is a bit slower than the fast mode, but less errors
@@ -442,7 +442,7 @@ static void doc_setup_writeaddr_sector(struct docg3 *docg3, int sector, int ofs)
 }
 
 /**
- * doc_seek - Set both flash planes to the specified block, page for reading
+ * doc_read_seek - Set both flash planes to the specified block, page for reading
  * @docg3: the device
  * @block0: the first plane block index
  * @block1: the second plane block index
@@ -1951,7 +1951,7 @@ static int docg3_suspend(struct platform_device *pdev, pm_message_t state)
 }
 
 /**
- * doc_probe - Probe the IO space for a DiskOnChip G3 chip
+ * docg3_probe - Probe the IO space for a DiskOnChip G3 chip
  * @pdev: platform device
  *
  * Probes for a G3 chip at the specified IO space in the platform data
-- 
2.35.3

