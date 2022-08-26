Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567BD5A224B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbiHZHu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245644AbiHZHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:50:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FEC7B96;
        Fri, 26 Aug 2022 00:50:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v23so923286plo.9;
        Fri, 26 Aug 2022 00:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hrOvC4yxHykycH1IrQSO1OAlTlALBHw2gbda8sHjukQ=;
        b=V+3b4HppDthK+E27D+Ob2MuVAzk8M25k8L3N7shYeVWOyGm/xr8NsO4fqjGS2Pv7xq
         llw0cS6psMf+IDLozZJ7k0UTpTquBcsOvHvUgb3UQwlcXoTaJZ4YCjmcAUNa2b1jHFOX
         fV5x7CK/ooq5in5cB7QDj/4w4WQLYpcTEiUbfnP10d7qtGzKMoxt74f/NssFwESOKHTl
         rowKDMVlQQ+gPiu0uWUUWNmFxOlqtOciBUi0JrbXWert6cQfpN2a4dPUjHcEgtnIBAst
         9atgkFtkcKmKaZUmA4fxIcmBHKDAEtwt898dXiQOyQ9neCzRLrXUMY2Pv4S1NzGeAoDX
         svTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hrOvC4yxHykycH1IrQSO1OAlTlALBHw2gbda8sHjukQ=;
        b=x7RtrIYLkIOmWtgujtWmSRQIWiuibtbhv2YdYGk8u8RV8vaA5qegwIgbf5pWYdveBq
         iRFViHLGJMVpb7CG1Fa29f/BTIUktrC/K5zSj9Flq3uMnRXbrtSdA9M2Psvjh1r1gKvE
         RHX6mfMG51h7v/ZqbJldTsc7EKMowETUCDAV+Tm4/tswQgUC0KzL/53lxX77yMxLy70e
         Z741R/oDvLftl67V+0r2r3zaxXH728EgWvVrD3vtEPLhZ7FmZEVUvSoZcxGqAl0ykHHs
         3JzTnzTI7zggHvyoiDi7BrhJmhwHKa3wqTIUDBTOzlIl5f9BjwIdsqNmDWDbkbN9DnaL
         I/4w==
X-Gm-Message-State: ACgBeo1AUPaf9LliNZynMT1dWAs05Gl8LZd5WYKgOZOSrkfSzziJNmRl
        GEwra+AB51EFXEYB68Ra0lDM70WbPEE=
X-Google-Smtp-Source: AA6agR7aMEamn8+vtzCRfUAq2feU9PfS+OkUObU7cXAlJ5iFpSZryzVIZh8jATa928ftLMxWp8gf+g==
X-Received: by 2002:a17:902:d34d:b0:174:429d:7789 with SMTP id l13-20020a170902d34d00b00174429d7789mr423764plk.144.1661500249548;
        Fri, 26 Aug 2022 00:50:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b001726b585d4bsm870993ple.202.2022.08.26.00.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 00:50:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     linux@roeck-us.net
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xupanda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] usb: typec: tcpm: tcpci: Remove the unneeded result variable
Date:   Fri, 26 Aug 2022 07:48:57 +0000
Message-Id: <20220826074856.253810-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: xupanda <xu.panda@zte.com.cn>

Return the value regmap_update_bits() directly instead of
storing it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xupanda <xu.panda@zte.com.cn>
---
 drivers/usb/typec/tcpm/tcpci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index b2bfcebe218f..4436e9e5e2f7 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -328,11 +328,9 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(dev);
-	int ret;
 
-	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
+	return regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
 				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
-	return ret;
 }
 
 static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
@@ -884,5 +882,3 @@ static struct i2c_driver tcpci_i2c_driver = {
 };
 module_i2c_driver(tcpci_i2c_driver);
 
-MODULE_DESCRIPTION("USB Type-C Port Controller Interface driver");
-MODULE_LICENSE("GPL");
-- 
2.25.1

