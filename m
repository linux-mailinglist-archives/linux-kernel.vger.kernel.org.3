Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD13572C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiGMESA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiGMERw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:17:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF985D9E16;
        Tue, 12 Jul 2022 21:17:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id va17so17806469ejb.0;
        Tue, 12 Jul 2022 21:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=MAwaURqcRpusNRl3AIB3mDLAkAjWXQjGjCMsVfkKjiM=;
        b=SHAihmGvWkE8qpEv25473rAGVNxGa61bY8JpoBaWp+8MeHkBmpu1xaKFY4tD1zGApG
         HVtsvWZIVpYhHUlpGPhYS2VSECPp50yZaeq1+fAV/JQn493YrOb0G3YjRIQ5x5kwByoc
         ytPA/ogIvjCE9VQaYcV5eWpv6EwC81oPLVgFZ0yc0dfYIDbI80HTZcv65W6iZT58+5u6
         +7AlQnsR11xU8Q1KEu5ZRP8sBf32dKlm1QvtILh2kkX6BDqwaRHK4MP+4eXoRMnbqDV+
         eI8vTDzz6mJTU+a0//MHiAzSSEmjuUL004Xgl1o1pyyMAIOxoq4Mk7Jw+xicTMAH+xZu
         fwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MAwaURqcRpusNRl3AIB3mDLAkAjWXQjGjCMsVfkKjiM=;
        b=1Yt4UY/sEa8+Hm8VrIOG7ii912Vs7VDwT1fjOBgQ92fHPXQd5YEYqEhnpCLLM9/34m
         /ey6nCtqXmDW9sIclhe+Uku2V8NGu5L0GNhEJCDHy18Y+UC0c+GqFT27OVgd0dxVRbqn
         gxhFn3LuAa3gpbq+E6Pzql3PT/Wv8nPRprTMQ8sCMld4jgSLua8E/4DWMwNCLJk9D8tK
         RrCOAwe6xULaNeAHmlxiW19m26B+xf+snXiYTwkFOYqeo8/zYRHrj+5uoceIhIDZwE8b
         aJLxLBY0NlmQLmgiuJc2rbUfCIKR13DQcD8Ili8UXs3rNrX1psZIi71rsP08dMye7mTx
         E9OA==
X-Gm-Message-State: AJIora++sEGBlS0JiUZkyZ+YbJ6OHzOnx06kIs1gifRkNEFpRD6LtZyk
        LywE6vWyd4nPkqDfAJ86HTQ=
X-Google-Smtp-Source: AGRyM1vC7+7aeJHF+wLpsnF+8rObPlM9ui7JrN3XWlslx+0t/pBXJyqA6DX74NdxdrAjc/baJm81MA==
X-Received: by 2002:a17:907:6091:b0:72b:88c5:2a2f with SMTP id ht17-20020a170907609100b0072b88c52a2fmr1384552ejc.715.1657685870242;
        Tue, 12 Jul 2022 21:17:50 -0700 (PDT)
Received: from felia.fritz.box (200116b826b4e8009cf80f75265d524b.dip.versatel-1u1.de. [2001:16b8:26b4:e800:9cf8:f75:265d:524b])
        by smtp.gmail.com with ESMTPSA id kw11-20020a170907770b00b006f3ef214e27sm4539772ejc.141.2022.07.12.21.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:17:49 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] MAINTAINERS: drop entry to removed file in ARM/RISCPC ARCHITECTURE
Date:   Wed, 13 Jul 2022 06:17:27 +0200
Message-Id: <20220713041727.8087-1-lukas.bulwahn@gmail.com>
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

Commit c1fe8d054c0a ("ARM: riscpc: use GENERIC_IRQ_MULTI_HANDLER") removes
arch/arm/include/asm/hardware/entry-macro-iomd.S, but missed to adjust
MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Drop the file entry to the removed file in ARM/RISCPC ARCHITECTURE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
PATCH v1: https://lore.kernel.org/linux-arm-kernel/20220311130957.17884-1-lukas.bulwahn@gmail.com/

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5aeaddc9539..a783ef8f58a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2652,7 +2652,6 @@ M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.armlinux.org.uk/
-F:	arch/arm/include/asm/hardware/entry-macro-iomd.S
 F:	arch/arm/include/asm/hardware/ioc.h
 F:	arch/arm/include/asm/hardware/iomd.h
 F:	arch/arm/include/asm/hardware/memc.h
-- 
2.17.1

