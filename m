Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A324A6DAC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245424AbiBBJTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244541AbiBBJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:19:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2388C061714;
        Wed,  2 Feb 2022 01:19:35 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m26so8471223wms.0;
        Wed, 02 Feb 2022 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2wQ8mV586mhuZL4frfEIcmzmgyOteCfGDcIoUviviw=;
        b=HMR0fQk+43OprJJQhoAWA1vrzxeJ7K9GuusGqJmhmn9qrV4FPNQCuVfQ/EgN6JDuOV
         ItTGUF5Dgkbzrc0BP3kf4o8RgtuRJDgBUVW2u7ujycRXWXGbP3sHMT+FhVxbYKuCOhUP
         NuSPhvF73lzYGN6aw9bRp1rufqZXbJGUxmm6uPoLSTgZUOtZAjVsr1FSgFWPnupx0W4b
         QYCi6oFWCkLwseF/2urpLefcj+NlbRotNyjlgHlzqx/szIH6zrT6aE2x4G4PLXd/L5nc
         x9Kik9/cIQ5FNFy9P66gMqEm3mpfzY1DYnOAXovJIggmVKx+xv+7Fa+WVJENIfcnY/oU
         aS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2wQ8mV586mhuZL4frfEIcmzmgyOteCfGDcIoUviviw=;
        b=blXgJgCx/zGIRD2KucgcrJpP2HDMlIwVY6FAHr+LGdWHT76DI12W+G2JqekKnpBG1r
         Mhiu+iDaBwypZS7uBhANgeYJ+3neSPBNREQO1FeT0tYMbVNhoQquPJR384iT1XqHPsCk
         u+BGN/ZPa4aqMHbGKUfEBqjZ6Q9P/8GoHm5gY+oMuSFJQRxPRhaZFLSxjxNpB61Dycer
         LAtcT4RjAqXa3q4LldA3nNhQw8g3EcIrXBlWeznzVNge61Pe96EvISMKyYT5mVEn2Qx4
         WWHKXAh8u3haA14DB/pAX62LLhUmye+zXEdtGL0mSwYLZLzwe9fLdPzm9//feNWbf6e4
         GIuQ==
X-Gm-Message-State: AOAM5301MlghIuKOgrReWiXVuOJNUBoU5LZCfchwbhOslS0gR7rT0fS+
        y0LYF/wN7ICjt3VLRguUaxU=
X-Google-Smtp-Source: ABdhPJwM4L2i3gC4Fnib4qik/6mxnjQrjp2xywymmmJ4lMG28PscLkUb49xWC14FbXhvYlXRHY8BSw==
X-Received: by 2002:a05:600c:35c4:: with SMTP id r4mr5271109wmq.29.1643793574508;
        Wed, 02 Feb 2022 01:19:34 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n22sm4561639wmc.27.2022.02.02.01.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 01:19:34 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: gadget: f_uac2: Fix spelling mistake "maxpctksize" -> "maxpcktsize"
Date:   Wed,  2 Feb 2022 09:19:33 +0000
Message-Id: <20220202091933.580713-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a deb_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/gadget/function/f_uac2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index f2237bcdba7c..c9b8d11f9870 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -755,7 +755,7 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_o
 
 	if (max_size_bw <= max_size_ep)
 		dev_dbg(dev,
-			"%s %s: Would use maxpctksize %d and bInterval %d\n",
+			"%s %s: Would use maxpcktsize %d and bInterval %d\n",
 			speed_names[speed], dir, max_size_bw, bint);
 	else {
 		dev_warn(dev,
-- 
2.34.1

