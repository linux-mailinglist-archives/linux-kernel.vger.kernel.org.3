Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA1156434E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGBXNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiGBXMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:12:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A93BC33;
        Sat,  2 Jul 2022 16:12:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cf14so7133406edb.8;
        Sat, 02 Jul 2022 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jieKz72cmVh5R8qYrLL4foPrJEJnRnBgZYhz6Rx/tnM=;
        b=frQ1Qol83oss+lv4GeZejx5ahE9NUdxPRX7bykNoHAmP4yH9SlRkF8V0VDWBwvJ0BA
         7n4Ck6HDdgQTsfE5uCN5BYfHbI9+YmmiiBPbTGGFY5EqBz7Ln+zmA2sjdOKzZGKEdDTN
         mg+iGjc9VzHsOvEwdNX5gou53MqdHNbsRwL6DL+ihsBxTMGll5CrKR0TmaC8FeQOhp7i
         K9jdBZkvJpSzKJM3T2j+lXjhCrssEjR6BvPyhL64OIWGiwod7aLBwEp+TWYWF+/pKMTG
         RywinF2Q9cQjR3saZBvz2fb/qnRDeEgxDfHOSN4ch7t/+3zYmA/RR+9/9kgEy4yEgB4C
         fMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jieKz72cmVh5R8qYrLL4foPrJEJnRnBgZYhz6Rx/tnM=;
        b=r/WiYM9YJuT0ppwbIhwxaPoLQ5Ds2h4WbG9Q64groJDUfJ+JMZZ9Oe8PgUdr4Pnl+c
         T9CJH/Mi9BGNkI7fFTuwDU2vFHYFcp6aan2Euu5vNkqQEYh1z28vQ0WMuQQE1zqqRIAm
         7CUNprF9L8NI4xt4lgMT7Od6arnatFZpLLUj0ahG01hY2natrJs57p3iPHC/mQWkmCId
         /iNVT5krepMptoX987cgf5Q57syrgu0Mv3X0Gm9hElyV6a4+DM1qoYZ8AV+9n+696jTV
         6y8wdLlJHanGqniffKJPSKIFfVXL7hCkI/7+ZSUx9G16S7RvB3TYrPGEeVRrULFrvQDo
         AmBg==
X-Gm-Message-State: AJIora9u9YgiflV1Xy1dTwEdv4YWYSDYLqhiO9HoeCMT0POeENJ7sIs+
        2EhkUMYx6/sp5Y13iZ6Lhp4=
X-Google-Smtp-Source: AGRyM1u9Fq2VuzmmIzRNy0ZkprnEdbdp2bP9FPBBwB2JuLApMZEyuznyiXVqsHVJm3iOg6OSo5/iZg==
X-Received: by 2002:a50:ef12:0:b0:435:81f3:a93a with SMTP id m18-20020a50ef12000000b0043581f3a93amr27300326eds.80.1656803564739;
        Sat, 02 Jul 2022 16:12:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4d4-2700-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4d4:2700:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm12234329ejb.28.2022.07.02.16.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 16:12:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 5/8] mtd: rawnand: intel: Don't re-define NAND_DATA_IFACE_CHECK_ONLY
Date:   Sun,  3 Jul 2022 01:12:24 +0200
Message-Id: <20220702231227.1579176-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
References: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
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

NAND_DATA_IFACE_CHECK_ONLY is already defined in
include/linux/mtd/rawnand.h which is also included by the driver. Drop
the re-definition from the intel-nand-controller driver.

Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 056835fd4562..3df16d5ecae8 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -100,8 +100,6 @@
 
 #define HSNAND_ECC_OFFSET	0x008
 
-#define NAND_DATA_IFACE_CHECK_ONLY	-1
-
 #define MAX_CS	2
 
 #define USEC_PER_SEC	1000000L
-- 
2.37.0

