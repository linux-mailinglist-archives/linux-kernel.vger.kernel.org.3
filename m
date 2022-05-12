Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97606524753
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351178AbiELHsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350850AbiELHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:48:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0FE49693
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:48:11 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzP2S427TzGpbC;
        Thu, 12 May 2022 15:45:20 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 15:48:09 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 15:48:09 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <lgirdwood@gmail.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <ryan.lee.analog@gmail.com>, <ricardw@axis.com>, <steve@sk2.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>
Subject: [PATCH -next v2 2/2] ASoC: tlv320adc3xxx: Fix build error for implicit function declaration
Date:   Thu, 12 May 2022 15:46:40 +0800
Message-ID: <20220512074640.75550-3-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512074640.75550-1-tanghui20@huawei.com>
References: <20220512074640.75550-1-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/tlv320adc3xxx.c: In function ‘adc3xxx_i2c_probe’:
sound/soc/codecs/tlv320adc3xxx.c:1359:21: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_gpio_free’? [-Werror=implicit-function-declaration]
  adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                     ^~~~~~~~~~~~~~
                     devm_gpio_free
  CC [M]  drivers/gpu/drm/nouveau/nvkm/engine/disp/sorgt215.o
  LD [M]  sound/soc/codecs/snd-soc-ak4671.o
  LD [M]  sound/soc/codecs/snd-soc-arizona.o
  LD [M]  sound/soc/codecs/snd-soc-cros-ec-codec.o
  LD [M]  sound/soc/codecs/snd-soc-ak4641.o
  LD [M]  sound/soc/codecs/snd-soc-alc5632.o
sound/soc/codecs/tlv320adc3xxx.c:1359:50: error: ‘GPIOD_OUT_LOW’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_LOW’?
  adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                                                  ^~~~~~~~~~~~~
                                                  GPIOF_INIT_LOW
sound/soc/codecs/tlv320adc3xxx.c:1359:50: note: each undeclared identifier is reported only once for each function it appears in
  LD [M]  sound/soc/codecs/snd-soc-cs35l32.o
sound/soc/codecs/tlv320adc3xxx.c:1408:2: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
  gpiod_set_value_cansleep(adc3xxx->rst_pin, 1);
  ^~~~~~~~~~~~~~~~~~~~~~~~
  gpio_set_value_cansleep
  LD [M]  sound/soc/codecs/snd-soc-cs35l41-lib.o
  LD [M]  sound/soc/codecs/snd-soc-cs35l36.o
  LD [M]  sound/soc/codecs/snd-soc-cs35l34.o
  LD [M]  sound/soc/codecs/snd-soc-cs35l41.o
  CC [M]  drivers/gpu/drm/nouveau/nvkm/engine/disp/sormcp89.o
cc1: all warnings being treated as errors

Fixes: e9a3b57efd28 ("ASoC: codec: tlv320adc3xxx: New codec driver")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
Changes in v2:
* Add missing header files instead of adding dependencies
* Calling 'gpiochip_remove' depends on 'CONFIG_GPIOLIB' enabled

 sound/soc/codecs/tlv320adc3xxx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index a5e9f80cfa32..80b8115e6053 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -14,6 +14,7 @@
 
 #include <dt-bindings/sound/tlv320adc3xxx.h>
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/io.h>
@@ -1025,7 +1026,9 @@ static const struct gpio_chip adc3xxx_gpio_chip = {
 
 static void adc3xxx_free_gpio(struct adc3xxx *adc3xxx)
 {
+#ifdef CONFIG_GPIOLIB
 	gpiochip_remove(&adc3xxx->gpio_chip);
+#endif
 }
 
 static void adc3xxx_init_gpio(struct adc3xxx *adc3xxx)
-- 
2.17.1

