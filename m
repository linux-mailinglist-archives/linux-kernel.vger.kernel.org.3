Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3311471AE2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhLLOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:42:11 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:55339 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229756AbhLLOmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:42:10 -0500
X-QQ-mid: bizesmtp33t1639320088tem3qh1c
Received: from wangx.lan (unknown [171.221.148.2])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 22:41:20 +0800 (CST)
X-QQ-SSF: 0100000000200080C000000A0000000
X-QQ-FEAT: k0yT7W7BRd0vz2DOBTsDYaU881ppjiZOQ+erxIGyan1lNE2BJDGsMuiK3MgQu
        +/1JbJQ0AHHqqQbGfKnwIM9UrRQXNyoV/yxITDqWwxt8N1NvnPOQVHasT9vb2INh6XOPsXa
        EHVbUXG65xPt6elZJrtTajMj0TuYp8vgAnAiWgxBQGGJBhRxsNSNIclbDAZ4YE7cNEhVZTO
        5fcBN3o1T6Ek0aLT32oFppX05zLBlahrBHmrXXwdbi42Qhe9Ub8gzvRLqNPn2X7fYbxFtSE
        FlfFuIwgXaO1kFZRB4VQTGoDqczm1JuK8yiMSDUTKfpcjEZxz0OuRbVFRGUuEo4fENB6BED
        L4rwgBVJ9cbyE6lZbg2ht777GHc9FADRTd8W26e
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] iio: adc: ad7606: Fix syntax errors in comments
Date:   Sun, 12 Dec 2021 22:41:18 +0800
Message-Id: <20211212144118.16904-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/iio/adc/ad7606.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 9350ef1f63b5..4f82d7c9acfd 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -62,7 +62,7 @@ struct ad7606_chip_info {
  * struct ad7606_state - driver instance specific data
  * @dev		pointer to kernel device
  * @chip_info		entry in the table of chips that describes this device
- * @reg		regulator info for the the power supply of the device
+ * @reg		regulator info for the power supply of the device
  * @bops		bus operations (SPI or parallel)
  * @range		voltage range selection, selects which scale to apply
  * @oversampling	oversampling selection
-- 
2.20.1

