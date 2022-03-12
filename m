Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF0E4D7045
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiCLSFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCLSFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:05:14 -0500
Received: from tmailer.gwdg.de (tmailer.gwdg.de [134.76.10.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF246B30
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 10:04:08 -0800 (PST)
Received: from excmbx-17.um.gwdg.de ([134.76.9.228] helo=email.gwdg.de)
        by mailer.gwdg.de with esmtp (GWDG Mailer)
        (envelope-from <alexander.vorwerk@stud.uni-goettingen.de>)
        id 1nT662-000G61-G0; Sat, 12 Mar 2022 19:04:06 +0100
Received: from notebook.fritz.box (10.250.9.199) by excmbx-17.um.gwdg.de
 (134.76.9.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2375.24; Sat, 12
 Mar 2022 19:04:05 +0100
From:   Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
Subject: [PATCH] drivers: iio: fix a few code style issues
Date:   Sat, 12 Mar 2022 19:03:43 +0100
Message-ID: <20220312180343.8935-1-alexander.vorwerk@stud.uni-goettingen.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.250.9.199]
X-ClientProxiedBy: EXCMBX-03.um.gwdg.de (134.76.9.218) To excmbx-17.um.gwdg.de
 (134.76.9.228)
X-Virus-Scanned: (clean) by clamav
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Fix indent in else statement
* Remove unnecessary 'else' after 'break'
* Remove space in '* attr'

Signed-off-by: Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
---
 drivers/iio/industrialio-buffer.c | 4 ++--
 drivers/iio/industrialio-core.c   | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 208b5193c621..15c5405853d7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -915,7 +915,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 		if (scan_mask == NULL)
 			return -EINVAL;
 	} else {
-	    scan_mask = compound_mask;
+		scan_mask = compound_mask;
 	}
 
 	config->scan_bytes = iio_compute_scan_bytes(indio_dev,
@@ -1649,7 +1649,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	}
 
 	attrn = buffer_attrcount + scan_el_attrcount + ARRAY_SIZE(iio_buffer_attrs);
-	attr = kcalloc(attrn + 1, sizeof(* attr), GFP_KERNEL);
+	attr = kcalloc(attrn + 1, sizeof(*attr), GFP_KERNEL);
 	if (!attr) {
 		ret = -ENOMEM;
 		goto error_free_scan_mask;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 409c278a4c2c..346c8fbf18a4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -892,8 +892,7 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
 		} else if (*str == '\n') {
 			if (*(str + 1) == '\0')
 				break;
-			else
-				return -EINVAL;
+			return -EINVAL;
 		} else if (!strncmp(str, " dB", sizeof(" dB") - 1) && scale_db) {
 			/* Ignore the dB suffix */
 			str += sizeof(" dB") - 1;
-- 
2.17.1

