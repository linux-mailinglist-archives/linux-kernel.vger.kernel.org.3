Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708859C33D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiHVPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiHVPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:41:52 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170821CFC3;
        Mon, 22 Aug 2022 08:41:48 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id e4so8395598qvr.2;
        Mon, 22 Aug 2022 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=cRvGK+nfZIMwtiejaDileiwHPvBs7s1NtuCURg1xkOE=;
        b=jrIMSLP1O0YpmecScYkEyzJrB11luBCBk7dY8gXgO+9dVe6uTS9YjcXSs+Ta5OH1sV
         dXHvi7zstA8c4+yeoSq6Ynqtg3+Pt1rYjxvkNcbx5rOihOE/RiUAWJp5bdf7H+4uz8tk
         KywVzWly9gjOTSr8FzpDKLVQUOBlSeikDyiCQGM5ouYLMl1N7a5sOj8e6Dn3mZIlfqrg
         doR5BHOHDXum4QOY+Kpf43/7h9SwVIYRj9yIktK86uPksWD11jIlT93UN5hUZFtKRE9W
         Qoh6Pa7XE+GeU5tV50GZL695dNnS9HEKr2xWG2d7cAMi/OeM/Hp8umiCVKxSfLsjeu2Z
         e5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=cRvGK+nfZIMwtiejaDileiwHPvBs7s1NtuCURg1xkOE=;
        b=WUyZEdc/J6SpJtYaKgDRdtw6FuwNaOq3ETd9z2ZGufhdR8WAVxxxPU+VCJYHZ1Z7hi
         x0R8w2vdMJW0qj19W5emAqodw2I4/SSZ+jRKTZD4j3HzB3xeeuM/+aiBzzXRIulFgTfo
         iZYjuoHfe4udyUUHIWONBqIv/EA1eS8/RJc8XpPCX3WLVNiBx09jf94Z5XbnDAuy1FaT
         HCbDkQFUHhSLt5JeuKfEot4049oP8CnigUCCUcVjDDjl8yTyzHdgTud2XBGoxbOdtW3c
         3JXMng9LdPczVvBia4IZ1vzCrLSDdVw89qeFyaQydCHtiqqQtf0rXSXGqyKyyqyRyoLW
         9Hfg==
X-Gm-Message-State: ACgBeo3c+ZmQ5zzjJDWst72S5VnYgWadziJplfCu06+nEFMiB6PpvJ1K
        YTgEDUUWwh2PAA5osbN8uwY=
X-Google-Smtp-Source: AA6agR76hATzF/fDLbd6N41mySAOy78wgkBSUZiZKFl8do1rkquH1626SX3sseMpeZ7SIVjZHhCKWA==
X-Received: by 2002:a05:6214:e68:b0:474:89bf:ca1b with SMTP id jz8-20020a0562140e6800b0047489bfca1bmr16197681qvb.107.1661182907114;
        Mon, 22 Aug 2022 08:41:47 -0700 (PDT)
Received: from valhalla (2603-7081-5203-61c3-0000-0000-0000-1449.res6.spectrum.com. [2603:7081:5203:61c3::1449])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a0c4500b006b5e296452csm10854329qki.54.2022.08.22.08.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:41:45 -0700 (PDT)
Date:   Mon, 22 Aug 2022 11:41:43 -0400
From:   Christopher Carbone <chris.m.carbone@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Split multiple assignments to individual lines.
Message-ID: <YwOjt+ZrQkKFGRH9@valhalla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: multiple assignments should be avoided

Signed-off-by: Christopher Carbone <chris.m.carbone@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dbd1159a2ef0..a0f8ae359248 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -386,7 +386,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 
 	ret = lynxfb_set_color_offsets(info);
 
-	var->height = var->width = -1;
+	var->width = -1;
+	var->height = var->width;
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
 	if (ret) {
@@ -498,7 +499,8 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		return ret;
 	}
 
-	var->height = var->width = -1;
+	var->width = -1;
+	var->height = var->width;
 	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
 
 	/* check if current fb's video memory big enough to hold the onscreen*/
@@ -723,7 +725,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
-	crtc->cursor.max_h = crtc->cursor.max_w = 64;
+	crtc->cursor.max_w = 64;
+	crtc->cursor.max_h = crtc->cursor.max_w;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
 	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
 
@@ -1027,7 +1030,8 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	if (!sm750_dev)
 		return err;
 
-	sm750_dev->fbinfo[0] = sm750_dev->fbinfo[1] = NULL;
+	sm750_dev->fbinfo[1] = NULL;
+	sm750_dev->fbinfo[0] = sm750_dev->fbinfo[1];
 	sm750_dev->devid = pdev->device;
 	sm750_dev->revid = pdev->revision;
 	sm750_dev->pdev = pdev;
-- 
2.37.2

