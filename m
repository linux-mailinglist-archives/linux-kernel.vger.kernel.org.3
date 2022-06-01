Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC949539C67
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiFAFC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiFAFCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:02:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725BACE06;
        Tue, 31 May 2022 22:02:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t5so594972edc.2;
        Tue, 31 May 2022 22:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=CJfkExmQybsu5ozSrsneWDXvP42mt+s6pSPZLC/iiC4=;
        b=Yv89hL1H4RtELSP5V7YOlyWrV7eT/5EcKFQDg7J4tMthPjtSpJjna99D7bU4StQCct
         ofBnxaXFMcvcIXhct22w3Ss6BtrlZZ6NYEbUSoSsKxDRWm0Yafc8b6SdGMLu4XTkN/DM
         lrkaPNR5uQ5LcvtUTmO0svSJVVAIeJR9ePv54+b4qoxhfToVkMemIyaLS1Bj1XQkfGJK
         l6TS4466ayKaaVNwQmCw4kij8JN73+d1yv4XrRO+Yt5b2yflg7mvPK5dHiPL7i89255p
         XoEIf2R5LczKSY1Z5b7cLobHVDAz8Tvq+a4KQ64Egn2TJIj4KZ+HVxO2vGs/qYKQrHkV
         YBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CJfkExmQybsu5ozSrsneWDXvP42mt+s6pSPZLC/iiC4=;
        b=KtnUdrqLAMes2fa3LpQef/4d1lDly6/gR2VRUCBcY+sdgCFLMvxVq8Y7WQrvOnKPBL
         BbeXbTikysORgOzMoDnoPSqimbu5c+KVqHlm4sHnw1+brZ3e1t+eYkV30GNl+PPfGVEf
         NhbPE/nIQ+DOGIvCbX0mI3E77kzzrHNfT7GKWTKZ7FF0SeeUtleOE3LD4CZtvQS21m25
         nnLYtJmT2N4bwIvKAoPEhb9stM7P/Td+5qA7ceaocRC4BEXTgJv52QQOUEj7quwf3y8a
         5A90OQ5YyibnKvvKOpSPe01CKCKWIV+sXoSSTxBS6BxsGyETWUij9X18WSQ3j36Lhlfv
         Gq9Q==
X-Gm-Message-State: AOAM532m5MMK71EcceuwynA8YG2noXTB7z6MAELV210vW7rl7E7xfrh5
        X3++th31uBe06Q0L3S7LA6E=
X-Google-Smtp-Source: ABdhPJy2RSUsqtk8q2SsKPLoUzAqx7++3R0VGDBvyxuzHwpb9rQUrUhXbtI5b6fHNlRCtcoqt7+AOg==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id y13-20020a056402440d00b004129e8a5e51mr66929429eda.362.1654059740934;
        Tue, 31 May 2022 22:02:20 -0700 (PDT)
Received: from felia.fritz.box (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de. [2001:16b8:2620:c000:28af:8878:8fa7:d286])
        by smtp.gmail.com with ESMTPSA id er14-20020a056402448e00b0042dd05edeedsm336718edb.17.2022.05.31.22.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 22:02:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust ARM/INTEL IXP4XX ARM ARCHITECTURE to ixp4xx clean-up
Date:   Wed,  1 Jun 2022 07:02:00 +0200
Message-Id: <20220601050200.22213-1-lukas.bulwahn@gmail.com>
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

Commit c83227a5d05e ("irq/gpio: ixp4xx: Drop boardfile probe path") and
commit 155e4306107f ("clocksource/drivers/ixp4xx: Drop boardfile probe
path") remove files include/linux/irqchip/irq-ixp4xx.h and
include/linux/platform_data/timer-ixp4xx.h, but miss to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Remove file entries for those files in ARM/INTEL IXP4XX ARM ARCHITECTURE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Linus, please pick this minor non-urgent clean-up patch for ixp4xx arm.

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58e751b9346e..e0f5895feb6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2196,8 +2196,6 @@ F:	drivers/clocksource/timer-ixp4xx.c
 F:	drivers/crypto/ixp4xx_crypto.c
 F:	drivers/gpio/gpio-ixp4xx.c
 F:	drivers/irqchip/irq-ixp4xx.c
-F:	include/linux/irqchip/irq-ixp4xx.h
-F:	include/linux/platform_data/timer-ixp4xx.h
 
 ARM/INTEL KEEMBAY ARCHITECTURE
 M:	Paul J. Murphy <paul.j.murphy@intel.com>
-- 
2.17.1

