Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF87253FF5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbiFGMsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244194AbiFGMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:48:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B841D0C3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:48:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k16so24030876wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMquTTOroydUsr7NpGwE4Uf+57dZsT0an9Oj32CtfR8=;
        b=SJqAcgwcKc541NPPZ5zBDw/V2UH7qLMeGwhWpAtsVgIe4J8/yFDv9jxyuIEoaqFbxu
         ZoK2FHEOi1E4RoL4UAB1grpS8PL3JF69YbzeO5RwdbkAC3awzsRFXxCe9nWMejpnp5Cm
         dzA+zse+9NejfmX4mzZBgqrgh33QPahfiQ1zCuOwbFz6bZZ9lya9BzsnYyGFbcoP9FS2
         aDFHVnQFw87voI26g8WUYqLdmPd6SoCJRsFz924mkgX0fYCzv5hwOOhpAr78S4JTEJX7
         jEcDFaB/sGl1TV4Qoc1rjyfzJ7/DVMWe8bHpATuE3+NoHG3bpBQRD44a2WotUtHExpgI
         oJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMquTTOroydUsr7NpGwE4Uf+57dZsT0an9Oj32CtfR8=;
        b=ik1WfQEmsung1jL5pe25cHpyt7wT0R1Ja20PwQ76jFBLHsY7vSsXlCJh7PsawZ5pqZ
         fNA6Nqun16dZD1bSdz44TFkOXAChl4GBbRqu54/NXscsGUISHN+Tomz6gYm37UnQeBTt
         +CaBnj/ei3JEyUDdXUOvyhZtiog+g8YXTu+JVD9EVQYdsJmVqsxWn0JC+uD5A3IEO1ZR
         9YLM0DI82W/OBUmN7ZSvCWYCXlWEzfhryUASG3UPUlMpAEx+ET6pStlWTyRKaML0YPIS
         2DIJQIJiy1B5tF1rcREMv6lWTyTenZLpnTPK4ddmxdhnjVaWnreg0wR/EX0Kp8io2kkX
         m4LA==
X-Gm-Message-State: AOAM530AEUikl4XmaPokBYt3MIYzWKp3FFTKI2n85ysXcn8QzE1r7ugR
        SjxThttkH1XPhhKopz2f20U=
X-Google-Smtp-Source: ABdhPJwWyysFynKdRZD0VY9hOFnjV6UDPBdHOAjmGRDCxM5RtZFaijh158j2fm+1nuGW3p3YYPQ0Cg==
X-Received: by 2002:adf:f14b:0:b0:213:b98e:c0df with SMTP id y11-20020adff14b000000b00213b98ec0dfmr23120907wro.79.1654606085298;
        Tue, 07 Jun 2022 05:48:05 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-98.xnet.hr. [88.207.96.98])
        by smtp.googlemail.com with ESMTPSA id g12-20020a5d46cc000000b0020fff0ea0a3sm17523837wrs.116.2022.06.07.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 05:48:04 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>, christophe.jaillet@wanadoo.fr
Subject: [PATCH] regulator: mp5416: remove kernel.h include
Date:   Tue,  7 Jun 2022 14:47:59 +0200
Message-Id: <20220607124759.775133-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Driver does not seem to utilize anything from the kernel.h, compiles
and works fine for me without it.

So remove kernel.h include as it pulls in a lot of unused stuff.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Cc: christophe.jaillet@wanadoo.fr
---
 drivers/regulator/mp5416.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 71e20e8d78ac..82892d71c2c9 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -9,7 +9,6 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-- 
2.36.1

