Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867675AFD04
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiIGHBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiIGHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:00:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED0F73313;
        Wed,  7 Sep 2022 00:00:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so18860191wri.0;
        Wed, 07 Sep 2022 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3AbvUXReTTM4AVHYC5kqdjEokxzgC2ZBAFH06E7ehB4=;
        b=ZPpmg8pzNU8yYuXM43od2R3D7UP/i+w7igE0ilaWfjoec8donbztt98TfGszzzHHTE
         63iquvB1JlvDtHVQbLOvvqqytHTeYP/Vdthz6z9V/Ryh4IE+iLk0HjCT9ERWikzkzqrg
         ntvR5YV5kIZwFt6Cq4KoI/tLeiaTFFlFZjQgoW4yBOThDDR/RVpBHeXwCSffmWIzMwnL
         t7TrKsg4wJRzWHi+2Yod/R2b3xCE1HgwRlwDR+XOYFFYCmdhiZUkeGyS6ScHYzeb1Xkg
         pBp3S6iI2sXAdKd5vDyLcmr51GnfPWbZUiUHMk33py4d9kjP1sNPBvNGN/7o3OlQvFDh
         3RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3AbvUXReTTM4AVHYC5kqdjEokxzgC2ZBAFH06E7ehB4=;
        b=QbQNmcqGd2ohEpeQLlLlCOr8yZswWO84Zy4hyYblqCuHptcr3IPrAvmV8wk+vWTcMb
         Hu1BmhZXVeK0ZPnMbxTPw0k6BXcIJD6n6o/C4Y+IkyC08zdQNoj+pMaaUHfpPBGU0YB6
         VTCS8aNVNfi/f7gmzbbf+xnfgCG6v0XEUHhOyoBZ8IOwptHMveSRSOXPSXV/dQFwG8zp
         dlrRS3hnyPHN+M2Rv7bvJsW/s5dHjTdw3bhNmA4KRaSv+v30Vwongqt1nE8sRBCyZuI3
         IfydQPtAfOgRd7fUtMisTTVFSCo9jjo38eWWLd0pn1ZJ5pRvVKbAE1+XF5Lf2dDtjTNi
         708w==
X-Gm-Message-State: ACgBeo05MW4gHTAVIgmd757Nq4aWJ9MnZVNJxT4+CERtt+j5xr6Hr5Yk
        UV6aLTVRE4I2TryKj9EjDIc=
X-Google-Smtp-Source: AA6agR4lbx546dnFZXjh/JPS+dXfFLv+RB2Q2d+U/Cx+nWVHSNR4c6WQDWULzEuim6fgFJbC3a1D8g==
X-Received: by 2002:a5d:5c08:0:b0:228:e139:43f3 with SMTP id cc8-20020a5d5c08000000b00228e13943f3mr1004599wrb.396.1662534044533;
        Wed, 07 Sep 2022 00:00:44 -0700 (PDT)
Received: from felia.fritz.box (200116b826d16800c8aacf399f0c2a06.dip.versatel-1u1.de. [2001:16b8:26d1:6800:c8aa:cf39:9f0c:2a06])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00226dedf1ab7sm10576303wrt.76.2022.09.07.00.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:00:43 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     William Zhang <william.zhang@broadcom.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] leds: bcm63138: refer to ARCH_BCMBCA instead of ARCH_BCM4908
Date:   Wed,  7 Sep 2022 09:00:01 +0200
Message-Id: <20220907070001.19867-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA")
removes config ARCH_BCM4908 as config ARCH_BCMBCA has the same intent.

Probably due to concurrent development, commit a0ba692072d8 ("leds:
bcm63138: add support for BCM63138 controller") introduces 'LED Support
for Broadcom BCM63138 SoC' that depends on ARCH_BCM4908, but this use was
not visible during the config refactoring from the commit above. Hence,
these two changes create a reference to a non-existing config symbol.

Adjust the LEDS_BCM63138 definition to refer to ARCH_BCMBCA instead of
ARCH_BCM4908 to remove the reference to the non-existing config symbol
ARCH_BCM4908.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/leds/blink/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/blink/Kconfig b/drivers/leds/blink/Kconfig
index 945c84286a4e..bdcb7377cd4e 100644
--- a/drivers/leds/blink/Kconfig
+++ b/drivers/leds/blink/Kconfig
@@ -1,10 +1,10 @@
 config LEDS_BCM63138
 	tristate "LED Support for Broadcom BCM63138 SoC"
 	depends on LEDS_CLASS
-	depends on ARCH_BCM4908 || ARCH_BCM_5301X || BCM63XX || COMPILE_TEST
+	depends on ARCH_BCMBCA || ARCH_BCM_5301X || BCM63XX || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
-	default ARCH_BCM4908
+	default ARCH_BCMBCA
 	help
 	  This option enables support for LED controller that is part of
 	  BCM63138 SoC. The same hardware block is known to be also used
-- 
2.17.1

