Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA89756CC33
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiGJBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGJBbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:31:39 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6FC1581A;
        Sat,  9 Jul 2022 18:31:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 20so1658778qky.5;
        Sat, 09 Jul 2022 18:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1R9XYBQRQY6J4EL6q7xM/icI9gP00uZ1F/foaEJGDM=;
        b=EIw21Qh2zZWAmoPE/Z9rzXd90AZ8KUbpFHaSv2nlfmaoA9apb7256ra//TALnXh03v
         9Cvl52+wzkW7OIlPla1Bt6DtbwYpokbBu80df3imVed+bfwCJc8hGAQ8M7bAtwoMdTa1
         7jSZ+uhd8u2G9IL6c7AS+Mjau2y79FTK9+ov7o+Fy1cViEiVdBGt2k7Bz76FzpoXP2Yx
         rX+87GA9Bw+Cm+sra44GRBA1PehPkE8EUYXh1ef//kIWhcc8RzCMUerja5yS8cDK8nG4
         SP67I3AnyE9pETRoBhSHAEIS9endzpz48gEZtIfEu2TGWErQ8LHMYWLbvehWiJnrzlb4
         aPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1R9XYBQRQY6J4EL6q7xM/icI9gP00uZ1F/foaEJGDM=;
        b=sU7+zABJ2VpBpyeLN85TRVz/9lNCa9uiMj0xdYc2W3g0wPJ16F0t60zrh/wjUDsln8
         csx/vHmWmunwj3e0Bvjif2406zmXWz9nNSWV/aByiR93Qt9+iMhvEoXvjDYo96ccaNzO
         0swh3vod0hPfYI4RPLFAHoZDRkZefs9qnC4XGx2LVszMPlO4lXeDz2iG6pJ/R3V5iPtZ
         MdiUPxPLgi7HPwdq6T1IMou2iOW1IkKElOZVAG5j1epqXyvRma0eYrPokfvsl3HE/kal
         8z5ERyUQHrVPdHEsBUpvUaBiPRGVFeVOl1+gzVOVI47i3dLL5Yf8GLSqKjFVvrkczkWl
         W1TQ==
X-Gm-Message-State: AJIora/WgVwIyr2KA2V5BfD2IZKRrkJh31ll9Zk4U3FQ4TEukLEuYqoO
        79DkUFQCBnPjyheU1j30yXU=
X-Google-Smtp-Source: AGRyM1v40+Bae8lIhG+ylmB8X4dyx7FACeiNXvqa9RzGNfVtDG5FWjfh1coEHEHquRzE5l1FbXB7uA==
X-Received: by 2002:a05:620a:2082:b0:6b5:74e6:ced7 with SMTP id e2-20020a05620a208200b006b574e6ced7mr2793515qka.333.1657416697547;
        Sat, 09 Jul 2022 18:31:37 -0700 (PDT)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a410d00b006b575a9775csm2137258qko.45.2022.07.09.18.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 18:31:36 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jic23@kernel.org, geert@linux-m68k.org
Cc:     peda@axentia.se, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] iio: afe: rescale: export symbols used during testing
Date:   Sat,  9 Jul 2022 21:31:08 -0400
Message-Id: <20220710013109.3349104-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220710013109.3349104-1-liambeguin@gmail.com>
References: <20220710013109.3349104-1-liambeguin@gmail.com>
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

In preparation for module support, export symbols use during testing.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/afe/iio-rescale.c       | 2 ++
 drivers/iio/test/iio-test-rescale.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 6949d2151025..1f280c360701 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -107,6 +107,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		return -EOPNOTSUPP;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(rescale_process_scale, IIO_RESCALE);
 
 int rescale_process_offset(struct rescale *rescale, int scale_type,
 			   int scale, int scale2, int schan_off,
@@ -140,6 +141,7 @@ int rescale_process_offset(struct rescale *rescale, int scale_type,
 		return -EOPNOTSUPP;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(rescale_process_offset, IIO_RESCALE);
 
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
index 735e2f97af18..cc782ccff880 100644
--- a/drivers/iio/test/iio-test-rescale.c
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -712,3 +712,4 @@ kunit_test_suite(iio_rescale_test_suite);
 MODULE_AUTHOR("Liam Beguin <liambeguin@gmail.com>");
 MODULE_DESCRIPTION("Test IIO rescale conversion functions");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_RESCALE);
-- 
2.35.1.4.g5d01301f2b86

