Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4904F9C2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiDHSB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiDHSBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:01:52 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D418D2B4;
        Fri,  8 Apr 2022 10:59:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x33so9903441lfu.1;
        Fri, 08 Apr 2022 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHwD9GpfMIl1xZZPIJHVwBE+F4ubsEa4nK0RYjRnyoU=;
        b=pkII27vEMBXPOVRFSuqGRql7ECxDp+6zybJkSzjSmZEB4rtpeAH6EZdLnEb6+Bf96+
         +qKhP5qGpVcxxsHXCmeuF0LpyYXU4kuP3YPH1rxpvZp/TDlEp4q5Ch15ZBXWaLjFQpGf
         ldd7P1xXUU21YFiIm+2cWURXwjG/qotqJQEoLwMYSGFEziLoRXAD3NJ4t+hEZDWn9IoH
         LCO3N/g8KginyTxzgn6behS9lUZZEeyMLOBtpY6AvLeQFcl/0KZemwsd+UPI1E33gNp0
         AifsI1QxH4MX4NT562J1A/f9SOPLBz1ljShdd7lQCqF4izBH1S43csxSNqgmzd/YcSP+
         J4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHwD9GpfMIl1xZZPIJHVwBE+F4ubsEa4nK0RYjRnyoU=;
        b=XYF7jfqWYEEYur7zuLbMwgR6rqHdR4TAc9qC11jZgw3kSsscLVNMBv4AbYdiGS9YNP
         RtVLkOviODAE9u/Mu3VbELH3ytcctIzgEkbgGpPujDmq5Ey+wg4QhDBYrw3awwVr8iWn
         uZNP0Spwp2YKe+dfwaGZvwJQUzZFcgTAUFM4+wNIoBySI8MZyNegjROasCr5WZZWLsoA
         A9+HNERD79iq5gRd8c9kPx9ICvh2Z3yrcB7v9HLOK2OPxn8wGVUx7K85e0jYXIr8dcYd
         fVeMi2s6plTEbQqFbVy0bUQA5GSRumFO43lBK2oZruyNQ1xC/p+DDnR/gziE5Q1iZhrg
         D0kA==
X-Gm-Message-State: AOAM53010pr0DGtsSLMH5JT20GDsTZ0eObBs4T9sMTk8QLVZ65ZCCcmr
        yNDYIvr1Gqv+0XQUOsFNJYWh5RMtis0=
X-Google-Smtp-Source: ABdhPJx/RRusuJLg0P0+7asKI3Org4PDwmMiP5YKiDrhBMgWuH/+/AfJt98EN5DMXeDpze9HPauvVg==
X-Received: by 2002:ac2:4e14:0:b0:44a:24d4:fa29 with SMTP id e20-20020ac24e14000000b0044a24d4fa29mr12746828lfr.586.1649440784643;
        Fri, 08 Apr 2022 10:59:44 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p3-20020a056512312300b0046b83c2f92fsm272456lfd.58.2022.04.08.10.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:59:44 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 2/2] leds: ktd2692: Make aux-gpios optional
Date:   Fri,  8 Apr 2022 20:59:27 +0300
Message-Id: <20220408175929.281453-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408175929.281453-1-markuss.broks@gmail.com>
References: <20220408175929.281453-1-markuss.broks@gmail.com>
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

Make the AUX pin optional, since it isn't a core part of functionality,
and the device is designed to be operational with only one CTRL pin.

Also pick up maintenance for the LED driver and the yaml bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 MAINTAINERS                       | 6 ++++++
 drivers/leds/flash/leds-ktd2692.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2db49ea7ae55..8ef5667a1d98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10479,6 +10479,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
 F:	drivers/video/backlight/ktd253-backlight.c
 
+KTD2692 FLASH LED DRIVER
+M:	Markuss Broks <markuss.broks@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2692.yaml
+F:	drivers/leds/flash/leds-ktd2692.yaml
+
 KTEST
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	John Hawley <warthog9@eaglescrag.net>
diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index f341da1503a4..fc9c2e441caa 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -284,8 +284,8 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 		return ret;
 	}
 
-	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
-	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
+	led->aux_gpio = devm_gpiod_get_optional(dev, "aux", GPIOD_ASIS);
+	ret = PTR_ERR(led->aux_gpio);
 	if (ret) {
 		dev_err(dev, "cannot get aux-gpios %d\n", ret);
 		return ret;
-- 
2.35.1

