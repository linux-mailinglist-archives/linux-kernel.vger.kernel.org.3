Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9A59CBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiHVWnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbiHVWmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:42:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F8B5141E;
        Mon, 22 Aug 2022 15:42:53 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b9so9078230qka.2;
        Mon, 22 Aug 2022 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=6C/d8xlHQCGOlClXK65WdMdS1M8Gsu61gKL4UEc2TB8=;
        b=p/68VzadPb34Psj/7p/+bpCgGsInjxK7JXKHCtWZIF7GrlzSxf0Pak5jJxw8fMbdu/
         QU59+q+I1IAWDFndRk82ue5jatLFF5apcfv5vWxPC/dAx4l1/VQlbGZplcTGxgkbs4qM
         sCko3XKSlsxJoC7zPduKFee+QyycEODSRjDbbsOwVliJ6wwnSF25VMy1gKzJeXP9Yrrb
         JHLlsAhZj5Fd7eCoUozNQHzjTj562sFrB8cPiVpfWCPKHyH0R3o9zx5qYQrDXY7rQM9c
         78QyeiGrSsDQeZ3Bc1T55qLZPU264B4krlqYHGlW1YTDUotx/J+bTSUiXu4N/NTRHKo+
         Vmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=6C/d8xlHQCGOlClXK65WdMdS1M8Gsu61gKL4UEc2TB8=;
        b=swOk+M+K4YL8/kWGpHy5izwTIjcv29wgRjlp7MV1uhZDYE8DUJFHGWHtz0NzozZFOG
         blvQr6Ix1Kzuctd3TdXdBlw9rFCRvAWQcBJnnB0nkkJrqrL1e8LJXZy7Pomqnlh0a4b/
         szSm0YOcKTIRgBYHgF3y60fqD7cfKI05fzq8bb6lIUflu1SDHIFhcI6+Glpxso9Byt+H
         MmimdfuferQS01hrVYA2c0A2jhetWg6VkWlZ3eVLvw1jlEktxiuwjqJMEvAygdozyMrv
         6Bl9mWsPowtaLjwIrnRn+bl+evfFAEyNpGFkg5F5d07f8FYT9udqtEJwJRGtU0G+Vqn8
         Z6Lw==
X-Gm-Message-State: ACgBeo3QBVd1KIq/E7fGVIxxlaNxyqF2BnFuTW2gBhmcHnQ/d24n5sSw
        UNOezZBEAMqD5hcPEWF7AYFKNao+lRt2Vw0G
X-Google-Smtp-Source: AA6agR6193RM0nlcmpDSpP0KqEk10dsmRjfuA66BmNYTxwnKHnK7MI+FnN8t13CU1o+X6L17OmsoRg==
X-Received: by 2002:a05:620a:4e1:b0:6bb:5c0e:ab58 with SMTP id b1-20020a05620a04e100b006bb5c0eab58mr14525126qkh.730.1661208172231;
        Mon, 22 Aug 2022 15:42:52 -0700 (PDT)
Received: from valhalla (2603-7081-5203-61c3-0000-0000-0000-1449.res6.spectrum.com. [2603:7081:5203:61c3::1449])
        by smtp.gmail.com with ESMTPSA id hg17-20020a05622a611100b0034359fc348fsm9521347qtb.73.2022.08.22.15.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 15:42:51 -0700 (PDT)
Date:   Mon, 22 Aug 2022 18:42:48 -0400
From:   Christopher Carbone <chris.m.carbone@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: split multiple assignments to lines
Message-ID: <YwQGaLoBHH9C0aXN@valhalla>
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

CHECK: multiple assignmentst should be avoided

Signed-off-by: Christopher Carbone <chris.m.carbone@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dbd1159a2ef0..6f4c31635cc4 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -386,7 +386,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 
 	ret = lynxfb_set_color_offsets(info);
 
-	var->height = var->width = -1;
+	var->height  = -1;
+	var->width = -1;
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
 	if (ret) {
@@ -498,7 +499,8 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		return ret;
 	}
 
-	var->height = var->width = -1;
+	var->height = -1;
+	var->width = -1;
 	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
 
 	/* check if current fb's video memory big enough to hold the onscreen*/
@@ -723,7 +725,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
-	crtc->cursor.max_h = crtc->cursor.max_w = 64;
+	crtc->cursor.max_h = 64;
+	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
 	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
 
@@ -1027,7 +1030,8 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	if (!sm750_dev)
 		return err;
 
-	sm750_dev->fbinfo[0] = sm750_dev->fbinfo[1] = NULL;
+	sm750_dev->fbinfo[0] = NULL;
+	sm750_dev->fbinfo[1] = NULL;
 	sm750_dev->devid = pdev->device;
 	sm750_dev->revid = pdev->revision;
 	sm750_dev->pdev = pdev;
-- 
2.37.2

