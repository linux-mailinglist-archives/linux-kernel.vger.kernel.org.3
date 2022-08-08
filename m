Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CD58CB31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbiHHPUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbiHHPUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:20:23 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD1DF55
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:20:22 -0700 (PDT)
X-QQ-mid: bizesmtp73t1659972011tykjz25x
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:20:05 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: CR3LFp2JE4lkPKPkl52ZM+6mQ7+lq6ja/jzb8IWf7GxSJkQEH/txV+93F7Rh9
        P7Qf/2vfenPL3WZaqxio+9lNBl21RjoMT4gjpHO4/7vCj+ug1sGYIZlD3SWejtyavQPDxde
        5qk1Khqu5o1ousRqIuG3JTJjXYzVNI38mtrZ0iPxgEBRB3f3dAKF9Dhf+skfgaTmO6KwooW
        mnTPWgRYjajzkSKFmqE8K37rb5MyCoNTn1++kxjnsDByt+xWLod3ctXf7H/N4ZpkVf0jOYt
        4c1YuQ5NJHhZVBp40SSv7wAQuWDLWGhf1p/KR3Snh9bkP6Iq7/m/UyburqPdZc2VVYJUQhN
        CKxD77AiQ3JQYWtQI196zyp7oUjXO1grb77WkrTOpj/tgMIAMGO/7Irk5MPXvBAV4jy82mo
        3ZQ93mcjdAw=
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] tty: Remove unexpected word "should" in comments
Date:   Mon,  8 Aug 2022 11:20:04 -0400
Message-Id: <20220808152004.2364-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an unexpected word "should", so remove it.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/tty/amiserial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 5458e2b1c125..81e7f64c1739 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -12,7 +12,7 @@
  * (non hardware specific) changes to serial.c.
  *
  * The port is registered with the tty driver as minor device 64, and
- * therefore other ports should should only use 65 upwards.
+ * therefore other ports should only use 65 upwards.
  *
  * Richard Lucock 28/12/99
  *
-- 
2.35.1

