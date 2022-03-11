Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8398D4D6221
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiCKNLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiCKNL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:11:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B681C230E;
        Fri, 11 Mar 2022 05:10:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h15so12874288wrc.6;
        Fri, 11 Mar 2022 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ifuiYsfaZmXujhhjdnLGqkFWQ/ohB0GeELLEYUmC2Ro=;
        b=Da9XXFi60VvRHH8Yzcn8N5oz1mPAi4o7TexgydtetpRGNxTKZwD/SZT2wemiyZYTJs
         r1cjTiLN4nG1ULIMV3K6Yi+6hrhey4qdqB/DxGqXSo7GFIPDgrO45gnpOLv87DaALjQv
         7z0iR0cGb8lhFHrPO6yY1Y8leQg0TPy3I9HxaBNiuOiPGD7GYLXz98+NhYPccVj19zhb
         92FkqCJlD+buFnh18dsLjwDwR4GTkvrghyUln7qJBkOwMmVwlr6X8Ugbpl+EMDNuJaxb
         hqmlzEXS7ojFUojtQkooC1CIornXfqvvDWG/hRHWWrbfrxUqP2RhBqg8AJ0f7uc1wddG
         49aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ifuiYsfaZmXujhhjdnLGqkFWQ/ohB0GeELLEYUmC2Ro=;
        b=vu6TkpE5xOeqrIHuVopPrTWVE0bOeh6wdWE9wu6JFq/8w2GSG7q50LxpIhtqvDqsJb
         R0j10pD1ls4G8RdtbX82Aw2GCyfUqdSMKS6rJlt86HWAqQiZd/tVvj6MXw50WyPE7HWX
         5IqKm4UV0VuJrR9p+4o+CPquTMqAFm8ykeX3QwAa5SlPvPnLblarBIW5QiHf6dSHAB9w
         CjitnB/GWAt82Dh8H9Mqto47Znlx3zDQ6g797p6Cwl6cEdtgTtNyCv93AOv16cP16tOC
         pzTkNH8ugnz+3u0WkfprQfF0Bv9WDTPQqXiNLuMWDCrVPB+EFeeOTWROrXx9mqfmFQts
         QI6Q==
X-Gm-Message-State: AOAM531xYKSTkiuA/6vjQ1QwzPuJCkGIRhN1rH1OvxU4Fuw5HUkz50zk
        6jLnwDAM7wbtXJplcXRN3xI=
X-Google-Smtp-Source: ABdhPJxnhIX4FNkmpQCGan7ANCBMmiZgwwCSIIz3zRWvpgP/Rp8upFTo/ZOYgr2xBSbtS7Ij8OkRNw==
X-Received: by 2002:a05:6000:143:b0:1f0:25a1:874c with SMTP id r3-20020a056000014300b001f025a1874cmr7220705wrx.191.1647004221946;
        Fri, 11 Mar 2022 05:10:21 -0800 (PST)
Received: from felia.fritz.box (200116b826a9a900147fc2a0771e144b.dip.versatel-1u1.de. [2001:16b8:26a9:a900:147f:c2a0:771e:144b])
        by smtp.gmail.com with ESMTPSA id e4-20020adffc44000000b001f1dba38a65sm6581325wrs.105.2022.03.11.05.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:10:21 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: drop entry to removed file in ARM/RISCPC ARCHITECTURE
Date:   Fri, 11 Mar 2022 14:09:56 +0100
Message-Id: <20220311130957.17884-1-lukas.bulwahn@gmail.com>
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
Ard, please pick this minor non-urgent clean-up patch. Thanks.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02a75dd04187..d0df1309cca2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2606,7 +2606,6 @@ M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.armlinux.org.uk/
-F:	arch/arm/include/asm/hardware/entry-macro-iomd.S
 F:	arch/arm/include/asm/hardware/ioc.h
 F:	arch/arm/include/asm/hardware/iomd.h
 F:	arch/arm/include/asm/hardware/memc.h
-- 
2.17.1

