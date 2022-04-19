Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24F5507AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356681AbiDSUYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347789AbiDSUXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:23:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC5286CA;
        Tue, 19 Apr 2022 13:21:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so1420722wmb.1;
        Tue, 19 Apr 2022 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxuX79qNn642a66gAPHJUJU+SDUv1URkLNT8e6p6QeA=;
        b=OkyizCXOo+WWlMBZLtcAQ1HbTqiTnP4SShdSeD2Qe5EcyCBc4S8v9uLfmQRki3oAWT
         wCDpTfL3bQ7GOExUFaJ5wuTXGTlNburXZ3zWYEoG+X6L95R11zNDjVRaIXHnBHc8nfcz
         d41+/LwkrB9MkKAirXROTyRrIp7jB88xpiIsClmAFolqkw+SPaO/SlJF5ikLe2HdiEjl
         BBh6MquWBfDTPThhIxlOwI1jOUS00lUi1zljxxcfjdHJWnb/ENqLajvrEt+s2/BzciZX
         3kbSmhsj2Ih/xXuvUhnbANxM2D1CxC6YG/M4BgZPrkcjVk+RlvebSxlvf9xzsCR0eRvN
         n3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxuX79qNn642a66gAPHJUJU+SDUv1URkLNT8e6p6QeA=;
        b=q9blqtkXS4LlXbBIUuDBTVu0b2n+vuwkkTg8d3sv5lXFHIPj/9qiGaX0O6iXE+/8+D
         cn3NkVPI5KgzalLDxgt5b6LSRPrpG9QzLFs/wOlSOZE2+lWLR4zBPsMovKGF+MiP+raZ
         JNtUDhHP9wC2Eqrf3qyd/fozcH8p0FVAvYL0RwxDNmTH+UUBmB6lmUrQrJvLrvK1E3Ga
         REQt7JKH0t3RaZCTgfRQqEZglwOudD2TOnTof5tKas73wuWqDx4RU+lPkjrAdffna2Td
         sXkTt+Zt2mUO8D0V9IM4LqUYSGrvZ+bVvEdXCLWcGSI5zOenEo9Yy4hBY1zV5xkXxmBM
         6JiA==
X-Gm-Message-State: AOAM531VsnOd9IHzv8AcwQ9cPfc6yykqupCS4vDVZifjjrN6R4Styigd
        bd1H1UjpFzg+Q8H1vtUl3Sw=
X-Google-Smtp-Source: ABdhPJxK3f5mSqPgiqCFMeFGrS2jKPSzG4BGI06yeTuIc580hSQfbhSMiNZnn/zJQXfSWajKc+wJ7g==
X-Received: by 2002:a05:600c:3d0f:b0:38e:bc5f:5515 with SMTP id bh15-20020a05600c3d0f00b0038ebc5f5515mr281338wmb.128.1650399669690;
        Tue, 19 Apr 2022 13:21:09 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d45cb000000b0020a810f7726sm9959168wrs.5.2022.04.19.13.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:21:09 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     matt.ranostay@konsulko.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH 1/3] media: i2c: video-i2c: Move defines to the top of the file
Date:   Tue, 19 Apr 2022 22:20:49 +0200
Message-Id: <20220419202051.44013-2-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419202051.44013-1-mosescb.dev@gmail.com>
References: <20220419202051.44013-1-mosescb.dev@gmail.com>
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

Currently, the defines in this driver are after some structs and
functions, it makes more sense to move them up to the top of the file,
so that the constants can be named together with other defines.

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/media/i2c/video-i2c.c | 50 +++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index cb660b4bfd4b..b3fe9a507f7f 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -34,6 +34,31 @@
 
 #define VIDEO_I2C_DRIVER	"video-i2c"
 
+/* Power control register */
+#define AMG88XX_REG_PCTL	0x00
+#define AMG88XX_PCTL_NORMAL		0x00
+#define AMG88XX_PCTL_SLEEP		0x10
+
+/* Reset register */
+#define AMG88XX_REG_RST		0x01
+#define AMG88XX_RST_FLAG		0x30
+#define AMG88XX_RST_INIT		0x3f
+
+/* Frame rate register */
+#define AMG88XX_REG_FPSC	0x02
+#define AMG88XX_FPSC_1FPS		BIT(0)
+
+/* Thermistor register */
+#define AMG88XX_REG_TTHL	0x0e
+
+/* Temperature register */
+#define AMG88XX_REG_T01L	0x80
+
+/* Control register */
+#define MLX90640_REG_CTL1		0x800d
+#define MLX90640_REG_CTL1_MASK		0x0380
+#define MLX90640_REG_CTL1_MASK_SHIFT	7
+
 struct video_i2c_chip;
 
 struct video_i2c_buffer {
@@ -135,31 +160,6 @@ static struct nvmem_config mlx90640_nvram_config = {
 	.reg_read = mlx90640_nvram_read,
 };
 
-/* Power control register */
-#define AMG88XX_REG_PCTL	0x00
-#define AMG88XX_PCTL_NORMAL		0x00
-#define AMG88XX_PCTL_SLEEP		0x10
-
-/* Reset register */
-#define AMG88XX_REG_RST		0x01
-#define AMG88XX_RST_FLAG		0x30
-#define AMG88XX_RST_INIT		0x3f
-
-/* Frame rate register */
-#define AMG88XX_REG_FPSC	0x02
-#define AMG88XX_FPSC_1FPS		BIT(0)
-
-/* Thermistor register */
-#define AMG88XX_REG_TTHL	0x0e
-
-/* Temperature register */
-#define AMG88XX_REG_T01L	0x80
-
-/* Control register */
-#define MLX90640_REG_CTL1		0x800d
-#define MLX90640_REG_CTL1_MASK		0x0380
-#define MLX90640_REG_CTL1_MASK_SHIFT	7
-
 static int amg88xx_xfer(struct video_i2c_data *data, char *buf)
 {
 	return regmap_bulk_read(data->regmap, AMG88XX_REG_T01L, buf,
-- 
2.30.2

