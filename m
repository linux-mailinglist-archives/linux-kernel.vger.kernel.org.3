Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6374BCE95
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 14:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbiBTNPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 08:15:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiBTNPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 08:15:02 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A13C72C;
        Sun, 20 Feb 2022 05:14:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i10so10839164plr.2;
        Sun, 20 Feb 2022 05:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQJzI4pAiqIrAiK8xf/I2uFAOefNuHWrds+r7Y0sKAI=;
        b=K8WLbjNA5ycR3w9LmvOwdvvjkeiXak+aPyHiG6SkSdlSviSF1zMJWLYgVTrkSLuEOa
         t34YKn527pBGIF6TkShiLK/Fk8snv3HKRhkKpcKj7VVeYAR5oRLYiLwGHI0Jq9eE0FSj
         aTUtZ4AYWt1ZxgSUSETEIiZUBJwdJVck3A2PRc8OarO9UWL0b6xOFj8xeRSB8KbL12WB
         OHEpfo82pqCm30BLJb8MhYVQzGaBzQo1cd7J6DqES3qGzYjKNgdBwqhf/J+RQSASA6py
         HqQ/B4I1HsrDn5SYi+S8reyLVdZKTlnUzPeUt2tfPEheSFbzHFkUL5fwYF3AvyMjqJcp
         51dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQJzI4pAiqIrAiK8xf/I2uFAOefNuHWrds+r7Y0sKAI=;
        b=giQYVyP6PRP/S8HkM813DxtAJ29oaO8Uixk7s1AZ+DDIWnDlsDm+zmQT5psh/td6Np
         6BB6ssf3YMTOkW9B/3x/JR1ODZFbPt0pZ7MCHGaqa0tGzgwHYos+liJEw0e7y+eCwdaX
         TqgSCReqm8rTUSfHZymmMswdRXliujTQJi1UIkVBi/JF7m8K8EQRyItfptRxrNB8RrGC
         KvJ3ajsqi/xSXGPjW8ppabwlA8vDs6ZDGHSEW5TVHbwhpigaAtGimFV7gZ8bx2GB3BTY
         67HhyoGFo5V5SPX0WscLA45DK+ga3B7ty8XunrBuTAMkBLAzxl3OYrh6UCdHxvXd6rbm
         G1lg==
X-Gm-Message-State: AOAM532o8zM+L5oV0nrJE/nQiUlJvTLJf7Yj3+W9ApOep44TAD1p6LDS
        wLQc4Gr5qXj4891wenYK4jiYdpIIqeKIDg==
X-Google-Smtp-Source: ABdhPJz3w1igsvJNn/MOHJOWYKDvjPkoHXbYuBdOrDyg2khlwjE+3CpTWD76C8LJWbJWRh4KeL3mig==
X-Received: by 2002:a17:90a:e008:b0:1b9:2e0f:1e57 with SMTP id u8-20020a17090ae00800b001b92e0f1e57mr21291546pjy.174.1645362881969;
        Sun, 20 Feb 2022 05:14:41 -0800 (PST)
Received: from localhost.localdomain ([116.206.246.215])
        by smtp.gmail.com with ESMTPSA id c68sm15593739pga.1.2022.02.20.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 05:14:41 -0800 (PST)
From:   Husni Faiz <ahamedhusni73@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     Husni Faiz <ahamedhusni73@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] usb: serial: Fix Coding Style Error Around Ternary Operator
Date:   Sun, 20 Feb 2022 18:44:05 +0530
Message-Id: <20220220131405.179732-1-ahamedhusni73@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212175510.521072-1-ahamedhusni73@gmail.com>
References: <20220212175510.521072-1-ahamedhusni73@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes "spaces required around that '?'"  checkpatch error
Added a space before the "?" ternary operator.

Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
---
V1->V2 : Separated the style changes into multiple patches.

 drivers/usb/serial/cp210x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 8a60c0d56863..1fcdfb7d118c 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1403,7 +1403,7 @@ static int cp210x_tiocmget(struct tty_struct *tty)
 		|((control & CONTROL_RTS) ? TIOCM_RTS : 0)
 		|((control & CONTROL_CTS) ? TIOCM_CTS : 0)
 		|((control & CONTROL_DSR) ? TIOCM_DSR : 0)
-		|((control & CONTROL_RING)? TIOCM_RI  : 0)
+		|((control & CONTROL_RING) ? TIOCM_RI  : 0)
 		|((control & CONTROL_DCD) ? TIOCM_CD  : 0);
 
 	dev_dbg(&port->dev, "%s - control = 0x%02x\n", __func__, control);
-- 
2.25.1

