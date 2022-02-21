Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48374BD602
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiBUGUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:20:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbiBUGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:20:37 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD610C1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 22:20:14 -0800 (PST)
X-QQ-mid: bizesmtp79t1645424404te6fwesw
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 21 Feb 2022 14:19:58 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000000A0000000
X-QQ-FEAT: hR9GyqeohSjJ8b/qPk34ny37FDJWImGPRvOx7CiNu3SDi/J1JEglKreV1giAO
        DO8xtgMRmohoyPBF3C537Ys3WEBfk6oA6v29etPGuRLwNbEXuajJpL4VS4I63kXOXMehMs7
        vQ8TUXh4vYgwsoz75bgK+Jurhfwwp4nlYZBv23LwBYxaMKqzzV30e6PHk2Op2N4pW6mJ2Wz
        hfr2eBOq8dWMr1+WoY1W7HheQvSKwCcHLqfnKYcp+XM1h9wiwGVOjshARnkFiO4R0P36NkF
        5aOs9K+IiByovORfSgURAaNuFtplWzRjOS0hHCjanRqtqB9feuqrqeUCigEzNRt4MlN2+Yf
        k1NoiHJrCIR3qw52txtSJknNkO3zECzpYjCp4+M
X-QQ-GoodBg: 1
From:   tangmeng <tangmeng@uniontech.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] kernel/debug: remove unnecessary CONFIG options
Date:   Mon, 21 Feb 2022 14:19:54 +0800
Message-Id: <20220221061954.4822-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel/Makefile has:
obj-$(CONFIG_KGDB) += debug/

so kernel/debug/Makefile don't need this 'obj-$(CONFIG_KGDB) +=',
delete it from kernel/debug/Makefile.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 kernel/debug/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/Makefile b/kernel/debug/Makefile
index 332ee6c6ec2c..9c49ff7c75f4 100644
--- a/kernel/debug/Makefile
+++ b/kernel/debug/Makefile
@@ -3,5 +3,5 @@
 # Makefile for the linux kernel debugger
 #
 
-obj-$(CONFIG_KGDB) += debug_core.o gdbstub.o
+obj-y += debug_core.o gdbstub.o
 obj-$(CONFIG_KGDB_KDB) += kdb/
-- 
2.20.1



