Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1525AE002
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiIFGl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiIFGlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:41:23 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 832851F635;
        Mon,  5 Sep 2022 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rHS2Z
        Bylmoj1eBUVZMlFgyd3inWGdLuGTp2PlEkLBeQ=; b=BszX9hwZzlqNkiGDS95J6
        X90OresLDIKoTjZzu1HN3QEhadAWrWD52b9I3slnqS/BueUp0irfW1Gm/PjdApUW
        eUs+dAk49AaPuzQn4OrSH9QwLyHuU6bjrAd/ZG6+uGweDL6CFKZe3wiaF/TArvbG
        C2cy+IKSWsSLfYhkAy5YZs=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgBXKgVa6xZj0OLUbA--.23536S2;
        Tue, 06 Sep 2022 14:40:28 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     richard.genoud@gmail.com, gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] tty: serial: atmel: fix spelling typo in comment
Date:   Tue,  6 Sep 2022 14:39:57 +0800
Message-Id: <20220906063957.2951323-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgBXKgVa6xZj0OLUbA--.23536S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GFWkKw48JFb_yoWftFcEg3
        Z7Ww4DJrW8uF4FyrnxCrW5uFy5Kw1DuF1rGFn0v3sxX39rJa1kG34q9rnFyrn8CrW8XF98
        X3ZxGFyfAayDXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbtkuDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivhx0+1ZcenAOMQAAsS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/tty/serial/atmel_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 7450d3853031..7f8af2ea3fa5 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -40,7 +40,7 @@
 /* Revisit: We should calculate this based on the actual port settings */
 #define PDC_RX_TIMEOUT		(3 * 10)		/* 3 bytes */
 
-/* The minium number of data FIFOs should be able to contain */
+/* The minimum number of data FIFOs should be able to contain */
 #define ATMEL_MIN_FIFO_SIZE	8
 /*
  * These two offsets are substracted from the RX FIFO size to define the RTS
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

