Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD374C8991
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiCAKoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiCAKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:44:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBC48B6D0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:44:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cx5so1166491pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmdWZ0Ngl9nlWWgEJzu97RHRmPhanMjm7buTdrAowbQ=;
        b=QnSZWYzZdu9pqqIrseh0j/wMKrMxCoz1ovhyc32RMroAy9PX81dIaqyWXzuBcd+Ing
         38+fyN5e1R5RX5MjBQ2hFz81qRwouo2brDxy+SavYZ15NksmlfWinKxuEjsCXLX1twnK
         2M/vcNiXIbmFtFvCY2cHvFLR2XHsbBdBzUOL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmdWZ0Ngl9nlWWgEJzu97RHRmPhanMjm7buTdrAowbQ=;
        b=sobFuJAhErWITw+0/gkVuXE/1kwxKSKzZPGeSGfwBgtbAK9qysH6gnOBtClKY0Ft18
         CSKr08GmmxSbSPYjKn0wU0UFIjbD1PafBdqxaqWdILheVk6vWr5s3ogJgU5a88rh13H1
         LDvczzgI43i13JwVP3Xg0XmGT4RBpsX3rHfWw7uaa/ODzt54GCt0nPpxPrtCJjzgyeRC
         L7HrDE9QI/ztGiQrPdOnp8el3/QOMYTp5xVHSH6zxOLpNH7OSs1urfSdo90iB+o1E3k4
         o/togQfZo0hkj+Bd8D00bIob/vFrHPJ2KH/lqgsNsMEpzyaFBGzNZKZ1cVZzsrMmUaCE
         tQmA==
X-Gm-Message-State: AOAM5328lcaPsutf/+egzhtCt4bVyoztKFMqvMsJqTMSb4ZRPXD7We+G
        1ZMMlQij3RYmchMJQWFaprL3vQ==
X-Google-Smtp-Source: ABdhPJwrSX2GUxypOi5r5JZLVm6VZm/peM4ozIYt2gLhPM/CN+YBAry5prx9rHsksurFwbXdzwGRCg==
X-Received: by 2002:a17:902:cf02:b0:14f:e0c2:1514 with SMTP id i2-20020a170902cf0200b0014fe0c21514mr25090497plg.90.1646131440627;
        Tue, 01 Mar 2022 02:44:00 -0800 (PST)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id m20-20020a634c54000000b003739af127c9sm12832867pgl.70.2022.03.01.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:44:00 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, arnd@arndb.de, olof@lixom.net,
        romain.perier@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] ARM: mstar: Select HAVE_ARM_ARCH_TIMER
Date:   Tue,  1 Mar 2022 19:43:49 +0900
Message-Id: <20220301104349.3040422-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mstar SoCs have an arch timer but HAVE_ARM_ARCH_TIMER wasn't
selected. If MSC313E_TIMER isn't selected then the kernel gets
stuck at boot because there are no timers available.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---

I moved one of my CI builds from a 5.16 based tree to a 5.17
based one and it stopped booting. At some point I had broken my DTB
so the MStar timer wasn't getting probed anymore and at
the same time the arch timer driver wasn't getting built in.
I'm not entirely sure why the arch timer driver was built
before but isn't now. Anyhow, all of the other ARMv7 machines
seem to do this so I guess it's right.

Arnd/Olof, please apply directly if acceptable. Maybe this should
be in 5.17 as a fix?

 arch/arm/mach-mstar/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
index cd300eeedc20..0bf4d312bcfd 100644
--- a/arch/arm/mach-mstar/Kconfig
+++ b/arch/arm/mach-mstar/Kconfig
@@ -3,6 +3,7 @@ menuconfig ARCH_MSTARV7
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select ARM_HEAVY_MB
+	select HAVE_ARM_ARCH_TIMER
 	select MST_IRQ
 	select MSTAR_MSC313_MPLL
 	help
-- 
2.35.1

