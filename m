Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0597563ED9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 08:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiGBGrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 02:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 02:47:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781E24BEF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 23:46:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q6so7542837eji.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2xZCau6Evf2BZjNgWltZHP5fbMXtXjkrl0nc2J1mak=;
        b=ppW6cHv+XOlCHWw1HLiFTNDsOimxS/UCYqHFM50VvMLjK/a2io7J8vN3pT/fYNltWq
         UmOEvCatvk2vrgAsGRS93UpnZHJzg9HRscha/tA5xGWY26njJy9mgYYJH+zgvdSdgTaq
         rVWBNv8vqx5kJUqTNcp5TjiVwMMMkN1YbF1zRJRpDbsmgfbnTaJjbq7BMALbRiMB3O9n
         jM49ftEBz80MFgZ0yMMb3uP8USOQ58ZMEtiIPU5eZacDW27nU4xbrnWTDtyGZIa5gGWT
         M3UzfZgsIar1ApvncT3og4JWT8n6G6E4fZsJP8mhej02W0ZamAwOUJfZgFrwh6MlNx+l
         xNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2xZCau6Evf2BZjNgWltZHP5fbMXtXjkrl0nc2J1mak=;
        b=xS2xHLhhXR+go/YdZ215yodEXuppWvQahyM3XcATEvj4bAT9PgAJMAJCZk3QAku8Ra
         2pVmtZuWfK2/pFpimRqx60YDG+g8z3tsjqgrIpZ/eO1lhyGhD6rzBhTHwE9NOVx3StcC
         gh7oqBW0OpBLTWqswU9Mm+uce8+Q5D/Izy39Jbo6YysMSrjZuAMwGvZXgRmD+9slKp48
         z347d2igz4Ew3eodPOQITWIq3PA84GjjL9yDsuTK/uubISYs5YsG2sP8YhcLFD7IStnx
         AMz2HVvLeF0YYm994GvBO4rayYCFaDx9x9HbCItXYMoEYCAgTuatpLrkRGRkCYozRpKx
         4o6g==
X-Gm-Message-State: AJIora9ZE22P9YMK8FMBjdaxpdQjzCkvYmxMkaymwh7570zi6hTmoS4C
        VAdn/eSO7JscBB8n3lIPk3A=
X-Google-Smtp-Source: AGRyM1sxHzfBYCvE6k+BhyRNBjhMwMik3lBZyOA/igDKEpcTniCHFaK9TNbdl/nxMSBbb+k5TFfrZg==
X-Received: by 2002:a17:906:5053:b0:70d:a0cc:b3fd with SMTP id e19-20020a170906505300b0070da0ccb3fdmr18054178ejk.162.1656744418267;
        Fri, 01 Jul 2022 23:46:58 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba7.dynamic.kabel-deutschland.de. [95.90.187.167])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906538100b0072a55ebbc77sm3335811ejo.66.2022.07.01.23.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 23:46:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: make ffaddr2pipehdl() static
Date:   Sat,  2 Jul 2022 08:46:26 +0200
Message-Id: <20220702064626.27506-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The function ffaddr2pipehdl() is only used in usb_ops_linux.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/usb_ops_linux.h | 2 --
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
index 641f059ffaf7..966688eedf66 100644
--- a/drivers/staging/r8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
@@ -26,6 +26,4 @@
 #define usb_read_interrupt_complete(purb, regs)		\
 	usb_read_interrupt_complete(purb)
 
-unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
-
 #endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 0269e602b217..220e592b757c 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -7,7 +7,7 @@
 #include "../include/usb_ops_linux.h"
 #include "../include/rtl8188e_recv.h"
 
-unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
+static unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 {
 	unsigned int pipe = 0, ep_num = 0;
 	struct usb_device *pusbd = pdvobj->pusbdev;
-- 
2.36.1

