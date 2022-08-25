Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CC15A0E44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbiHYKqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbiHYKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:45:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFD975FC1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:45:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kk26so9011442ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=B74MyhI1tqmo0N64Inyl8esUuDcVbj2gBgBeF+qJP5E=;
        b=PZHIXpE/xPX9CT5ZHM4d+9cCdZN89cD4SQNr8YhLlIMieRHKGykVgI+jDOMzDRroGc
         AlfdL1r2it8Bf5eh/N0PkHr697t49G8rxXovx/WzfdLh0mIrWqJZiAlyzGuOl4Bw5r/Y
         /7mvd/ZQEx/Zi7eSclX7RKQ9uxLgBYQkqNZc1ONafRO1ZhouYsLVUoSWOZlCHBrOa+gM
         nQV4wqFq2t0UhN9+2xUcVJdEkXgi/2lZXF2Wppr1x9MgzzrNTjIZlzh9BP24cHbiB4BK
         mB+n6e1+PFzfrafCTG4+5BiJuKuz2+0mGNkIaJtdou1Y9m71b/lTLktdnsTsqxQOwUmo
         dhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=B74MyhI1tqmo0N64Inyl8esUuDcVbj2gBgBeF+qJP5E=;
        b=qDtWBt7t5OSpcaQTrdJFUE1dgrdGSjkDzF20gUnP7V1NIHHQrvRBUldenFbC5y9oxW
         F0juvp0X1k5n7kH/f3ZKYClFqP53eK5kRw0kJjE79VvMiD7tVOyycSAi+wmn4pKcWrSv
         P0C7JEzp6gxB7nGtxL/tpqnvwvZdrdSoA5p2BCFpBAEUNNPY+gTJLafx9CQvg2DJut6F
         lmBXhKd6IR0c2Q6XueUlcWvn3BBvyDz1/tw0/+2WPN8AI9NHlg/OpECioLnzD2bPfIss
         9fCKx6HLK9BnVXsJ7t8OhlaEDEvIdknNC6HnU/cStbgI54/EbtI8moXAQxKr/y8itthh
         3zTA==
X-Gm-Message-State: ACgBeo27Uh2zZsNSTNw4byoi8Xd8MB6UQ0BrzPlYaH0o6PnxSJUbmCOv
        Ld/v69Kt51coKPx3NXBnLYmoK351ei7Vvg==
X-Google-Smtp-Source: AA6agR4qLgr5vYaOZYjvjciwtlrfRGqpaImV9NhFTR1KXt+7nKJDpKyq7HWhpthJ3AbnmAAYa4mG+w==
X-Received: by 2002:a17:907:7e9e:b0:73d:ae12:5f11 with SMTP id qb30-20020a1709077e9e00b0073dae125f11mr2132957ejc.176.1661424315701;
        Thu, 25 Aug 2022 03:45:15 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:1164:5cc1:3e9e:c41c:ad2b:22b0])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7d3c9000000b00447c89a63f4sm341700edr.35.2022.08.25.03.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:45:15 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH] dt-binding: gpio: publish binding IDs under dual license
Date:   Thu, 25 Aug 2022 12:45:05 +0200
Message-Id: <20220825104505.79718-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes gpio.h DT binding header file to be published under GPLv2 or
BSD-3-Clause license terms. This change allows these GPIO generic
bindings header file to be used in software components as bootloaders
and OSes that are not published under GPLv2 terms.

All contributors to gpio.h file in copy.

Cc: Stephen Warren <swarren@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 include/dt-bindings/gpio/gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/gpio/gpio.h b/include/dt-bindings/gpio/gpio.h
index 5566e58196a2..f8df7511b8b4 100644
--- a/include/dt-bindings/gpio/gpio.h
+++ b/include/dt-bindings/gpio/gpio.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * This header provides constants for most GPIO bindings.
  *
-- 
2.25.1

