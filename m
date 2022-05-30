Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7925379CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiE3L1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiE3L1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:27:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB213FD9A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u23so16306481lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=4e9cAQNYvP51hKc6KpBonPtXgR81jEqGpiEVOIyf/5s=;
        b=xizF6KRy3bFdr7qqwILsD9GKyKXrT5rRjnCMU+4tebhEx+64CxYJbtIbvsChGeZp9p
         eSNkgCkAudTzd3EKloNzUi0JiC3932qtJlaXk1tfWhx3CZo0+1/dlrPo2A0+4lDBNj1/
         oy6OpdKdMux4+Yco38Cdoh1Ak2+Q7U0JVjDpaDnR9IQhAyAgrDsDlmf9XZ7w9jnPg8hZ
         6lVTYkwk7E555m7EJX5Ebmj9BJHMo+oyNavkwL/xerfAMHsVuJKLEuhAr+reY72Zpvms
         GKxs7z2KmJmMOOMUjpCHbYKh3Q965rKnTT3EtDdZNmVh1yEu4+GEDLRkHsOXns+JVJmo
         onaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=4e9cAQNYvP51hKc6KpBonPtXgR81jEqGpiEVOIyf/5s=;
        b=k6HJtawU8D0fczX1FBb1qzq4DKY59V+QvWHIV7zQItJJq+b5UrvmQjqot2edr4HGLY
         GRRYi8wOntjfrFkLJpEeALnJ9Z8+A/N5WERQFqF4db4Xp1n9KwI/eB5cMQpIrQRqXzc4
         JY3Xal2X1gejtFd/kHtwkzfk8Ef3yhzOmD6J1ur4PPo/jr6t84dFLV5Shi+u+DK2LTuP
         FIgryyHifV4bCyHXOI5+fUSp3b9FwJBGIu7VdDjLExwkBLKSP8l1S1hQnqVLFz8HflEI
         4OcjjSfuWDtwrLsCFaCYYZq32BwiBmBH2dUrlGlHjhJSu8be+D0JrnhOvFXtR3fpaMNy
         i+Ng==
X-Gm-Message-State: AOAM533st5rx3xJ3Q1CmSiSfuIDpEM4n68KD9qo8njhQBXwH50Ajlcpn
        By/Q6DaQGFEkH+3XlwoTsBOuWQ==
X-Google-Smtp-Source: ABdhPJwF1AwMaj291W7nGiUPQz5B+WwYAG2NqIo/7HzPTtCYWTM7nFaT7vdg6FgpWglp2bJz7VaG2Q==
X-Received: by 2002:a05:6512:31d0:b0:477:ce21:fa6d with SMTP id j16-20020a05651231d000b00477ce21fa6dmr35830913lfe.219.1653910011534;
        Mon, 30 May 2022 04:26:51 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id be10-20020a056512250a00b00478cd831077sm1308038lfb.271.2022.05.30.04.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:26:51 -0700 (PDT)
Message-ID: <3b524f9c-c078-1118-9385-7e57cb5a0347@openvz.org>
Date:   Mon, 30 May 2022 14:26:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 7/9] memcg: enable accounting for large allocations in
 mem_cgroup_css_alloc
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <cover.1653899364.git.vvs@openvz.org>
Content-Language: en-US
In-Reply-To: <cover.1653899364.git.vvs@openvz.org>
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

Creation of each memory cgroup allocates few huge objects in
mem_cgroup_css_alloc(). Its size exceeds the size of memory
accounted in common part of cgroup creation:

common part: 	~11Kb	+  318 bytes percpu
memcg: 		~17Kb	+ 4692 bytes percpu

memory:
------
Allocs  Alloc   $1*$2   Sum     Allocation
number  size
--------------------------------------------
1   +   8192    8192    8192    (mem_cgroup_css_alloc+0x4a) <NB
14  ~   352     4928    13120   KERNFS
1   +   2048    2048    15168   (mem_cgroup_css_alloc+0xdd) <NB
1       1024    1024    16192   (alloc_shrinker_info+0x79)
1       584     584     16776   (radix_tree_node_alloc.constprop.0+0x89)
2       64      128     16904   (percpu_ref_init+0x6a)
1       64      64      16968   (mem_cgroup_css_online+0x32)

1   =   3684    3684    3684    call_site=mem_cgroup_css_alloc+0x9e
1   =   984     984     4668    call_site=mem_cgroup_css_alloc+0xfd
2       12      24      4692    call_site=percpu_ref_init+0x23

     '=' -- already accounted,
     '+' -- to be accounted,
     '~' -- partially accounted

Accounting for this memory helps to avoid misuse inside memcg-limited
contianers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index abec50f31fe6..376734af8935 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5064,7 +5064,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 
-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
+	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL_ACCOUNT, node);
 	if (!pn)
 		return 1;
 
@@ -5116,7 +5116,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	int __maybe_unused i;
 	long error = -ENOMEM;
 
-	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
+	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL_ACCOUNT);
 	if (!memcg)
 		return ERR_PTR(error);
 
-- 
2.36.1

