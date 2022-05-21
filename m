Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA9752FE28
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350665AbiEUQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbiEUQiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:38:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A7460DBE
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:38:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p4so17587049lfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=RmbAIVvF6HA8xSsvLvM24CBpM1SuThxarZu9EjTYW2g=;
        b=M71piTm4QZ2DLh7IhmfELsYTvMjovz64N6L4bc7j7NKyHPlOrc2Zi9Xwk38DW64VN+
         7bH5RKLiIHTSQpVq+jOGo3auyXvFr+ZKHqS4gcHwTZm1EIykS44nrpPaLiYLVyfTiHEe
         xKLSGhYsd0plkaeN/1Jvr53qHXecz6RYfUSZrDvrkMfxtCeZPAjjEc98ScxJ4sM6HJXK
         oOd8QKCzmgM3xikU3DAVc1HkiumoMe5ymxFZCvjWB2fnVHLi10YLibLTSX/wXOUkAEFZ
         KlEbX6CEFOKKGiVh3E0J5iiAHnMRS6ua48EE4OPGd8SAMk3Rd/wdSn9aM5tYwh98PtQ7
         LLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=RmbAIVvF6HA8xSsvLvM24CBpM1SuThxarZu9EjTYW2g=;
        b=N9gp5gHa3yrjs/gK+MLCKgVZbq3Ke4I5I6gcWEzcBbr0WRF9a9qatV2xInqKhijGFB
         Mktj6Jtrur7wfOX/Rqk8QKcuHJs+XvPtfnw1XrAGGR+f43PEPSiyLRPaaojdjj51dfK/
         yshxNEUiDSZXk2DYORJU5N6SrgQc3Fp9pkQadbUOTS5NImRh54toXyGs9CBS+hDlEbFc
         dB7dS8yc8WfmxfSAfxYQ+OYi+3SovrMkxGRwAh1cTvC/ERKlOOYm3Gl82tRdkiAufbVl
         a2KwCwGH6f9UBv52JyOmbnpmep+I4OH0VKjW2z1mbzhc1BgIF01Q2mUwYzODLPeRY/Wo
         MKKg==
X-Gm-Message-State: AOAM533oJ7RYkeh1EzJAx69WwFR7WPMErDaQtDi1wZdyaiWBxwnmwkCa
        aXzB5t2M/Ib8wajWqu4Z0yf8RA==
X-Google-Smtp-Source: ABdhPJxi3Tmu3Z2yv3O/1Nib/iVtyL3aPOp6WRbOKPKbZRX6++ivLJPbV1LaKb0QhUqpaJtfJ02HOA==
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id bp8-20020a056512158800b00477a5564ab2mr10655943lfb.376.1653151092288;
        Sat, 21 May 2022 09:38:12 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id u6-20020ac258c6000000b0047255d210dbsm1123031lfo.10.2022.05.21.09.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:38:12 -0700 (PDT)
Message-ID: <b69d2389-3a1f-d0bb-6a14-83473fe2d815@openvz.org>
Date:   Sat, 21 May 2022 19:38:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 4/9] memcg: enable accounting for struct simple_xattr
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
1   +  128      (__kernfs_new_node+0x4d)        kernfs node
1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)       simple_xattr
1       32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)

'+' -- to be accounted

This patch enables accounting for struct simple_xattr. Size of this
structure depends on userspace and can grow over 4Kb.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 998045165916..31305b941756 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -950,7 +950,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 	if (len < sizeof(*new_xattr))
 		return NULL;
 
-	new_xattr = kvmalloc(len, GFP_KERNEL);
+	new_xattr = kvmalloc(len, GFP_KERNEL_ACCOUNT);
 	if (!new_xattr)
 		return NULL;
 
-- 
2.36.1

