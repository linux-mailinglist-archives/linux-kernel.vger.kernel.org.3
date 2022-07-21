Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0804357D2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiGURhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGURhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:37:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9BC88F34;
        Thu, 21 Jul 2022 10:37:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q5so2452028plr.11;
        Thu, 21 Jul 2022 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7A7f3vsCoMPD+oJ+DRhT8m5bm216n3txZjp85zwns54=;
        b=fcxHtD+v0Oc9pKDm4ZTw/rm1K57I0OQz/UHDeHsDbMw+3Td+wBMXFhXOHEGrAhrxr3
         SLLB/p1ps0OE6wLB8PRZh26P8D25wo2Vh8f8aZ1YIclS6UbuStT/fV+15MWMKgS3PUt/
         EkHav+1hzaMnAMZyRndLXSlViTpoZvO7c6qGu7vztPAHHScqrmqgrJhLD0hhq6yZNi1k
         5ogKzoifhm4vADyYuT5/WqSQGRZOLHZoDG0iDh1Q3HO/nu5Q2azJ7e99v+Cbyu+Pdlsy
         9Bz6MPEmHJ5aBGbIwP5pMfhTZ17GC8Xv73ZuVfYmjXxw22bzndmo76HMMlLuF8TFpNum
         FJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7A7f3vsCoMPD+oJ+DRhT8m5bm216n3txZjp85zwns54=;
        b=0BrJJMlOAbl7fYvi77Ac+7QW3s3E2InpLvRbxUvjuiurPLt83Nrx32drsPXCZJbdVz
         JITsXxtgAoUWWE1/qZZyc3PbdIlGTYEKfKg8phMf0nLbXyzzuN8fd8gdajTQvhlPRCKI
         6W3ImTJWi4ttUeHWIE5bOKQKL3wqSz/1X7DJKA0lP9b/BzW8LRqODMv1ExeolI+vwc0P
         iYnJVG5URrzY95pdd3nkIyNskCfyXRluMRMOUy4ipkox1GUJBBHRL/Y5JSknkLgpxm9m
         hS6PUsybuiCKsIE+GK9sO6L3PlcJqPvRThNNFq1v8yuP2T8LM9T4KPTHT8oKhVitziWh
         ZX6A==
X-Gm-Message-State: AJIora9hh6/jLlLP9VMTtnFEtJaZN7eJwm82xEAksdhJyVcI0v6e/7Sv
        XgSjSWAMM957aDzV2uRjMzUc3YI0skEGqJ3BaWA=
X-Google-Smtp-Source: AGRyM1uHlIPUVPRS+0S6K83Tv/R6O1KC9VAqTt4sA26lM1hbFUgDjkfUujDhCqIiUbzhOB/8olB6fA==
X-Received: by 2002:a17:90b:4b81:b0:1ef:cd2c:bf2e with SMTP id lr1-20020a17090b4b8100b001efcd2cbf2emr12282986pjb.137.1658425059113;
        Thu, 21 Jul 2022 10:37:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d01c:7038:1b61:a224:b8d7:290b])
        by smtp.googlemail.com with ESMTPSA id q9-20020a17090a7a8900b001f219c5ae7dsm1711714pjf.31.2022.07.21.10.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:37:38 -0700 (PDT)
From:   Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     abhijeet.srivastava2308@gmail.com,
        Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] media: staging: media: zoran: Fixed Block comments
Date:   Thu, 21 Jul 2022 23:07:22 +0530
Message-Id: <20220721173729.63844-1-abhijeet.srivastava2308@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.

Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
---
 drivers/staging/media/zoran/zoran_driver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 4304b7e21709..b408c1d4e0a7 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -746,9 +746,11 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
 	.vidioc_enum_input		    = zoran_enum_input,
 	.vidioc_g_input			    = zoran_g_input,
 	.vidioc_s_input			    = zoran_s_input,
+
 /*	.vidioc_enum_output		    = zoran_enum_output,
-	.vidioc_g_output		    = zoran_g_output,
-	.vidioc_s_output		    = zoran_s_output,*/
+ *	.vidioc_g_output		    = zoran_g_output,
+ *	.vidioc_s_output		    = zoran_s_output,
+ */
 	.vidioc_g_std			    = zoran_g_std,
 	.vidioc_s_std			    = zoran_s_std,
 	.vidioc_create_bufs		    = vb2_ioctl_create_bufs,
-- 
2.34.1

