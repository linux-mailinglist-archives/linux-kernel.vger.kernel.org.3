Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA5557E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiFWOwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiFWOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:51:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF047543
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:51:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y32so33804313lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=hqvRcJBRW/zXn9o8PLaPnPcK1byd11F8xwtbZSlj240=;
        b=L3GdFJ5msAUKjEBgJr8tC0Ye/uf5rOW/nTjACFOPDVkM4uV2p2NICHRx0qbgkWRrHW
         xye3mNc9OUGNDUkdfVMWc+YCL7Uw2FtXXna0LVEbGKFaP1NtOR9VxXehiJAtnQEze01M
         zD25I3FxU8/N5GjP9dXmVKZL2giwMWH1O04S/yKV3I/NnfvtJbiXvpW1ovOGu9+QwMgj
         GBDOyIDuwc8e82tKToKvcUFx39aq2ki+Tp6x/9ooZM/+FRKSWkYPJ3fK+x6UXHRL0vlb
         /b9h4l4s9Eg3vjeZyOWNwEHeOq/ax6nMC3d26/bpwKwaZyykWOqIebfDdRo9GEwfGrzZ
         C52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=hqvRcJBRW/zXn9o8PLaPnPcK1byd11F8xwtbZSlj240=;
        b=JH/8JGUmgR6Bedd/x8+0Ip1I60a/KTlTNQQJncxCTJLY3LsjMELTUaQB1fztiuGUSh
         e8tdKAl8yEPV1DvCK6YOCg7ru35+7nCegez5SJKDVbm/bYQSLe8CA78ijPY4EwTeJ01i
         tjXhylaX4kr6KKR60Y7lHKBDIX11hATMgv1NfOQqUkrGmgdm6/I98Qr0cZ+fu/ymk57F
         qO8Cvo12wxWYGlxE+peVq93tZqs3mewFOOZXvDvIaM9qE1oteRQJtP25o1sm8kFIBmGH
         IDE/vWhwN3x4cdFXUdKIK3BHLPGbEWADRHlekRlTPsjoKF91bq77CSgZ1daP93C6MMBc
         +TVg==
X-Gm-Message-State: AJIora/u7sNsfkS6oPQxGUbF9ByRy1Y0L3hhGh3ttl8b4b5ZL09q2dlH
        z95Q7t/SJZ1g2d8KpAcuL6z9eQ==
X-Google-Smtp-Source: AGRyM1v6I/+vDXiKc4oKtXa6cXcr1Fi2ubJWusXb8148nVz1lt5JY6qWafShI9FEMt2PZmgT4xszhw==
X-Received: by 2002:a19:f207:0:b0:47f:6890:60b0 with SMTP id q7-20020a19f207000000b0047f689060b0mr5440246lfh.327.1655995915827;
        Thu, 23 Jun 2022 07:51:55 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id s3-20020a195e03000000b0047861cba7bdsm3019220lfb.53.2022.06.23.07.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:51:55 -0700 (PDT)
Message-ID: <6a0f9fb4-2ddd-8ad0-4f2a-d3780c1d9397@openvz.org>
Date:   Thu, 23 Jun 2022 17:51:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 8/9] memcg: enable accounting for allocations in
 alloc_fair_sched_group
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
Content-Language: en-US
In-Reply-To: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating of each new cpu cgroup allocates two 512-bytes kernel objects
per CPU. This is especially important for cgroups shared parent memory
cgroup. In this scenario, on nodes with multiple processors, these
allocations become one of the main memory consumers.

Memory allocated during new cpu cgroup creation:
common part: 	~11Kb	+  318 bytes percpu
cpu cgroup:	~2.5Kb	+ 1036 bytes percpu

Accounting for this memory helps to avoid misuse inside memcg-limited
contianers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8202b5cd3d5..71161be1e783 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11503,12 +11503,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	for_each_possible_cpu(i) {
 		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
-				      GFP_KERNEL, cpu_to_node(i));
+				      GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!cfs_rq)
 			goto err;
 
 		se = kzalloc_node(sizeof(struct sched_entity_stats),
-				  GFP_KERNEL, cpu_to_node(i));
+				  GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!se)
 			goto err_free_rq;
 
-- 
2.36.1

