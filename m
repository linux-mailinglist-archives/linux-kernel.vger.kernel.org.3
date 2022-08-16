Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574185953BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiHPH1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiHPH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:26:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6517CFA6;
        Mon, 15 Aug 2022 20:56:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r69so8222221pgr.2;
        Mon, 15 Aug 2022 20:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=YuC2ZqlMehLcukRikexVLN8c3OueFi6zQgBUaoUIHB4=;
        b=ambV1WUz+EEFvIdtBiBM3+Y+Ps+F0Qisf1jvrAvoK1SwyRdG9aQwk5K0aYHK+22Nms
         HxG96J/tZBY2RM81FJckLa1ycHPUTzLiHj5JU/J65umVYdW51dipAeBPIYBskzEgEaCE
         G9M1Wx2p1oVm4cvwRWbeBsibsYN5VxXwpNkb8IJE4X/Enntq6kpK6x8mQr+k9anFPwgE
         fNFiqmVjcldrzJHtl+tfb/C9Uki0yrwdZbSOefFKE5hlhNVNP5A9KOfXhuWB8OwkjBl6
         MBFSPyWedUML8RIJMZ1u6ECheXYWN6DLRxvnpRVk7DYbbu7oNw/GnMBYY6qH0OosFZ0z
         2n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=YuC2ZqlMehLcukRikexVLN8c3OueFi6zQgBUaoUIHB4=;
        b=MDwONOfAxHorCT63i1vBnxwKZv2JllH6HnZlGw4AlMhrom8VsWdQhRtXzTkrjamTK2
         ZVhrGWwB0WLV46RFIwPdDvxQF7LDoDOwQgHs8tbDCTxwlr70fF6d7sEY7mw224eb4KaW
         KaNhK3wFnHoVsr2eqINipOmi2N7H7HBF2O+61lUrnsk4aWpORb/moj7H22/6HefPx3FJ
         s8YzLm/O/y0cKiNfhsgfBy8TZy7F/yh8RqEfmVMtNJ8dtNNc8QyFrHcnjgLHD+dGPx2B
         tFhJX4qt+FEgj2z1cFxAfYRrPlF7dNg1md/t94osm4/UrRr2vyURZIht7IH8tvoT1i1/
         TWJg==
X-Gm-Message-State: ACgBeo3e676GT3EZN10BNtEpWd4REx86sv+UjyqAV1wl7huWuoOq7Lrd
        mCQSeoe038FIC2gGN2yPgp4=
X-Google-Smtp-Source: AA6agR4poCFA2FPUmDLgZGZ89i5B+AsjmhUPsWnxrNaSnPlLpNOPqPaHgMH3OnVoSGXlqf1OBcOSKA==
X-Received: by 2002:aa7:8205:0:b0:531:bd8:6a2e with SMTP id k5-20020aa78205000000b005310bd86a2emr19460609pfi.28.1660622202987;
        Mon, 15 Aug 2022 20:56:42 -0700 (PDT)
Received: from localhost.localdomain ([116.75.96.232])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090ac58d00b001f2fa09786asm5356846pjt.19.2022.08.15.20.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 20:56:42 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: [PATCH 1/3] rtc: rv3028: Inserting some required spaces.
Date:   Tue, 16 Aug 2022 09:26:34 +0530
Message-Id: <20220816035636.27226-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816035636.27226-1-jagathjog1996@gmail.com>
References: <20220816035636.27226-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style changes for checkpatch.pl error.
Add space required before the open parenthesis '('.
Add space required after the ','.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/rtc/rtc-rv3028.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index cdc623b3e365..5cebb00bec21 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -80,8 +80,8 @@
 #define RV3028_EEBUSY_TIMEOUT		100000
 
 #define RV3028_BACKUP_TCE		BIT(5)
-#define RV3028_BACKUP_TCR_MASK		GENMASK(1,0)
-#define RV3028_BACKUP_BSM		GENMASK(3,2)
+#define RV3028_BACKUP_TCR_MASK		GENMASK(1, 0)
+#define RV3028_BACKUP_BSM		GENMASK(3, 2)
 
 #define RV3028_BACKUP_BSM_DSM		0x1
 #define RV3028_BACKUP_BSM_LSM		0x3
@@ -522,7 +522,7 @@ static int rv3028_param_get(struct device *dev, struct rtc_param *param)
 	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
 	int ret;
 
-	switch(param->param) {
+	switch (param->param) {
 		u32 value;
 
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
@@ -532,7 +532,7 @@ static int rv3028_param_get(struct device *dev, struct rtc_param *param)
 
 		value = FIELD_GET(RV3028_BACKUP_BSM, value);
 
-		switch(value) {
+		switch (value) {
 		case RV3028_BACKUP_BSM_DSM:
 			param->uvalue = RTC_BSM_DIRECT;
 			break;
@@ -555,7 +555,7 @@ static int rv3028_param_set(struct device *dev, struct rtc_param *param)
 {
 	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
 
-	switch(param->param) {
+	switch (param->param) {
 		u8 mode;
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		switch (param->uvalue) {
-- 
2.17.1

