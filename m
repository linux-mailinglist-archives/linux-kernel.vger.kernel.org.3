Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458C14A6D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245335AbiBBJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245328AbiBBJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:12:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B958BC061714;
        Wed,  2 Feb 2022 01:12:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v13so36944416wrv.10;
        Wed, 02 Feb 2022 01:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJdtPOjpOJxcw/bDrep6QyoQiiLSPQ6yNsHfnZN05PI=;
        b=jSUB4XrIRP6GTtKBT+hq9g63X7O1VislQePExHgAwMfwlO0SqMVeEd9JKZ9CJhFR+W
         Wj5881Lad6UA9L/qk4xuwZlu6TUoOT3tuTZ5J5cdPCM9QdUu576JUaIjlOLdyG7enFlS
         UdQIzMT6nYHC16AQoyJvWtGdya1EP48iuJxZ5E9I/ApEJHleOVYvTB7ff+4BrbCcN55y
         IriE6ufcTxAYYFgTIoLHliIlDqlVGXl1NzivvraBEMHgtEtNvgb7ewKj96yTs5x+yJwe
         OonhUvWaanyy7zyxFTocEz1LBO0k+ba1vZmXEGTJFeBax7RYM9352e6e3sSn0ZeuyqY0
         76GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJdtPOjpOJxcw/bDrep6QyoQiiLSPQ6yNsHfnZN05PI=;
        b=oqZ/49w8hghBuxrfOaiXr3ruKvXYX+wqoU249sELD7HGFVjcL7/vSI0JEq064OAKZ9
         oIf8vLhVAQYdEpteR2j6wopzOZwQVY5Ljx8vLa0/X0x/74xzN/6G+dzJ4jVH0hHmKDNT
         EFaYIFcrGi89A2r38fSxdI8JfOPnCVPK9D5e5jroXtN6+IW7CjGQLZnF6PP0fdj5FRTE
         YFF4h0QQLIs+c3nGX67U1sfneCPScIqXy83+88prJ5QveSR2zWciZ/+2mmsb8GavR4XW
         Os3h4FSn+Jha7gqkyhtv4CNepKAHoLNPxVH1pXAZsCIwb+KVvz+slzhM/nQLr6rcFRvW
         n13Q==
X-Gm-Message-State: AOAM5310XzHhoH7CeR+kaKSiMHW5upRr5/Df5HGTGqY6Xno0XhmdXjtw
        Ksnh19/MYYmynKQuoE7kVQU=
X-Google-Smtp-Source: ABdhPJzGm5XRxQrPBOIGpKj/DmunuAW2c5T5gyDjptyQR+b0izn4UDCqFxguQioa4WWh87M3GLZQvQ==
X-Received: by 2002:a5d:6d82:: with SMTP id l2mr24731664wrs.236.1643793168264;
        Wed, 02 Feb 2022 01:12:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b11sm4112779wmq.46.2022.02.02.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 01:12:47 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: axp288_fuel_gauge: Fix spelling mistake "resisitor" -> "resistor"
Date:   Wed,  2 Feb 2022 09:12:46 +0000
Message-Id: <20220202091246.580091-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a MODULE_PARM_DESC description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index dcedbc59732d..13be2c1d6528 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -91,7 +91,7 @@
 
 static bool no_current_sense_res;
 module_param(no_current_sense_res, bool, 0444);
-MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense resisitor");
+MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense resistor");
 
 enum {
 	QWBTU_IRQ = 0,
-- 
2.34.1

