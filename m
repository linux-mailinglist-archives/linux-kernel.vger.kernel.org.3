Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB154997C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbiFMREZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245278AbiFMRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:03:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC525E98;
        Mon, 13 Jun 2022 05:06:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so10735346ejk.5;
        Mon, 13 Jun 2022 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4LnRhv1XPrMRe8LfEDMdb6UDXnn4Q/sdmLV0dEK7deY=;
        b=UqgXUl0TeLu1MpsMQdmPvuijUskO1t1tDAnQ6bBiySAudym3qS7EU0QLabSP5as8Xe
         suhhupJUDJZLSsvfc4pG3yu2KtQw4hB7RZTBz16eJuRUmV5l4M+/DNrDXhj9QC6tTE15
         mUYdvDP316xdhKLh/mJRUP258SM6O8rOsAaCAPJ5xVuDeABsyksgTLhCxM59f9yByULo
         x3C1MN9xBaDrWTlB6Ft5z0Xg0bjdRQH6D+a0T7aSBY7P/UMXJ+M4r3t2gfymKY3E2URO
         YNurm6zvuwyMWpCjKWRBfAyqhFKxxUVumKFrDfqyYXlAjqn/Jr6RPkNp6mUKYgIP9AWG
         qVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4LnRhv1XPrMRe8LfEDMdb6UDXnn4Q/sdmLV0dEK7deY=;
        b=e9KWodZ3JcrpNMC1X7jMFQmuIwsfmofsut3LRao4yIuTrdYcx+DNSGy/AqiXCDb6A+
         Irguwkl4R+ltM3ds/IZURAaXo41ctNeZx55GqvjejPVQ87Yh6D3Z6Jns5993CFOR07eG
         JfnunxWUpknCEagvzau88g7O9Xe2Dyj0AfF5GzXpmuA0pgISRwICy7QiHROELrDsknyo
         m0ko0DL9Dh6tYc4eDBnhl9vqsEv9BHEETDnk7awM1lwD2DiiKR0e5ra/OX/E4x/6/dIq
         wG9s1B5UC7Q26n8cVmyP7G/4LuMe4OKN6LZI+DXb5lITjKYuVfdOQ4Dh3bhSEqzap1Xj
         Qy5A==
X-Gm-Message-State: AOAM533CFc4BM4jt1gaUYK14waaL+6oGnY/LpBrYcWabkWBDmgG5Mpdy
        FeRHfU0r+4TKnp8l1w504wE=
X-Google-Smtp-Source: ABdhPJxbC/VDYi14hJYSAhGxiokYiyjH34mvR54EXqXa9KCYwRaGxFtjmard8oXdYegd/j2FaRztzA==
X-Received: by 2002:a17:907:97d4:b0:711:cf0c:c220 with SMTP id js20-20020a17090797d400b00711cf0cc220mr35688150ejc.269.1655121963907;
        Mon, 13 Jun 2022 05:06:03 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id j5-20020a170906430500b006f3ef214e0esm3738751ejm.116.2022.06.13.05.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:06:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/leds to LED SUBSYSTEM
Date:   Mon, 13 Jun 2022 14:05:55 +0200
Message-Id: <20220613120555.2859-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/leds
are also the maintainers of the corresponding directory
include/dt-bindings/leds.

Add the file entry for include/dt-bindings/leds to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Pavel, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30f80e8fe775..856ac3231a54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11208,6 +11208,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git
 F:	Documentation/devicetree/bindings/leds/
 F:	drivers/leds/
+F:	include/dt-bindings/leds/
 F:	include/linux/leds.h
 
 LEGACY EEPROM DRIVER
-- 
2.17.1

