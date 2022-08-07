Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647DB58BBC2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiHGQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiHGQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 12:03:05 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4D464EA;
        Sun,  7 Aug 2022 09:03:03 -0700 (PDT)
X-QQ-mid: bizesmtp83t1659888167tbvqfw97
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 00:02:43 +0800 (CST)
X-QQ-SSF: 0100000000000040B000000A0000000
X-QQ-FEAT: AmBEVSWWrMca1Gv19HfFCsafPdV2RRaBAFQrEm5BmZmWHz0Cjx1IMB3HjWkSP
        2p5HUAJcBG5VRbOM2AI1vf3WiTaxFWZ2yDncZcF/hhV87IgGIAVXTaPFOvSlCiEBASlg3nO
        Xwue8NDPacJW4sMlqI+an7lNTK4gAZ9lHmrVjgrwG5PykXTPtjkj8bGj2NgIMxpou1pMNDT
        Izt/6ibwmUevmzfZjZ/Ztu4a2dEkYGjb9vGHIW4CPnwNzFlgSkZDRRlwiPbPYrx3+MywlDN
        lSh91wti9XdIb3eR6uc+nY6q3JOYNQ0umBo0iOIvlu/GqsBWc52PmJD1vmD+TKHnb+5CCPU
        O3UOW+Jzt2KxCb/G6F4ant/C0LIsg==
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] perf scripting python: Delete repeated word in comments
Date:   Sun,  7 Aug 2022 12:02:39 -0400
Message-Id: <20220807160239.474-1-dengshaomin@cdjrlc.com>
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

Delete the repeated word "into" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index adba01b7d9dd..107aeccbae30 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -131,7 +131,7 @@ static void handler_call_die(const char *handler_name)
 }
 
 /*
- * Insert val into into the dictionary and decrement the reference counter.
+ * Insert val into the dictionary and decrement the reference counter.
  * This is necessary for dictionaries since PyDict_SetItemString() does not
  * steal a reference, as opposed to PyTuple_SetItem().
  */
-- 
2.35.1


