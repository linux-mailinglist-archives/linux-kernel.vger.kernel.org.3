Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDBD54407C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiFIAUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFIAUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:20:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0424079380
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 17:20:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i15so2244162plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NNsTE+H5y4+Dn7QhD8QIrDFxBD62atmh2P9kX+CPPA=;
        b=V083dcgDQA28ZZVOOuJPiir9o22XTZPLxKELJ8SX5j3QT5Jc8euz93PV+5TovRmwoq
         WTSoTJMSIe+pMoQapwXhCU5lrvyWPO8Wr12FZ+B4L3k/6e8lLaNBKV4Zo+1F0npe4Iy0
         AhXniNhX646rMbJkJZiQ7cr5pUotuWG1b3j6X784fWZoQlzOs9ziQmq4so9vcDPD7ZwN
         m4LuH1d69WJoRTbf9k+1QvIvX9V/KdXDjzC7ZMkClHa12wFUZKdk7A5JjqSu7urcsWN6
         VJkTtbTjMaKZy8/014E++6Fr9BQf4wfZCkUQLYEBM1yz/1MkhWUaNwwRlqrkKLJUvdP3
         ieHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NNsTE+H5y4+Dn7QhD8QIrDFxBD62atmh2P9kX+CPPA=;
        b=bUagRDtIxWKo2Egw6EWnbSQ8ujW4sPOJes2jWRVyjFNG93T1jTFF73SN/Sv2EqM0sf
         G3wVVxgk49ZvPmetbU7Zc5/ZoxnuriXo46otCE4hhBXhZH2H3XMNPzFUcOmwBliXNeWq
         DMrGlU5f/hcqCaSmuiUjv2SxG8FQWHvh2StQJRvpYAwJ1Hy8gXZ4tVGyhmYqvd+bmsCf
         T1qqG2dAcFpjpdXvHtdAc7cnnWMQWavHZ9pB75XpZQH4Ue2pTaMb1UXmwtSqVLPk4cIQ
         OS8VPOW8V7W7em6fH/tWjENBZOt/aQ8z55XC6jGjVIEutFgPlaYqRqnmymsFL7cntsEh
         A9/A==
X-Gm-Message-State: AOAM530nB1uzR3np7NYucaokOKXwV0LM+9gcSOFSdXaIffdUo3/iS/wr
        u0dUk9Pupgjp1xGzBbu54Dg=
X-Google-Smtp-Source: ABdhPJz1befrH4ePaNQhNUN4Goi4HJsAwoQRAZico6X1zdYmH2PkOl47ZsPmhteCTITn2ecIqidnTg==
X-Received: by 2002:a17:902:db0f:b0:166:42b5:c819 with SMTP id m15-20020a170902db0f00b0016642b5c819mr34872393plx.96.1654734001350;
        Wed, 08 Jun 2022 17:20:01 -0700 (PDT)
Received: from longfanaikebuke.Dlink (36-236-186-165.dynamic-ip.hinet.net. [36.236.186.165])
        by smtp.gmail.com with ESMTPSA id jd10-20020a170903260a00b001635a8f9dfdsm4379614plb.26.2022.06.08.17.19.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 17:20:01 -0700 (PDT)
From:   Steven Lung <1030steven@gmail.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, 1030steven@gmail.com
Subject: [PATCH] sched/fair: Fix minor grammar
Date:   Thu,  9 Jun 2022 08:19:48 +0800
Message-Id: <20220609001948.74849-1-1030steven@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The letter 's' for 'CPUs' was in capital, and replace the word
'maybe' with 'may be' would be more appropriate in the sentence,
since 'maybe' is an adverb.

Signed-off-by: Steven Lung <1030steven@gmail.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9..f0cade37f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -960,8 +960,8 @@ update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 	/*
 	 * When the sched_schedstat changes from 0 to 1, some sched se
-	 * maybe already in the runqueue, the se->statistics.wait_start
-	 * will be 0.So it will let the delta wrong. We need to avoid this
+	 * may be already in the runqueue, the se->statistics.wait_start
+	 * will be 0. So it will let the delta wrong. We need to avoid this
 	 * scenario.
 	 */
 	if (unlikely(!schedstat_val(stats->wait_start)))
@@ -5851,7 +5851,7 @@ DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
 static struct {
 	cpumask_var_t idle_cpus_mask;
 	atomic_t nr_cpus;
-	int has_blocked;		/* Idle CPUS has blocked load */
+	int has_blocked;		/* Idle CPUs has blocked load */
 	int needs_update;		/* Newly idle CPUs need their next_balance collated */
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
-- 
2.35.1

