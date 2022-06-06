Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0153DFAD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352169AbiFFCa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiFFCaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:30:23 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDDD4BFDC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:30:18 -0700 (PDT)
X-QQ-mid: bizesmtp80t1654482614tc09bx4z
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 06 Jun 2022 10:30:09 +0800 (CST)
X-QQ-SSF: 01000000000000C0G000000A0000000
X-QQ-FEAT: 1XNERxhHvDk4xWDPpoQaM3JMDtE69kR0RqkASNEMLc4qdld7pEdlpP6G43kz3
        A5kkzaTgkG4Y185PJRo4wmLCQjzRuS4zJKn4KagLNQ3e3kCNa1IVAGptZwjPDeQtuK7zYad
        ISWokeVWJJn58ws8hgxS8cCplEOqBCZWU53fS8QSWUQYTjjcWZGYAGi3n7xySxqNz9HMqBU
        qvJwjImK6mogIOqboWHawqV/J79Q9zwrjT6H1ijHYrMKv204WLKcJMKa1xMMjutpUYrfNF+
        pxCTcSvKxLfVH51jYqUtQrgcZ0coG0Rvw/Cl5GuC1IdDBRRzwCPbugmMbtdUOzgnaEReliE
        EZWDiNutpGvrskJ9Eg=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     mingo@redhat.com
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] tracing/user_events: Fix syntax errors in comments
Date:   Mon,  6 Jun 2022 10:30:07 +0800
Message-Id: <20220606023007.23377-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'have'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 706e1686b5eb..a6621c52ce45 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -567,7 +567,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	 * to allow user_event files to be less locked down. The extreme case
 	 * being "other" has read/write access to user_events_data/status.
 	 *
-	 * When not locked down, processes may not have have permissions to
+	 * When not locked down, processes may not have permissions to
 	 * add/remove calls themselves to tracefs. We need to temporarily
 	 * switch to root file permission to allow for this scenario.
 	 */
-- 
2.36.1

