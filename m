Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B675899B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiHDJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiHDJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:10:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88A061D41;
        Thu,  4 Aug 2022 02:10:02 -0700 (PDT)
Date:   Thu, 04 Aug 2022 09:09:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659604201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuJg6N+fhMpv3s6C9HMpwWkOH8f617D63uQS87KGQRg=;
        b=tPACn0/C+SHzAPxiXS4cV0AKNTtjNFgASjqN4NU3OjD/nLSL/RtOa90u1jFmsq0iboyM3m
        CS3vHLITt5KM5+pDonSyjvfgA80cUXgTkdil5OcUAIWs4A9jVWXV0im7JtrqpX2Kn065Gp
        WZla0RkzqcfDMvrWynGRL+y2BBFA3/EUW1tUs/NjC7ZDDpelTmgL43xEDCNfL+L50T7qIm
        tV3Df81H4Q4sKzyBboJyIbnwqm9OuZGUiO70Qwjt1lP2LV17ujNGKmM2sbQYWGT3ov6Wre
        XEzB3WAOrSbmbUw1KRKVuQH5zEJouX9MIQy53p6BsqaYCilFaY2Wp8Hofpx/dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659604201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuJg6N+fhMpv3s6C9HMpwWkOH8f617D63uQS87KGQRg=;
        b=4Kq3Nk8zbTm5w0WrKRcWolf3mwGgdCf/nppNi0Z0NWOnZidFkdrt3dyYnkUrMBBaSSPfp+
        KDjEVOaNzT1jqgAQ==
From:   "tip-bot2 for Xin Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove superfluous semicolon
Cc:     Xin Gao <gaoxin@cdjrlc.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220719111044.7095-1-gaoxin@cdjrlc.com>
References: <20220719111044.7095-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Message-ID: <165960419995.15455.14077879462438437814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8648f92a66a323ed01903d2cbb248cdbe2f312d9
Gitweb:        https://git.kernel.org/tip/8648f92a66a323ed01903d2cbb248cdbe2f312d9
Author:        Xin Gao <gaoxin@cdjrlc.com>
AuthorDate:    Tue, 19 Jul 2022 19:10:44 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Aug 2022 11:02:08 +02:00

sched/core: Remove superfluous semicolon

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220719111044.7095-1-gaoxin@cdjrlc.com
---
 kernel/sched/core_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 93878cb..1ec807f 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -205,7 +205,7 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	default:
 		err = -EINVAL;
 		goto out;
-	};
+	}
 
 	if (type == PIDTYPE_PID) {
 		__sched_core_set(task, cookie);
