Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653834768EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhLPEBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:01:51 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52555 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbhLPEBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:01:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V-meZ4O_1639627308;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-meZ4O_1639627308)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Dec 2021 12:01:49 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     srinivas.pandruvada@linux.intel.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] HID: intel-ish-hid: ishtp-fw-loader: Fix a kernel-doc formatting issue
Date:   Thu, 16 Dec 2021 12:01:46 +0800
Message-Id: <20211216040146.89075-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function had kernel-doc that not used a hash to separate
the function name from the one line description.

The warning was found by running scripts/kernel-doc, which is
caused by using 'make W=1'.

drivers/hid/intel-ish-hid/ishtp-fw-loader.c:271: warning: This comment
starts with '/**', but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
index 0e1183e96147..e24988586710 100644
--- a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
+++ b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
@@ -268,7 +268,8 @@ static int get_firmware_variant(struct ishtp_cl_data *client_data,
 }
 
 /**
- * loader_cl_send()	Send message from host to firmware
+ * loader_cl_send() - Send message from host to firmware
+ *
  * @client_data:	Client data instance
  * @out_msg:		Message buffer to be sent to firmware
  * @out_size:		Size of out going message
-- 
2.20.1.7.g153144c

