Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6D482669
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 04:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiAADdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 22:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiAADdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 22:33:39 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C91C06173E;
        Fri, 31 Dec 2021 19:33:38 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id p19so25447654qtw.12;
        Fri, 31 Dec 2021 19:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/QUXGuUmCgqGwWw+2nWvnPCOvClaTQspM6COZ2NY0k=;
        b=OP13XCwkX7mq6PP2h0+m3mXoMQ0WEcPQ5vSEd7c3cjd06AfxcJxVEOZ5WifeWDiQDx
         nSTKhCu2KqJ+cVxApx4J30O1tMbcIKkvqfBMjBLeU6jI9vicgJrt/h4PIQIJDYjdbw4+
         HEEI6xBZEhueHA1W2/nwXo3e0iHCu4XwJlEDOFL6QvoR8mqOLuDq4odsUg4XrYFM8GRI
         PkMievS8dD1Wom8QBExM6GB7wBqJg/xXJTNFRVzLBJjjcFuS1OYnRkvAajxjgOZuee1R
         xO/7B8pkkL6+oJt94YUUo2sEyWCWAQ+PjmizBXhEc734uIXQQBwmyXJI7jPJ2o5bOOUQ
         92fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/QUXGuUmCgqGwWw+2nWvnPCOvClaTQspM6COZ2NY0k=;
        b=GpKzau8X4lEwn9YO1KZbv8YMndnmHiG0iHwg+KvAzAG1B3yj3rtOVUZw/pHaL09E8M
         Q9Ah4/lqGS4Ouhl09N99Gqg/LmRpxVu+V7nF1VV+NctiITiPwgi06u5xhQlw3m4Qgq4o
         CrW/iFW272zjKNYg0MlWMgLeUoGGZTJ5apztMd97ldJZEJMAjHlxOB9WuSSiZBluCnRL
         xwyvSRYP7uU2BzULK0akD6c6Tyw19l7dG3lThCDcfDH9z80ns29mjm7oKPDqWafW7f4L
         FeYDmuFqxVIsxdDQdpybrlx+YNxfnO9/0XlEGaYyIckykzd/+TVEvDwarZ43bnEEJaFh
         xdww==
X-Gm-Message-State: AOAM531dc91x4cKvrNjTlvf0RtRZjKQgxBk7SggiEZeomjU4czC6GoUH
        oN/5ApOZxztH3Md4rpn8Rf/3hTWM9hw=
X-Google-Smtp-Source: ABdhPJyC3mgDgblToT0ZS9KXelO6WouefshI+RPoaC8fjsPFkpEgrfknO4BI1PoTD37z6Zs31kyEWQ==
X-Received: by 2002:a05:622a:1a03:: with SMTP id f3mr33531443qtb.141.1641008017847;
        Fri, 31 Dec 2021 19:33:37 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id x4sm24132867qtw.44.2021.12.31.19.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 19:33:37 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, erhard_f@mailbox.org,
        yinxiujiang@kylinos.cn
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] of: unittest: change references to obsolete overlay id
Date:   Fri, 31 Dec 2021 21:33:28 -0600
Message-Id: <20220101033329.1277779-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220101033329.1277779-1-frowand.list@gmail.com>
References: <20220101033329.1277779-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Unittest inconsistently interchanges overlay changeset id and
overlay id.  Change variable names of overlay id to overlay
changeset id.

Do not fix variable names in the overlay tracking functions
of_unittest_overlay_tracked(), of_unittest_track_overlay(), and
of_unittest_destroy_tracked_overlays() which will be replaced in
a following commit.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 54 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 481ba8682ebf..33c458044600 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1492,7 +1492,7 @@ static int __init unittest_data_add(void)
 }
 
 #ifdef CONFIG_OF_OVERLAY
-static int __init overlay_data_apply(const char *overlay_name, int *overlay_id);
+static int __init overlay_data_apply(const char *overlay_name, int *ovcs_id);
 
 static int unittest_probe(struct platform_device *pdev)
 {
@@ -1973,18 +1973,18 @@ static void of_unittest_destroy_tracked_overlays(void)
 	} while (defers > 0);
 }
 
-static int __init of_unittest_apply_overlay(int overlay_nr, int *overlay_id)
+static int __init of_unittest_apply_overlay(int overlay_nr, int *ovcs_id)
 {
 	const char *overlay_name;
 
 	overlay_name = overlay_name_from_nr(overlay_nr);
 
-	if (!overlay_data_apply(overlay_name, overlay_id)) {
+	if (!overlay_data_apply(overlay_name, ovcs_id)) {
 		unittest(0, "could not apply overlay \"%s\"\n",
 				overlay_name);
 		return -EFAULT;
 	}
-	of_unittest_track_overlay(*overlay_id);
+	of_unittest_track_overlay(*ovcs_id);
 
 	return 0;
 }
@@ -2029,7 +2029,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 		int unittest_nr, int before, int after,
 		enum overlay_type ovtype)
 {
-	int ret, ovcs_id, save_id;
+	int ret, ovcs_id, save_ovcs_id;
 
 	/* unittest device must be in before state */
 	if (of_unittest_device_exists(unittest_nr, ovtype) != before) {
@@ -2057,7 +2057,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 		return -EINVAL;
 	}
 
-	save_id = ovcs_id;
+	save_ovcs_id = ovcs_id;
 	ret = of_overlay_remove(&ovcs_id);
 	if (ret != 0) {
 		unittest(0, "%s failed to be destroyed @\"%s\"\n",
@@ -2065,7 +2065,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 				unittest_path(unittest_nr, ovtype));
 		return ret;
 	}
-	of_unittest_untrack_overlay(save_id);
+	of_unittest_untrack_overlay(save_ovcs_id);
 
 	/* unittest device must be again in before state */
 	if (of_unittest_device_exists(unittest_nr, PDEV_OVERLAY) != before) {
@@ -2192,7 +2192,7 @@ static void __init of_unittest_overlay_5(void)
 /* test overlay application in sequence */
 static void __init of_unittest_overlay_6(void)
 {
-	int i, ov_id[2], ovcs_id;
+	int i, save_ovcs_id[2], ovcs_id;
 	int overlay_nr = 6, unittest_nr = 6;
 	int before = 0, after = 1;
 	const char *overlay_name;
@@ -2225,8 +2225,8 @@ static void __init of_unittest_overlay_6(void)
 		unittest(0, "could not apply overlay \"%s\"\n", overlay_name);
 			return;
 	}
-	ov_id[0] = ovcs_id;
-	of_unittest_track_overlay(ov_id[0]);
+	save_ovcs_id[0] = ovcs_id;
+	of_unittest_track_overlay(ovcs_id);
 
 	EXPECT_END(KERN_INFO,
 		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status");
@@ -2242,8 +2242,8 @@ static void __init of_unittest_overlay_6(void)
 		unittest(0, "could not apply overlay \"%s\"\n", overlay_name);
 			return;
 	}
-	ov_id[1] = ovcs_id;
-	of_unittest_track_overlay(ov_id[1]);
+	save_ovcs_id[1] = ovcs_id;
+	of_unittest_track_overlay(ovcs_id);
 
 	EXPECT_END(KERN_INFO,
 		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status");
@@ -2263,7 +2263,7 @@ static void __init of_unittest_overlay_6(void)
 	}
 
 	for (i = 1; i >= 0; i--) {
-		ovcs_id = ov_id[i];
+		ovcs_id = save_ovcs_id[i];
 		if (of_overlay_remove(&ovcs_id)) {
 			unittest(0, "%s failed destroy @\"%s\"\n",
 					overlay_name_from_nr(overlay_nr + i),
@@ -2271,7 +2271,7 @@ static void __init of_unittest_overlay_6(void)
 						PDEV_OVERLAY));
 			return;
 		}
-		of_unittest_untrack_overlay(ov_id[i]);
+		of_unittest_untrack_overlay(save_ovcs_id[i]);
 	}
 
 	for (i = 0; i < 2; i++) {
@@ -2294,7 +2294,7 @@ static void __init of_unittest_overlay_6(void)
 /* test overlay application in sequence */
 static void __init of_unittest_overlay_8(void)
 {
-	int i, ov_id[2], ovcs_id;
+	int i, save_ovcs_id[2], ovcs_id;
 	int overlay_nr = 8, unittest_nr = 8;
 	const char *overlay_name;
 	int ret;
@@ -2316,8 +2316,8 @@ static void __init of_unittest_overlay_8(void)
 	if (!ret)
 		return;
 
-	ov_id[0] = ovcs_id;
-	of_unittest_track_overlay(ov_id[0]);
+	save_ovcs_id[0] = ovcs_id;
+	of_unittest_track_overlay(ovcs_id);
 
 	overlay_name = overlay_name_from_nr(overlay_nr + 1);
 
@@ -2335,11 +2335,11 @@ static void __init of_unittest_overlay_8(void)
 		return;
 	}
 
-	ov_id[1] = ovcs_id;
-	of_unittest_track_overlay(ov_id[1]);
+	save_ovcs_id[1] = ovcs_id;
+	of_unittest_track_overlay(ovcs_id);
 
 	/* now try to remove first overlay (it should fail) */
-	ovcs_id = ov_id[0];
+	ovcs_id = save_ovcs_id[0];
 
 	EXPECT_BEGIN(KERN_INFO,
 		     "OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8");
@@ -2365,7 +2365,7 @@ static void __init of_unittest_overlay_8(void)
 
 	/* removing them in order should work */
 	for (i = 1; i >= 0; i--) {
-		ovcs_id = ov_id[i];
+		ovcs_id = save_ovcs_id[i];
 		if (of_overlay_remove(&ovcs_id)) {
 			unittest(0, "%s not destroyed @\"%s\"\n",
 					overlay_name_from_nr(overlay_nr + i),
@@ -2373,7 +2373,7 @@ static void __init of_unittest_overlay_8(void)
 						PDEV_OVERLAY));
 			return;
 		}
-		of_unittest_untrack_overlay(ov_id[i]);
+		of_unittest_untrack_overlay(save_ovcs_id[i]);
 	}
 
 	unittest(1, "overlay test %d passed\n", 8);
@@ -2837,7 +2837,7 @@ struct overlay_info {
 	uint8_t		*dtb_begin;
 	uint8_t		*dtb_end;
 	int		expected_result;
-	int		overlay_id;
+	int		ovcs_id;
 	char		*name;
 };
 
@@ -2991,7 +2991,7 @@ void __init unittest_unflatten_overlay_base(void)
  *
  * Return 0 on unexpected error.
  */
-static int __init overlay_data_apply(const char *overlay_name, int *overlay_id)
+static int __init overlay_data_apply(const char *overlay_name, int *ovcs_id)
 {
 	struct overlay_info *info;
 	int found = 0;
@@ -3013,9 +3013,9 @@ static int __init overlay_data_apply(const char *overlay_name, int *overlay_id)
 	if (!size)
 		pr_err("no overlay data for %s\n", overlay_name);
 
-	ret = of_overlay_fdt_apply(info->dtb_begin, size, &info->overlay_id);
-	if (overlay_id)
-		*overlay_id = info->overlay_id;
+	ret = of_overlay_fdt_apply(info->dtb_begin, size, &info->ovcs_id);
+	if (ovcs_id)
+		*ovcs_id = info->ovcs_id;
 	if (ret < 0)
 		goto out;
 
-- 
Frank Rowand <frank.rowand@sony.com>

