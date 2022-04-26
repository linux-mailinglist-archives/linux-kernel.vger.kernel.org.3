Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0D950F120
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiDZGiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiDZGiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:38:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F17270D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:35:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso1648128pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsxxmMpYiSWcAhtj5+OuqmggGxrIXpA+UsxQ7ABN67M=;
        b=j5TQZ2g999dmM/MQYRIDRQBOnysL/Nqn8YY63eeiuM3Gz+JXmrsfTqFQX+t55FCp5u
         ic66KPy4x7erupcC7rRSEL4e+bc+HxVWJWZUQYl85JbdctXGYVTE61k1g9Y/Xv7tB2yj
         THd4xnEvQVZK4bG0T9Y4bc/b8ucM8i5a/6b7t630upBJ+queuwDBbfmyk50nADPtYbry
         ipa6jxu6Kb+5qIfXExWrgAirac+AJN45R9t+kx8GvnktP6GQtJ3+7Q6z281nJXl3KweR
         +SspRygsMDXPROnKTOyZngUu4BmWDl0fJOyO/yG+kIauFmjAlSc9kp75a6y4yuQvSIce
         6Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsxxmMpYiSWcAhtj5+OuqmggGxrIXpA+UsxQ7ABN67M=;
        b=xjluAVPGXmtfzIcD+4+PaYENKB3Tff8gVyTh5fuyiHdPDlx2COrWAqmuZioBrTzKYy
         n5sN5i6wqjIB9Okohjszj58nEa1nN/GEN8rORDosXuTFtnZCe2AajMlkzCG0O3fLxwrG
         cz/19318q05t4HXpVYCoEMIMZLImuK1Gtyqehz6aba3YL3btvtPNCc33N0x/D3mBDAiu
         9+cD4FoILDWUQQpBKYNvDo4xHdD7QMdcBeC8r/YCW6V/+o1UwESqNLKHfqAfJ5tu1a43
         2sia6EwcbXfsQuwlQHvVPKOU2WQgoxfNAEhgmb4ElMVFh4IIV4EDujZjMahsrvPBnE0V
         Nx7A==
X-Gm-Message-State: AOAM5338Ne8OzCZmWRoSPCBuPQFfDhYoGSjBO5Gqn1FPChwmx6VUDWmy
        IiO7mCfGtY5W7j0TVpsoKgQ=
X-Google-Smtp-Source: ABdhPJxG28FDzxvhJspsw/fE0f8/uq5XCOreBZRgn1TCqr3v3ji+DMbAHXZSvukj0phTIBCB19A71g==
X-Received: by 2002:a17:90a:c402:b0:1d9:a003:3f8a with SMTP id i2-20020a17090ac40200b001d9a0033f8amr4738422pjt.18.1650954908058;
        Mon, 25 Apr 2022 23:35:08 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a858300b001cd4989ff62sm1446257pjn.41.2022.04.25.23.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:35:07 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
To:     linux@dominikbrodowski.net, Jonathan.Cameron@huawei.com,
        broonie@kernel.org, arnd@arndb.de, lukas.bulwahn@gmail.com
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: add MIPS_DB1XXX dependence
Date:   Tue, 26 Apr 2022 14:34:59 +0800
Message-Id: <20220426063459.520478-1-starzhangzsd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

drivers/pcmcia/db1xxx_ss.c uses the bcsr_read like function from
arch/mips/alchemy/devboards/bcsr.c, which is controlled by
MIPS_DB1XXX. So add MIPS_DB1XXX dependence.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
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

