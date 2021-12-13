Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8032472AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbhLMKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbhLMKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:49:40 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D4CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:49:40 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j17so14742017qtx.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vlfNfrOceOEoYXiDCyE8CsjbUpv2PQ5GDOLk4jPLtE=;
        b=WHwgI4i/lIvtO/xog+9VopKiTNorTcd27b97xeXShSYZLzm188UY22HdGYZnVsUY/m
         FfjIfhYfzesQ48+7a3qql/vBdi80iZy71cV55ilrkMiDvalGKSP5ZiwX35UCO+eohK/9
         Um11+rY+gJTSb2da5Bmjdw7PmNhFrOAJGJpvKg2iu6eezERgpciSnDwpIIm9GnZe6ETY
         dMq1oauC2wHsX6tUtt1Df0Ak9ykP6dnJu9QJNwDyjBVcoNjcWGU8RQMkElHYAjUf/qMb
         VN4krq7nTGG3EqaR4VquEPq35YFtGRAN5fQkxWPGFG/NDae7CliNiSNwo3CMaoa/PTgn
         QUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vlfNfrOceOEoYXiDCyE8CsjbUpv2PQ5GDOLk4jPLtE=;
        b=ag994F12X7FCCsCSF7hGyGZlJ1ru4tSswRUUGwquxFj53FuREwZRnZbVyM7/tUavCr
         RX4aWV6crf4uox2ajsRrkMloxUwz6F2t1UfT0QhWRgQyQUL1GLNqHVOvWYWLylloZvL+
         V/L7mRZ9Wc/kwXEyi4nfTz+vEeKyWz0RerkAnl6HCRDEoyrfYrGWGBrig6uem3dJIXWw
         SYPXV+lYkvvKthfigrNDNt0umcsuaBLhJwc4CF24xhwluyXYQuTqG4LR9dQ2l0kXqQND
         WTKCzunIWxOs4nIhG60cJ3LeQoL2GNXWol/x8ZozYGXB4G5zbMWM/n6cruFDFOsU2NDJ
         QHaQ==
X-Gm-Message-State: AOAM531PlTy3766BYlO6YufcWOogA8wqU28QDzlnlv7KwCriMfxmjfFr
        +SUq0ZDFUdNJL2TZIa2ZyEY=
X-Google-Smtp-Source: ABdhPJzPAG4ov64AeneoCqMD8XRa2RVV0yc9vdWyYc/bORq1dEYKgI2qZ2TqWzWZ1Y1o8vjMzrQ7dw==
X-Received: by 2002:ac8:5f93:: with SMTP id j19mr43808197qta.596.1639392579818;
        Mon, 13 Dec 2021 02:49:39 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i6sm9089759qti.40.2021.12.13.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:49:39 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     miquel.raynal@bootlin.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, vigneshr@ti.com, zealci@zte.com.cn
Subject: [PATCH nand-next v2] mtd: rawnand: gpmi: remove unneeded variable
Date:   Mon, 13 Dec 2021 10:49:30 +0000
Message-Id: <20211213104930.436602-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213101519.25f4e2e1@xps13>
References: <20211213101519.25f4e2e1@xps13>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return status directly from function called.
change since v1: mtd/nand:remove unneeded variable
             v2: mtd: rawnand: gpmi: remove unneeded variable

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 10cc71829dcb..ab9d1099bafa 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1425,7 +1425,6 @@ static int gpmi_ecc_write_page(struct nand_chip *chip, const uint8_t *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
-	int ret;
 
 	dev_dbg(this->dev, "ecc write page.\n");
 
@@ -1445,9 +1444,7 @@ static int gpmi_ecc_write_page(struct nand_chip *chip, const uint8_t *buf,
 				    this->auxiliary_virt);
 	}
 
-	ret = nand_prog_page_op(chip, page, 0, buf, nfc_geo->page_size);
-
-	return ret;
+	return nand_prog_page_op(chip, page, 0, buf, nfc_geo->page_size);
 }
 
 /*
-- 
2.25.1

