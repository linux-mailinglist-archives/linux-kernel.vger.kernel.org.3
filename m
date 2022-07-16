Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8F9579FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiGSNha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiGSNhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:37:16 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6740EEEA11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:51:49 -0700 (PDT)
X-QQ-mid: bizesmtp84t1658235103t7w1xz26
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:51:41 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000020
X-QQ-FEAT: DoD8xN2rKoxRd00XGB/LgIRzQWRmbxoBGTC/FBkbJV5tSlrju5SuaYtLIyLU/
        0oUjv3XNZvI7GDvsOsWc8GqIE2SU+lAXpzqXXg1zAi2iJbv64Mgrv1rcYFQLE0o2lxg/CLe
        mKzqjHdS0RLD3XfGFNnVi+lEo3p6l5XI8qAnLZGUwnsA5Z96n1bp4HteYqM8iKJIU/3ucoa
        F6JG7U4oYl1rP4xLpGAbcJHjTnEsGFW791XDlSjxBW2tV8PxCCgS92qJjWGl1hvCQmnGcyd
        In2zGP4ViytA77L8rj51mBYKbMAMVIPGkwjISPECLy2UeJ8MiQ5sn00w11qAb9oIEfXizjb
        eYLa+6V32XSXyEQE0f0gwgIWfr97pViiCf3KJGxWmCio3JIE+PQhJpN45czfWofx3KYO5Wk
        JiZOFodu4Q4=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mingo@redhat.com
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] tracing/user_events: Fix comment typo
Date:   Sat, 16 Jul 2022 12:49:40 +0800
Message-Id: <20220716044940.45032-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `have' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1

