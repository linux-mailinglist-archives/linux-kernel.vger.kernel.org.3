Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BD156A82F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiGGQgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiGGQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:36:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324472D1F0;
        Thu,  7 Jul 2022 09:36:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so10483240edc.4;
        Thu, 07 Jul 2022 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLHJBhKHjVuVR3mcBnbsIiyt4ymeaQeICW0gIztUwNk=;
        b=WtTIbV5NJdT9zJWs+mhSLRYyDgDLVvro/qoXQvONrI99p4YJdq9CJvunBXxk/s4flX
         2fSST51RQKynfZABj3JPYqMiqNhpxOrjfGEOsZopM40wCsc+a9IJGONgwTmCPuxj8F2N
         901RsE3W/IVPtf53qV+qeTwdwRmp8oB2buDdr/gQkn8pfV8Y1m/6DRWUT6F0vze+JhGJ
         nvkPnuMkGR5yLKqdA8e6iCG0N09O9rWjSCoqE1GZmKybAkqmkfj0m+LIsNEF/3LvSI45
         70EYoKn0jJm/WLgq+v7qN1VC+G7divIXTl+23AMGmWncLv1mEE2p/0H+AcrOfWwjCcc8
         QxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLHJBhKHjVuVR3mcBnbsIiyt4ymeaQeICW0gIztUwNk=;
        b=DHcpkRMnuaSp7GBc7xwbAk77f49PvNWTchTQEDixcYuxVe5PaW2LOV9xLeViao58Ig
         65XuK7qc6wDA3FfZyC++l7eZ2YHbbY+NdktOPuiw9CabJG+qabA8UCWugC+5TuqIA9dU
         VwAqjxYfpH6oxNhqsWGt/Gdd/kwEjrhHSqLRIuNIxrJ3b06UDQzUI+0lB51ou0SoSb7c
         5V0IR4Z+B+bmIIxrB+HlDAfCFL4A9pmGU+UNDl0VLKuGWnh5WqyMUrvL66BP/C6vSmqF
         WQVKmrAmcgDMlgTUjJ21rYrWh04SB+agpZKD1hV+SnR/8e/rA4JeG6UIEXm3KgSS87ZV
         S4qQ==
X-Gm-Message-State: AJIora8sk3BMf3UDIh4BroY+wdGPriFO4sl+aQPKGsdL7N9lY8rEgyVn
        O/Am5kd2Yv2F9B6hSgNtFRsUMtR10Gg=
X-Google-Smtp-Source: AGRyM1ukPWJPXLiuOVCJXJPl+hNENNGEsZ/ZCuSj7lSJ/+SZlZLgHpvXwZASVtuHy7YIqSlpb8HKQw==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr29336124edb.348.1657211777713;
        Thu, 07 Jul 2022 09:36:17 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t27-20020a17090616db00b0071cbc7487e1sm19009030ejd.69.2022.07.07.09.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:36:16 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     ansuelsmth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] mtd: core: simplify (a bit) code find partition-matching dynamic OF node
Date:   Thu,  7 Jul 2022 18:36:06 +0200
Message-Id: <20220707163607.20729-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

1. Don't hardcode "partition-" string twice
2. Use simpler logic & use ->name to avoid of_property_read_string()

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/mtdcore.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index dc9b33990895..79c447fe30b4 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -573,15 +573,15 @@ static void mtd_check_of_node(struct mtd_info *mtd)
 
 	/* Search if a partition is defined with the same name */
 	for_each_child_of_node(partitions, mtd_dn) {
-		offset = 0;
-
 		/* Skip partition with no/wrong prefix */
-		if (!of_node_name_prefix(mtd_dn, "partition-"))
+		if (!of_node_name_prefix(mtd_dn, prefix))
 			continue;
 
 		/* Label have priority. Check that first */
-		if (of_property_read_string(mtd_dn, "label", &pname)) {
-			of_property_read_string(mtd_dn, "name", &pname);
+		if (!of_property_read_string(mtd_dn, "label", &pname)) {
+			offset = 0;
+		} else {
+			pname = mtd_dn->name;
 			offset = prefix_len;
 		}
 
-- 
2.34.1

