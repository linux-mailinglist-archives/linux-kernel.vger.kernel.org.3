Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7F04F0DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 05:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355199AbiDDDy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 23:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242399AbiDDDy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:54:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802F30567
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 20:52:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u14so3782340pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 20:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=5FFxSTXwBaEGi4lfK+T2LU99v/h0J5utIcW5ijXutv0=;
        b=aOwqDqJ9BCgS/OlFhm9cTrjEoXpHxRWPaSdFORy8vWyW8x/iTrv2q1mKVoilW1X400
         OYFUvmhZHwmxTfQ43WxSyToXNH8dNyR/4aZoQHt6FGLCZ5EzRJYK6VHPPDNxH7K45XV4
         hKsn1oXQLQNJDGCbJVDdtpXbVvgSAJlh4IMtxPc/cYsKQw8j6umU8GrjzjGStAuPZ/9D
         6U6zgRbaUIcKw3Mw2HI9yunNV3XtGbQTXz5hm/NDfp6yE0ThHY3E8rTtm5YWQPuK6QF6
         lI9AQ7+LxxLZaJtacqBiWFunVSWfaX9CfPquerctUl6jstXQPOXCg9lzO1IIDS4+GUhY
         8A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5FFxSTXwBaEGi4lfK+T2LU99v/h0J5utIcW5ijXutv0=;
        b=BWMkgi8AIe6lOEz6mkn5DSveEz2vSoSDHryF2R3va7zbGr8il7oPmrmXbxtEbWzphY
         UQKiPDk6wuUcSpigCIpWBmBdSHqpixmuxjx7MXJugyEfI5vsdprJkoZm8Dh14eK7ZOFV
         4E66HnrFR7FvZo+38oWl9bZtJ2jVU8BzxCF28+cfL53UYJ46O3x/PDCGzpcF4S7wj9ge
         HZmaU+LS4rTblNdPd7mYmwUET+Z9R2UKB/oM6imQwAtO2/Qf6YrZI0K7zcXwbhOXQ7Bk
         pHNEooEXY7TLrO8i5xIppJVktWjX3KIcEWV8EtC7czX/f7vmmlQP0hppoI0hHbcg3Yi+
         Phxg==
X-Gm-Message-State: AOAM530kORYe+Cq9Pwy6dabU2hgMSA4jKhaIgbYt+bl4zQ7LrkRvD14/
        pNsj2qtecXcQIeni6t7Hj00=
X-Google-Smtp-Source: ABdhPJyudhD009LYaZ/Hx+oWc+f1KFk4uFo6y5eJN4i37qfjlVM9CRWpoE25/CLl7gD4dLO4V2JDtA==
X-Received: by 2002:a17:90a:2ecc:b0:1ca:6007:406c with SMTP id h12-20020a17090a2ecc00b001ca6007406cmr9762848pjs.84.1649044352039;
        Sun, 03 Apr 2022 20:52:32 -0700 (PDT)
Received: from ubuntu-vm.jnpr.net ([116.197.184.15])
        by smtp.gmail.com with ESMTPSA id hk16-20020a17090b225000b001ca00b81a95sm15405045pjb.22.2022.04.03.20.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 20:52:31 -0700 (PDT)
From:   Sathish Kumar <skumark1902@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Cc:     Sathish Kumar <skumark1902@gmail.com>
Subject: [PATCH v2] staging: rtl8712: Fix multiple blank lines warning from .c files
Date:   Mon,  4 Apr 2022 09:22:13 +0530
Message-Id: <20220404035213.2609-1-skumark1902@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warnings like:
CHECK: Please don't use multiple blank lines
+
+
from rtl871x_ioctl_rtl.c, rtl871x_ioctl_set.c, rtl871x_recv.c,
and rtl871x_security.c

Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
---
Changes in v2:
  - Updated the subject and changelog text
---
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c | 1 -
 drivers/staging/rtl8712/rtl871x_ioctl_set.c | 1 -
 drivers/staging/rtl8712/rtl871x_recv.c      | 1 -
 drivers/staging/rtl8712/rtl871x_security.c  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
index b78101afc93d..2b539335206a 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
@@ -367,7 +367,6 @@ uint oid_rt_get_scan_in_progress_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-
 uint oid_rt_forced_data_rate_hdl(struct oid_par_priv *poid_par_priv)
 {
 	return RNDIS_STATUS_SUCCESS;
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
index 6cdc6f1a6bc6..603a3a48f952 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
@@ -22,7 +22,6 @@
 #include "usb_osintf.h"
 #include "usb_ops.h"
 
-
 static u8 validate_ssid(struct ndis_802_11_ssid *ssid)
 {
 	u8 i;
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 66cc50f24e29..de9a568eaffa 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -455,7 +455,6 @@ static sint validate_recv_mgnt_frame(struct _adapter *adapter,
 	return _FAIL;
 }
 
-
 static sint validate_recv_data_frame(struct _adapter *adapter,
 				     union recv_frame *precv_frame)
 {
diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index e0a1c30a8fe6..e46a5dbc7b65 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -381,7 +381,6 @@ void seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_code,
 #define P1K_SIZE         10    /*  80-bit Phase1 key                */
 #define RC4_KEY_SIZE     16    /* 128-bit RC4KEY (104 bits unknown) */
 
-
 /* 2-unsigned char by 2-unsigned char subset of the full AES S-box table */
 static const unsigned short Sbox1[2][256] = {/* Sbox for hash (can be in ROM) */
 	{
-- 
2.17.1

