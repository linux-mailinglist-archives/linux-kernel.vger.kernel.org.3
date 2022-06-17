Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66A550102
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383580AbiFQX4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382433AbiFQX4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:56:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE7D60066
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u12so11347102eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M05mXEEsCUtqw0Yy5vlYj0mxj1VIm7h4Q0ugvilopUQ=;
        b=MYqD5c5PmVQ3vLo24PfyqQTI2LSm3WSKDIOTiSWiP9/wPfKHfDPb1fhnamNLyk8lrG
         X+BqbEOmWkDWKnFgh+YtFObJEs1sJtOtI8Hcu9FPEGZ76enJivSLXaKZQ38x7QwqZ4Cl
         JDCEUWnhKJEZc7sNYYfcAeud+GtRx0Ge9DmOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M05mXEEsCUtqw0Yy5vlYj0mxj1VIm7h4Q0ugvilopUQ=;
        b=TAAPms4Oo/1yt3dpaW+AI5AjqJyaflldPYwLWwvZnCJFTNA5K5/YzIrhdd3r//ZVmT
         RPoFB3PRkCk+dd8DL5mLFLV5l0i1GLSj2BuiyHx+yQPocW+3rCA9SlHsZzbuTefP2KuY
         yW+fyHSamRf8XHhaOwj1kx4LaxicM+hnx03EnmEI6t6zvug7et47DRLjpXvPzXotItxm
         5MV2XVefdTODVuWVUWlKNfNjk+W7A/HQOUWQH11voOr83E6ze/kxWeu0GI9l+jmR9Qhm
         cmaBNy2h3PSqVu+9zg9fNsf7XpZxgzzHBJopEVbCyBJANbnNVenIWzz0wujYraPIERfz
         Fn6A==
X-Gm-Message-State: AJIora+dzOSO8fWQlwvSDh7wOprOMjdQoM3A38U+8IyjyxoeGhMF0r39
        /5LXsZXDYjNbyGleWIdg5cvCBg==
X-Google-Smtp-Source: AGRyM1vueI4Kl7zXsaG4DyZPoxK7P8LQhQyg2HcRdwuyEtMZ41FPn5m0lBPJgAL3x2WdOsfAkUAjVQ==
X-Received: by 2002:a17:906:9c82:b0:6e1:2c94:1616 with SMTP id fj2-20020a1709069c8200b006e12c941616mr11421842ejc.64.1655510175518;
        Fri, 17 Jun 2022 16:56:15 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm1452538edq.63.2022.06.17.16.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:56:15 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 4/9] media: uvcvideo: Use standard names for menus
Date:   Sat, 18 Jun 2022 01:56:05 +0200
Message-Id: <20220617235610.321917-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220617235610.321917-1-ribalda@chromium.org>
References: <20220617235610.321917-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of duplicating the menu info, use the one from the core.
Also, do not use extra memory for 1:1 mappings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 116 +++++++++++++++++++++----------
 drivers/media/usb/uvc/uvc_v4l2.c |  80 ++++++++++++++++-----
 drivers/media/usb/uvc/uvcvideo.h |   3 +-
 include/uapi/linux/uvcvideo.h    |   3 +-
 4 files changed, 144 insertions(+), 58 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index a03714c3a265..1a3021a16b76 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -362,19 +362,31 @@ static const u32 uvc_control_classes[] = {
 	V4L2_CID_USER_CLASS,
 };
 
-static const struct uvc_menu_info power_line_frequency_controls[] = {
-	{ 0, "Disabled" },
-	{ 1, "50 Hz" },
-	{ 2, "60 Hz" },
-	{ 3, "Auto" },
-};
+static const int exposure_auto_mapping[] = { 2, 1, 4, 8 };
 
-static const struct uvc_menu_info exposure_auto_controls[] = {
-	{ 2, "Auto Mode" },
-	{ 1, "Manual Mode" },
-	{ 4, "Shutter Priority Mode" },
-	{ 8, "Aperture Priority Mode" },
-};
+static u32 uvc_mapping_get_menu_value(struct uvc_control_mapping *mapping,
+				      u32 idx)
+{
+	if (!test_bit(idx, &mapping->menu_mask))
+		return 0;
+
+	if (mapping->menu_mapping)
+		return mapping->menu_mapping[idx];
+
+	return idx;
+}
+
+static const char
+*uvc_mapping_get_menu_name(struct uvc_control_mapping *mapping, u32 idx)
+{
+	if (!test_bit(idx, &mapping->menu_mask))
+		return NULL;
+
+	if (mapping->menu_names)
+		return mapping->menu_names[idx];
+
+	return v4l2_ctrl_get_menu(mapping->id)[idx];
+}
 
 static s32 uvc_ctrl_get_zoom(struct uvc_control_mapping *mapping,
 	u8 query, const u8 *data)
@@ -523,9 +535,9 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
-		.menu_info	= exposure_auto_controls,
+		.menu_mapping	= exposure_auto_mapping,
 		.menu_mask	=
-			BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
+			GENMASK(ARRAY_SIZE(exposure_auto_mapping) - 1, 0),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -730,9 +742,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
 		.menu_mask	=
-			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
+			GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 0),
 	},
 };
 
@@ -745,9 +756,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
 		.menu_mask	=
-			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
+			GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO, 0),
 	},
 };
 
@@ -970,13 +980,17 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 	s32 value = mapping->get(mapping, UVC_GET_CUR, data);
 
 	if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU) {
-		const struct uvc_menu_info *menu = mapping->menu_info;
 		unsigned int i;
 
-		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+		for (i = 1; BIT(i) <= mapping->menu_mask; ++i) {
+			u32 menu_value;
+
 			if (!test_bit(i, &mapping->menu_mask))
 				continue;
-			if (menu->value == value) {
+
+			menu_value = uvc_mapping_get_menu_value(mapping, i);
+
+			if (menu_value == value) {
 				value = i;
 				break;
 			}
@@ -1108,7 +1122,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 {
 	struct uvc_control_mapping *master_map = NULL;
 	struct uvc_control *master_ctrl = NULL;
-	const struct uvc_menu_info *menu;
 	unsigned int i;
 
 	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
@@ -1153,11 +1166,15 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
 		v4l2_ctrl->step = 1;
 
-		menu = mapping->menu_info;
-		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+		for (i = 1; BIT(i) <= mapping->menu_mask; ++i) {
+			u32 menu_value;
+
 			if (!test_bit(i, &mapping->menu_mask))
 				continue;
-			if (menu->value == v4l2_ctrl->default_value) {
+
+			menu_value = uvc_mapping_get_menu_value(mapping, i);
+
+			if (menu_value == v4l2_ctrl->default_value) {
 				v4l2_ctrl->default_value = i;
 				break;
 			}
@@ -1250,11 +1267,11 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 	struct v4l2_querymenu *query_menu)
 {
-	const struct uvc_menu_info *menu_info;
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
 	u32 index = query_menu->index;
 	u32 id = query_menu->id;
+	const char *name;
 	int ret;
 
 	memset(query_menu, 0, sizeof(*query_menu));
@@ -1276,11 +1293,10 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	menu_info = &mapping->menu_info[query_menu->index];
-
 	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
 	    (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
 		s32 bitmap;
+		u32 menu_value;
 
 		if (!ctrl->cached) {
 			ret = uvc_ctrl_populate_cache(chain, ctrl);
@@ -1288,15 +1304,22 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 				goto done;
 		}
 
+		menu_value = uvc_mapping_get_menu_value(mapping,
+							query_menu->index);
+
 		bitmap = mapping->get(mapping, UVC_GET_RES,
 				      uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-		if (!(bitmap & menu_info->value)) {
+		if (!(bitmap & menu_value)) {
 			ret = -EINVAL;
 			goto done;
 		}
 	}
 
-	strscpy(query_menu->name, menu_info->name, sizeof(query_menu->name));
+	name = uvc_mapping_get_menu_name(mapping, query_menu->index);
+	if (name)
+		strscpy(query_menu->name, name, sizeof(query_menu->name));
+	else
+		ret = -EINVAL;
 
 done:
 	mutex_unlock(&chain->ctrl_mutex);
@@ -1783,7 +1806,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		if (!test_bit(xctrl->value, &mapping->menu_mask))
 			return -EINVAL;
 
-		value = mapping->menu_info[xctrl->value].value;
+		value = uvc_mapping_get_menu_value(mapping, xctrl->value);
 
 		/* Valid menu indices are reported by the GET_RES request for
 		 * UVC controls that support it.
@@ -2229,12 +2252,28 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
-	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
-	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
-	if (map->menu_info == NULL) {
-		kfree(map->name);
-		kfree(map);
-		return -ENOMEM;
+	if (mapping->menu_mapping && mapping->menu_mask) {
+		size = sizeof(mapping->menu_mapping[0]) *
+			      fls(mapping->menu_mask);
+		map->menu_mapping = kmemdup(mapping->menu_mapping, size,
+					    GFP_KERNEL);
+		if (!map->menu_mapping) {
+			kfree(map->name);
+			kfree(map);
+			return -ENOMEM;
+		}
+	}
+	if (mapping->menu_names && mapping->menu_mask) {
+		size = sizeof(mapping->menu_names[0]) *
+			      fls(mapping->menu_mask);
+		map->menu_names = kmemdup(mapping->menu_names, size,
+					  GFP_KERNEL);
+		if (!map->menu_names) {
+			kfree(map->menu_mapping);
+			kfree(map->name);
+			kfree(map);
+			return -ENOMEM;
+		}
 	}
 
 	if (map->get == NULL)
@@ -2577,7 +2616,8 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
 
 	list_for_each_entry_safe(mapping, nm, &ctrl->info.mappings, list) {
 		list_del(&mapping->list);
-		kfree(mapping->menu_info);
+		kfree(mapping->menu_names);
+		kfree(mapping->menu_mapping);
 		kfree(mapping->name);
 		kfree(mapping);
 	}
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 85aced173daa..0ba1eb92df8e 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -25,6 +25,64 @@
 
 #include "uvcvideo.h"
 
+static int uvc_control_xu_2_mapping(struct uvc_control_mapping *map,
+				    struct uvc_xu_control_mapping *xmap)
+{
+	char (*names)[UVC_MENU_NAME_LEN];
+	unsigned int i;
+	u32 *mapping;
+	size_t size;
+
+	/* Prevent excessive memory consumption, as well as integer
+	 * overflows.
+	 */
+	if (xmap->menu_count == 0 ||
+	    xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES)
+		return -EINVAL;
+
+	map->menu_mask = BIT_MASK(xmap->menu_count);
+
+	size = xmap->menu_count * sizeof(*map->menu_mapping);
+	mapping = kzalloc(size, GFP_KERNEL);
+	if (!mapping)
+		return -ENOMEM;
+
+	for (i = 0; i < xmap->menu_count ; i++)
+		if (copy_from_user(&mapping[i], &xmap->menu_info[i].value,
+				   sizeof(mapping[i]))) {
+			kfree(mapping);
+			return -ENOMEM;
+		}
+
+	map->menu_mapping = mapping;
+
+	/*
+	 * Always use the standard naming if available.
+	 */
+	if (v4l2_ctrl_get_menu(map->id))
+		return 0;
+
+	size = xmap->menu_count * sizeof(map->menu_names[0]);
+	names = kzalloc(size, GFP_KERNEL);
+	if (!names) {
+		kfree(mapping);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < xmap->menu_count ; i++) {
+		/* sizeof(names[i]) - 1: to take care of \0 */
+		if (copy_from_user(&names[i], &xmap->menu_info[i].name,
+				   sizeof(names[i]) - 1)) {
+			kfree(names);
+			kfree(mapping);
+			return -ENOMEM;
+		}
+	}
+	map->menu_names = names;
+
+	return 0;
+}
+
 /* ------------------------------------------------------------------------
  * UVC ioctls
  */
@@ -32,7 +90,6 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 	struct uvc_xu_control_mapping *xmap)
 {
 	struct uvc_control_mapping *map;
-	unsigned int size;
 	int ret;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
@@ -63,23 +120,9 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 		break;
 
 	case V4L2_CTRL_TYPE_MENU:
-		/* Prevent excessive memory consumption, as well as integer
-		 * overflows.
-		 */
-		if (xmap->menu_count == 0 ||
-		    xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES) {
-			ret = -EINVAL;
-			goto free_map;
-		}
-
-		size = xmap->menu_count * sizeof(*map->menu_info);
-		map->menu_info = memdup_user(xmap->menu_info, size);
-		if (IS_ERR(map->menu_info)) {
-			ret = PTR_ERR(map->menu_info);
+		ret = uvc_control_xu_2_mapping(map, xmap);
+		if (ret)
 			goto free_map;
-		}
-
-		map->menu_mask = BIT_MASK(xmap->menu_count);
 		break;
 
 	default:
@@ -91,7 +134,8 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 
 	ret = uvc_ctrl_add_mapping(chain, map);
 
-	kfree(map->menu_info);
+	kfree(map->menu_names);
+	kfree(map->menu_mapping);
 free_map:
 	kfree(map);
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 0736b8815d79..b702f1c8547b 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -253,7 +253,8 @@ struct uvc_control_mapping {
 	enum v4l2_ctrl_type v4l2_type;
 	u32 data_type;
 
-	const struct uvc_menu_info *menu_info;
+	const u32 *menu_mapping;
+	const char (*menu_names)[UVC_MENU_NAME_LEN];
 	unsigned long menu_mask;
 
 	u32 master_id;
diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
index 8288137387c0..1b64b6aa40b5 100644
--- a/include/uapi/linux/uvcvideo.h
+++ b/include/uapi/linux/uvcvideo.h
@@ -36,9 +36,10 @@
 	 UVC_CTRL_FLAG_GET_MAX | UVC_CTRL_FLAG_GET_RES | \
 	 UVC_CTRL_FLAG_GET_DEF)
 
+#define UVC_MENU_NAME_LEN 32
 struct uvc_menu_info {
 	__u32 value;
-	__u8 name[32];
+	__u8 name[UVC_MENU_NAME_LEN];
 };
 
 struct uvc_xu_control_mapping {
-- 
2.37.0.rc0.104.g0611611a94-goog

