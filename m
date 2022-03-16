Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613194DABCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353851AbiCPH0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354042AbiCPH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:26:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796B5FF3B;
        Wed, 16 Mar 2022 00:25:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t1so1610929edc.3;
        Wed, 16 Mar 2022 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=k2XDkxW4pcLGrgBabuAmAWd2wJ7suNpD4bXx0nDuw4w=;
        b=e87GAQob7VcIIZSaxRDrpHGZbYz0ZLqpbpsbExBi7EtftlKzsTJpNifAKitn4+JP7O
         0bcmBf8LEgJP/UMjC0df3Brsms6H4l2DLgnzJq1LLbpKrAfpXXsZQQV043DiOmOAT6D2
         eoxkM2OQPP3m6nYcsOUM8ZNdroy0XKNotNJsX7jOhw5lgVbSMY/HTS4ucOA9FWbabWSI
         2rLUDsW/81XtrV7kaSxTGL86iPvWnvvOF2olzaA0RsjETSgkSOETvBD60d7FbRBCVBi1
         YXj+ZdgJVi6KknqY7nXvfgbKM8pBAwJ7QG9AWhzX4Xwg9evIKsUaoKs1hC7hp9fnODwc
         hQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k2XDkxW4pcLGrgBabuAmAWd2wJ7suNpD4bXx0nDuw4w=;
        b=IdsMZX2O0qGaTG+a3v37hNMLqZZEDInvI2Qjc/0r6AgU9x1WISGHv1DM2PoYeWrhdy
         CfNsWaCHCD9OGFBP8DmrmOCsAH9rlzhqXhXMKVvbtuZ9ZMI95sWJAE3TrPRmXstZh570
         egE1OEX+FPq32WCBfJHOPUPAMpNfodZlz7h+qXzza0plE7+mjffHMXw1WnDLfuESF76C
         BAXTxpB+L0l4RQloOkn32wfDPbmL89WQK2ldCdFmZXJu27eqJ287w5JA/6CgY4yTEFEL
         qLJsk4L9jlcQ2FbgUafD3OA9L3Y6PE0/buZCRAiPCEHv1Ut4TNMu893AqPSvR6IRm9Jc
         HYXA==
X-Gm-Message-State: AOAM531gzjMyN8R6mlwLrHO7fBL+1qrsA+KXV4wpLwS5hS9yMPDJwIvv
        r4bhIh4MVenlsbxt0u1LCKdP2yUJxf0=
X-Google-Smtp-Source: ABdhPJxyekmY0haMxC8PoH31GMrAN1hP/z/MhOAc/9HVXy5Z5yU61UaHNqQ45lG2uvlq/M7CCL85BA==
X-Received: by 2002:a05:6402:40d1:b0:418:e73c:a1a8 with SMTP id z17-20020a05640240d100b00418e73ca1a8mr1850794edb.321.1647415524913;
        Wed, 16 Mar 2022 00:25:24 -0700 (PDT)
Received: from felia.fritz.box (200116b826783100351493f9f729970f.dip.versatel-1u1.de. [2001:16b8:2678:3100:3514:93f9:f729:970f])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709064b1300b006dabe44a6edsm515502eju.141.2022.03.16.00.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 00:25:24 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust entries to nxp driver movement in media platform
Date:   Wed, 16 Mar 2022 08:25:17 +0100
Message-Id: <20220316072517.3607-1-lukas.bulwahn@gmail.com>
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

Commit 46fb99951fe2 ("media: platform: place NXP drivers on a separate dir")
moves various files in media/platform into a nxp subdirectory. It adjusts
the section MEDIA DRIVER FOR FREESCALE IMX PXP in MAINTAINERS, but misses
some references in NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER and MEDIA DRIVERS
FOR FREESCALE IMX7.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust the file references in the NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER and
MEDIA DRIVERS FOR FREESCALE IMX7 sections.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mauro, please pick this minor clean-up on your -next tree on top of the
commit above.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eacf125e052..c4f54cf46ae8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12130,7 +12130,7 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/admin-guide/media/imx7.rst
 F:	Documentation/devicetree/bindings/media/nxp,imx-mipi-csi2.yaml
 F:	Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
-F:	drivers/media/platform/imx/imx-mipi-csis.c
+F:	drivers/media/platform/nxp/imx-mipi-csis.c
 F:	drivers/staging/media/imx/imx7-media-csi.c
 
 MEDIA DRIVERS FOR HELENE
@@ -14166,7 +14166,7 @@ R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
-F:	drivers/media/platform/imx-jpeg
+F:	drivers/media/platform/nxp/imx-jpeg
 
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
 M:	Jonas Malaco <jonas@protocubo.io>
-- 
2.17.1

