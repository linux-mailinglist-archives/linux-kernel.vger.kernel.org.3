Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0C51F297
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 04:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiEICJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 22:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiEICGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 22:06:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5973031522
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 19:02:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v11so11030157pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UBgd03YNSMHF2YxZI7eb6ybQEEaYpSlyO0Ot8Fm1Dn4=;
        b=RwTZ8E8Qdlcmn2IDIfSXeh8qA/ZW7KSo4MzH/9AC2ei0ar7lT4yEhHctLBxv7DzClh
         vw4FjcWfr3tE101Vyu9By+KwSSqj+Z/2w7qSmI7ZxI7wxqzVb8Nr14P4qs321iIotbjs
         WVNiUjH1hzgINsKeOpT8pMTS3AB1rGBi/fQjosnt31D93kBkHs0sWKT9xmWYnEk3u5Br
         54WMZYNSOBNk2rr/k1ATmvug8wOLU03YhzkPQkcRZPutQzqwE6/6GwwScdTkPRZ+83cA
         gop3MhucGSnKNoI4kbbrTBirDh5PmDAXw4ykHyjnvIyzSTx1z2CuP94WJyyl/hSAJ4Ls
         aVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UBgd03YNSMHF2YxZI7eb6ybQEEaYpSlyO0Ot8Fm1Dn4=;
        b=AhmjAAzuiL1JqrAaoyrbN3mlkTMDm92iMrsNxPmm4ruN+N+VUjzplPRAhHl78+evNE
         2wYZrciJd74316SpJj3LwtlU3nRKZXpaViD37OpN1QwebF2aOM8KthbFaavOnois7WeX
         i8iD34MjFUed49hQ0i8v5GSgvHIgN851Q7raY7MEj84RsqZVRtGbR4V+lntcTkaNLrjQ
         EiWuIWNyxjWB8S36xyCzhiBzrIQrBTqD0YonlO9REAUbGR86LpYMH2ji3lUChz2Lcg1k
         ffy0+AizmY/deD9KoRPaCbrtEYCyIbCljB6APfmHST7c/PXuX+m+Zd1DrVQOv3deKA3K
         Edaw==
X-Gm-Message-State: AOAM532CwOXkRr76w0a2tbsM0Bxm1B2i+uXUbJHVjiN+zPPZbr3WhLST
        ALGmSzoEP9JZHKya1fbmY4Q=
X-Google-Smtp-Source: ABdhPJxAzUWKLMbuZDA+c+OuAARJhrxCsQ4d4NUeLcLNsVK06gVJdrawbo8qRfxEig208x+K/Bj1ZQ==
X-Received: by 2002:a63:5c6:0:b0:3ab:a0ef:9711 with SMTP id 189-20020a6305c6000000b003aba0ef9711mr11259845pgf.426.1652061750825;
        Sun, 08 May 2022 19:02:30 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id k7-20020a056a00134700b0050dc76281b6sm7608740pfu.144.2022.05.08.19.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 19:02:30 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
To:     linux@dominikbrodowski.net, Jonathan.Cameron@huawei.com,
        broonie@kernel.org, arnd@arndb.de, lukas.bulwahn@gmail.com,
        daniel@zonque.org
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pcmcia: add MIPS_DB1XXX dependence
Date:   Mon,  9 May 2022 10:02:22 +0800
Message-Id: <20220509020222.1219813-1-starzhangzsd@gmail.com>
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

From: Shida Zhang <zhangshida@kylinos.cn>

drivers/pcmcia/db1xxx_ss.c uses the bcsr_xxxx() from
arch/mips/alchemy/devboards/bcsr.c, which causes a link
error:

drivers/pcmcia/db1xxx_ss.c:(.text+0x2b4): undefined reference to `bcsr_read'
mips-linux-gnu-ld: ../drivers/pcmcia/db1xxx_ss.c:(.text+0x2fc): undefined reference to `bcsr_read'
drivers/pcmcia/db1xxx_ss.c:(.text+0x374): undefined reference to `bcsr_read'
mips-linux-gnu-ld: ../drivers/pcmcia/db1xxx_ss.c:(.text+0x380): undefined reference to `bcsr_read'
drivers/pcmcia/db1xxx_ss.c:(.text+0x534): undefined reference to `bcsr_read'
drivers/pcmcia/db1xxx_ss.c:(.text+0xcc8): undefined reference to `bcsr_mod'


So add MIPS_DB1XXX dependence.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
Changes from v1:
- Rewrite the commit message.
---
 drivers/pcmcia/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 2ce261cfff8e..04b51cb67fbf 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -151,7 +151,7 @@ config TCIC
 
 config PCMCIA_ALCHEMY_DEVBOARD
 	tristate "Alchemy Db/Pb1xxx PCMCIA socket services"
-	depends on MIPS_ALCHEMY && PCMCIA
+	depends on MIPS_ALCHEMY && MIPS_DB1XXX && PCMCIA
 	help
 	  Enable this driver of you want PCMCIA support on your Alchemy
 	  Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200, DB1300
-- 
2.30.2

