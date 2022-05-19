Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785F452DE04
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbiESUAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiESUAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:00:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047426221A;
        Thu, 19 May 2022 13:00:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c2so5698741plh.2;
        Thu, 19 May 2022 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+JBYr/YBgGXuX47erfmD8xS+ac8EQgaMka1WHtaqB4=;
        b=LPsUDlU3loCxhBQvblYbW66lDJFR18zfe2nlAm+4rDrUENsZuLNk1Wsi/M4rO70IcD
         7rHDm/fc9uYPIghOCMqaw0TE4lmFbkJiByMMuRCL+NgGj79JurByaVWvxOqIZxbqT65G
         L2yQ3gAek2NOyFIGKq//Zust4e49BF7hNPmpZbpUkP8i6efDAoaQzPBJ129vyrFBclgM
         aEuhlIEtwBLhYOdjiD9Kiru7VubgwTqHHcPC2CLobv54iZbOFQ9fMRQQP5hhtvCBcsYn
         mVo7+vJyp9pOFMvx2EmavhzMQ/ilheYfbhXKbpXwu+8Iee+aqcuG11mMmI41bL0rqqGK
         qR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+JBYr/YBgGXuX47erfmD8xS+ac8EQgaMka1WHtaqB4=;
        b=1cSITMUZtuCwdf6/g2JzF8JcmCPsgPG2XteYFeyBUNkjCh5duHPQ6K81OnFWuW8sMy
         7jyONiA/P6TjMeKStZsFttWMVNM/3DfA8JpSAg61crKP6hEy38xBVudcT02erXevcE+L
         tlEJxGl731PfoZfILS1fmAlL0uZu9G8Nm8aRimYazr9aMkBJfvAStKmG0WzGAO/th6+Y
         XzC9HTRrBcUuTKTy/7KVD5LJ7WlIHWbog/UpQ+cyRaGrl1tawEPPRseuxj2GRg8fLUrT
         1yjQFAQfOnHcuOJbs83HA6l0ksvwaTqPXhptS4H0qatCdyfThfrWOUS8maNQK/xJNGWX
         GbvQ==
X-Gm-Message-State: AOAM530+Lvxv03zLqyTNd8mH0GRrvOxm6bllgLEX8GOtOLATr98k8dZm
        6IgBK7h/6PAch+D5S/DdJhQ=
X-Google-Smtp-Source: ABdhPJwJMOd7ydAiGD+9PmRxBJQiyykFNT3FGPiA3YebQjvdKTelVfAjhA3VE1luVEdMSXLijY3eSQ==
X-Received: by 2002:a17:90a:ba11:b0:1df:2d09:1308 with SMTP id s17-20020a17090aba1100b001df2d091308mr6704251pjr.184.1652990418629;
        Thu, 19 May 2022 13:00:18 -0700 (PDT)
Received: from ubuntu.localdomain ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id j17-20020a170903025100b001618644d8b5sm4073863plh.154.2022.05.19.13.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:00:18 -0700 (PDT)
From:   Gautam Menghani <gautam.linuxkernel@gmail.com>
To:     sudipm.mukherjee@gmail.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc:     Gautam Menghani <gautam.linuxkernel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] drivers/parport: Remove unused variable 'ret'
Date:   Thu, 19 May 2022 13:00:12 -0700
Message-Id: <20220519200012.59253-1-gautam.linuxkernel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Remove the unused variable 'ret' as suggested by clang scan
warning: Value stored to 'ret' is never read [deadcode.DeadStores]
                        ret = 0;


Signed-off-by: Gautam Menghani <gautam.linuxkernel@gmail.com>
---
 drivers/parport/parport_pc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index eda4ded4d5e5..3d9fcbe758d7 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -507,7 +507,6 @@ static size_t parport_pc_fifo_write_block_pio(struct parport *port,
 			ret = parport_wait_event(port, HZ);
 			if (ret < 0)
 				break;
-			ret = 0;
 			if (!time_before(jiffies, expire)) {
 				/* Timed out. */
 				printk(KERN_DEBUG "FIFO write timed out\n");
@@ -636,7 +635,6 @@ static size_t parport_pc_fifo_write_block_dma(struct parport *port,
 		ret = parport_wait_event(port, HZ);
 		if (ret < 0)
 			break;
-		ret = 0;
 		if (!time_before(jiffies, expire)) {
 			/* Timed out. */
 			printk(KERN_DEBUG "DMA write timed out\n");
-- 
2.25.1

