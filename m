Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939AF4DC500
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiCQLpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiCQLpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:45:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55B11435B;
        Thu, 17 Mar 2022 04:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647517466;
        bh=Yfa3ut3W4uYD/9bxmkIeZvM2xi6/JQhxv3O0dcLAJMQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cCjsuL2+m1ibXNhseP7H5/dIZyZIa5AbYbSeTSWN/cWA1Bnl7MwTBu47daaGOQDaK
         lMuNBcECsm9KVI5ttqRGwbaoDDJ6EQCLjCPEILVa3YFCt38o/13D6zyXuQZs5wqwTP
         4DIbplXrOJZW34uh68SVqpCiDrBbTPGLWs6ZyWfo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1nKv3u2L88-00GX3W; Thu, 17
 Mar 2022 12:44:26 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: nuvoton: wpcm450: select GENERIC_PINCTRL_GROUPS
Date:   Thu, 17 Mar 2022 12:44:12 +0100
Message-Id: <20220317114413.1418484-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WdpBpWF/JwLrd0AcAECvf7YahZE34xeKMfffvgDL4CsDOB4F4tm
 l5fJfDRjm3SdGgl21NqmpMuQn1n/lbDv4FB/EdRPy2wPb2tikoC1lyaqwJ6+6c9C3EGk3pv
 XNCKiQVuu2fAXB0JofhIYcdo/U3admMZ99eAI7Nj24fRTYFtd+WzTyRZH5QfGgJCWe8iVvk
 f4S2BkCgzAFOUgZWIY7pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SUiuo1HjD1w=:xEBAktKb5SkpPyOPbqNI0q
 MQ2X3vDHwXXXOLZNJ++V4ftz0UgHDq3A1G/++MedP7dL6ej0jnm/gfwKub1Ombi7GRgTqqBbT
 X7kFamBDnEZiMFwXS2CKNUeJru3TX6Zcs44bjxpJljIab1/CSGw1CXhA4nurzf2aQw1xg/Vcs
 CyBJcRPivMvGUMDvj+qCHBgHBtgbCu3UI8/ilrrhasjbwdXDu5UaEtV374FkPWS9HQiNILveY
 mUkPk/Jacu5eegJM0dggqqkfxgKel5hDS8iuVYHkRupAde3liVBQZIG6abY7X6E9xnZho+Fuc
 FymrhDh8y2Lf79QSjmM2HwRIO86xAm1iVuebjlcdnY/4tj6/IC7NHwkRAMzQCDParZbbrQRHM
 u13ZTQtkfs3j2aZuC5DyUqH76dV11TixYazzHPDhg4a59v+aP82r5wVzM1yaT4G2QFPh4Krk/
 SYFHM2GqqYjCagGy2pq1WvWLN+1YWmtewRF3NVZA7fw3N5SlSzavKHy7i3B9EsEnDvrZF0L+7
 ebWLOrGjx4jEt2hlF8LRRw5HHSaUmUmuHkv4synuG7tcUFMn+zALXw5Ipf6/c10XPbB12cnLY
 UF1qLROYxkuFUjZFcaiUqZ6hT4Bsq+AbWqZQffIMwZ0hwFhQfiUVWoHeRjGtYAFz0ACje4hTG
 ty765KgJg0UtCJFz7JzgmqLLgCWJ/SuaQLQx+ZYZ22zqq8ffbAL5RyU2XRC1yr8jgXviFomjQ
 Pz8ud5cRWUAiL2CCen/X/B3vi3k60iTUjHzw4zOEX6BRk3lIMmMh9GxX58+Uc69yptFRbqhzM
 iCtLQBkB2YjFSoE4cejpjjZXkMWcoFk0ARDuQXAi3KjE0LHnarAZW6B+SBiccLF4DdumDZg1D
 BxUPLdFl5jcSEpcV/hlyHt7cFmsXwuUyoaAg1DTqH2plnajRsAzLD7O/0inWM+p16mUbgsftr
 lFzm7NIS8II84n/nq0zuelS7iG1WQ+LTHG1uz2WnoyhMWpjA2ujd8/e41BlQdpm5gjYmZL2tl
 E5QCPjsXiDguep4LjSeOYL5xRbdttvIXAqU9zBAZ7jKg3w8wFrLs2hdwWtPj+xV/ieBihZv0l
 +N1aPHfMJf2erM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_GENERIC_PINCTRL_GROUPS must be selected in order for
struct group_desc to be defined in pinctrl/core.h.

Add the missing select line to CONFIG_PINCTRL_WPCM450.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/pinctrl/nuvoton/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/Kconfig b/drivers/pinctrl/nuvoton/Kco=
nfig
index 6a3c6f2a73f2d..b48d32912bef1 100644
=2D-- a/drivers/pinctrl/nuvoton/Kconfig
+++ b/drivers/pinctrl/nuvoton/Kconfig
@@ -6,6 +6,7 @@ config PINCTRL_WPCM450
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
 	select GPIOLIB
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
=2D-
2.35.1

