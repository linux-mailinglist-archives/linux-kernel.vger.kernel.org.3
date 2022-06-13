Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8F5499F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbiFMR1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiFMR1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:27:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D9549242;
        Mon, 13 Jun 2022 05:43:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s1so6966666wra.9;
        Mon, 13 Jun 2022 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gWZ2iuIrN0ujnQkPHV+TXRlSbNOjanWQAKWTOlhoEcw=;
        b=m77Tk6N3ACPMUA59bi65hTpTPrRkAmreeEkyPDG3GSgXJ4ZskPgxVFTCgLrtL3XMIN
         ptdPRIejAHUs/msgd9kwUcXEjXH9h7iZTcPwQxmlBnAUS7pH5Fm0NyuuqMXMP7CiLvVO
         A9X9U3iJN+KG2ON0S31rL3jMCzil1eJebmUdSlTO0cApaAKzK6aiS/YCtN5nqUvbdiWe
         gIf7Zmiz6VM37j6dsu/XmcwtVHHpYInnIywvwAg1s0q6KNVE7YG/xv2O93IgV/yg+P7Q
         s2pNHc1o5iLoQm+lbRaHYNVnObrF+/BXhSd9zlqbOuRTur8kUpI7PWlWdET9InW86Eqd
         fw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gWZ2iuIrN0ujnQkPHV+TXRlSbNOjanWQAKWTOlhoEcw=;
        b=5UXfS2fjCGSQkFlZKZMLo7c5axWa4m3Kt3jmYQXnhZE0ixUw/JXD/7+twL8O1TLAJN
         fysoJ3KT6V4UlbZf/Guyheg0iyQ0QiS4Mt7heHEUw42PNDNNa2SrbwsiYMsFONH1jTTw
         jCeAOjVXDp8RQeHeTySsRgLehHkBBcsBfy5IFQb+gi1ZWrm3i2SAR3BeRsCJXEx/Pl0p
         RKbgtvHTK+oCOKrL0cn2sdZFbVNRQq6tSOZZUyeeG2PYuYKaYno/nQnAf/X3/pUgzgXu
         r/77B0XdUgSXATWzNqMGiCvHR2BKKKmOB0/YTVFpjSWCnV4+I83C0sZtqBTe/K5fQ04x
         PSnw==
X-Gm-Message-State: AOAM530OEGRwbAcENhZcw5qSn79f/IVpN5gEzMcpo7Isd7uiWQu9DIm3
        xygdv/9i86k6axmXGHGjHpg=
X-Google-Smtp-Source: ABdhPJxmRpI3gbTnGIrNNYzB/skcfriE8YOSY4phl7jCU0+HLVMzMpV8RT5xLa1lCuYOs16Wh9CFCA==
X-Received: by 2002:a5d:6c62:0:b0:218:3e13:4b17 with SMTP id r2-20020a5d6c62000000b002183e134b17mr38913538wrz.673.1655124201670;
        Mon, 13 Jun 2022 05:43:21 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm8383940wrh.65.2022.06.13.05.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:43:21 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/thermal to THERMAL
Date:   Mon, 13 Jun 2022 14:43:09 +0200
Message-Id: <20220613124309.28790-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/thermal
are also the maintainers of the corresponding directory
include/dt-bindings/thermal.

Add the file entry for include/dt-bindings/thermal to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Rafael, Daniel, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec2e764a22ee..4fd2c1080aa5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19858,6 +19858,7 @@ F:	Documentation/ABI/testing/sysfs-class-thermal
 F:	Documentation/devicetree/bindings/thermal/
 F:	Documentation/driver-api/thermal/
 F:	drivers/thermal/
+F:	include/dt-bindings/thermal/
 F:	include/linux/cpu_cooling.h
 F:	include/linux/thermal.h
 F:	include/uapi/linux/thermal.h
-- 
2.17.1

