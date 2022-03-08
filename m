Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010874D167E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbiCHLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346645AbiCHLoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:44:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282B13E97;
        Tue,  8 Mar 2022 03:43:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so1301102wmq.2;
        Tue, 08 Mar 2022 03:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BD9aL/dk972NeBQAccfFJoKozgGlibcPRxYjlFBN04k=;
        b=HKZd76acvxhuP1BW/RDw2oDbrADj7nvmM0wYNYDB9G0smXzeJyRazrshA1yYwkV0Io
         jPRxoZHjqxwNrFCPAhOs87KulQ168F2ZIJA0dL0sDnelfLoaryk3z7sTS7+YsqQU77Aj
         RrYMwXqAaQ0bgXsewEEmdgdnW1oGu6SFAVfbLViM4ZT+exZGNVslMW+zPMmjv2Q2rnXr
         IZggZAqSVMT2pQSJja8yxysD17kcg9XkJwV03PCpHN8O0ICv8z/xpxlK9/qG2Jg/kqf5
         yTPUZzMSfAewV+2GHkRYkqYyI5WnWSX86TeX80dVyDwy0d1Svc9BAN66Z4xh5ccw8RM1
         RwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BD9aL/dk972NeBQAccfFJoKozgGlibcPRxYjlFBN04k=;
        b=BdbacgkmaGF2vO7VogZGveKGnEffK4IYaQujqOe5BG58pOHQ4gNrSJJWirNr8fP7Zt
         3hO5uMQLec5jp6Mw2nipI4ZhZobDJ/oJ2yug7zEJ2Y/JZOHqyOXWOPpUL3O6ilfxjeLc
         D1K3BBxGLYsNXeMQJ4JLYDLEz0t6uD1ZgJXJ7vDBJU1NARfFX9Z1UevzOMb2d4uD70RQ
         WJpQfkZA1wbr4P88FpYZospcxPnmoRWTqO9DZ4IC8FrGjpLjhRSBf/PhIzBhgbeygHYW
         2FNDfLxUmQZ5TXmKe0pA01friRXDWO0AE6InOA1PX1lGulWiXSJtIkNCbhUoYk6mZR2V
         1S3g==
X-Gm-Message-State: AOAM533L/ATY3KREn3brt7yAOIFAKzXu2Krw0zhGEfKChxK4miDx9Y8r
        /+3eGDhswNG1fK8KDarVw98=
X-Google-Smtp-Source: ABdhPJxHS9QZHXHiJbg8LL9woOu+Y9wLufJJ6DmZ5EISoQGuEpYGXYx9AX/nNTbePJ25NMWVKuvkpQ==
X-Received: by 2002:a1c:4489:0:b0:389:8b0f:9a67 with SMTP id r131-20020a1c4489000000b003898b0f9a67mr3202144wma.40.1646739794391;
        Tue, 08 Mar 2022 03:43:14 -0800 (PST)
Received: from felia.fritz.box (200116b82626c9000cc91df728b27ead.dip.versatel-1u1.de. [2001:16b8:2626:c900:cc9:1df7:28b2:7ead])
        by smtp.gmail.com with ESMTPSA id p11-20020adf9d8b000000b001f063deef80sm11773169wre.86.2022.03.08.03.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:43:14 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Bin Liu <bin.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RFC] MAINTAINERS: drop unreachable contact for MEDIATEK JPEG DRIVER
Date:   Tue,  8 Mar 2022 12:43:00 +0100
Message-Id: <20220308114300.12502-1-lukas.bulwahn@gmail.com>
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

After sending a patch to Rick Chang, the mediatek mail server responded:

  ** Message not delivered **

  Your message couldn't be delivered to rick.chang@mediatek.com because
  the remote server is misconfigured. See technical details below for more
  information.

  The response from the remote server was:
  550 Relaying mail to rick.chang@mediatek.com is not allowed

So, drop Rick Chang from the MEDIATEK JPEG DRIVER section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---

If Rick Chang is gone, pick this patch.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c7e40e1215e..02a75dd04187 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12334,7 +12334,6 @@ F:	drivers/iommu/mtk_iommu*
 F:	include/dt-bindings/memory/mt*-port.h
 
 MEDIATEK JPEG DRIVER
-M:	Rick Chang <rick.chang@mediatek.com>
 M:	Bin Liu <bin.liu@mediatek.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek-jpeg-*.yaml
-- 
2.17.1

