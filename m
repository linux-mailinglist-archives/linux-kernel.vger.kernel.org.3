Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1959B50C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiHUP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiHUP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:27:53 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31706237F3;
        Sun, 21 Aug 2022 08:27:51 -0700 (PDT)
X-QQ-mid: bizesmtp90t1661095655tfv6j94y
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:27:33 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: Wp4pj0u9TIfGYEa5O2LPWVWLmI+a4Sh95G0eBNKr6mBebP9K5sq4h3BRTgfDl
        u9nRDAHfTx2x4NxDyhUyIKNcyhm4gWvA2YF0IS5eVpbdW1wTwL19a/8LPILJ3+mIU1q75m7
        3+ZQuwTM2d/a+DW8HV6NBSTrR1I2g60RpwYdgbHrOb2R2cqH/GeoMUG4eb5/VIm7AxeMi8C
        B9JvHZNTAKWFGXOfdlsTtti6DDAe8h4amwEISg1cnNW4H/RP1c8Ccasj5ggYgn5Wort+pEd
        taR8jR9KJiqpf3DZ+xtct3SBPh4J5y/z5JMJDaO+k6OhXTl2+jOriOHfS1NZLDUqkunUphK
        KiarPShExHtBAUn6tIg4rs3ZVm52SFbuLy02tvl9CCIYNIeQqA=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     Kai.Makisara@kolumbus.fi, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/scsi: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:27:27 +0800
Message-Id: <20220821152727.65412-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'of'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 56a093a90b92..e65f05615b7f 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4660,7 +4660,7 @@ static DEVICE_ATTR_RO(read_cnt);
 /**
  * read_byte_cnt_show - return read byte count - tape drives
  * may use blocks less than 512 bytes this gives the raw byte count of
- * of data read from the tape drive.
+ * data read from the tape drive.
  * @dev: struct device
  * @attr: attribute structure
  * @buf: buffer to return formatted data in
-- 
2.36.1

