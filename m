Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9950C06A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiDVTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiDVTcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:32:17 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A4263C9B;
        Fri, 22 Apr 2022 12:10:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3675815|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00515553-0.000522895-0.994322;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.NVyzeau_1650654583;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NVyzeau_1650654583)
          by smtp.aliyun-inc.com(33.37.68.185);
          Sat, 23 Apr 2022 03:09:55 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        contact@artur-rojek.eu, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v2 0/3] Improve SPI support for Ingenic SoCs.
Date:   Sat, 23 Apr 2022 03:09:40 +0800
Message-Id: <1650654583-89933-1-git-send-email-zhouyanjie@wanyeetech.com>
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

1.Add support for using GPIOs as chip select lines on Ingenic SoCs.
2.Add support for probing the spi-ingenic driver on the JZ4775 SoC,
  the X1000 SoC, and the X2000 SoC.
3.Modify annotation texts to be more in line with the current state.

v1->v2:
Use "device_property_read_u32()" instead "of_property_read_u32()" as
Paul Cercueil's suggestion.

周琰杰 (Zhou Yanjie) (3):
  SPI: Ingenic: Add support for use GPIO as chip select line.
  dt-bindings: SPI: Add bindings for new Ingenic SoCs.
  SPI: Ingenic: Add support for new Ingenic SoCs.

 .../devicetree/bindings/spi/ingenic,spi.yaml       |  3 ++
 drivers/spi/Kconfig                                |  4 +-
 drivers/spi/spi-ingenic.c                          | 49 +++++++++++++++++++---
 3 files changed, 49 insertions(+), 7 deletions(-)

-- 
2.7.4

