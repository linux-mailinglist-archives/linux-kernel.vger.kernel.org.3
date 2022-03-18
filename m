Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8494DDF58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiCRQwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiCRQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:52:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E98D0AB4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:50:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h1so10926919edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oijxu/f5iYqZvIjDXs+VJYzgILezr7W6S5yxU4cLB60=;
        b=MJbIasCfRhwa1NH1dypo3beHOiq9TBtIHjvCEGUEZ7NpriFAL1IoyGPICKVH8vEY/r
         67Zw5yWC5jkH9CfENfL8ssHzagmKZk97sJWKBH1RGJRlVbciKijZPCn1nF16TqvxQt1N
         kIzUwgY3WmovpFOU5+5CF2iRXzr4AI5HxGeLvcHAd9/MXqo55KocpszME6BtYeemHL2o
         CrcZKqXiopX0YvwOhj8UmaGKVF2hvMTSrekJ5NKgTF3+AYgZBuSWA9v7g6Zjbk+YUNqh
         XeWWJ+6k2fPEBjijBmqIMuJy3ncLys/r+K4I/N7bJj9+D28ryfb4HXGzt8Itr6egKiU8
         pnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oijxu/f5iYqZvIjDXs+VJYzgILezr7W6S5yxU4cLB60=;
        b=cYpwXH18VELsTbIW+AWXx9zW7e100wnWQO3z+0M3AoGF5HH677LBwzYXqR6zbgfV54
         FAbZV1n3+IqOJar95u9OxVXm5n5IHkiNRCTILqJca4hFM3iXFIxaUzZ1ZC3AFUbmDirs
         gPlLoJziyNVsKEkeoYqS0xXyeOpTO1u5RrWdFwdgTKZ9bdQTryqjDdbMycA4tn+GYAUy
         F3K6NcqYAl6n5fiIcLdAKOG5rN/ckC5pI2wRJVG9ZZroCUla5qwIGto2nCicDOjAoQtO
         T5DEQ0ww06hFq2R30VmOwnvNt1XjqD3eljZqapZ6WHIrf/5mpbBBMaaHPFvkwzkOFLFU
         hhIA==
X-Gm-Message-State: AOAM533HOqOsI4vh1Al8UdJRfyTUWAFiWapU1rbYWLb/oEUI+ZPDymn1
        PCMywVki7Jsm7IiEbML5GYg=
X-Google-Smtp-Source: ABdhPJzHe/FYbC6iOGD84lzpd3XCiGnXiREZKFepXaNGJAi4f2Qgu2pKiNJKo79P3iPLU/XjvSpvNg==
X-Received: by 2002:a50:bac3:0:b0:418:edb0:4ae8 with SMTP id x61-20020a50bac3000000b00418edb04ae8mr10109911ede.219.1647622249016;
        Fri, 18 Mar 2022 09:50:49 -0700 (PDT)
Received: from nam-dell (dslb-002-203-132-165.002.203.pools.vodafone-ip.de. [2.203.132.165])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7dc42000000b00418ef55eabcsm3613764edu.83.2022.03.18.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:50:48 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH] staging: sm750fb: add necessary #include in sm750_accel.h, sm750_cursor.h
Date:   Fri, 18 Mar 2022 17:50:46 +0100
Message-Id: <20220318165046.33745-1-namcaov@gmail.com>
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

In sm750_cursor.h, struct lynx_cursor is used without including the
header file where this struct is defined. Similar thing is seen in
sm750_accel.h.

The module can still be compiled because there is "#include "sm750.h""
before every "#include "sm750_accel.h"" and "#include "sm750_cursor.h"".
However, the order of #include should not affect the ability to compile.

Add "#include "sm750.h"" to sm750_accel.h and sm750_cursor.h.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h  | 2 ++
 drivers/staging/sm750fb/sm750_cursor.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 2c79cb730a0a..fe6ff196272c 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -2,6 +2,8 @@
 #ifndef ACCEL_H__
 #define ACCEL_H__
 
+#include "sm750.h"
+
 #define HW_ROP2_COPY 0xc
 #define HW_ROP2_XOR 0x6
 
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index b59643dd61ed..f023b691ac0b 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -2,6 +2,8 @@
 #ifndef LYNX_CURSOR_H__
 #define LYNX_CURSOR_H__
 
+#include "sm750.h"
+
 /* hw_cursor_xxx works for voyager,718 and 750 */
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
-- 
2.25.1

