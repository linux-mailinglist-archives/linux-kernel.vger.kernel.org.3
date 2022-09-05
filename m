Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A665AC8B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiIECMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIECMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:12:34 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3705521E3F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 19:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UhOTn
        q4LpbvawDLF/ipZQT+kbw2lua4Q89NZBtJL2a0=; b=bkaWnB+amf1tXndkSfjJb
        Avi6GdYqf8cGTa9aUj1LP53dGWBpMeMcXWpk0MjAkLZktHwlpouV15tAfjYaTPux
        8O10TRyeeiMMy9UHHMuR8VUIDXzZGC7DyvBTvccQXlpHSo9KEYMADVelwDU43hBK
        H8+NIY0OGuGtTlHjehN0rs=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgDH9Ye1WhVjia_Kaw--.30864S2;
        Mon, 05 Sep 2022 10:11:03 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     gregkh@linuxfoundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] init.h: fix spelling typo in comment
Date:   Mon,  5 Sep 2022 10:10:34 +0800
Message-Id: <20220905021034.947701-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDH9Ye1WhVjia_Kaw--.30864S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GF18GF1DGFg_yoW3urb_C3
        W8Jr409rWxGF4Sva1vkF4avFyaga48KFWUWrn5JrnrXan7Zan8J397JrnFv3s7GrWvkF90
        q3Z3WryIyw15ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU88R67UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiVxBw+1etoJ76+QABsK
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
 include/linux/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index baf0b29a7010..3254766ebbf2 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -134,7 +134,7 @@ static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
 
 extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
 
-/* Used for contructor calls. */
+/* Used for constructor calls. */
 typedef void (*ctor_fn_t)(void);
 
 struct file_system_type;
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

