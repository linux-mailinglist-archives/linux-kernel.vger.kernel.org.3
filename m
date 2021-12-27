Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A2847FC8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbhL0MUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:20:00 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:39097 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhL0MT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:19:57 -0500
X-QQ-mid: bizesmtp48t1640607586tgddolbf
Received: from localhost.localdomain (unknown [182.148.15.121])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 27 Dec 2021 20:19:30 +0800 (CST)
X-QQ-SSF: 01000000006000203000000A0000000
X-QQ-FEAT: 1al0Ay5k4U0ecPCTT8jfLuHbwr587YXUBXorn5bX34A/1lJPX9qGPZIPLW1aU
        b8lnUdlVDUmzkGdhHSz8ANG3CuCdidFMzFKGr06xKJH3JIcthqea14uklvz+8IniI4wrEyV
        Es8Hg1ayoIsy7o9cKHtHDnt445fP0VIfjrhYEQ9hhIYU0tvIiT4p6re3/TTCYW8h4NBmGai
        601ZmQ5fPV1gqluUnhqiBDXzw41CUOqKUD8NN/UCejl9ZuG6k625xteF/G3yH6WZ3TCuY93
        ABGYFj2nHC+zl819XUuXU1hgpWqduA1ftRI1vJiUrH02FxNtF1JGJ9mml1TquuiqqHUYBWO
        9MMsef3cg5tNmiVFXA=
X-QQ-GoodBg: 0
From:   Chaofan Li <lichaofan@cdjrlc.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, Chaofan Li <lichaofan@cdjrlc.com>
Subject: [PATCH] sched/headers:return true/false (not 1/0) from bool functions
Date:   Mon, 27 Dec 2021 20:19:22 +0800
Message-Id: <20211227121922.15099-1-lichaofan@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chaofan Li <lichaofan@cdjrlc.com>
---
 kernel/sched/autogroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/autogroup.h b/kernel/sched/autogroup.h
index b96419974a1f..238ac9ee9dde 100644
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -43,7 +43,7 @@ static inline void autogroup_init(struct task_struct *init_task) {  }
 static inline void autogroup_free(struct task_group *tg) { }
 static inline bool task_group_is_autogroup(struct task_group *tg)
 {
-	return 0;
+	return false;
 }
 
 static inline struct task_group *
-- 
2.34.1



