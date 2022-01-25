Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1731949B573
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385430AbiAYN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385360AbiAYNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:54:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B7C061762
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:54:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e2so4659391wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D4gfH4WoXONGxg/5IXwV1T9yFOu1r9ABY1KT+VoPdqY=;
        b=8JPKo2WjlraxmnR2DwEn4bWVh/fzxiqndxcVsEA7aguJiSy7qPVYGp5G629rqhJ+ya
         NpMVAJ2WoU7NDTUaCwdYK91UOXymf3RIPLwhBZJNhtG3IZNaxuUqZRwD9rRNMrb2/Dli
         RbGsBEf9gTWBlarMsAB7DlS8x2qcR4t1RGTIq78wGbBidt37ibQTnO02tQEf1xOO1eE3
         07PEV2T6VygC5zEmSmXjIsXal0FdPn5EoGVWuMQZJevN3FHedTH/mPZZ7CNInz2syswP
         jMliqh2D/6VwxWU/rjMmntOttFvcJxNEHvxvUA5KGN5Rg95d9Kdogat1/SBgZo+4oQis
         CqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D4gfH4WoXONGxg/5IXwV1T9yFOu1r9ABY1KT+VoPdqY=;
        b=U61ntcUyubOyxdNnw6z6Ygkyr89BgwBVy9Y4OPHTfsIGvvlufDyWmIF9vR7GnsoV6X
         7RJy39dYwNJgGXFme8FUZSSaYO53REI2fwtJJNOuVYcUqFtlTaN6N8/oAd1BgqMnM1KQ
         pmYoSEgUP2XaHpv3g32EeNe3YGEmXPAjW/Nh+/Npxz6Sk8dL+yMWyJrMOudx5ou/ei3S
         7kOcsB7PuUd8Q7ue8RvFA4zkbRUqOby5BfAPOAjKTF8autU2KOwHFKwvFKiVygsiGyi6
         9REtVw6SigyJwf+TKgranwz72hVRBNcvdLOhCfDy/4nIJ+G23RNt7XqI126THQp7CRoD
         PUdQ==
X-Gm-Message-State: AOAM531uiblUOsGsU0VxrY0kBTN1LamaY4y0g1GKxxayLsG9qAxqLFJs
        B+gjvYl2aZe3QhGL0iIMJU0DvdikkPNQow==
X-Google-Smtp-Source: ABdhPJx24SVgxveHSirOnsJuXcFCCz5p1muhRgFKnbcDI2KTmeitiwitdqyujOGmnsnrisBrPSpHYg==
X-Received: by 2002:adf:d849:: with SMTP id k9mr6133481wrl.380.1643118872965;
        Tue, 25 Jan 2022 05:54:32 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 8sm468917wmg.0.2022.01.25.05.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 05:54:32 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] macintosh: macio_asic: remove useless cast for driver.name
Date:   Tue, 25 Jan 2022 13:54:21 +0000
Message-Id: <20220125135421.4081740-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_driver name is const char pointer, so the cast it not necessary.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/macintosh/macio_asic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index c1fdf2896021..1943a007e2d5 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -756,7 +756,7 @@ MODULE_DEVICE_TABLE (pci, pci_ids);
 
 /* pci driver glue; this is a "new style" PCI driver module */
 static struct pci_driver macio_pci_driver = {
-	.name		= (char *) "macio",
+	.name		= "macio",
 	.id_table	= pci_ids,
 
 	.probe		= macio_pci_probe,
-- 
2.34.1

