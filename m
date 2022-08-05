Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883C158AF71
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbiHESB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiHESBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:01:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3FFDB1;
        Fri,  5 Aug 2022 11:01:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j15so4068750wrr.2;
        Fri, 05 Aug 2022 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Ox8BTswWjDA6tlpp8yUvWlHE29irGGE5vTqBdJh9t3Y=;
        b=Tiugjdva7px9jepzH69IdxO1DOxcplknDJyYK6EIFlkoeS+o0ZTNLVpfmPQ1Tipcuj
         hPKLJVdoWpjjujx6H+gM3OA0mjd/7BHrPIHnng7POpTTwSBgHAo0Wz44EA3XRduRNgme
         hkRn98n6wKon9jdnITZrYHkdM2ELdBuWeB5KdIWp/wut3rhuyPqLvKpTSe/tzw5ueuwS
         h1cv2KWU+ZyCvOwoHacDDZiW5gqq+wiWIdutZW2PWcKeFm/kibXOB6l/hCsaQ/FEc8Xw
         iu4HKShZWXRvWxRSKXr6XpiT2fw6Gbncu5wGDNJVStW4HOuJK8iT+GykkyvHZe8MDY3k
         MwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Ox8BTswWjDA6tlpp8yUvWlHE29irGGE5vTqBdJh9t3Y=;
        b=RHNx1TvD8rcPvmC1ljsggKU6WU+PBJit0j3Sa3Rr1CkVzUuBZAiyKGONdS7f0/Y1Lz
         B7CLpeYfxd+5cc+spm3yyTbIAa5Mz8Tobn60QqM2WtqcRncEA8pRm+96NuurA4OEN275
         xwsdbCVm1BzF5HOIGFzD94a18Q769N6F6RzysYLNIluHKnp9dJEWm/2RFgNolAMNGhU0
         Fjqn3qX20G0G1R/DSc4likUuHwbNLz78v9nZTgk/BMQ4hJRGl0ATqCQBKp/3cWB8pBg1
         dZZqACLEUxRMAwJRaQHs8DLwNxDJ960EkRj1R110rMtAPFs/9eSMHp6AB7yvJcQrmWNs
         6pfA==
X-Gm-Message-State: ACgBeo0H/UCXxlDWzZ4FtepRB0k+p7W29hrkg6AVm2li/7sqvdZcYXiq
        KK+ud5u2W7OPjph3mYGGihY=
X-Google-Smtp-Source: AA6agR7cEFeGrAg2BqNXxTWauwFFuVStXnv4Myk/bPJ+hVKzpy/pbAl/uDCLB3EXTjSUMrxkA0OXdQ==
X-Received: by 2002:adf:ef8b:0:b0:220:8235:124 with SMTP id d11-20020adfef8b000000b0022082350124mr4874983wro.628.1659722478247;
        Fri, 05 Aug 2022 11:01:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600001c900b0021eaf4138aesm5213673wrx.108.2022.08.05.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:01:17 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: cafe: Use correct function name in comment block
Date:   Fri,  5 Aug 2022 19:01:17 +0100
Message-Id: <20220805180117.2375503-1-colin.i.king@gmail.com>
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

The incorrect function name is being used in the comment for function
cafe_nand_read_page. Correct it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/nand/raw/cafe_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index af119e376352..66385c4fb994 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -358,7 +358,7 @@ static int cafe_nand_read_oob(struct nand_chip *chip, int page)
 	return nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 }
 /**
- * cafe_nand_read_page_syndrome - [REPLACEABLE] hardware ecc syndrome based page read
+ * cafe_nand_read_page - [REPLACEABLE] hardware ecc syndrome based page read
  * @chip:	nand chip info structure
  * @buf:	buffer to store read data
  * @oob_required:	caller expects OOB data read to chip->oob_poi
-- 
2.35.3

