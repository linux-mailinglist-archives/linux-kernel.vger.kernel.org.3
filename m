Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997644DD7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiCRKgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiCRKfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:35:55 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260B08BF2D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w21so1076964pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fRESBb1qpqOH9PJ2aIurp7ZJ33pgIpvPdKysm8+ZUG8=;
        b=m1JnxZNmOmklJD60WMV143YD8TVkfFZmJ0lRDEIH5wGUwBgCOy0jLaCItaxJGnJSKs
         sg4mCCoIR/d5cEzvGC9bVdphVHckM+do3oNU7vLKqKr9V++Sq4S5ZUHnyDWGO/re27vV
         d53908yvPrSiGyDYs4JNhkiBzOY5WfCqis+MU35iOkXB9ZcoWb9XSk7XfYt44RyTk2tX
         KSfjXmj9JIvTdDY2mDNX2gffmIWvjoEtpuPA/UMk4DkIk52LBWxiy4bsHn/SN6yUM+qn
         96oVYjOdg7kMMEYaGCZBnTfwZ4/ydUeLu/p4Xo+3CleGnXP4mFK6Tyl41nC7IstJ6t33
         YnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fRESBb1qpqOH9PJ2aIurp7ZJ33pgIpvPdKysm8+ZUG8=;
        b=xQ1/5BYKOWAFXji0dGp3i7BVkpNPHpjJ6crSZtp+DSDuY5NTkzXSHV7G4XuYOpzpYi
         3VFMOcbpnh6LeSXobhTXBcs5TIz516VnEJC44yyweMlVc6TVyShDV/7cdrT70Rpnqtso
         GfG6etNbl1HeAQOODaqGP6P/WkYRCCDan/Oq2s8/axXYSN4qLtCEpMupL574cADwHSRj
         jU2tnQy7jEV0zGzyVOPR1eUARlszUBJ4rSlia9fd3dbveHbQnBsLVvtOZKB/PqFVbbjS
         hrQCpjsahMCeV1BXwZjqFFm9+hMYaFwDIY6zQqgCbCKOvw+4p4uJdgJdlCDbuc4mIz7/
         YTYQ==
X-Gm-Message-State: AOAM530lX92xAK30OMDY/qKhMtX9iIQKeqVqLxZDwhTSjlRdhRr7p/h5
        RzWmuaL7fg+H5MaXywq29tc=
X-Google-Smtp-Source: ABdhPJz43YC1eoOd62V/z1W6lJ89r3eS9lSSJ+X5l3p3fxrWsewgbBcxvOxdHWh5mrV6rLpl720ypg==
X-Received: by 2002:a63:b06:0:b0:374:5e1a:150a with SMTP id 6-20020a630b06000000b003745e1a150amr7149034pgl.137.1647599675723;
        Fri, 18 Mar 2022 03:34:35 -0700 (PDT)
Received: from ubuntu-vm.jnpr.net ([116.197.184.15])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a000cc900b004f7ac2189e2sm9528808pfv.191.2022.03.18.03.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:34:35 -0700 (PDT)
From:   Sathish Kumar <skumark1902@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Sathish Kumar <skumark1902@gmail.com>
Subject: [PATCH v2] staging: rtl8712: Fix CamelCase warnings
Date:   Fri, 18 Mar 2022 15:44:40 +0530
Message-Id: <20220318101440.13887-1-skumark1902@gmail.com>
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
Changes in v2:
    - Remove the "bln" prefix
---
 drivers/staging/rtl8712/drv_types.h   | 2 +-
 drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
 drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index a44d04effc8b..4de3aad08242 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -157,7 +157,7 @@ struct _adapter {
 	struct iw_statistics iwstats;
 	int pid; /*process id from UI*/
 	struct work_struct wk_filter_rx_ff0;
-	u8 blnEnableRxFF0Filter;
+	u8 enable_rx_ff0_filter;
 	spinlock_t lock_rx_ff0_filter;
 	const struct firmware *fw;
 	struct usb_interface *pusb_intf;
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index acda930722b2..69d3c55ee9e5 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -202,7 +202,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 	mod_timer(&pmlmepriv->scan_to_timer,
 		  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
-	padapter->blnEnableRxFF0Filter = 0;
+	padapter->enable_rx_ff0_filter = 0;
 	return _SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 90d34cf9d2ff..d58ae5b387d4 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -102,11 +102,11 @@ void r8712_SetFilter(struct work_struct *work)
 	r8712_write8(adapter, 0x117, newvalue);
 
 	spin_lock_irqsave(&adapter->lock_rx_ff0_filter, irqL);
-	adapter->blnEnableRxFF0Filter = 1;
+	adapter->enable_rx_ff0_filter = 1;
 	spin_unlock_irqrestore(&adapter->lock_rx_ff0_filter, irqL);
 	do {
 		msleep(100);
-	} while (adapter->blnEnableRxFF0Filter == 1);
+	} while (adapter->enable_rx_ff0_filter == 1);
 	r8712_write8(adapter, 0x117, oldvalue);
 }
 
-- 
2.17.1

