Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643D05ACFEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbiIEKSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbiIEKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:17:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85430578A1;
        Mon,  5 Sep 2022 03:16:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x73so3727438ede.10;
        Mon, 05 Sep 2022 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=oZcqLkJ6f0EdVnoUZ/Kk+EN7566m04ZTx5pIlmEDnVc=;
        b=MGTcB3RAgv7JapB0U8k5xcLAUh7S9QRNoqaJdojzUz5Xh+tTHhUSY3VxnPf1vfZb/7
         yrfqVdJzM+a+Hi31jxUVydb4u4cJCU3mFK7Nllu5r6tIwtwQzA0CP5H+nrl1jcIqTJ2u
         suBLDlLITAXDKi9JJzcdPkiDHxXZIv+c2bvX9uJ0xytZgig+vgRs4uSkPBjr1R6MKXTx
         Rls8y4vMxWKZqEYtuAZKNycIT85DXPwa+/5qm148KuWLT81yg07ou8ckLKd+X5oKE1nS
         g091Yzfe+khCWyR/1XJ2DsBz/m9CiQOhSLGZ+bm7XxDcGbKKU2HFeR5bKXYH1dQz/eGb
         ItXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oZcqLkJ6f0EdVnoUZ/Kk+EN7566m04ZTx5pIlmEDnVc=;
        b=cVCLL4eo737EUkgjWwHYbtGGxbrWubDUKdKUKt6l8ywmYWeO/D2RuB3A9EVRItttJB
         dNbIvnM+d3R7ixMt5nUEXFXEkwR7JGnTeKoK5kdDHj1vpNbOZQO5Fr01go4nAoAMmp+S
         63LNfLFh0avOar1ILS5wLUaSxxx+7zjHIpJIL6q50gOxm7TN44E8krH2AhK/NfoxvTX6
         1phaoA1qMrW2nd8bPlgAE01AXg55R8k+yPQ7yMEjARWMyrbcLvd07xzaxY67rmuLE3nW
         TqIOT7hBPLukk0RR5d8wqPR5nOt56pAuwVqGO2W0ygVGQXAl7e3BTcjZiuEcoPQxQvsg
         pSMA==
X-Gm-Message-State: ACgBeo3KimSaH4I5BmR6XzedlPmFxllZheDGDw1HY5pAzCEr+Z5C7Yrr
        t6UseqgFDFVDA69jgYQD2JA=
X-Google-Smtp-Source: AA6agR6wvbt9Cj6cEsO99WDV0sDdoEPAezh0P63BSPvGuyM8e9cmb6ahY9HcGlJBTq2tYpFyV0J6Cg==
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr42219633edh.355.1662372981774;
        Mon, 05 Sep 2022 03:16:21 -0700 (PDT)
Received: from felia.fritz.box (200116b8268cc400942297814b5b37b6.dip.versatel-1u1.de. [2001:16b8:268c:c400:9422:9781:4b5b:37b6])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7d44d000000b0044eb5b922bdsm130230edr.24.2022.09.05.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:16:21 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] media: MAINTAINERS: adjust entry to zoran driver movement
Date:   Mon,  5 Sep 2022 12:14:16 +0200
Message-Id: <20220905101416.11114-1-lukas.bulwahn@gmail.com>
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

Commit 2a0c28063de2 ("media: zoran: move to mainline") moves the zoran
driver from the staging to the media subsystem, but does not adjust the
entry in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in ZR36067 VIDEO FOR LINUX DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c239d7e69158..228d3a9ddc34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22578,7 +22578,7 @@ S:	Maintained
 W:	http://mjpeg.sourceforge.net/driver-zoran/
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 F:	Documentation/driver-api/media/drivers/zoran.rst
-F:	drivers/staging/media/zoran/
+F:	drivers/media/pci/zoran/
 
 ZRAM COMPRESSED RAM BLOCK DEVICE DRVIER
 M:	Minchan Kim <minchan@kernel.org>
-- 
2.17.1

