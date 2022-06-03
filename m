Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3070B53CA81
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbiFCNO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbiFCNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:14:24 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59292DA89;
        Fri,  3 Jun 2022 06:14:22 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h9-20020a056830400900b0060b03bfe792so5482823ots.12;
        Fri, 03 Jun 2022 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCnbF91LIkxHhaVG1Alz8mNBG7NVUai+EV3oRdthdwc=;
        b=epaLeTStOQVQYmyc06vyKPPmUEuubF/tg7w534cTgzzVx2tPJL/ZnYn1soMrzu57E0
         nIxFlixwXwZN219KY+LIw7+FTp1qQceiltp3eeumhoeyD4WK9XNO/u2Ik+e6dyz1VgW4
         Ln2G3FidUo0WLdPf9MNJKjNfR7mg2oB0tuNH1Mj6/brEnJ4sHXK8w0q/Rj8pM/x2mVcd
         GMd78NM38faYaqn7umXeLkvGJbG0Q/vjg1dc+gw6vME3SdWFGfimEKEhHyks3FYPO5+O
         FgbEQ2JWTJ2PocwCKTgSIyKt2PxQNQbQtLoDO9KatvCVPeA+0XSA/IGuiBmL2Opj8rCN
         JdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rCnbF91LIkxHhaVG1Alz8mNBG7NVUai+EV3oRdthdwc=;
        b=yk5jRnB3xUTggNjvTK82AayYnAlq7+bP1sjcZkZ1bUeiRliS9ap1nMgPQPSE33ofGn
         39sOwlwlJRJKKgMe0fGCGpL/9bs13kMdMqDv9NaW9CaPdfafhdEp1NxWWqvMQGET201j
         xFlWBNpBsEgxNJ8YGGbcZwmxrLsxo7UBKcTJhNL5kYy/XcT7VtTFXeAcjFeWeAgMvdim
         5hZjytIh/oLHJjM9slrfY//p0QOVAfxmJbZwx/INXKkLMTr685Dcmich6gidJJRsgidW
         oAKoTHlvldXqFaxL3Wz2pt1fQb5EsWXAaEL9Lh1W/2saYXrG9RLk+HMUlwj3RL028ePP
         pfyg==
X-Gm-Message-State: AOAM5320RLgZpx+be9eQv80Lm+Crj7RqqfSL08vE78TwoCO2KUczRW1p
        VDcdVVaUvR8UR3E9tcU+m/g=
X-Google-Smtp-Source: ABdhPJzLtEwQ/esm74d/F634Zk44P3yo84Oy3SfH5ELpHgfOwaQKdIcDChbPMdKw3xr6O3VY+K5ibA==
X-Received: by 2002:a9d:6a8f:0:b0:60b:c33f:46f4 with SMTP id l15-20020a9d6a8f000000b0060bc33f46f4mr2881236otq.296.1654262062300;
        Fri, 03 Jun 2022 06:14:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13-20020aca240d000000b00326d2cba5d3sm3940151oic.8.2022.06.03.06.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:14:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Jean-Marie Verdun <verdun@hpe.com>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] watchdog: gxp: Add missing MODULE_LICENSE
Date:   Fri,  3 Jun 2022 06:14:19 -0700
Message-Id: <20220603131419.2948578-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build system says:

ERROR: modpost: missing MODULE_LICENSE() in drivers/watchdog/gxp-wdt.o

Add the missing MODULE_LICENSE.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/gxp-wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/gxp-wdt.c b/drivers/watchdog/gxp-wdt.c
index b0b2d7a6fdde..2fd85be88278 100644
--- a/drivers/watchdog/gxp-wdt.c
+++ b/drivers/watchdog/gxp-wdt.c
@@ -172,3 +172,4 @@ module_platform_driver(gxp_wdt_driver);
 MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
 MODULE_AUTHOR("Jean-Marie Verdun <verdun@hpe.com>");
 MODULE_DESCRIPTION("Driver for GXP watchdog timer");
+MODULE_LICENSE("GPL");
-- 
2.35.1

