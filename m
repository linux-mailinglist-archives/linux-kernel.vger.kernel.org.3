Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6252FE37
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245654AbiEUQjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355413AbiEUQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:38:57 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF662BFD
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:38:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o22so12638170ljp.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=qcH7iik2GW8EIkmCTFLKGtsxL3Zpurysxl71BOJq3d0=;
        b=V7d0heHmQbb0lFT0Ux/CBuPX/IC6qfLxB/rSo6O/O0i9wSVjG5Ip4fAl4/azlz37Qp
         o0SKGZNBkBQpcTOI1/8zTI3sf1iWzXfHKzi0xD6JmPR/cm6Pd8BvTLtWPhWK+6TIoH62
         /O8kcXjU9NyHnKAc8SOHrP9rEgcmf6/rXU0G5vRbKLhfgsZdyFOVelMZjNF0atRmcs04
         ZJOc8G8oZX0v36VwWF5fc3JG3qvu3RYUrhI57jhbV6nNKmYcTuStB46lUMnASonXo9nL
         P1eRtwHn0UWufluLGtrgtVexlM7nrm9RiBAoGwuDNoL3Lb9PCOrTMgfOpLLHajkdUvne
         AJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=qcH7iik2GW8EIkmCTFLKGtsxL3Zpurysxl71BOJq3d0=;
        b=11/oyD1/nvpe+TDyCgzYvZLprf9bVjlCQ1glowc4bfCNS4bfZToA9Ncz/oDWxJLNud
         PSCGr6FP1gp0LwKuxLuebKEPYY5+aS6IreXgS4Eny3xBaVdriMWgUB+T8tzz4YW5Qr0x
         +pkA/JZghBhlHvTtXSQHk3lkOVVYjv9j+6pGTxuWNQPj7QqR1qXR6znAXw+FizZZXNGC
         0tfyFiZgn6GC1LK1fJ4CijTopEAoD5bpAkJBX1zj6eE790xG0iN3DUnipKhtC3QMW3P8
         SZLkMRG1X0oPZqz3G+pAVO5IFC2LcNnphgJ9xNEqFErIUbmxFbRDPLxGDERjt0bD/fBk
         DypQ==
X-Gm-Message-State: AOAM5306ob+VZ/YdT5IUf6xSvrDs5M7DZSi+fFOqOz0rYMfa4C0sXThs
        vdZ/UeGUx//fbRJVGLok0Q3kGw==
X-Google-Smtp-Source: ABdhPJxjygUXX4QCAwm9KAEI1xUTwXCLkTN8Twbn6uRFx/5ZcZU1fXNfPqwcBGGidzKsSfm1TRiqeQ==
X-Received: by 2002:a2e:8908:0:b0:253:9c85:8cc8 with SMTP id d8-20020a2e8908000000b002539c858cc8mr8241083lji.141.1653151131580;
        Sat, 21 May 2022 09:38:51 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id c38-20020a05651223a600b0047855a54704sm641313lfv.172.2022.05.21.09.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:38:51 -0700 (PDT)
Message-ID: <46bbde64-7290-cabb-8fef-6f4a30263d8c@openvz.org>
Date:   Sat, 21 May 2022 19:38:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 8/9] memcg: enable accounting for allocations in
 alloc_fair_sched_group
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Yn6aL3cO7VdrmHHp@carbon>
Content-Language: en-US
In-Reply-To: <Yn6aL3cO7VdrmHHp@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a68482d66535..46e66acf7475 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11529,12 +11529,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
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

