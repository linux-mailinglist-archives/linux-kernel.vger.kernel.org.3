Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF594DD6CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiCRJF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiCRJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:05:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A017F3E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:04:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o13so4634445pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=FXtO594ge8nWoKJhkRK9YLemS9ZVc4q9DV746nBa+bU=;
        b=iQd+PY1pSOiSzKuysLdHJIP/VldyYqhEj5zXUYhNp5AgOTQwI0PaGAsYgJR+Y7SlsN
         PVr9PdrqgjPkH+NtCTEGuO/ENGLyq56Ljiz2B2m5fXLTbmOEuqlp3UmJyL2WJB6Fc+CU
         E/dBN1nrRSsX5mkjjggZoBOhL1x4adzylzHAifEc62Yu6xJhXguiJZ4cw/1iB/egBCUY
         svuGHXnCK4PZoVcVzCX+mgWyicOWerTWTdqsigjlUxUeWh5+coKcnPrX7aZZHM+EZ/RB
         /5DD9KrLjiYBTV4sJaFtUpHX8u86iBkDHLrRxEE4/d1VTIUmwfm+DqDqZ0di9nKgQO03
         HNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FXtO594ge8nWoKJhkRK9YLemS9ZVc4q9DV746nBa+bU=;
        b=gpEa7po2odwVNC2eVYcSQwI+LvPZtks9xLAde/XF9Y1Y/NL+QDGx++9dJ6PKXFeR3T
         xBG37U+d/Dv7/1Q58dFfFzDNXTjExDme/fjlbbDg1jjiFEEJy9jFGggw/lVOZSMT6k/3
         mS0cblFB9Jf+e3+PFXcbuJyrBMNe8fBnrXHLp0JMOBdhG2gIMIjiqC6YELI3rdFecbYt
         62pRung18N1JVrPzmikMDy42/vMJ/xU96y1X6bLonYVFnn7904O/SNs8I6llnK/00P1D
         +f6rmL7+nZ8gagNAYww8Xq+3XLFqc1MF/fsAna9nKFiOco3CQqIShLZy1MNVqg3OCJpl
         lTsQ==
X-Gm-Message-State: AOAM531h3/PeD6V9JAjVBNXNGqnvF677rj8grubq0gxnmnHdaPucYgGd
        TnJeTd0vZJOwK0omWWcMeL8=
X-Google-Smtp-Source: ABdhPJyX5a81jAmAQVWNWUkR1fmd1MXW+wU7Hh5PDemKokzPtuyKb0Mnq49JAgh13Mu6mRSjrYAaog==
X-Received: by 2002:a05:6a00:989:b0:4f6:f12a:e2ab with SMTP id u9-20020a056a00098900b004f6f12ae2abmr9019013pfg.34.1647594269811;
        Fri, 18 Mar 2022 02:04:29 -0700 (PDT)
Received: from ubuntu-vm.jnpr.net ([116.197.184.13])
        by smtp.gmail.com with ESMTPSA id h16-20020a056a001a5000b004fa343c2d0csm5647867pfv.136.2022.03.18.02.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 02:04:28 -0700 (PDT)
From:   Sathish Kumar <skumark1902@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Sathish Kumar <skumark1902@gmail.com>
Subject: [PATCH] staging: rtl8712: Fix CamelCase warnings
Date:   Fri, 18 Mar 2022 14:33:58 +0530
Message-Id: <20220318090358.13559-1-skumark1902@gmail.com>
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
CHECK: Avoid CamelCase: <blnEnableRxFF0Filter>
+   u8 blnEnableRxFF0Filter;

Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h   | 2 +-
 drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
 drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index a44d04effc8b..88845b46131f 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -157,7 +157,7 @@ struct _adapter {
 	struct iw_statistics iwstats;
 	int pid; /*process id from UI*/
 	struct work_struct wk_filter_rx_ff0;
-	u8 blnEnableRxFF0Filter;
+	u8 bln_enable_rx_ff0_filter;
 	spinlock_t lock_rx_ff0_filter;
 	const struct firmware *fw;
 	struct usb_interface *pusb_intf;
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index acda930722b2..ad82379c062b 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -202,7 +202,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 	mod_timer(&pmlmepriv->scan_to_timer,
 		  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
-	padapter->blnEnableRxFF0Filter = 0;
+	padapter->bln_enable_rx_ff0_filter = 0;
 	return _SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 90d34cf9d2ff..7c7435d20580 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -102,11 +102,11 @@ void r8712_SetFilter(struct work_struct *work)
 	r8712_write8(adapter, 0x117, newvalue);
 
 	spin_lock_irqsave(&adapter->lock_rx_ff0_filter, irqL);
-	adapter->blnEnableRxFF0Filter = 1;
+	adapter->bln_enable_rx_ff0_filter = 1;
 	spin_unlock_irqrestore(&adapter->lock_rx_ff0_filter, irqL);
 	do {
 		msleep(100);
-	} while (adapter->blnEnableRxFF0Filter == 1);
+	} while (adapter->bln_enable_rx_ff0_filter == 1);
 	r8712_write8(adapter, 0x117, oldvalue);
 }
 
-- 
2.17.1

