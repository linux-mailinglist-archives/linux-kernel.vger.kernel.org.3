Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78A4E9A51
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbiC1PG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbiC1PGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:06:55 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EFBF42493
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:05:13 -0700 (PDT)
Received: from hp-amd-paul (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 4453a9ce (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Mar 2022 15:05:11 +0000 (UTC)
Date:   Mon, 28 Mar 2022 10:05:08 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IIO: accel: fixed coding style issues
Message-ID: <YkHOpCT2Gad1YaxN@hp-amd-paul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed case statement issues and spacing issues.

Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 15 +++++++++++----
 drivers/iio/accel/dmard09.c           |  2 +-
 drivers/iio/accel/kxsd9-spi.c         |  4 ++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index d11f66801..f7dd7ec2c 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -432,10 +432,17 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 
 		for (j = 0; j < 3; j++) {
 			switch (val[j]) {
-			case -1: str = "-1"; break;
-			case 0:  str = "0";  break;
-			case 1:  str = "1";  break;
-			default: goto unknown_format;
+			case -1:
+				str = "-1";
+				break;
+			case 0:
+				str = "0";
+				break;
+			case 1:
+				str = "1";
+				break;
+			default:
+				goto unknown_format;
 			}
 			orientation->rotation[i * 3 + j] = str;
 		}
diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index e6e28c964..87bc38d4d 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -24,7 +24,7 @@
 #define DMARD09_AXIS_Y 1
 #define DMARD09_AXIS_Z 2
 #define DMARD09_AXIS_X_OFFSET ((DMARD09_AXIS_X + 1) * 2)
-#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1 )* 2)
+#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1) * 2)
 #define DMARD09_AXIS_Z_OFFSET ((DMARD09_AXIS_Z + 1) * 2)
 
 struct dmard09_data {
diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index 57c451cfb..989f53fb0 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -44,8 +44,8 @@ static const struct spi_device_id kxsd9_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
 
 static const struct of_device_id kxsd9_of_match[] = {
-        { .compatible = "kionix,kxsd9" },
-        { },
+	{ .compatible = "kionix,kxsd9" },
+	{ },
 };
 MODULE_DEVICE_TABLE(of, kxsd9_of_match);
 
-- 
2.35.1

