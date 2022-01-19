Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3B493309
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351035AbiASCkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:40:19 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36052 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351026AbiASCkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:40:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2F5bjL_1642559989;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V2F5bjL_1642559989)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 10:40:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, wedsonaf@google.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] rust: Remove unused including <linux/version.h>
Date:   Wed, 19 Jan 2022 10:39:47 +0800
Message-Id: <20220119023947.30628-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow versioncheck warning:

./rust/kernel/bindings_helper.h: 13 linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 rust/kernel/bindings_helper.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/bindings_helper.h b/rust/kernel/bindings_helper.h
index 99a7d785ae01..a79f3f398b93 100644
--- a/rust/kernel/bindings_helper.h
+++ b/rust/kernel/bindings_helper.h
@@ -10,7 +10,6 @@
 #include <linux/sysctl.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
-#include <linux/version.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
 #include <linux/mm.h>
-- 
2.20.1.7.g153144c

