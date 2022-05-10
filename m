Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591B3520B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiEJChC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiEJCg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:36:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA550047
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:33:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso968718pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 19:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKXi4kzCtIUrl3kGSGIUPwmPCUIXCJvogddZPqVh3dM=;
        b=CMcpe1NTcxuv8ZCDKvGvLbrEMAoQv/2DwWzvjcCDZhIDAI6/SXt0uKeryAB2/lqDmM
         jaUAdIbf71hyFlFT5thPDsDWZJMD3gWmMJka2bqqagtejFTm8yVfNyeY24AnfEDVg97C
         cNiMQUqPJUnu6uKe+ZwPzJij7+9w8NO4BVNAyi2UBP9dYif3ayXkZqoMlaN0FPvmBDH5
         anmd5DTcUItoZa3dc0jM55A5PYxoJ6YaPEszs4LMz3DTmCqf/Vivv+NjKO1QPAtaUf3E
         TRO/ajPgGJ+fitsrhjb2kAh7qSb6cVXetAaEG4fticGih1xCDhFtQsVTFkM6Kqd1GI62
         adUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKXi4kzCtIUrl3kGSGIUPwmPCUIXCJvogddZPqVh3dM=;
        b=IILHzgyyXbopAMOTglzF8XbDDZzrGUVnBBpW3trsHrpdGgpjE0bO/Hmq0iJLvN/5UA
         K8IUfACSxiwPSQnAhSdrYp2LU144Zy3Gwa5QscIaCQH6EZdSnlJAihzeOcJSEQ98Vdcs
         RX7rcwza+dF1jguZIHucCsrKT+TWhLgAL89llM4KBGk6aTGyDwvA5GcNs69jKRcfQ3KN
         FdgRNYfBlun4Ep0xNeZ6WKpvtsGsYXVx90/dCacsMNg7HvCk2zPc+Uaqa7bC6s5beoim
         3fL6KXpJB7y7/hIF1l63f5vWk/3EmGCqcnuPaSgu1KU/stYliBYdaxTcF5PLrwXVhoZE
         s1ow==
X-Gm-Message-State: AOAM531qczL++hisOSbyd+Xi+w0B+Xv1U1YiC4v+NphKMjXWbBVSvLS+
        GvB0Dktvi5RA0CqLjADMmms=
X-Google-Smtp-Source: ABdhPJzWGqpo7OvBidbFMWMlIUvEgym623Dart9BdYAwwmsrXSMMosXc8bjfn/r+9ww7x/hoTmWakg==
X-Received: by 2002:a17:90b:1e05:b0:1dc:575e:6211 with SMTP id pg5-20020a17090b1e0500b001dc575e6211mr28673804pjb.120.1652149983228;
        Mon, 09 May 2022 19:33:03 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id b14-20020aa78ece000000b0050dc76281fasm9426969pfr.212.2022.05.09.19.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 19:33:02 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
To:     linux@dominikbrodowski.net, Jonathan.Cameron@huawei.com,
        broonie@kernel.org, arnd@arndb.de, lukas.bulwahn@gmail.com,
        daniel@zonque.org
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v3] pcmcia: add MIPS_DB1XXX dependence
Date:   Tue, 10 May 2022 10:32:55 +0800
Message-Id: <20220510023255.1283529-1-starzhangzsd@gmail.com>
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

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes from v1:
- Rewrite the commit message.
Changes from v2:
- Give credit to k2ci for reporting the issue.
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

