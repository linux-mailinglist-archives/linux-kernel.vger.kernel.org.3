Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B153C57DECD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiGVJgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbiGVJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:35:53 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 289167E809;
        Fri, 22 Jul 2022 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jjDDe
        4egOwV1lhAhUWGF8m1wZn8cgCAgLW/uacCzNzk=; b=cvkFc1jGWWF4qR/mriV+c
        TnK800yDX64shx3u0eZXOm/geV8t2lfl1dr/tFmvRdZRVTqUw79xTAR4FLSwtIPS
        +ARFT0HBrpQ3VXVtbkwppoPnhcaFx6hdtonTpuXiZSuK81UURI/nmbNn12G+3jGk
        D9L9/ZmR8hl+2Eh0pVbbwU=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp4 (Coremail) with SMTP id HNxpCgBnq3vGbNpiCop+QA--.22733S2;
        Fri, 22 Jul 2022 17:24:24 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     linus.walleij@linaro.org, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] pinctrl: at91: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 17:24:19 +0800
Message-Id: <20220722092419.77052-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgBnq3vGbNpiCop+QA--.22733S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1fCF45ury5Ww1xKrg_yoW3Wrb_ua
        y8JrW7A3y8urnavr129rnIvFy0ya98Zr9Y9r1qg3Wa9ry5Xw4Fqr92kr4DG3s5Gr4SyFyU
        uryDXa4rJryUCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRJDGnJUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQBGZGBbEb07XgAAsl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/pinctrl/pinctrl-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 5e3a2f4c2bb6..5634fa063ebf 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1742,7 +1742,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	writel_relaxed(~0, at91_gpio->regbase + PIO_IDR);
 
 	/*
-	 * Let the generic code handle this edge IRQ, the the chained
+	 * Let the generic code handle this edge IRQ, the chained
 	 * handler will perform the actual work of handling the parent
 	 * interrupt.
 	 */
-- 
2.25.1

