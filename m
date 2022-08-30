Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E265A6628
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiH3OVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiH3OVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:21:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE212AFADA;
        Tue, 30 Aug 2022 07:21:42 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bh13so10819762pgb.4;
        Tue, 30 Aug 2022 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Ep2MANbHOmXdnX6tPL+TZV3efYdCEHeaDVmWvQZttAw=;
        b=YevEzndU6KjjBk3G++RPD82udEXoQOHSDepG5BdKyLWPCuHWQUiShgLmeCD10OOgAR
         pugP+dBXpSPATFgNp3LmGKil+TIZW9+vrDXMxkQGLMGzcjvry4mCmZNomSvSRZvrwSBU
         +05bE0UpQQLOA2FT/pmSd8qntpyR3kuAA1x/K84Hj6YCqawbAgje9lgHq7QiG99VQ38x
         qfAmIICABejXyRUxxDDYN4BY2JLYAwo+UO8XdJSuAvGU1wl1WLp0iGcJUlWMSmeVjz24
         MpnugA6LjbJ4AnAUn0kirmpjwbG1jL/78Tn1um+UptkPP2WX0z70vyASlwLUBVF6hF2M
         V/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Ep2MANbHOmXdnX6tPL+TZV3efYdCEHeaDVmWvQZttAw=;
        b=IB4boHjbU1V7WCBCTZ6aIYM0BE7INqB770wbbANybOxQnbRoomBb4GE5unhAYoZ+Zu
         zWhKsmjVzv7GETmEfpQX9/qQqlJjIAQBJrV783FEjlkfJa6842p0A3PQHroy9qfusPuL
         ++yi9a7VtUFbneMowK2tu3qhTKkIXESI8X6N7RwCL++h+ghZjMKCWAEwFJU+4yRqZclu
         P7GHigEPUOZpXFVwYlcfHlfAois+FZR0Hjy110RHNVUUnSRiD2xwpUHnP77e6QiE64V2
         i/MM90+SGbWfaWwxKl/dq7pEJCbxcBPkBByEusbeDZ2nhXTWL+5NEq1l0CeLVtqQQzAX
         IihQ==
X-Gm-Message-State: ACgBeo0xIP8kE03BoG14j231EWaDeCOu9w4pNpTP7xX1wg3i6ONp4z8/
        Werr3NaPc505TK3782zOxlA=
X-Google-Smtp-Source: AA6agR7RjwL35h/4E+5ZpPrxnPws776CluJ2ghuHRWveoV3I4HEU7+TaV+zfiUyKcEcChdKLpVVlQQ==
X-Received: by 2002:a63:88c8:0:b0:42b:59d4:ea81 with SMTP id l191-20020a6388c8000000b0042b59d4ea81mr17416941pgd.344.1661869301549;
        Tue, 30 Aug 2022 07:21:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z1-20020a626501000000b0053675c0b773sm9371834pfb.88.2022.08.30.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:21:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     aaro.koskinen@iki.fi, jmkrzyszt@gmail.com, tony@atomide.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ARM: omap1: remove redundant variables err
Date:   Tue, 30 Aug 2022 14:21:36 +0000
Message-Id: <20220830142136.299373-1-cui.jinpeng2@zte.com.cn>
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Rturn value directly from platform_device_register()
instead of getting value from redundant variable err.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 arch/arm/mach-omap1/board-ams-delta.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 651c28d81132..e5531ef0fbde 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -822,8 +822,6 @@ static int __init modem_nreset_init(void)
  */
 static int __init ams_delta_modem_init(void)
 {
-	int err;
-
 	if (!machine_is_ams_delta())
 		return -ENODEV;
 
@@ -832,9 +830,7 @@ static int __init ams_delta_modem_init(void)
 	/* Initialize the modem_nreset regulator consumer before use */
 	modem_priv.regulator = ERR_PTR(-ENODEV);
 
-	err = platform_device_register(&ams_delta_modem_device);
-
-	return err;
+	return platform_device_register(&ams_delta_modem_device);
 }
 arch_initcall_sync(ams_delta_modem_init);
 
-- 
2.25.1

