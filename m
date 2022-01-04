Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86784840C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiADLZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiADLZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:25:50 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71329C061761;
        Tue,  4 Jan 2022 03:25:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so2790787pjb.5;
        Tue, 04 Jan 2022 03:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7PlsrZmkmw1dwadd6snlv+j19gs+J67k6Ar8dpYo9s=;
        b=D1/Gg1QeEGmwykg1bz7ati5WfxbzjsbtIFmdpyMW/yWuGR3zQhHfa4NEOloPtOtjWD
         eXV/vzaxlQDKlSzKG2Y888exOY5+6OVVnklyuVBjb5kvo9Atp+G5ET3iYXshibZfg+AP
         HvBg6drQRv1iU6jQgV2PBCb5/961Owe+GxWGhcie4zmhANIoyJ+cMDAcht7fmq8g9rSQ
         GvnbQnnt83tsOXKz+B39CDJCxtPYagmmh+7KYcBxOq1Epri1cbALUivzceVSrAkGCPmk
         5JesPtJ9Y9eFYkokOu2c0YrH+Z9H5FVZQWKLrqOBYX41i3IsIMvO1zNm7EVBzCA4ugyZ
         kXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7PlsrZmkmw1dwadd6snlv+j19gs+J67k6Ar8dpYo9s=;
        b=gHMN2Dcvku02Ffj/498hvcsNL6yBz/TDA8KGazq+Jefh61l1VTPtY6wmLg9iuL0RFN
         sX/949TxLf4Rd2wEIAXaZ1fEpTzY/du123dNCTtavVzHEc9lFvOwY6jco9LVsUs5kBY2
         L6uf2+kT1V0Yjs8VkdJIgNIiXv72flp0weY18Cp96+HLaJ0vLVEyKytFNKJ0CxRSg2js
         UqLC2x5QCrlr0+MS34LMyHxRPLBwAbo94JovgMN+tpQOzy4NNd9/MbgXu5tqFsE30kh3
         xtBREeN6H8CRoegB16p3mghOskoNgrKAclhTXrBBAzDGqZAGnDA4gIyHCx3NxsKtgptj
         P+ew==
X-Gm-Message-State: AOAM531PP34pvR39A3pKvu3q1KTfyxq8yLgj5JroYZtCVKm1yZArZgrm
        xEG1VHvFyY3F3LIf3ZCvi78=
X-Google-Smtp-Source: ABdhPJxoUEMRxA3KH1bowDD9/35VotMFoLpdgp1guXcyEfxBBd0pNwQ3Ugs+HIe4RUaSARO3YQINrA==
X-Received: by 2002:a17:903:3013:b0:149:5ba0:4f80 with SMTP id o19-20020a170903301300b001495ba04f80mr45675901pla.87.1641295549957;
        Tue, 04 Jan 2022 03:25:49 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n20sm36936608pjt.40.2022.01.04.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 03:25:49 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/ata: remove redundant val variable
Date:   Tue,  4 Jan 2022 11:25:45 +0000
Message-Id: <20220104112545.601962-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from DIV_ROUND_UP() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/ata/pata_octeon_cf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index b5a3f710d76d..70f91800fe9e 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -73,16 +73,12 @@ MODULE_PARM_DESC(enable_dma,
  */
 static unsigned int ns_to_tim_reg(unsigned int tim_mult, unsigned int nsecs)
 {
-	unsigned int val;
-
 	/*
 	 * Compute # of eclock periods to get desired duration in
 	 * nanoseconds.
 	 */
-	val = DIV_ROUND_UP(nsecs * (octeon_get_io_clock_rate() / 1000000),
+	return DIV_ROUND_UP(nsecs * (octeon_get_io_clock_rate() / 1000000),
 			  1000 * tim_mult);
-
-	return val;
 }
 
 static void octeon_cf_set_boot_reg_cfg(int cs, unsigned int multiplier)
-- 
2.25.1

