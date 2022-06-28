Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0F55D832
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbiF1L2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345360AbiF1L2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:28:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D7E6582;
        Tue, 28 Jun 2022 04:28:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so9230163edb.9;
        Tue, 28 Jun 2022 04:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/aCGOJhN5hhaa/wf3udZzref7WmmFge/G1kcYg31ZE=;
        b=CbVDEz1YIhN/CZwz7Po586XwhR1tDqMnUEZiyAz09iRURJR1bDxDRt7GkakaoBMvQV
         FUKWaFOIETEp7V9O5XgdKEJA7NWf0anlbK2XF9IqbXY517vNSaPnGajPw8WWH79aWnnX
         Yo1w8ea+6diWxwLYIVivAE/vLlBVoF0SZx3B1avkEBg7d9QO8fDyZ8Zi+70erfT+lKNz
         Bi+Yy7E3VEodPI3JUG8C94mNeymMndsANF/8MYmTzaIyU7hHK3O0DfHuGsmAs9nxM+xU
         UhPCe3/LVi3DPW2K3QvEGQUOJV5uPlI9uEmA8bb6T2ZeckMY8mVoQzR9aKbpQayk89iy
         pPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/aCGOJhN5hhaa/wf3udZzref7WmmFge/G1kcYg31ZE=;
        b=Z/lLmGyE+thvyyVL6isAYNhYTfybPIHULoeSkrw+Z/62HcsBqZSK3IGPMV2QgFAWuG
         Rshhc/nUA+f764GyjxBA6l8g6UwlnMPZUA6sTb9fFizeBVdFG6rrPx8lqWtpml9GJ9UG
         vmB+EWiJsVPnuh0hZ+Eq1XAEYkgI4c6Iut5T33IsFLJxaUOokZkLcq6w0HYggKvkbc0C
         JAXA4pzIoLHhBqmoHtC62FRApg7evGsOfB7X55aOoKmViiKnYf5rFtoEzhQrQc7JUk1R
         /RhoQsPn4/xIYclzD/EpZE42HtrK0Lj2ItycnAF9tt5IsrXjYsX+p7RZeu76yaOTt1mW
         0+7g==
X-Gm-Message-State: AJIora+LbvOiN6v6x42WmFgXIGQF179etHTFlh5xkmrGT5vJv9xa5AF4
        NMsP3YTXlT8RSp+fdZwYlxw=
X-Google-Smtp-Source: AGRyM1ty2755DziH+VQSppOQlJavQFFOcOu1ZHriPAA4F7jhidLeXeluQ2PnRW4xmThrhoABTwVnTw==
X-Received: by 2002:a05:6402:1c09:b0:435:6562:e70d with SMTP id ck9-20020a0564021c0900b004356562e70dmr22237136edb.203.1656415694067;
        Tue, 28 Jun 2022 04:28:14 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm9456318edw.20.2022.06.28.04.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:28:13 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 4/8] mtd: rawnand: intel: Remove undocumented compatible string
Date:   Tue, 28 Jun 2022 13:27:27 +0200
Message-Id: <20220628112731.2041976-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
References: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
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

The "intel,nand-controller" compatible string is not part of the
dt-bindings. Remove it from the driver as it's not supposed to be used
without any documentation for it.

Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 3df3f32423f9..056835fd4562 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -723,7 +723,6 @@ static int ebu_nand_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ebu_nand_match[] = {
-	{ .compatible = "intel,nand-controller" },
 	{ .compatible = "intel,lgm-ebunand" },
 	{}
 };
-- 
2.36.1

