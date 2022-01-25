Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FF649B214
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349252AbiAYKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358797AbiAYKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:33:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A91FC061747
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:33:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f17so18967751wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2tvArvkFXd3MQ4djZji7/EbHBu/CVbsYkCdzO/75ZE=;
        b=YRbYZuZbIuT/bEoLQsMojsxdBzznDEAV0zUTl9x2+fo6nx+Z6kxiXtm+7JLWnQb6iW
         wgUdYbL9vFmm+aWtr4bSfNPIys6bJCUPOZVNuG4hZi28ffGhnkNI5HKjmOngOpI21NnZ
         jf3Uf43OYqoZihOQx1bUf8r66N7lLbted+gcKSiB2NrxR8r8p93WARD0Gnx5rrEqy9zQ
         7B/r/1iTBo20/Y0uKEJSOXGv1q01stSnbTD7BDSPS6UJVTrURrG/aviR2M8noYBqDktx
         gANP77BeN142e1WfrOXSOTF21LfEfbugy6JMpKHqXcIPk/4Fv/cWF3ndqsXm44RYR+Gg
         l1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2tvArvkFXd3MQ4djZji7/EbHBu/CVbsYkCdzO/75ZE=;
        b=Z2FWQ+ztzUp3MLWEluesO0u/7YRKW8VEStMqeccMTnOvsMFDFEPJP4mgdQ66e/TOEW
         f3oCLq3DLkbs+5H35nN4cCwu/mllnYd0rkwqrgZaxX4U4dc4wJEy57Hnjsyco4bzAp28
         3cprNO2g4SIT1cqashhU0qwa5bZv66UZ4wvNM1jej3k8KS3JQRduSU+oPdYUcZukBtFd
         7cYwP6lmvkXeuzsT8/IMhNUCDUVYHe3HShLufuBvFNmdN0WImeQrkcJnLH2gcA304xMh
         B6JeTJa3MhKt9wH5NRMJKNyghc5jHp2Cy2Wzli4uyJDk8wYTayn1E98t0CApwloluolt
         7z5A==
X-Gm-Message-State: AOAM531qYKCNKjq+zsynp1+eSBcz6fLftcQujBtH9gJ6W7ZJF7hDD/GP
        ORpRKfZVgRhrOV4l12zKjuo=
X-Google-Smtp-Source: ABdhPJw8Kn+HzNY27AKVpXLtQC5q+GEQSUBB/cNZu06T46rKWc3leTAr89Sy46HK36ktrRCjjQ59ZA==
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr17667779wrx.586.1643106814103;
        Tue, 25 Jan 2022 02:33:34 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id i94sm16615337wri.21.2022.01.25.02.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 02:33:33 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 3/4] drivers: dio: Fixed braces coding style issue
Date:   Tue, 25 Jan 2022 11:33:09 +0100
Message-Id: <20220125103310.13893-3-aleksav013@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125103310.13893-1-aleksav013@gmail.com>
References: <20220125103310.13893-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving braces to the appropriate lines.

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index d2d3028df93f..0f29d4903012 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -57,8 +57,7 @@ struct dio_bus dio_bus = {
  * I think we do this by copying them into newly kmalloc()ed memory and
  * marking the names[] array as .initdata ?
  */
-struct dioname
-{
+struct dioname {
 	int id;
 	const char *name;
 };
@@ -67,8 +66,7 @@ struct dioname
 #define DIONAME(x) { DIO_ID_##x, DIO_DESC_##x }
 #define DIOFBNAME(x) { DIO_ENCODE_ID( DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
 
-static struct dioname names[] =
-{
+static struct dioname names[] = {
 	DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
 	DIONAME(DCM), DIONAME(DCMREM),
 	DIONAME(LAN),
@@ -190,8 +188,7 @@ static int __init dio_init(void)
 		request_resource(&iomem_resource, &dio_bus.resources[i]);
 
 	/* Register all devices */
-	for (scode = 0; scode < DIO_SCMAX; ++scode)
-	{
+	for (scode = 0; scode < DIO_SCMAX; ++scode) {
 		u_char prid, secid = 0;	/* primary, secondary ID bytes */
 		u_char *va;
 		unsigned long pa;
@@ -267,9 +264,9 @@ subsys_initcall(dio_init);
  */
 unsigned long dio_scodetophysaddr(int scode)
 {
-	if (scode >= DIOII_SCBASE) {
+	if (scode >= DIOII_SCBASE)
 		return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
-	} else if (scode > DIO_SCMAX || scode < 0)
+	else if (scode > DIO_SCMAX || scode < 0)
 		return 0;
 	else if (DIO_SCINHOLE(scode))
 		return 0;
-- 
2.34.1

