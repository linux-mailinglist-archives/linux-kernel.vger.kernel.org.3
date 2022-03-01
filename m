Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9258F4C81AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiCADic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiCADib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:38:31 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A255AFE8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:37:51 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v4so12966846pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Y59gyCffyOhOSSUAlyy3NdXkmSMCP50vAXaPaXGgRyE=;
        b=bnUIEZJkSDNKGvslYRZbVyCXakXieB4o3Y9r3c8Ow1RmhHcCjeAOBaNbPEvWpuU6Sd
         a7T65sQzL0OVg7NHSzpW6OiWdiejkSj1jVD7lE6kgNkX0kOxYrUvJogqfZRQw9IAtCd/
         uZ0pnycsrbHUvvragrc/7P+WL7a4aqGCZbRxw2iNPRBgzeq0qVzU1jhbZknI6L0FPtuC
         cUqn0tYxD1ZH20w8lY/CE87krF53yrZlyXrqgiSjZSh1xIur3nsy1tRqSy98XEm0sog6
         SBNvoFdyNs7wHuDBqeYgoJy8NuegJRs+Oir08MoXrM93NYTYyzxJaczITuOsqlbO/xh7
         N51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y59gyCffyOhOSSUAlyy3NdXkmSMCP50vAXaPaXGgRyE=;
        b=2OkTLCApiWiAc2Y8c+dEHJuxCBxxfmpSFHBKMlJhbIJznu4GnkUitwCGmRjYNcwlre
         v48KZ1v0gEo3QuL0zjKZ2RtPC44OZ8iYIQHWJvGw4L52PhmHZru3EWIiklTMZvEt5nkm
         TwtU7LcgFzmT4HyeZo4z44AqkVHrn3XAuI0w5iEsfKLxzD63asKWsiqEtZAssHlYsksB
         nIoV+nqcAVGl0DXzXPAhfhX461JCL8LU88XTf7ob8bsSWkx4GXGWRyo9k5UONv39nWfh
         6Ap8b8KqXwgXarKCvEFxTjRUye2xHQd1ey+dyHT+mnzudj2+8+XOp1gBbEWJU42Eqtvf
         i2WA==
X-Gm-Message-State: AOAM532O5+xf9idZz7ErEqFnpm/vhJdalI8bjdQuaSyggrl21KXZKshM
        Ao6IM+qUYidHQRbgJWECIJc=
X-Google-Smtp-Source: ABdhPJyjolLvLWBYBA+jZMrMqyiu//ZW7hkqh65CJ7om8JKI+kdIDktPJNU9jnCAESr7qUYYCYXBww==
X-Received: by 2002:a17:902:b405:b0:150:2523:9e8a with SMTP id x5-20020a170902b40500b0015025239e8amr19980608plr.109.1646105871206;
        Mon, 28 Feb 2022 19:37:51 -0800 (PST)
Received: from meizu.meizu.com ([137.59.103.163])
        by smtp.gmail.com with ESMTPSA id g5-20020a655805000000b003643e405b56sm11536586pgr.24.2022.02.28.19.37.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 19:37:50 -0800 (PST)
From:   Haowen Bai <baihaowen88@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Haowen Bai <baihaowen88@gmail.com>
Subject: [PATCH] sched/core: remove unneeded semicolon
Date:   Tue,  1 Mar 2022 11:37:45 +0800
Message-Id: <1646105865-22040-1-git-send-email-baihaowen88@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
kernel/sched/core_sched.c:210:2-3: Unneeded semicolon

Signed-off-by: Haowen Bai <baihaowen88@gmail.com>
---
 kernel/sched/core_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index c8746a9..085f188 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -207,7 +207,7 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	default:
 		err = -EINVAL;
 		goto out;
-	};
+	}
 
 	if (type == PIDTYPE_PID) {
 		__sched_core_set(task, cookie);
-- 
2.7.4

