Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0253658AB3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbiHENGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiHENGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:06:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270A205F5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:06:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p10so3182283wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMBHKeG+uj2RCiscp/m14dBH4g2RDMQBDvQVGQjAQpA=;
        b=CCCgaKAT/t03FTKn2Ul9JcmLP30Sb1n8CRn2Na8/JwSzHTJuDnRH80W++218pg/NNE
         qNCul8Ee9O3nwrro/2qu2oGUUP19pFO0mkZvk8t9Zqdz3PmFYnAuPQ942TgsZ3xpbP3O
         I70rEKjHcXe8hBg7bGni0qxfQcHJ+RyMFCv3q/L5EB+NyyOCx9+TP5V9tKUd2FDQMrKQ
         UDXqjphViRdXF7Na4aOOGpe53KKbLs/VfZ758wLFjLnpxZiIxC3H2JkGcerAqD/Z8Shn
         7Dv3v5h9vehGqCXnby5bL0sFwmUjXYIKpN8vaCF01k/eswQGTs9BzDMSVwOVtSH+74Hv
         RJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMBHKeG+uj2RCiscp/m14dBH4g2RDMQBDvQVGQjAQpA=;
        b=Df81o3IrlRosSGtSXlxiUWTaUxboKNrIcTMSOrhVKynttL6DIvZEQpxbbAGY5UNsGw
         G2Anvkj/AJhEHUOEkZU1P48qNRU60Yf7WpilVqOhIfHMCH7q0nIKhW1PN3Moc14v6MWw
         JQ0LSvIRvlZ2YtfIwotxjwKGM7sOif+T1ezVG2ELQoiZyElcvfZlVV1DSgv0dVxhJvRY
         KP9AAkYDApHXmn1cGK8FvM6XDkVWHpF5MD2zgG+MkoRp1YM3PReq9V6oLlSjgIB3pQtL
         5urAmY5a9alCzbK7n+sy/F1CHpB35UCn1IHRFY5qVzXjbJqOz1FpoDm4337Gg3cM5TiP
         sHuQ==
X-Gm-Message-State: ACgBeo1mwTIdAPWxOapdMicr0SEP3r5Ek3cevLlSqHurX5HzDiNeDv84
        MwahoW2ofoq4Ho8oMNTvGJhYu95alQ9hVPEY
X-Google-Smtp-Source: AA6agR60jW2rSIVn/470RYnjAIjv8R48SysKold+eZg1dX80YmmCzW2tJNa33tfHW7I2jUj7F7L/FQ==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id i1-20020a5d5581000000b0020ffc517754mr4458033wrv.413.1659704793841;
        Fri, 05 Aug 2022 06:06:33 -0700 (PDT)
Received: from localhost (cpc109575-know16-2-0-cust250.17-2.cable.virginm.net. [94.175.88.251])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c4e8a00b003a30fbde91dsm10920176wmq.20.2022.08.05.06.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 06:06:33 -0700 (PDT)
From:   Alix Dixon <notdixon.alix@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Alix Dixon <notdixon.alix@gmail.com>
Subject: [PATCH] drivers: android: binder: Fixed coding style issue
Date:   Fri,  5 Aug 2022 14:06:11 +0100
Message-Id: <20220805130611.59289-1-notdixon.alix@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fixed issue with comments on multiple lines not being aligned correctly + multiline comments not being on multiple lines

Signed-off-by: Alix Dixon <notdixon.alix@gmail.com>
---
 drivers/android/binder.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c964d7c8c..5a6da6765 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5289,8 +5289,10 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	unsigned int size = _IOC_SIZE(cmd);
 	void __user *ubuf = (void __user *)arg;
 
-	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
-			proc->pid, current->pid, cmd, arg);*/
+	/*
+	 * pr_info("binder_ioctl: %d:%d %x %lx\n",
+	 *		proc->pid, current->pid, cmd, arg);
+	 */
 
 	binder_selftest_alloc(&proc->alloc);
 
@@ -6544,8 +6546,8 @@ static int __init binder_init(void)
 	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
 	    strcmp(binder_devices_param, "") != 0) {
 		/*
-		* Copy the module_parameter string, because we don't want to
-		* tokenize it in-place.
+		 * Copy the module_parameter string, because we don't want to
+		 * tokenize it in-place.
 		 */
 		device_names = kstrdup(binder_devices_param, GFP_KERNEL);
 		if (!device_names) {
-- 
2.34.1

