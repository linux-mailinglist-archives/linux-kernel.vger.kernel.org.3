Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E85255C9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358091AbiELTeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358072AbiELTeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:34:15 -0400
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E021323AE40;
        Thu, 12 May 2022 12:34:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1882421|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.121701-0.0170663-0.861232;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.NjCS19M_1652384046;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NjCS19M_1652384046)
          by smtp.aliyun-inc.com(33.13.195.200);
          Fri, 13 May 2022 03:34:07 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     tsbogend@alpha.franken.de, paul@crapouillou.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com
Subject: [PATCH 3/3] MIPS: Ingenic: Refresh defconfig for CU1000-Neo and CU1830-Neo.
Date:   Fri, 13 May 2022 03:33:41 +0800
Message-Id: <1652384021-46309-4-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652384021-46309-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1652384021-46309-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refresh the defconfig files of CU1000-Neo board and CU1830-Neo board,
remove the selection of SPI-GPIO, and add the selection of SSI.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 arch/mips/configs/cu1000-neo_defconfig | 2 +-
 arch/mips/configs/cu1830-neo_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/configs/cu1000-neo_defconfig b/arch/mips/configs/cu1000-neo_defconfig
index 9d75f5b..5bd55eb 100644
--- a/arch/mips/configs/cu1000-neo_defconfig
+++ b/arch/mips/configs/cu1000-neo_defconfig
@@ -61,7 +61,7 @@ CONFIG_SERIAL_SC16IS7XX_SPI=y
 CONFIG_I2C=y
 CONFIG_I2C_JZ4780=y
 CONFIG_SPI=y
-CONFIG_SPI_GPIO=y
+CONFIG_SPI_INGENIC=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_SENSORS_ADS7828=m
 CONFIG_WATCHDOG=y
diff --git a/arch/mips/configs/cu1830-neo_defconfig b/arch/mips/configs/cu1830-neo_defconfig
index 29decd00..cc69688 100644
--- a/arch/mips/configs/cu1830-neo_defconfig
+++ b/arch/mips/configs/cu1830-neo_defconfig
@@ -64,7 +64,7 @@ CONFIG_SERIAL_SC16IS7XX_SPI=y
 CONFIG_I2C=y
 CONFIG_I2C_JZ4780=y
 CONFIG_SPI=y
-CONFIG_SPI_GPIO=y
+CONFIG_SPI_INGENIC=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_SENSORS_ADS7828=m
 CONFIG_WATCHDOG=y
-- 
2.7.4

