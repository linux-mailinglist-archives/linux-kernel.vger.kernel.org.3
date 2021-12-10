Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40E846F90C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhLJCWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhLJCWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:22:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABE4C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 18:18:27 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i12so7160016pfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 18:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=poNSG/gxo2Fhzr7JKqoglN/TlnftEObbhIqVh18TXuQ=;
        b=pZQFulNnonlKgH7+dXRF/vCwQt8w5zzPKB5f/V0va9u8wKzma0xk9ISqBBpimCFyj7
         iTwKPa3eG70jVKX619oLdukAlEEnTyXNwzJJbXsemigerDOIPVVAdRdsFUKfoIpky3bU
         BjeAK+8Ak+kehQ7t5AldpQr7gyG/Pcs/J7S6oycLlKuZyslDNoXXVyCXGzpNUZZsG7Li
         hd994rtNWZJt/gHxV4K1e99354VPHmANsf2LPa2ebiYN+/9ttAU/YaZpdOwjcWQNaagV
         44IQHMzzhLRWM0yCFmE8dShUGgqjJDsEVMpDJFfJ9WFdek9zBwFNVPXIWtBjwm3k/Eu/
         eyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=poNSG/gxo2Fhzr7JKqoglN/TlnftEObbhIqVh18TXuQ=;
        b=RL8ZHgsuOV+TpRFylw9vYcUu6jpbXUBjYK9IQdfhOQoFgz5GFLDh9Y0CSAEZSuqj9g
         hLLNo2EaH1z0x1OTIToKFXtz/znyWpObfW/5gQWIY0DKizEGtXJR8uvWQ0LoTi92vCU+
         0BloWiNZQxun9IWZK4NsPLUie8VUZEtoOiVzySHOSDiUsp/iaZhNcOtf+T7YbW5zTDwk
         MPuhUO82Ona9B+eE+I1/x9vv+MWDbUMkEjy5Sa0UjXQN4+nkw4oMpMgkJCz0wkmKToP9
         bdxIJa6/co82ks8Ye9DwH0l5PuGREa4iOMylTWLAV4buu0Jqxpm9iQ0wTYc0lkHNgMAG
         BGlQ==
X-Gm-Message-State: AOAM530MLiHNzEWk89qgiruFGfgLcazoRCEzt/Zj8EHPGXq/Jzf0DsGC
        Ksei2PYrVoXmOGLBhJvWEl4=
X-Google-Smtp-Source: ABdhPJyX+9SXt8lpomYrFFuvvvVEaEAAb0Fq4qTprNsXW5/3HNjOCWtqJKcWyDKG3mTMnEvOgFFuHA==
X-Received: by 2002:a05:6a00:1516:b0:4a0:2c42:7f17 with SMTP id q22-20020a056a00151600b004a02c427f17mr15524711pfu.74.1639102706632;
        Thu, 09 Dec 2021 18:18:26 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n16sm970534pfv.123.2021.12.09.18.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 18:18:26 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     han.xu@nxp.com
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH nand-next] mtd/nand:remove unneeded variable
Date:   Fri, 10 Dec 2021 02:18:22 +0000
Message-Id: <20211210021822.423833-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return status directly from function called.

Reported-by: Zeal Robot <zealci@zte.com.cm>
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

