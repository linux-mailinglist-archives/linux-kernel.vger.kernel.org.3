Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF057E4AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiGVQs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGVQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:48:55 -0400
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C993C0E;
        Fri, 22 Jul 2022 09:48:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2783662|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00548407-0.00159274-0.992923;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.Ob0cn8C_1658508518;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Ob0cn8C_1658508518)
          by smtp.aliyun-inc.com;
          Sat, 23 Jul 2022 00:48:47 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
Subject: [PATCH 0/3] Add SFC support for Ingenic SoCs.
Date:   Sat, 23 Jul 2022 00:48:27 +0800
Message-Id: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Use the spi-mem poll status APIs in SPI-NOR to reduce CPU load.
2.Add SFC support for the X1000 SoC, the X1600 SoC, and the X2000 SoC from Ingenic.

Liu Jinghui and Aidan MacDonald provided a lot of assistance during the development of this driver.

周琰杰 (Zhou Yanjie) (3):
  mtd: spi-nor: Use the spi-mem poll status APIs.
  dt-bindings: SPI: Add Ingenic SFC bindings.
  SPI: Ingenic: Add SFC support for Ingenic SoCs.

 .../devicetree/bindings/spi/ingenic,sfc.yaml       |  64 ++
 drivers/mtd/spi-nor/core.c                         |  42 +-
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-ingenic-sfc.c                      | 662 +++++++++++++++++++++
 5 files changed, 768 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
 create mode 100755 drivers/spi/spi-ingenic-sfc.c

-- 
2.7.4

