Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAA57B38D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiGTJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGTJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:13:06 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30C6A31202;
        Wed, 20 Jul 2022 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=swMyA
        Q1wYL/KmkzxV6qPZe+Wkp4Kniua9t03hTRYu0g=; b=VE16iW9f4rpDlkc1DBomq
        jszlskLV8iLrr47QE0heYaco3KKT+KTscEbrwkO8eqDQSnHIT7k3uoocGT1JwBj4
        A9JSZ7VSsgsAy1pFxO/cnqdn2u3Ga6UT+9q2KGjSDRkpD8LxuWYgI1Ro3ik4f3+Y
        NyVDp4Lux1h/ERjeT3E7Z4=
Received: from localhost.localdomain (unknown [223.104.68.229])
        by smtp13 (Coremail) with SMTP id EcCowAB3dlj6xtdiBJXxOg--.1197S2;
        Wed, 20 Jul 2022 17:12:29 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] perf/core: Fix typo
Date:   Wed, 20 Jul 2022 17:12:20 +0800
Message-Id: <20220720091220.14200-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAB3dlj6xtdiBJXxOg--.1197S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrWw4xCw45tr48uF4ktr4rGrg_yoWxXFg_Gw
        18Xas29r4FyasxKrZ8Xa92qr1jgr4UWa4Fyws7tF98K34jga4Ykws5JrZxAr9xJanrZryU
        tFsxGwn0qr18CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUU0tAtUUUUU==
X-Originating-IP: [223.104.68.229]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDR1EZFaEKAL21QAAsr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typo.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2573673be8f3..7dd15bdb1f22 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4457,7 +4457,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 
 	*value = local64_read(&event->count);
 	if (enabled || running) {
-		u64 __enabled, __running, __now;;
+		u64 __enabled, __running, __now;
 
 		calc_timer_values(event, &__now, &__enabled, &__running);
 		if (enabled)
-- 
2.25.1

