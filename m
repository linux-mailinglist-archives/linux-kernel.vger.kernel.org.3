Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6CC55FA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiF2I1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiF2I1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:27:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843213C719
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x20so7815437plx.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+hv2nO2fwtPMmF677sjLMD65FxmARA/7K2+94HQf5T4=;
        b=t7B3pzL62UzySws37XyUzkEb8EAQqLlKP1pza0Y0wI/ODhS5gGAmLxr4ktiv045Dcf
         l4i+WZ6yvBv+gOuV/sHYlb2MYqPhJonoXds36dCjIaiA1MQGtEFJLZxoVf+jWuyd6oOD
         INUsjkXUKKgm+8leY5pedkZkkB3W6wdGT0BsolQwqNb6NcUzhMPZH+Nchn0nePBbxJ76
         z51CGkDdjaOB8VKOAU6/007Gt5GGQ+vihUxTfsa9DiHKBQYXvN7neG3F+UhDoFTM9LFd
         QeH/adERI6jRneskmLoZq4wuAgwl+9tswRwbK5NV53xGHiqRDYLt6r2YHcx3MdQqg4I8
         dV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+hv2nO2fwtPMmF677sjLMD65FxmARA/7K2+94HQf5T4=;
        b=3gGaftRIL2wf+Kh4SLTaXNzWyG+pZdtY5Pb5jedX8BvLif6lKmc8AtpBeIfxw42haw
         7DosWkLA48RK9U/dFrc0K2BwXJRgKWhkvJOjNi+ru8yxOPn0oFa8b72ZgYxFrAdgZZI+
         5NmWVGnoogAVHoiXlxaeVvjxwP8WsXS+aIG+t8wFIv2glYAp+aEQss6N7F8OhNZJYOe9
         ItnHqWW0q6G4etQb3SJJSH3N7kz3cgP8vEbUQo9MyIaFXPGdSptMMfwhOb6cOTGSKEvD
         pwOqnHQerPjMR4652qoMTpqI3m4l8/ZmoD7mgKtpniq7TBaRAMjEiz+u9rMx8mYr5N6o
         hz0w==
X-Gm-Message-State: AJIora9l8GYolWs/kVfRS0zoeB4hfCUgSdHTQ1IWZjAO712W2ahlqss9
        ZLMqY2Jla0xzyNz5n4kDXR9Q
X-Google-Smtp-Source: AGRyM1tlfjlmKgAZQ2DJFBJe6ldvGsUFDTww8AE9GL44qhynLK2PEHBvRZR/SAmPa6KWzmfkH4xh9Q==
X-Received: by 2002:a17:90a:6809:b0:1ec:c213:56c8 with SMTP id p9-20020a17090a680900b001ecc21356c8mr4464266pjj.82.1656491213144;
        Wed, 29 Jun 2022 01:26:53 -0700 (PDT)
Received: from localhost ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id i1-20020a625401000000b00527dba9e37bsm1517039pfb.73.2022.06.29.01.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:26:52 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] vduse: Update api version to 1
Date:   Wed, 29 Jun 2022 16:25:41 +0800
Message-Id: <20220629082541.118-7-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629082541.118-1-xieyongji@bytedance.com>
References: <20220629082541.118-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's update api version to 1 since we introduced
some new ioctls to support registering userspace
memory for IOTLB.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 12 ++++++++++++
 include/uapi/linux/vduse.h         |  8 +++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7b2ea7612da9..2795785ca6a2 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1206,6 +1206,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	case VDUSE_IOTLB_GET_INFO: {
 		struct vduse_iotlb_info iotlb;
 
+		ret = -EPERM;
+		if (dev->api_version < 1)
+			break;
+
 		iotlb.bounce_iova = 0;
 		iotlb.bounce_size = dev->domain->bounce_size;
 
@@ -1219,6 +1223,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	case VDUSE_IOTLB_REG_UMEM: {
 		struct vduse_iotlb_umem umem;
 
+		ret = -EPERM;
+		if (dev->api_version < 1)
+			break;
+
 		ret = -EFAULT;
 		if (copy_from_user(&umem, argp, sizeof(umem)))
 			break;
@@ -1230,6 +1238,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	case VDUSE_IOTLB_DEREG_UMEM: {
 		struct vduse_iotlb_umem umem;
 
+		ret = -EPERM;
+		if (dev->api_version < 1)
+			break;
+
 		ret = -EFAULT;
 		if (copy_from_user(&umem, argp, sizeof(umem)))
 			break;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 1b17391e228f..902ea19cd9e0 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -8,7 +8,13 @@
 
 /* The ioctls for control device (/dev/vduse/control) */
 
-#define VDUSE_API_VERSION	0
+/*
+ * v0 -> v1:
+ *  - Introduce VDUSE_IOTLB_GET_INFO ioctl
+ *  - Introduce VDUSE_VDUSE_IOTLB_REG_UMEM ioctl
+ *  - Introduce VDUSE_IOTLB_DEREG_UMEM ioctl
+ */
+#define VDUSE_API_VERSION	1
 
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
-- 
2.20.1

