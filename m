Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69952FE2C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245666AbiEUQh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349958AbiEUQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:37:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB5E61616
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:37:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v9so3386162lja.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=IVDqiXzI4dIEBMTsaaQRM7ta9ARirhRNc6apB4FJmT4=;
        b=EtLP8pxVwmIKt66WFCvOclrJgEDpp4X1B1T1JnZ7B39hZcHA/QLCYXBWJxjJd8pcIn
         lPowuGK/5K7RomQjyNJyh25sw01fJiLswg8uBKe7UwNYxrTR/UYqixFMFH9Kg3zSr8o0
         kA5sXr7Clen8UoGgs9FvZsKN2VPvgHy2ziuaqbmxMaS7uHK1gl8pK6fP/ymVim8sU6Zr
         BKqoipnZGWxy1V2JtyXxotPu0Iycs57GEAoUef3xEuleqmg+XkokIek+j2p/XY6v1PAK
         zkwFtJ4C3Tkwhu0SAOsQv0JgOS6cceETuFVTySGKI/A/j54qwu1CQneG+vRqOvOqUVA1
         cJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=IVDqiXzI4dIEBMTsaaQRM7ta9ARirhRNc6apB4FJmT4=;
        b=lhPV+mtMMtyLLxfX7TCpk/hd8pUN+bouJvTC82Bf6vrAu24CCgARzRAw9+xD9A7d+N
         F/LXSaOy1VU+qJ11G6tskSF0MF5htOBolCY9CstO8bI2WKHMvVeSKXzlq/rAsOEcqapE
         p2Yglayk4zbNPM2smVRcVY9+p8deX5ZdPCgYfhaUNVw4rADCQEWKLmBRGvrV9LkODXmF
         pDLuqJhAjhi9w4OVz2rvWcgHg87QvavS7cDwlBNrMpT5Pjy/HtDR8FLeY7Wadj1WeaRH
         lgBGGxnDtzE5Ggzc8H+Pd30CsvcQYQZ/zPpq5xU7ESGo4qW5FBDUNNpDi5SLdeQm8CXd
         fwnw==
X-Gm-Message-State: AOAM530ip9yCqnbn34jKXJkVmoflLAoCfZ8QXgXQpgkXF5OUWuJIQO5L
        YH6HOTUZMmfKXeUFaKkP+HQjhA==
X-Google-Smtp-Source: ABdhPJwTeHS4NovOhmuXmVJAEPnop69XY0S2sk+u6JhnkIHtEODDGFf4FcjmtHxM/Xhv4BUHh0QVsQ==
X-Received: by 2002:a2e:96d2:0:b0:253:d8f1:66f8 with SMTP id d18-20020a2e96d2000000b00253d8f166f8mr6552746ljj.321.1653151070521;
        Sat, 21 May 2022 09:37:50 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id w11-20020a05651c102b00b0024f3d1daebasm749238ljm.66.2022.05.21.09.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:37:50 -0700 (PDT)
Message-ID: <4f129690-88fe-18f2-2142-b179a804924b@openvz.org>
Date:   Sat, 21 May 2022 19:37:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 2/9] memcg: enable accounting for kernfs nodes
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernfs nodes are quite small kernel objects, however there are few
scenarios where it consumes significant piece of all allocated memory:

1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
   was allocated for 80+ kernfs nodes.

2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
   structures.

3) Shakeel Butt reports that Google has workloads which create 100s
   of subcontainers and they have observed high system overhead
   without memcg accounting of kernfs.

Usually new kernfs node creates few other objects:

Allocs  Alloc   Allocation
number  size
--------------------------------------------
1   +  128      (__kernfs_new_node+0x4d)	kernfs node
1   +   88      (__kernfs_iattrs+0x57)		kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)	simple_xattr, can grow over 4Kb
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

This patch enables accounting for kernfs nodes slab cache.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 fs/kernfs/mount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a..3ac4191b1c40 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -391,7 +391,8 @@ void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
 					      sizeof(struct kernfs_node),
-					      0, SLAB_PANIC, NULL);
+					      0, SLAB_PANIC | SLAB_ACCOUNT,
+					      NULL);
 
 	/* Creates slab cache for kernfs inode attributes */
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
-- 
2.36.1

