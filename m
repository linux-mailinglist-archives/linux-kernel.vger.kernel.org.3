Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C45472B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhLML0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhLML0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:26:39 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29210C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:26:39 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id i12so14039238qvh.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eD6ckxYOFOb+e8Paz6iMpOBDcRBstNtUogT+wtDanIo=;
        b=YVi7qSMIHAmqR1ziLS+oBD5WujjcwCE+4G3u70/XFkRKtNHL1rmXZEJ6FmKJIFdu02
         G30X1MLGRJxf++u4dAJreJ13q94+xdZEYlYccDmaClkGWseDYg+fD8ts0JDIIZZviucL
         HTEGgM4gQ9sUu8VL3lLv5/VSo1ZfHkDMvbT93gKgQ3pR7xt6x/KZENec/ExMhE0iQFJB
         dwHUJjwa4xgINdLxvcqAJDMxWo1U3CHNleqylIUhodRUv3EH7OHwJQ1IY4STphC/7ly/
         PmlpYT3LHnBODRFdhuqfX5iQhOFE/nphgwagOdAsYTHu7ewT0wzFaDV3M2h2sQVHCnOx
         3RdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eD6ckxYOFOb+e8Paz6iMpOBDcRBstNtUogT+wtDanIo=;
        b=uR9A2smKlu/UEbMguzP6YGL1yuWf+Df1lSvU2Mi0zLaHyPOHnxI8ynfiotNemkE3GM
         /hh4EZ89G4Nk3s99F0k8xUiviwy6bTPpqdjJzOuoLYPbVnefvlg6xotoLZWCEJc9iMnu
         gn8vvdsmW1RKtvXvLXTixLDrNb+jGFPTsJJ5IZOnEeyvJggL4+Cb5b2J4mnhCue8m80H
         jpvhDmGPvDkkjxgLpnljethTuCt7Yu9JTOoLGAIJA+0Gu8Qkl03ZyYT00MBSdgYZhMwZ
         8JuCK1yT/ofdlBe3asEvB7JhQUlZXytMjhyOfX5U/gkFNAJvr1lhCTd2VzJCwR/USpV+
         2zeQ==
X-Gm-Message-State: AOAM533H3wxziGjzqD8faqUD6NlnDXzyCQLAyHDQg08g7DE1Scaa8+01
        wVmdNgEJa5JfbT35XYNbfuY=
X-Google-Smtp-Source: ABdhPJyz8j/K09DZ5hzBHAp/+joA+v2M/C1JywjSTePQKxvwDTIJHTjCcK3ctzU6nAsJmW04ncaugA==
X-Received: by 2002:a05:6214:5094:: with SMTP id kk20mr40535508qvb.71.1639394798344;
        Mon, 13 Dec 2021 03:26:38 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i14sm5900465qko.9.2021.12.13.03.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:26:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     miquel.raynal@bootlin.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, vigneshr@ti.com, zealci@zte.com.cn
Subject: [PATCH v3 nand-next] mtd: rawnand: gpmi: remove unneeded variable
Date:   Mon, 13 Dec 2021 11:26:27 +0000
Message-Id: <20211213112627.436745-1-chi.minghao@zte.com.cn>
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

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
change since v1: mtd/nand:remove unneeded variable
             v2: mtd: rawnand: gpmi: remove unneeded variable
             v3: move the update log here
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

