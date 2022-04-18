Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A8505C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbiDRQey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiDRQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:34:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F965F50
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:31:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t13so19764416pgn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5XRVN0rYoKShdUkWHsZOX7pTFc2v1hH6PY/aOGhz2o=;
        b=opDlbbLXpfliyT0hxegO0lHHNJUhKN18viHaTHcXInOVtr00j2D8OJFj2gl2cJlr82
         f29Iyvsxr7+Q9zFvxuyMO9eQsR30Xr7MVxSFP6w3KA9acvyoS+j3brCpMYzkTI2x1lKQ
         VtEloOT+ljzj32WU7UF+mVHgUTggpIEl9WhX6gBQqLyTCBW5PFTKDwJv53+zsuWPc9Ot
         Wl2fCmF04oy43KKL6oGBP0xwv7LM1xKPJmKHDrWnNsXnyC4WSeWN3+WMBmUJc+HyV9s6
         wqtDbUp6BzP6OG0jFXWUEjZa/mgfOw7FBLEeSj0PoaqgIKC38IOmzaIR8fzRjP7v8Vbl
         cSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5XRVN0rYoKShdUkWHsZOX7pTFc2v1hH6PY/aOGhz2o=;
        b=TDKBw+G9w2hHsf2l/JjC6lMXkko1gB5a2jojpxublO58cNgr/j99w2IfB5PzUrAehO
         laQexBOkYQBeObvp/OzYoHJuL/NL4FGhwfSNJEg/1QhrLVe+Qv/e5GDP5VfzrV3Ae6X7
         RfStZs7aG0LEBsKqB7UZcF14nomo5PLllVWES5rllOkbYb7uBBKpO56LxbrwaYa8Gcv5
         lAHtcYoeydCcARjZmL2JCiE4sWJ+V2JbN4TOaHQoRkQU6DXwXzNxJF9KGue+8ovgAeyx
         ttHR/VTK3+7GM+rZqM07SovDqNkKHTIrhZoAE30E05HJ7oqKO0jDTVzMiVMiVLPSrZVT
         u6Lg==
X-Gm-Message-State: AOAM531PSo7YxyLNODWbeuxTLdS456rCT1XsJGsRN9HcrMYaWJYErIoq
        0R2c7FaKzbRDbGZAJIfanoI=
X-Google-Smtp-Source: ABdhPJxpEjB37dv3sT9B386rQBREHhLwteTv4M1Ps9RbqbppqC2G/I/1zlBh9L5z4QcXHZeRHi4kWA==
X-Received: by 2002:a65:4c4e:0:b0:39d:21c4:2381 with SMTP id l14-20020a654c4e000000b0039d21c42381mr10912664pgr.566.1650299502320;
        Mon, 18 Apr 2022 09:31:42 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id h18-20020a63c012000000b0039cc3c323f7sm13295602pgg.33.2022.04.18.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:31:41 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH v2 3/3] staging: media: zoran: add parentheses on macro parameter
Date:   Mon, 18 Apr 2022 21:52:50 +0530
Message-Id: <20220418162244.15346-4-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418162244.15346-1-aliyarahmani786@gmail.com>
References: <20220418162244.15346-1-aliyarahmani786@gmail.com>
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

