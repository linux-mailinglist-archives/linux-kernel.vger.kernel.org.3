Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16985577719
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiGQPfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiGQPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:35:03 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2106E13E88;
        Sun, 17 Jul 2022 08:35:02 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m16so2881816qka.12;
        Sun, 17 Jul 2022 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7+cg2LOJ1jjwaLPnm5wodKq+ffhY0uO8A/jZtHxwtA=;
        b=XW0KM7LR2T1Y//unaBu3Ul/2TzTRQWzx6EBVJ9QTIO0vo/uybtLneAJNUgX9mKOgaT
         ot1DUb/SEdJPxaNsXaLykoYJhsBG5zrqDCIUVCaSxwh/OTA4+svu92V9W87mt9kS+6+j
         Qn1UuoYVoMGR1AG7e1tJUly1xFMFR5aTXX7IaMR2qe4kB5UO0397aNolUPu3BKju5E6m
         7oN+xOrXG0RwK2auPBMYNEteO3kh9/OH4I8p/Ik6KYve6u8XG70X7FR9uoXw2YQCat+l
         Xs4PmX4KhcczaDbMiVSH+bzYF5c6rjT9JrtP8/idLVZzJfMppLOPpGNJAMnUfnOEjGql
         2PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7+cg2LOJ1jjwaLPnm5wodKq+ffhY0uO8A/jZtHxwtA=;
        b=E4ZywFEHSwXdp8mqEhMUr/74BEeCkMm3xqNm1Dsb7pOHOAc/9w7jgT4xm4CqbVXPVz
         WXdo2h12dzXvrR1l6Gjvks2QzDxxpZj68K77EZ3DryvGsHl4KDy9xn7AdZMTkzK6N6k3
         27aSBK+Ji2vC2vjiTVRlrf0/agzIn2lqZvcjw/4Dh4OH+urkfwfHQo8I1/fWYnv81vpf
         VhASBAGUgx6UpTrQ1OHx8YVeZircslOICZkIX0IGvm25RVzv9K5iB72EzseluwpXsYw9
         QjRzNmaKIkF7fdDhnDOnDFsNzYdhchs+ivwBj38q4xCVRuptgbriP7cCgIHIhlaYA5dV
         wAew==
X-Gm-Message-State: AJIora8UjYpO5Fvcs53TRji+BtKuNql2r00SAyYD3wyRGb2bHpHJVx17
        U/UFJ/M94XkRl7JHJ4E7l/VQwosao7o=
X-Google-Smtp-Source: AGRyM1tOomyBhtXwCr64p2wk6HYudjQrnvaiqliSLHvuPXogdJVCBz+pEHUAg+ZXPUEXrT6V8zDa8w==
X-Received: by 2002:a05:620a:c43:b0:6a9:77ef:e000 with SMTP id u3-20020a05620a0c4300b006a977efe000mr15387110qki.396.1658072100849;
        Sun, 17 Jul 2022 08:35:00 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id ez12-20020a05622a4c8c00b0031eb0bb5c3csm7708016qtb.28.2022.07.17.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 08:35:00 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH] iio: Use parens with sizeof
Date:   Sun, 17 Jul 2022 11:34:38 -0400
Message-Id: <20220717153438.10800-1-joetalbott@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer 'sizeof(var)' over 'sizeof var' as reported by checkpatch.pl.

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f504ed351b3e..88bccb0676c8 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -368,7 +368,7 @@ struct iio_poll_func
 	va_list vargs;
 	struct iio_poll_func *pf;
 
-	pf = kmalloc(sizeof *pf, GFP_KERNEL);
+	pf = kmalloc(sizeof(*pf), GFP_KERNEL);
 	if (pf == NULL)
 		return NULL;
 	va_start(vargs, fmt);
@@ -560,7 +560,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 	struct iio_trigger *trig;
 	int i;
 
-	trig = kzalloc(sizeof *trig, GFP_KERNEL);
+	trig = kzalloc(sizeof(*trig), GFP_KERNEL);
 	if (!trig)
 		return NULL;
 
-- 
2.35.3

