Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2355B310
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiFZRPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiFZRPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:15:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7570AE093;
        Sun, 26 Jun 2022 10:15:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso10223488pjg.1;
        Sun, 26 Jun 2022 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dPKELELgFlCVowNQzSbwUOPIVqSefa774VaFs/5xX9g=;
        b=TTTicy3ewL1Zk/RYe5zjLoofl+7vqoioHrHCGakdXAQJjtpZw1TVvrTZC+x62Cn5U9
         smedmNDM6j6HiUeRdceXl/LpjrziuO44JkHEZh2f9sqjIGh0udxl7Dc5u92gW4owZqgG
         ePbV+O101344ucPTugz+R+L+P1sL+ip7YTOX1IwWa1kspveMN4oUSwEIOUONmen19ZfS
         8r9vXdrZLUK54um6JoYFq/8dThjgt7UzscsJkChWx21aeeeVgLuTcDmq8L6NuGrvLH5s
         aIc+oV40D/N0XhH+v6VWfCy9TzVt9z7mBH1JqNM9syMbMtz3TdP2t5rB9nNpequuKllf
         I8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dPKELELgFlCVowNQzSbwUOPIVqSefa774VaFs/5xX9g=;
        b=t51g9vL2/+MsooHojtC+ymNmjFXEOrpGeVZep+D891v6QQ4WYcKX8j2LQuWDTiIQ7c
         66GIkGD+Pa3Lm0JFCS4VWmcpsAoNfneNTuxN/p9HV/msrwvjIVumaMQ75iI0zsZbTdOX
         +cCASNtlKYHNNPwhL1J8r9lk1hRu6VTTMvIgiAG1vNLe3bRILbhrTr11Y4jKBD65jqcZ
         6e4zv8Ax07imnAaD5Q5mhLnEeLIlgRJ6roafWNc3y8MX3K8WFmzm3InAPDhdgkK1G0mC
         myeOzByThdpo1+WMEGP6ge3BAlB9SLplGCBTmMtwl6S6onwfTXo1yykog+a6a+EqUbfB
         NM/g==
X-Gm-Message-State: AJIora+7sGsjujUPEligtV/PdVD2QDY43yzD1erBNDkVjxOreChFhg9F
        gZ2YbBAkyFFMqei+kF59CbY=
X-Google-Smtp-Source: AGRyM1txc6slEOYWYXWXLdsMQVfV6ZRoR58qxTkTnBp7RWuDTTrRkkLN5l/nMwi6Z1d+mgiTgakCwA==
X-Received: by 2002:a17:90b:4b48:b0:1ec:fc87:691c with SMTP id mi8-20020a17090b4b4800b001ecfc87691cmr16122588pjb.120.1656263734820;
        Sun, 26 Jun 2022 10:15:34 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([2401:4900:1c0f:ec3f:8053:b39e:a633:cf03])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b0016a4f3ca2b5sm5411427plo.277.2022.06.26.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 10:15:34 -0700 (PDT)
Date:   Sun, 26 Jun 2022 22:45:28 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     santoshkumar.yadav@barco.com, peter.korsgaard@barco.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] platform: x86: Remove duplicated include in barco-p50-gpio.c
Message-ID: <YriUMDJoip0Mknh3@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the duplicate include of linux/io.h in barco-p50-gpio.c
file.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/platform/x86/barco-p50-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
index f5c72e33f9ae..bb8ed8e95225 100644
--- a/drivers/platform/x86/barco-p50-gpio.c
+++ b/drivers/platform/x86/barco-p50-gpio.c
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
-#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/module.h>
--
2.33.0

