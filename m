Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA1053F66A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiFGGmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiFGGmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:42:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F1E20;
        Mon,  6 Jun 2022 23:42:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso3109916wml.1;
        Mon, 06 Jun 2022 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=c7fXZn7eLWOLLDVLCIffOLeUzZSMZgrh+9NwAae4wD8=;
        b=q4GUuIQCZxL0eQWg2lcpbiLZoptbLmLs0LH/cRatUYhibi0SzwJAfK/fIZ1TeCJJrC
         LTGBD+4YM1f0Dd4naLmCmye1QTgWtheU+3E6WRxzodAkZ7EhUjL32XwHf1uB++ieSTYa
         BjQDJfo8qelAWkEVwKosy11+ZBIfU9L57v8fyP+Q9HqJ76CbMLHucf4MbxvA7zuq/Hfw
         4OPQ8s2csbO8kHNJgQDHaJVpK8+rBJD8uNGhQOXmUPYPlzMjw9crHAFGgWCHL0fD+PLo
         eIBtgBE4QItHtHkwImtZhiCPHXPuulXkbS/9GAaeWa8R2X8vu0kFiIB4vkTGplEyX7JH
         cOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c7fXZn7eLWOLLDVLCIffOLeUzZSMZgrh+9NwAae4wD8=;
        b=jRyhi7dwdeHfYqLfyEiMPyS1B+daEJj7R9nB5yFf6YKN4C8y0AEvQRuBreq5cija1N
         Pl9FpzAgdnzMN5TmpgAbqxGkd6APlNR9bmDM3cVF56Qb5tq6CTnHJbI3KMqmW5NhhRDc
         ojWY1naS+7zn4Xz7+CKirIBjjMJ1Jbid00WPlUDBzX7BAHu+m72WRb/qdFGvGw1MaSEa
         IDRGQeKP0jzRqyPbgQ2ln3uh4ksMDE4KEJG1xg21pbl4afKOHKeLHvs8KktTkOyLsI/7
         XXuk5KWB7G320qtGLAhPjUx0us7Cah8xLai1x1iAHvqgc7dmUGfgA5k7W5Nl4RMgllLH
         /pDA==
X-Gm-Message-State: AOAM531BPpAzbOnyqOlWuWCCVpHCoFDld0UPTPUrUxPQkeZi2XPKqDWp
        y5/gkKLnZ0XUjE2miLdLakc=
X-Google-Smtp-Source: ABdhPJyEdwLm2b0emQkuqYzZNx6AsZ6IM/0WAAldI0QWInMs5ioKyUJ2E98qZWGsFWO9qC6NWoMKFA==
X-Received: by 2002:a05:600c:1908:b0:394:867d:66c4 with SMTP id j8-20020a05600c190800b00394867d66c4mr55368926wmq.152.1654584159534;
        Mon, 06 Jun 2022 23:42:39 -0700 (PDT)
Received: from felia.fritz.box (200116b8261d85004489eb5274e8e310.dip.versatel-1u1.de. [2001:16b8:261d:8500:4489:eb52:74e8:e310])
        by smtp.gmail.com with ESMTPSA id p9-20020adf9d89000000b0020d10a249eesm18444272wre.13.2022.06.06.23.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:42:39 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify file pattern in MICROCHIP OTPC DRIVER
Date:   Tue,  7 Jun 2022 08:42:20 +0200
Message-Id: <20220607064220.9296-1-lukas.bulwahn@gmail.com>
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

Commit 6b291610dd57 ("nvmem: microchip-otpc: add support") adds the
Microchip otpc driver and a corresponding MAINTAINERS section, but slips
in a slightly wrong file pattern.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Rectify this file pattern in MICROCHIP OTPC DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Claudiu, please ack.

Srinivas, please pick this minor non-urgent patch in your -next tree on
top of the commit above. Thanks.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 572f50739fb2..288393564abc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13119,7 +13119,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 F:	drivers/nvmem/microchip-otpc.c
-F:	dt-bindings/nvmem/microchip,sama7g5-otpc.h
+F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 
 MICROCHIP PWM DRIVER
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
-- 
2.17.1

