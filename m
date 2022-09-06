Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19F55ADF0B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiIFFuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiIFFtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:49:55 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 628633F1D2;
        Mon,  5 Sep 2022 22:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xNbDr
        StuvGwqNWDw0moNbItRHfUwiEd/kR4i8Eepi4o=; b=cpK+KPJH5Nd4O2uXzqhYd
        ysvezgukB+IWTxmiQqT7AMDzyP4dK/+6EwYJdrDvdFiBpepHagD0TyW/Dlo5ZAGj
        df/TATXXT1KKEzbs4mytgkpE83uWuTWnyuUEr1HP9jK8WnNCAAGPMM/9BCOcT6WT
        u5ZQR1qR2St2g3GtQPLt+Y=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgD3EVZw3xZjkgoxbQ--.41059S2;
        Tue, 06 Sep 2022 13:49:39 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] Input: hp_sdc: fix spelling typo in comment
Date:   Tue,  6 Sep 2022 13:49:01 +0800
Message-Id: <20220906054901.2283059-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgD3EVZw3xZjkgoxbQ--.41059S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GFyfZr4Utwb_yoWfAFc_Gw
        1xWr48Xr4kGF4Igw4UtFWavF1Ikr98KrnrZwn5ZwsxWa9rZan8K34kGryIk347WFWqkr15
        Xa1ruFZ29r13KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbl4i5UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbi8BN0+1uoiEvWwwAAsJ
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
 include/linux/hp_sdc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hp_sdc.h b/include/linux/hp_sdc.h
index 6f1dee7e67e0..9be8704e2d38 100644
--- a/include/linux/hp_sdc.h
+++ b/include/linux/hp_sdc.h
@@ -180,7 +180,7 @@ switch (val) {						\
 
 #define HP_SDC_CMD_SET_IM	0x40    /* 010xxxxx == set irq mask */
 
-/* The documents provided do not explicitly state that all registers betweem 
+/* The documents provided do not explicitly state that all registers between
  * 0x01 and 0x1f inclusive can be read by sending their register index as a 
  * command, but this is implied and appears to be the case.
  */
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

