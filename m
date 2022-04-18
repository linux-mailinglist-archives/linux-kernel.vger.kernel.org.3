Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0695505D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347160AbiDRR3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347162AbiDRR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:28:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE192B242
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:25:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u2so20023601pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKuq0wU3+JeGnDXBmVteCxHEwvafVW2Ji4siv6RJc6g=;
        b=Xhxa5K+utu+20ev8QXD3/Lag35QKJGaCMWBrtXNdffFxd4KBEDHQdfHNXN2MAU2oNe
         47KiHyvukhJBBbUl45qknLCBmfya/36mwjvNNiTsO1I9igy2qNvLEHgfodUUULeJvp/Q
         xRAIP/9qMTqxk4VHxG9yuN4UKq66u+zS1rxsFeYnKmsacrVfwjQ2qr7ynbAoobvMDm6n
         rAquBQyNzQByJy4weYuIB1ex+xEf/r4IufPrMauOHxTByzfsfB1nlztfPjFoj115xEcJ
         D+JfZjMAn9S82aMibIZsjpZ+b0lDuBd2fODhr9T8gtEuKlc2i4MyGySi0TkaXIhiWQqU
         I11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKuq0wU3+JeGnDXBmVteCxHEwvafVW2Ji4siv6RJc6g=;
        b=01lFIOCeYm8+PIYfML9VjVX48ePFOQSihGTEgNX/LbsSConX64LEPj+be/1lbrbN8Y
         v49I1pLkquGAP1JBtAG5OdQXFyII2X0kUjTeB8KtR+wYQn40UeKSAkaKAoA3pTHBbX5e
         xb1sJdTxRXDliiFgDvQuJsQm2kArvvKIW0RXszPa5si0SJZdUWygomnbA7RExgfxdQtH
         +AH4mVgYdIfTPjwi9oWo6I3Zz2507L5OT7bjinSGY/Jx7t3w0rH2ilxLNw2IrO+znTzd
         drlg5k5VxQbChIhcIIMNq/GcQFUpDCq0rYkI8vDsGhnxwHWVF9cRXhbDLGGDejKkXBwc
         0VWQ==
X-Gm-Message-State: AOAM53287bp0AMf7B5hfwW5Ki6esQG0HxGEqYYQd4aXoGGEvFxKvP7+/
        szWj/EafU6fQrlwUnuEO5rWMoLuq/uvaXw==
X-Google-Smtp-Source: ABdhPJy3JJAfOVN7tfyfI2+4b+4P83md/k20gxaF/4DLe0/MfcqlQs9FIeOyxP5Nqj4Fe1hS3IYReg==
X-Received: by 2002:a63:7d49:0:b0:378:907d:1fc7 with SMTP id m9-20020a637d49000000b00378907d1fc7mr11130115pgn.252.1650302749267;
        Mon, 18 Apr 2022 10:25:49 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78f29000000b005098201d2f5sm13041394pfr.205.2022.04.18.10.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:25:49 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH v3 3/3] staging: media: zoran: add parentheses on macro parameter
Date:   Mon, 18 Apr 2022 22:44:56 +0530
Message-Id: <20220418171453.16971-4-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418171453.16971-1-aliyarahmani786@gmail.com>
References: <20220418171453.16971-1-aliyarahmani786@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes checkpatch warnings of precedence issues. Add parentheses
around macro argument 'num'.

Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
---
changes since v2: Rework commit description and subject
---
 drivers/staging/media/zoran/videocodec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 19732a47c8bd..925f90fd5885 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -22,7 +22,7 @@ MODULE_PARM_DESC(videocodec_debug, "Debug level (0-4)");
 
 #define dprintk(num, format, args...) \
 	do { \
-		if (videocodec_debug >= num) \
+		if (videocodec_debug >= (num)) \
 			printk(format, ##args); \
 	} while (0)
 
-- 
2.25.1

