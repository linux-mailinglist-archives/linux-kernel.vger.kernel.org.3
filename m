Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9C74870BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbiAGCqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbiAGCqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:46:51 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421EC061245;
        Thu,  6 Jan 2022 18:46:51 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t32so4237955pgm.7;
        Thu, 06 Jan 2022 18:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6dLdb4lxKOn6iI2ropCkWZMbvhcd1NSA99J+kb7KyU=;
        b=BRknm4/L1i4HN7dGXIAt+OZgybXDYCqHX9Ot3jFAxPzMmbpr5bkeCaisaN8sIVKfH6
         qGlcjhZZHF/BxR2sblAC5X6xxz8ChXzGqVc7hyAtsI11/lWuk41mYWy3e9wgnQxdvnum
         vYE5TzT/ElSqm08oiVGGONg8l7TKfIIZ/G0aSbkTB6Yn0ldhp+4zx8QF4J4Yi1jLgwx6
         S3WjH1FkrKS4JXoPsgyjWtDCfdXBJwmbkza8X1czI4j0vKKlSAVUB9QtxDh1FHJC5cUy
         5Gg8WJ9mOzDvLwB4J+53fFaGCA8hmeYwHP4y0Nv0L93QmQvLEddyPzDFrijyzajJU/eZ
         JnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6dLdb4lxKOn6iI2ropCkWZMbvhcd1NSA99J+kb7KyU=;
        b=Lww1CchUlf8GIrDSoV276XDkFmYsK2Cg05YDL6aDzn1g31EJtHa0a18vyunJQx5Ddz
         lER0K9IQK5M6L7xed1aS5jC+W71HkWQRGjZvPcRRPaZJ9P0hWO3kqr02mIQcBULfAEAM
         iVSb+mFXGwmsNrv7tCDPQ5/zkVHs1tQkXLlEdj1yt/VuaUuCy7OokIIG+lmwnzEwFh9i
         iC1mZQ5VcbY6bHZO4ehTr35vbv2iR/sGa3vx7gDzU0jJUW0RDkjvEa4VVoFcGsR9l+YI
         XhR8fpJuTvg/+zqN2SbEIxwhC5ZmYBraPLwELozXpcwOTJAFi46tYmoR8G1/opps2XMH
         76VA==
X-Gm-Message-State: AOAM531ixXXa1KQDWfXq0xO3N0m42J98Mpkj5CKzWeRcrH3tya06ZQrJ
        Tvhm0dDDxmhwQdvrfONZHcc=
X-Google-Smtp-Source: ABdhPJzRzCyWPm+ISg39465n6AC675JbsBrFkJEZRG1n6G5kI9jWZElv8ap10Cfb1JdFZuWtEIYNgA==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr16905564pge.82.1641523610789;
        Thu, 06 Jan 2022 18:46:50 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.38])
        by smtp.googlemail.com with ESMTPSA id 10sm3862107pfm.56.2022.01.06.18.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 18:46:50 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Qinghua Jin <qhjin.dev@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: atmel: Fix typo
Date:   Fri,  7 Jan 2022 10:46:31 +0800
Message-Id: <20220107024631.396862-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'actualy' to 'actually'

Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
---
 drivers/spi/spi-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f872cf196c2f..c5e454acc22d 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -464,7 +464,7 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 	 * However, the first data has to be written into the lowest 16 bits and
 	 * the second data into the highest 16 bits of the Transmit
 	 * Data Register. For 8bit data (the most frequent case), it would
-	 * require to rework tx_buf so each data would actualy fit 16 bits.
+	 * require to rework tx_buf so each data would actually fit 16 bits.
 	 * So we'd rather write only one data at the time. Hence the transmit
 	 * path works the same whether FIFOs are available (and enabled) or not.
 	 */
-- 
2.30.2

