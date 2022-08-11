Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5758F819
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiHKHFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiHKHFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:05:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7776027B29;
        Thu, 11 Aug 2022 00:05:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x21so21806905edd.3;
        Thu, 11 Aug 2022 00:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=bk1qevapMhDm+JgbQICH5FeQCF79nTZHyWRD8Iuolyg=;
        b=HHXOsENPykilzkk+9zAEH6snB06XhWIvJCRH2YfsbkqfhUw7tFwUiUzKPpzsoZGVie
         3McguUxrq2oo5EM3p5EoUd60Lu4HVYsAlq5BcqWEogIZnEVPrlpnmqZUCCcL8nCtSgKE
         Ap5C7UA0aTQH4dTZZ4/0WoQ+MbP+gB+7tV8oXQcsfOZe7Qbw24uN+SXE94tAKB/nVdJW
         X8V/Jc6nshPUaacNc1eoPIjFuLRjIPgKziAuFHZn2ECqHjGgSDsltmsNT7YId0OmmltJ
         t6R0bCY29wW7TBX6AZ4sh5zFAVcMWSEHlCK3JWG+frmdKMUxzue4pkCvExw2ts+23+4n
         1uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bk1qevapMhDm+JgbQICH5FeQCF79nTZHyWRD8Iuolyg=;
        b=u1SjwSwhouhwmzGJajezuQy75M5yk+Hhq2WeWJxVxCPE2cpPvRtvkmasLHVvXeDMnI
         uYixn5S38VasXrxki7NBnkGu7RkYYAvrP+hLKtKaE84L5Wb7nPxRGZ0emKLh9paVkQ+v
         uRZcJudRWK+uF1CsLR+nFDIpgcf22iyvBjcMjXauVYUnBi45aS8N3IJp/7gsSW4smEfS
         0vt8/JduVwLGd8axfvBZs7AX7Vj3ztruug/xQ3+oE3Ucsj8t+RiZg9PfxXPDALE0k8if
         HGCD67k2EShDrCxDa7kRdbWNGQIazvBQgzeoHNt+REqagykHFRwSaSFeGJSkWTrjxNRP
         M4ag==
X-Gm-Message-State: ACgBeo3BCnjrXymvaz8VJuqnTcLdlfUkHHYpn0XwYMC6vefjuTHKMI3c
        js50ENgYqMFc0Y8j6PBdgsM=
X-Google-Smtp-Source: AA6agR4Qj9Zxnp5RPjzHOJWUZnvDcMKS0ttojT6gbGQkpd5WvKWIm3lfNR+byryujQ7KhVjhE59v3Q==
X-Received: by 2002:a05:6402:304c:b0:440:d482:2fa6 with SMTP id bs12-20020a056402304c00b00440d4822fa6mr14642512edb.344.1660201525897;
        Thu, 11 Aug 2022 00:05:25 -0700 (PDT)
Received: from felia.fritz.box (200116b8267089004d8d56997cb46253.dip.versatel-1u1.de. [2001:16b8:2670:8900:4d8d:5699:7cb4:6253])
        by smtp.gmail.com with ESMTPSA id ds13-20020a170907724d00b0072fe6408526sm3184188ejc.9.2022.08.11.00.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 00:05:25 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, Wolfram Sang <wsa@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
Date:   Thu, 11 Aug 2022 09:05:06 +0200
Message-Id: <20220811070506.12252-1-lukas.bulwahn@gmail.com>
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

Commit 3cbd67384677 ("MAINTAINERS: add the Polarfire SoC's i2c driver")
adds the file entry for drivers/i2c/busses/i2c-microchip-core.c, but the
file is actually named drivers/i2c/busses/i2c-microchip-corei2c.c.

Repair this file reference in RISC-V/MICROCHIP POLARFIRE SOC SUPPORT.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Conor, please ack.

Arnd, please pick this minor non-urgent clean-up patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9203efedea1e..797fde7e1821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17544,7 +17544,7 @@ F:	Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/char/hw_random/mpfs-rng.c
 F:	drivers/clk/microchip/clk-mpfs.c
-F:	drivers/i2c/busses/i2c-microchip-core.c
+F:	drivers/i2c/busses/i2c-microchip-corei2c.c
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/pci/controller/pcie-microchip-host.c
 F:	drivers/rtc/rtc-mpfs.c
-- 
2.17.1

