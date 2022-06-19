Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80638550967
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 10:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiFSIm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 04:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiFSIm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 04:42:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42632620;
        Sun, 19 Jun 2022 01:42:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so4290294wms.3;
        Sun, 19 Jun 2022 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wazsq8UhIUaOIBwX2Yb5mTAKaqwBYkzu0w6I7zPYq3g=;
        b=ghAKWzl+zepMk4HZrdDECE9IzXZo476DxjSpgMBqosbL7CHiWc9Yf2Ny3+s3MWOed3
         8IR4JtEouizcsIMFh7h6fTlthvus+HCBbhnAGV3hdC1ucJKt36TVZnwJphc9eilPyRLQ
         JX1Fk8TXGXd54Sglyo/zNlP8jwFJVSUAgj8JqQvFOkUd7MvZQHX4YR+fb7+HCeFTkWgf
         hzgrcXD9RhJ+eHHej/UfWU0ZugX5doXMLztEJnamVvl14IAOlK8XxVRPmZT+il65BNTM
         Whl0f3wui4pP8Vq7qiOYqzyuvWxDD5PpkODlTzYxFihz3OQwQC41mNd3lVkkWkmFAoNS
         iQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wazsq8UhIUaOIBwX2Yb5mTAKaqwBYkzu0w6I7zPYq3g=;
        b=qYC51roBR9XXvou2BhvC2sTyoMOki8cRXBpOwXWHPqxB2bDUC0Kinlx1NNlMpl/aCu
         rAr9H6nFReN8HmD17nvvXMMC667fWdSWWKZqXvb3kPr5CGSDdM5ii0v98NOmyDfueGrE
         oez+jupapidsW2wsqmaMNL6afYtwxsHkDtu79ZaWA1yADbpqPF3WPAu5bpSeHSPX0YTv
         2GYGGXTqIqpGCqv0Ds5JHVmxvvQbJo0ATs837GYVQhTwTwLEQ75eP5cHe+VvX5RPReZJ
         BKiriU8SL/AgeWqiYX4rR5KFWNhhimU7cwn2O7LeeKbgVj9V+auqUhihUGzhU11ld3mr
         2Vjw==
X-Gm-Message-State: AJIora/2SwDDsW+lpT77ipOsdKPQYwHXrOG4QDziQ6C0ZD2Ke3cRagb9
        aIvRQ918SZW6hjSrRlmfX+0=
X-Google-Smtp-Source: AGRyM1uTFK+e/sNCprJ9slSi3YLU6OTHKl8MT6d2ssqS4zkz3AGmbjs/BOrpAlt/AyqK0ajA8wHamw==
X-Received: by 2002:a1c:4409:0:b0:39e:f584:e2ad with SMTP id r9-20020a1c4409000000b0039ef584e2admr7733299wma.84.1655628170367;
        Sun, 19 Jun 2022 01:42:50 -0700 (PDT)
Received: from localhost (226.100-195-80.static.virginmediabusiness.co.uk. [80.195.100.226])
        by smtp.gmail.com with ESMTPSA id r184-20020a1c2bc1000000b0039749b01ea7sm13712308wmr.32.2022.06.19.01.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 01:42:49 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] extconn: remove extraneous space before a debug message
Date:   Sun, 19 Jun 2022 09:42:48 +0100
Message-Id: <20220619084248.21395-1-colin.i.king@gmail.com>
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

There is an extreneous space before a dev_dbg message, remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/extcon/extcon-palmas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index d2c1a8b89c08..32f8b541770b 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -107,7 +107,7 @@ static irqreturn_t palmas_id_irq_handler(int irq, void *_palmas_usb)
 				(id_src & PALMAS_USB_ID_INT_SRC_ID_GND)) {
 		palmas_usb->linkstat = PALMAS_USB_STATE_ID;
 		extcon_set_state_sync(edev, EXTCON_USB_HOST, true);
-		dev_dbg(palmas_usb->dev, " USB-HOST cable is attached\n");
+		dev_dbg(palmas_usb->dev, "USB-HOST cable is attached\n");
 	}
 
 	return IRQ_HANDLED;
-- 
2.35.3

