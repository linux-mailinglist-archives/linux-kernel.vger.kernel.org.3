Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41F4F1B4C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379600AbiDDVUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380661AbiDDUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:50:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B824BE3D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:48:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bq8so22459212ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J4LkMGmqh/IpZ1iCRfWTzUc90cCZBJCLLtl1EUpG/xY=;
        b=ZQN200a6cw/b5AfpR3Dx+RPgXMa7VenkpOgBGHkNCRIdT7BMrcE0L9W5n6V1sqV/GN
         VEjoVu8+TawE4B49MAioeNQyQLC/a897Fb1sB9R1KZuQUS3OlvyDSbc5eAKznWJj8PK7
         jSNFpYCDeMwCo9Qds7kiuAe30vY6FftnulC1FY/DcibM1/4NwlaCB99KMPb9vY3Uq9EY
         9sFAOKc5yrHx0I/XzPoj6ymiCprXHlzBc/gIgtxhURExOL4+jiBD8up6omNaJlQzZSJ9
         LFQH5DJZkK9mKsQlf094jh1SEs39EQjlHqoakvAbhg9dykYq9DUfruVI3jSlCGiezjIw
         qw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J4LkMGmqh/IpZ1iCRfWTzUc90cCZBJCLLtl1EUpG/xY=;
        b=ow1yFeRpF6fhpmXqG+AAtrq/oKrSxeQfZg8kerB5JHS/xffQUXJKCZd/c/QMqOjZSp
         RTa+x79yk3GHu5mt2tO6eZEiDFQGJhFBhewwUaEbFRa+4GKS3a1T/cMajw+AhgjgAsqD
         CeejOD6x8zxoDLqGCAj1gb+mCIUvQ3TCYWtF7yXhuRypVKPR2onxyd6DmtKuHCuy56Xt
         gU6EN8REN1VH2Ifk5BKc+r4//qiRPHIdNqkMOQxQURDmUop9KKkMxpa61+D+7ChoCuWO
         lpE4opC4WL1f69PGi/m5qDpHMM5JNYf6vepNv8BTOhY6PkygO38MDJ5PpProMQTm4HTK
         V6RA==
X-Gm-Message-State: AOAM530rpGo+WOrz6s+hFPUIWTrWMnqayCAZ4tPbWQOF1YrWpFnqL7Wr
        zifVwVtpE17wcdZmsB/hqZs=
X-Google-Smtp-Source: ABdhPJyOceuk4zKyHG56ftwcYbV0B24dltyTGZZA6cCalDmcC0XzzoKQDp1oRM93oXIPqNXKlmUrlQ==
X-Received: by 2002:a17:907:7ea6:b0:6db:ca53:9b0a with SMTP id qb38-20020a1709077ea600b006dbca539b0amr1857492ejc.763.1649105329789;
        Mon, 04 Apr 2022 13:48:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id x3-20020a50d9c3000000b0041c8ce4bcd7sm4529339edj.63.2022.04.04.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:48:49 -0700 (PDT)
Date:   Mon, 4 Apr 2022 22:48:47 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] staging: vt6655: Rename macro arguments with CamelCase
Message-ID: <70cce6671976e454830c12d6d7977a5fe816a287.1649103348.git.philipp.g.hortmann@gmail.com>
References: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename macro arguments with CamelCase in upc.h as
they are not accepted by checkpatch.pl
Removed datatype in macro arguments.

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: This patch was 4/7 and is now 3/6
---
 drivers/staging/vt6655/upc.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index b374db5fca81..f080a25e6cdf 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,34 +20,34 @@
 
 /* For memory mapped IO */
 
-#define VNSvInPortB(dwIOAddress, pbyData) \
-	(*(pbyData) = ioread8(dwIOAddress))
+#define VNSvInPortB(io_address, data) \
+	(*(data) = ioread8(io_address))
 
-#define VNSvInPortW(dwIOAddress, pwData) \
-	(*(pwData) = ioread16(dwIOAddress))
+#define VNSvInPortW(io_address, data) \
+	(*(data) = ioread16(io_address))
 
-#define VNSvInPortD(dwIOAddress, pdwData) \
-	(*(pdwData) = ioread32(dwIOAddress))
+#define VNSvInPortD(io_address, data) \
+	(*(data) = ioread32(io_address))
 
-#define VNSvOutPortB(dwIOAddress, byData) \
-	iowrite8((u8)(byData), dwIOAddress)
+#define VNSvOutPortB(io_address, data) \
+	iowrite8((u8)(data), io_address)
 
-#define VNSvOutPortW(dwIOAddress, wData) \
-	iowrite16((u16)(wData), dwIOAddress)
+#define VNSvOutPortW(io_address, data) \
+	iowrite16((u16)(data), io_address)
 
-#define VNSvOutPortD(dwIOAddress, dwData) \
-	iowrite32((u32)(dwData), dwIOAddress)
+#define VNSvOutPortD(io_address, data) \
+	iowrite32((u32)(data), io_address)
 
-#define PCAvDelayByIO(uDelayUnit)				\
+#define PCAvDelayByIO(u_delay_unit)				\
 do {								\
-	unsigned char __maybe_unused byData;			\
+	unsigned char __maybe_unused data;			\
 	unsigned long ii;					\
 								\
-	if (uDelayUnit <= 50) {					\
-		udelay(uDelayUnit);				\
+	if (u_delay_unit <= 50) {					\
+		udelay(u_delay_unit);				\
 	} else {						\
-		for (ii = 0; ii < (uDelayUnit); ii++)		\
-			byData = inb(0x61);			\
+		for (ii = 0; ii < (u_delay_unit); ii++)		\
+			data = inb(0x61);			\
 	}							\
 } while (0)
 
-- 
2.25.1

