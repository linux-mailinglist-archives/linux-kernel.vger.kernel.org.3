Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5964EFF5F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiDBHbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiDBHb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:31:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E5C174E9B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:29:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ot30so219557ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4G2eTtmdTWzx59Z9S8k6mI4CBAhKNnZVSSLyslzji70=;
        b=jkqKswMsP//Wzcxkixxy51XC8GWDhKyOIoCRqgS8wne69SZ3kaHPEKVjz+A84rBaTE
         782M7Lh7ShnecbEVBKck4rB/gBMVasweXPQzOAGldooO5wTsHRfMT6Q3PwsvNZeNmjbN
         sed2/OOnAA+VqdqgvTs1YiA7NI+OXjXpPQ4CCMEB6smnIBuBTzKToqiIEDuLkDtTO/yh
         xjvfUQlNZA/M2WkZOaIFczvwaRC1qosyfdDfPfWcNH1slbcNRj6yaiB8U/ky0K4GwyQ7
         6N73LVCE9hL18OnFc4jryAhmLJ7iGzIzB7fE5Hob1nPwQXz8yR4av5T8ZrWTTx5isZI8
         MB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4G2eTtmdTWzx59Z9S8k6mI4CBAhKNnZVSSLyslzji70=;
        b=qjyPSlueqpKYtVscF6XqoWMB4C6dklPpi3uKwruXyvBliFfGqWQb1ZUWD0bt5bb5o8
         uxZPzobKwAsajvT5F+WdrxdDs52cwype773uSxwTzeiRFl2zj+frKoB450E26J/e9XgK
         WApBIq4Q1484fzR0VJ3mw/+YgpPtneHHQFkTK6Noi8p9L7AaWxBxTrYdk9B7kKIeXIVZ
         mT96vq9+e1PmJNga9a6mfU76UOFWaprR4Q2j97rF3FxBLwjbJVSXH6wJP7T0c/K0XTeE
         cAIcoA5fFPeQnUSPIcGmg46Osq2Niv3ZCk2WxCtvWSN3MDg5iAZOx69+0PfVTgzWfYqh
         aDWA==
X-Gm-Message-State: AOAM530TeJsB2sJrrFyLn8y0B0JFs/cmKpsS6l1lvhYk6F36s5Kz7vnN
        a7wZviRTRvGn8gwB1/VLBeR/q2ibIoI=
X-Google-Smtp-Source: ABdhPJxc+iM8FEq5gjKr9iH3MrjretjQ51iEc+ImyyfgRb9F5kc44u3Exrvv6NHLUG62LyJOSPtMew==
X-Received: by 2002:a17:907:7e97:b0:6db:c1ef:6a68 with SMTP id qb23-20020a1709077e9700b006dbc1ef6a68mr2840176ejc.475.1648884577095;
        Sat, 02 Apr 2022 00:29:37 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id js24-20020a170906ca9800b006c8aeca8fe8sm1807682ejb.58.2022.04.02.00.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 00:29:36 -0700 (PDT)
Date:   Sat, 2 Apr 2022 09:29:34 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] staging: vt6655: Rename macro arguments with CamelCase
Message-ID: <f1396aec6cfbead2a4d6d40200ffbadf610f389b.1648882847.git.philipp.g.hortmann@gmail.com>
References: <cover.1648882847.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648882847.git.philipp.g.hortmann@gmail.com>
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

