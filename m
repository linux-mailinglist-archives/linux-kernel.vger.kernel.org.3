Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DB59E8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbiHWRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbiHWRKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:10:34 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ED1B4EA4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:01:03 -0700 (PDT)
X-QQ-mid: bizesmtp77t1661263231tcnq9o02
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:00:30 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: hUW8LCq5FgmS97YnLeF2+CUzDAQelsZKzhU/PytZhpRtO7oC1iH53Jno0gcbK
        78omLGtLJqMwSzfk4mvmK/DaqdlKG2gZ/fhRfiljbR5fUfZkPORyYECzCKzW6KXUHV2faIa
        k0pI4IAdkMlUZ9IhPfkDAgd8wcfbumvJa8hecvD232Cd3ggJIiGb1dtXFxQ3esFrwPni+Yy
        uonEwS/515lT7iVN3UoS/DqASy2D0CQMK6e+uPKubD2k5QlPzjPOMPcrLLVfQwr5Q00FSR7
        ifyGESK+/JozJ2qa16w2ReT0uAmgHPD8F7lYojhI7vbRlkKBQ8QRF22kLte1EQJN8KZMS9i
        V669VQZ+gc8biKkVeKGGg8JxOg29hY3nNzF7BFdUveGdnktAaFf125kOxUckQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] iio/accel: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:00:23 +0800
Message-Id: <20220823140023.2567-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/iio/accel/kxcjk-1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 748b35c2f0c3..b073ab12e6a4 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1064,7 +1064,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 
 	/*
 	 * We will expect the enable and disable to do operation in
-	 * in reverse order. This will happen here anyway as our
+	 * reverse order. This will happen here anyway as our
 	 * resume operation uses sync mode runtime pm calls, the
 	 * suspend operation will be delayed by autosuspend delay
 	 * So the disable operation will still happen in reverse of
-- 
2.36.1

