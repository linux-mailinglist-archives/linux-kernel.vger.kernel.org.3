Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73EB57CE69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiGUPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:01:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B19664EF;
        Thu, 21 Jul 2022 08:01:07 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r186so1932938pgr.2;
        Thu, 21 Jul 2022 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeYFtSPDsXNaZXYrTwjNhCXDJakI4RnMXmS/UIy+7LE=;
        b=SVI/XP2iFa0W/zveXCJv51PNfqhga0CSOUN0fdkEHmWKHobZSaspDG5RxXsDDBQQqg
         RVmpCBXdniVucnHYKvXWxGWrWRfdQONRjg9GxkpSroCpDslUTIiYU59DjdUe6B2agKPZ
         GaFIXlE5jLO7WhGb6HlBMZOzntlBElwDKLDYzMFq5AypUsw+OVfafHs47V98mpqpuVAb
         iyIEuTBDHaO/ARlR4Rr3yuHYTuzMiy2UyKpSTbG2PxkdSXZXarucw66nUuISrAZPsKLy
         mswB1Au0PV3twyhlMa8mCayZdFXNmVbCQM508g/pUuOIcNpxpA+2aXWsuHN4aBcFzdMt
         oPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeYFtSPDsXNaZXYrTwjNhCXDJakI4RnMXmS/UIy+7LE=;
        b=iJokOjs8lMCRtB/pQB4/YrKEkh/WgbVJjIkXNL3UH0Cq5KU+jk07OSbajAlP6zCZ9+
         sOlKZdYwrAQn+nFfOY3gHWE48DnOyTl15f44D+2wI4HQMm9TurSQw/FTKY7tf9ycJ0BU
         VIDi9b7JHbHObAMLHFsm5+UwXSLlwV1tcbxgplMvp7jhaGi+Nhjkuwiu0hczbw3upU0m
         t6DtCErliByfBs6CkViogyTYDfw3hX566WGrnUZ049D9Xan/8ncRUo7ytVBikDxhH4vj
         4fkhIQ6uvIo2lr2Pwt1WZb2iiAWNUuAvxWv3wN3m6sciTLlhpak1a8KdGn41sBFfyw3q
         oqYA==
X-Gm-Message-State: AJIora/AuRr6yv6kTtWjJCwE0SEL+iqgr8+2hkBiCeZ5hAJUXZKp6c5/
        8EAzL8hYcNBsx4trFJ5/U02kEDViIlplglk31pI=
X-Google-Smtp-Source: AGRyM1vqv9W28F3bZ6fQOjrj7iN3NNLa2Q9GtVzBpwKiJnnbbWIJzHWbkOsSDolpAd3EeOmw30U7Lw==
X-Received: by 2002:a63:ce4a:0:b0:419:c8f4:d2a3 with SMTP id r10-20020a63ce4a000000b00419c8f4d2a3mr32246515pgi.515.1658415666756;
        Thu, 21 Jul 2022 08:01:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d01c:7038:6d29:af18:34a6:1c34])
        by smtp.googlemail.com with ESMTPSA id e25-20020aa79819000000b0052aaff953aesm1851897pfl.115.2022.07.21.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:01:06 -0700 (PDT)
From:   Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     abhijeet.srivastava2308@gmail.com,
        Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] media: staging: media: zoran: Removed braces for single statement block
Date:   Thu, 21 Jul 2022 20:30:49 +0530
Message-Id: <20220721150055.52096-1-abhijeet.srivastava2308@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.

Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
---
 drivers/staging/media/zoran/zoran_card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 26f978a1cc72..0c138d47d0c3 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1038,9 +1038,9 @@ static int zr36057_init(struct zoran *zr)
 	zr->stat_com = dma_alloc_coherent(&zr->pci_dev->dev,
 					  BUZ_NUM_STAT_COM * sizeof(u32),
 					  &zr->p_sc, GFP_KERNEL);
-	if (!zr->stat_com) {
+	if (!zr->stat_com) 
 		return -ENOMEM;
-	}
+
 	for (j = 0; j < BUZ_NUM_STAT_COM; j++)
 		zr->stat_com[j] = cpu_to_le32(1); /* mark as unavailable to zr36057 */
 
-- 
2.34.1

