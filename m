Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833945ADDCA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiIFDJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiIFDI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:08:28 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 640E86BD7A;
        Mon,  5 Sep 2022 20:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vxCdw
        dBUw0DmipbTRNuKoL+VAC0UhCU9NiaMGV8I31E=; b=oXtHX0zWDwfXki/V896PH
        6Grkm1aa5H869JuF7IkqlokdyZkj/vUa9vTeADV17tN8Gx97x3+/5Adjv49KFp9+
        vnv4ka2kvgS9/ramsqr6yZcbfQNZGHhwYBv+jF27/Ie6bdrc8kiz42uIr/BsYjwK
        pPRcA0NLghS34pUGIIb30I=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgCHe19buRZjGCkKbQ--.40649S2;
        Tue, 06 Sep 2022 11:07:09 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     gotom@debian.or.jp, yokota@netlab.is.tsukuba.ac.jp,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] scsi: nsp32: fix spelling typo in comment
Date:   Tue,  6 Sep 2022 11:06:42 +0800
Message-Id: <20220906030642.854911-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCHe19buRZjGCkKbQ--.40649S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Gw1kGrWfKrg_yoWfXFbEgF
        Z3Z39rWry8CF4S9rnYyrZYvFWYvFWjgrs7uwn0grs3u3y7Xrs8ZFW8AF4xC347Jr40qFn8
        Jw1q9rnYkr1DJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbiSdJUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivh10+1Zcem4jDwAAse
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
 drivers/scsi/nsp32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/nsp32.h b/drivers/scsi/nsp32.h
index 924889f8bd37..47993d123a6f 100644
--- a/drivers/scsi/nsp32.h
+++ b/drivers/scsi/nsp32.h
@@ -520,7 +520,7 @@ typedef struct _nsp32_sync_table {
 #define SDTR_TARGET	  BIT(1)    /* sending SDTR from target           */
 #define SDTR_DONE	  BIT(2)    /* exchanging SDTR has been processed */
 
-/* syncronous period value for nsp32_target.config_max */
+/* synchronous period value for nsp32_target.config_max */
 #define FAST5M			0x32
 #define FAST10M			0x19
 #define ULTRA20M		0x0c
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

