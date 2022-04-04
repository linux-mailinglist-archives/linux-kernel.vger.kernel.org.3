Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5B64F1538
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347531AbiDDMvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240989AbiDDMvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:51:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409FA6272
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:49:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE93C210E4;
        Mon,  4 Apr 2022 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649076590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NX9TgjUsjoTpfBV0l77n3hZgxLhDy2L3l64wvrgqdzk=;
        b=1M0dkIKc+oNToF53hUGZQiBQCY99ZI8/5n7ExjBxGqJ3LJASqhwZlWyrKB53WTkJnrOHvc
        /eim40GPO4CakLmStoBpgLgMgpGl5ZUrIWKIB1w4Xh4pgwu6DDYmbbF7ep071LaW5IlvqC
        pJ2ZFF6ueocIRij1c5USLGtNGH0robQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649076590;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NX9TgjUsjoTpfBV0l77n3hZgxLhDy2L3l64wvrgqdzk=;
        b=wc+tMgWH0RYQsm+rnP7rhFVHRyjdYNz5grGHR0JjVysktRtZue+qviC0ieeiUPRr+fY3g3
        ghrS5owmAk3VC4DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF0E012FC5;
        Mon,  4 Apr 2022 12:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OEQ7KW7pSmI0DAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Apr 2022 12:49:50 +0000
Message-ID: <b7871192-8c93-e478-e93f-be9e4150dd1f@suse.cz>
Date:   Mon, 4 Apr 2022 14:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm/slab: remove some unused functions
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220322091421.25285-1-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220322091421.25285-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 10:14, Miaohe Lin wrote:
> alternate_node_alloc and ____cache_alloc_node are always called when
> CONFIG_NUMA. So we can remove the unused !CONFIG_NUMA variant. Also
> forward declaration for alternate_node_alloc is unnecessary. Remove
> it too.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Adding to the slab tree, thanks.

Included also this move of declaration closer to its users:

diff --git a/mm/slab.c b/mm/slab.c
index 4ea12ddaa7db..90b16c7ae01a 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -626,8 +626,6 @@ static inline gfp_t gfp_exact_node(gfp_t flags)
 
 #else  /* CONFIG_NUMA */
 
-static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int);
-
 static struct alien_cache *__alloc_alien_cache(int node, int entries,
                                                int batch, gfp_t gfp)
 {
@@ -3043,6 +3041,8 @@ static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 }
 
 #ifdef CONFIG_NUMA
+static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int);
+
 /*
  * Try allocating on another node if PFA_SPREAD_SLAB is a mempolicy is set.
  *

