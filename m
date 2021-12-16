Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E558B4774EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhLPOrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:47:40 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:35919 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229979AbhLPOrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:47:39 -0500
X-QQ-mid: bizesmtp47t1639665990txya3bdj
Received: from wangx.lan (unknown [218.88.124.63])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 16 Dec 2021 22:46:23 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000C00A0000000
X-QQ-FEAT: iANUFw1MatEqeVns3RawMwAOGfhq0dEtBtWBchNwpVZ7FkI9sTn6kIkSlDl3V
        5BQa/hS+m7m0PoJI3M3EOo6YcjTHmIOFhlo9ZrVRahnL9Hn5y6ZL6IjFxKYoIFYqUpso18V
        rLrzQNnOMSTLR19w/Bv55uFYmE2PVa8jzvpd3GCEFCTRcRKukUAPmp9EC8MKTtQhBz7BpEj
        KzvepFS6R0qV7G34F4LwlFsG2n17FxYXyV7GsTX9If780s1/D1xQ4uN8CLpt72xmG8qC348
        031gOxksSdPz4XF0dkSUBKUMmDUqSwFXXm1lphXYVzqwXgiGLO85s5a/cNZhUzNmchx7xW7
        48tK2Loi39u1F7Jm1rUjs4A1ic3/0w2hqK7MoBukZjrSpGcIOc=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] seqlock: Fix typo in a comment
Date:   Thu, 16 Dec 2021 22:46:21 +0800
Message-Id: <20211216144621.10746-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in a comment is repeated, thus it should be removed.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b8fee6..12156166c636 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -867,7 +867,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use the the internal
+ * For all seqlock_t write side functions, use the internal
  * do_write_seqcount_begin() instead of generic write_seqcount_begin().
  * This way, no redundant lockdep_assert_held() checks are added.
  */
-- 
2.20.1

