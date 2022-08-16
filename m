Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836C759561C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiHPJZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiHPJYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:24:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB98D3ED;
        Tue, 16 Aug 2022 00:40:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so12418972edd.4;
        Tue, 16 Aug 2022 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=D6ovg/4qbTNHMCF0lOjAQ6S2imf27/eFQ09R/uSkCoA=;
        b=nv3+t0iYnj3pgnrgw/prtnIe6Z/dh4WvgSeFpPH1+E40TVL6LoPG9beQTQLKIZTEBY
         SdFLR8CQwAm3bagtVtX6kehs94Kls7z9URDyXS+wW9n+isKLwUwm/YHdecbnOt6bb9hz
         HxnO3T3vsFNwXBiKDIaj0dc1mCTogg2mc5WrnHWVong+K/SAhEmcoYoIySN2hhSLF4K9
         jVjj5S6993h0eym9nD6+yZdZMq47xr0UCDhE8Kz5DWkjEmNo/pnQyUlJHIugkEysCofR
         /kWrZa/hBg2JyhlohcFlcpbxyQJBKETNzfhjv1VtUSKqWwtQ95L4Ac60nbUSScXk8J1k
         KHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D6ovg/4qbTNHMCF0lOjAQ6S2imf27/eFQ09R/uSkCoA=;
        b=Ybg76A4zuS6vVX2irCgeiq11ZBQRwyxy4KFj0pto+DQe0GqlHI9GJguCLTCdnRu4eE
         frNub/KfGoATbxsLkoOTJJ6BfTLXZQPtFR62rxilctlo1/QZdGR09OlUw4jDaVqekYYs
         nBRFh58XG/dPu6+7q1JgEEMpvFYPBodEY2vmAmMoWxpFWdoKjMnVY36sMcwhEDQ0VZHp
         hQtge5LoE5g7d4NhWoYJAD5RBnDFabtfq2jruhREmPx9Pihj7aqWphT4eG1PjrWKezTt
         Sok/56nZmW9VTrUBZSJXxrsrDg5R1xCjqrtt4lNwKRVFMtfJUlONS6yKAiDqbfTJB+GI
         vpYQ==
X-Gm-Message-State: ACgBeo1tnYhuVtt1yfQ9/BYcAeVkGD9LbGxRlHuP5Ztr8G9iJ14N2M1C
        Ncn5E8kQHEglMeWycdwyehZdJ6DRRK8=
X-Google-Smtp-Source: AA6agR6FZw/8AxKKuoYH4e0u+CEZIlmzkjrKyfX5w9aIOpYgPmzzWq1Ctslmb5qK2H+7hKEXVy/53A==
X-Received: by 2002:a50:fc89:0:b0:43c:bf1e:165d with SMTP id f9-20020a50fc89000000b0043cbf1e165dmr17175545edq.161.1660635608927;
        Tue, 16 Aug 2022 00:40:08 -0700 (PDT)
Received: from felia.fritz.box (200116b82612cb003523580d29724c22.dip.versatel-1u1.de. [2001:16b8:2612:cb00:3523:580d:2972:4c22])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906339400b00730b933410csm4977031eja.145.2022.08.16.00.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 00:40:08 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for XILINX GPIO DRIVER
Date:   Tue, 16 Aug 2022 09:39:52 +0200
Message-Id: <20220816073952.31619-1-lukas.bulwahn@gmail.com>
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

Commit ba96b2e7974b ("dt-bindings: gpio: gpio-xilinx: Convert Xilinx axi
gpio binding to YAML") converts gpio-xilinx.txt to xlnx,gpio-xilinx.yaml,
but missed to adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in XILINX GPIO DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f69a1c5212bd..7c20a1c9eb78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22344,7 +22344,7 @@ M:	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
 R:	Srinivas Neeli <srinivas.neeli@xilinx.com>
 R:	Michal Simek <michal.simek@xilinx.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
+F:	Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
 F:	Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
 F:	drivers/gpio/gpio-xilinx.c
 F:	drivers/gpio/gpio-zynq.c
-- 
2.17.1

