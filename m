Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A858AF1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbiHERrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbiHERrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:47:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444F874DFF;
        Fri,  5 Aug 2022 10:47:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z17so4026411wrq.4;
        Fri, 05 Aug 2022 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ywIR5VfnD8Y42zU7KgRawHi2uT/WWLO8S2W+Sh2EifI=;
        b=IXK+1GDKbuc6sXB5hNO0fO/rE2HE3sbxxCgV3jF+ba9n97aNFNX2xaRN+NET3V2HKy
         istpa5RWTSGJmsQfq50Qw53X6oBZ+GaCugmBzCZoo29sG/iKTqeU9IPojy4dQjQU/WTS
         x3Ej6zcOX+ZvEqvev4M26uo/+ivDZSXC5kNd4vHeoZQjaiTB+d0zL5yNpcb6ZkEniHVI
         +EO7fTfqHgyqQPljcdMQAOezTnayirQHYslVyezJfUFZdDkoW+pnc23sLRMwjQp2GRVZ
         WNvOK8kuny/PuIfjKgzsPhPtVFU8tEbiRiCyBSofgM4oVa/6UDoze1ICaGxB4Od5Ti4H
         265w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ywIR5VfnD8Y42zU7KgRawHi2uT/WWLO8S2W+Sh2EifI=;
        b=R9z9X4mhnJ0J6npmlEf77g+dsFYdcoJb5rmKp5NpDOl/MeNb2yESlXjM7hDG8dX+UT
         YO2mUK9RYVpTP8vk8BC04bi7rCfwkCDz+EX6egfsTtOjIWw4G7l9M7vgY13mKgfcOger
         ifQ+V8rwEHi289n/t4Y7hKppv1lj6uS0gn5EvzrR/6y+wPZbcMdUyiWUsYkSYgUT2sh6
         4v1iNG4fMjDzI5vnGPFXi4/Z1NxWAg61lGr6YJvasv1ipqNYlUpirucIYSA3mhze9oxo
         NBOvLWbyyo8dJn7NUn2BUJKQiBdGW5MLxeqX5+ydDS4i1MhYb6la4x49MW4Vs3w1ANeR
         JAXg==
X-Gm-Message-State: ACgBeo2j8M/LfoKRn/FF4I23ehtwvlyEJum4i9YGQ1vpE73z2XvVtiZR
        7PfuaWhTHNM36OZIdAIzuVqYKDCB6L8nu9WG
X-Google-Smtp-Source: AA6agR62l5PPa3d189koj+ys3Erv1Qba5IR7bbZWG9g53n+SDl83OEHZqGGB7Qc5/HETh+xUQVCB+Q==
X-Received: by 2002:a5d:63c9:0:b0:220:68e1:7f3f with SMTP id c9-20020a5d63c9000000b0022068e17f3fmr5103381wrw.134.1659721638721;
        Fri, 05 Aug 2022 10:47:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b18-20020a5d4b92000000b0021d6924b777sm4233092wrt.115.2022.08.05.10.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:47:18 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: tc3589x-keypad: Use correct struct names in comment
Date:   Fri,  5 Aug 2022 18:47:17 +0100
Message-Id: <20220805174717.2374416-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The incorrect structure name is being used in the comment for struct
tc3589x_keypad_platform_data. Correct it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/keyboard/tc3589x-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 89b9575dc75d..78e55318ccd6 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -70,7 +70,7 @@
 #define TC3589x_KBD_INT_CLR	0x1
 
 /**
- * struct tc35893_keypad_platform_data - platform specific keypad data
+ * struct tc3589x_keypad_platform_data - platform specific keypad data
  * @keymap_data:        matrix scan code table for keycodes
  * @krow:               mask for available rows, value is 0xFF
  * @kcol:               mask for available columns, value is 0xFF
-- 
2.35.3

