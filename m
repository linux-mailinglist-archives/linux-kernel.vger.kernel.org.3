Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA052A573
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349471AbiEQO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349515AbiEQO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:56:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1984222BDB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:56:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CE02621CB4;
        Tue, 17 May 2022 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652799380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cKC6APY5ZoftNuhm4lb9vGdaZGmApWHnIuruFBcvjF8=;
        b=EsvgOYZXAJOA52xN/lTUqCsIlXN5ZMmVYITV07UM977L9CaR6InlGRTTdLg2Lw0DDnp4OW
        X23eIWkK9iVIkUGlVAKZ06QoYJXT02Y+KIRKlPHk+XC6pxaMmZkNlGVpu+MX8mNH0DYAQb
        Gg11KTYCLPtsB2+OqUDHWflj63ndB2s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B3FAB2C142;
        Tue, 17 May 2022 14:56:20 +0000 (UTC)
Date:   Tue, 17 May 2022 16:56:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg reviewer
Message-ID: <YoO3lAxwkPiByu/w@dhcp22.suse.cz>
References: <20220517143320.99649-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517143320.99649-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-05-22 22:33:20, Muchun Song wrote:
> I have been focusing on mm for the past two years. e.g. developing,
> fixing bugs, reviewing.  I have fixed lots of races (including memcg).
> I would like to help people working on memcg or related by reviewing
> their work.  Let me be Cc'd on patches related to memcg.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I am really happy to see more reviewers!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ce78f2275dc..0d5de0c553aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5057,6 +5057,7 @@ M:	Johannes Weiner <hannes@cmpxchg.org>
>  M:	Michal Hocko <mhocko@kernel.org>
>  M:	Roman Gushchin <roman.gushchin@linux.dev>
>  M:	Shakeel Butt <shakeelb@google.com>
> +R:	Muchun Song <songmuchun@bytedance.com>
>  L:	cgroups@vger.kernel.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
