Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF67A52FC70
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiEUMsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiEUMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:48:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF624755E
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:47:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s28so14564794wrb.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norberthealth-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=xajSckGUllAsiw/fxcToNZh6oIkhT7E2nmZO0iNe+14=;
        b=tsR+x6Ql3TCCA9l9Oy4cvSfowhUYX9KT4B+ORuUAtDdpqrOnzElf5vDEJzs+FA+aYK
         OAa3Q6ChOLtkq9rhyOC02IYZDsZfwHBZnJkZidzrZ6O+INPBsn5hyM/WZ4q8WPpRs9yD
         TWPQ4flPKHz22yLnPEN/wmFqpSTXb5brX0l0o/3LKYXddIH7GyPP3JGuppgQQSRXjw02
         ns1fZp38CtkzJ4HjfFcVJAjZUrzs2wIvAtWEJSFl+Ybj9LSkZAq8E4QSo8ufCFQSdHRe
         t4czwy0AAiFr+IWLFHtr2on4UGNh1UGs6LUFRufJHszl1VNyho6VXbCdYQctzS0T2flY
         vV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xajSckGUllAsiw/fxcToNZh6oIkhT7E2nmZO0iNe+14=;
        b=hdbYALY7rSkVV1ZlkOfr/wVGrWsvhnqWu5c9Up003RbuRG+PcZvrPzb9LS262zgF/8
         VDPU0NHmTybVGhHPQ0SrNrsJd0hbEKnLOw+BzW7/gBIKPoKjJI5Q97FMG/kjjwTdiaM+
         oBKDG32XciYtSwXu2T8stO8cRjt236OiOTfFSTnlKh8BU2zZFMJ8bgBRyz7RnxCG7Qw9
         SPuzaKLEAsOfa3+hfQEFOqfQuj8tE3Uwmjie6i/5dAfLHSqhEBrIYVk+bS8x937V4bZA
         tucZN/HV2KuFlOaPV5YK2HM+jYFHqtjZLcqeKzOGlCNZqeWH4NOZYUha9uRXvuzuma3z
         m0cg==
X-Gm-Message-State: AOAM533N1HvMr0IYz85yKA5zxv26YiTu/vktm5VJEopfudtmncp07qLc
        mdT4qzU8j1y3QjD0at3tnTDLyOkGeu+z4CTo58U=
X-Google-Smtp-Source: ABdhPJxAU6b7F9I1ezcwxBkQ2hg19YDaNsi/bsMSHDitaBssg6ytkOUJtXZAu4jNAoaGxRa5cZoqxA==
X-Received: by 2002:a5d:5848:0:b0:20d:122c:a058 with SMTP id i8-20020a5d5848000000b0020d122ca058mr11941876wrf.719.1653137276341;
        Sat, 21 May 2022 05:47:56 -0700 (PDT)
Received: from localhost.localdomain (156.120.26.93.rev.sfr.net. [93.26.120.156])
        by smtp.gmail.com with ESMTPSA id s9-20020a7bc389000000b0039482d95ab7sm4194251wmj.24.2022.05.21.05.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 05:47:55 -0700 (PDT)
From:   Roger Knecht <roger@norberthealth.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Knecht <roger@norberthealth.com>
Subject: [PATCH v5] crc-itu-t: Fix typo in CRC ITU-T polynom comment
Date:   Sat, 21 May 2022 14:47:45 +0200
Message-Id: <20220521124745.8747-1-roger@norberthealth.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code comment says that the polynom is x^16 + x^12 + x^15 + 1, but the
correct polynom is x^16 + x^12 + x^5 + 1.

Quote from page 2 in the ITU-T V.41 specification:
  "2 Encoding and checking process

  The service bits and information bits, taken in conjunction, correspond
  to the coefficients of a message polynomial having terms from x^(n-1)
  (n = total number of bits in a block or sequence) down to x^16. This
  polynomial is divided, modulo 2, by the generating polynomial
  x^16 + x^12 + x^5 + 1. [...]"

Source: https://www.itu.int/rec/T-REC-V.41-198811-I/en)
The hex polynom 0x1021 and CRC code implementation are correct.

Signed-off-by: Roger Knecht <roger@norberthealth.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
Changes:
v5: Clean up patch description and added acked-by
v4: Changed comment from /** to /* (the comment is not a kernel doc comment)
v3: Moved "changes and thanks" out of the commit message.
v2: Extended patch description

 include/linux/crc-itu-t.h | 2 +-
 lib/crc-itu-t.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/crc-itu-t.h b/include/linux/crc-itu-t.h
index a4367051e192..2f991a427ade 100644
--- a/include/linux/crc-itu-t.h
+++ b/include/linux/crc-itu-t.h
@@ -4,7 +4,7 @@
  *
  * Implements the standard CRC ITU-T V.41:
  *   Width 16
- *   Poly  0x1021 (x^16 + x^12 + x^15 + 1)
+ *   Poly  0x1021 (x^16 + x^12 + x^5 + 1)
  *   Init  0
  */
 
diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
index 1974b355c148..1d26a1647da5 100644
--- a/lib/crc-itu-t.c
+++ b/lib/crc-itu-t.c
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <linux/crc-itu-t.h>
 
-/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^15 + 1) */
+/* CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^5 + 1) */
 const u16 crc_itu_t_table[256] = {
 	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
 	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
-- 
2.17.1

