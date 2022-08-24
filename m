Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1759FAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiHXNLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiHXNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:10:58 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 06:10:47 PDT
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC715A13;
        Wed, 24 Aug 2022 06:10:44 -0700 (PDT)
X-QQ-mid: bizesmtp65t1661346624tuy039p7
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:10:22 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: XBN7tc9DADLtYfvAxzsgzNN+T8mKALAUrxf7Y9I8DZLpTEuXCp9OXsUXbfiQg
        a+FPBqzgzz72txSEMdESHLmBF57DoEg6XA3NKMTuQ+3TdpCRwZMIwR/jl4+0UB3lIbnH6ip
        RjmQnDNmtq+Iwg3Qyo4YDpFwe/0IpSi+DlITqoK9kB4PUKPgbcBxpdSPJVYlfiHf61BZ5HZ
        kp3wMzpJ2ksFlkgJeSszr22Widujt92dLm86rM8PGm5jHUOq0mPDdeuC3xWz+HzWVHyTMAM
        2otEf6mVDf5pl+9Ayx9nYdkN+UxrDY7wbpUHdujUd5ifUfJjIbUwQT8aZYZClq//3LiU3bn
        EdtAXS2RZC+7erIl7/kBTC9vCh6+RsSyoOg46lO9Nxd2OfzWm9ky0+8PYdFQw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     crope@iki.fi, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/msi2500: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:10:16 +0800
Message-Id: <20220824131016.45828-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'for'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/usb/msi2500/msi2500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 71de6b4c4e4c..83b6e00c2b7d 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -209,7 +209,7 @@ static struct msi2500_frame_buf *msi2500_get_next_fill_buf(
  *
  * Control bits for previous samples is 32-bit field, containing 16 x 2-bit
  * numbers. This results one 2-bit number for 8 samples. It is likely used for
- * for bit shifting sample by given bits, increasing actual sampling resolution.
+ * bit shifting sample by given bits, increasing actual sampling resolution.
  * Number 2 (0b10) was never seen.
  *
  * 6 * 16 * 2 * 4 = 768 samples. 768 * 4 = 3072 bytes
-- 
2.36.1

