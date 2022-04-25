Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6C50DA40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiDYHkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiDYHkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:40:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2782212ACE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:37:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A01101F381;
        Mon, 25 Apr 2022 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650872233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i86FVqThQBACMnKmzxTZYyYhQk91L6sZ3MW2wyirS0M=;
        b=Ra6JWuLZd+GZZRYsGo5v2dY0Ms5bsyy/5IgZqelD4pH0vQUZl0/C2c3uPq/fYbX/j5ENbl
        YEVemUT1VGtOTsU3F2mlMWOOg0C/Gi2PgplC1hRv/3GImAQAo995CzN36oMFwa2hNj7TfG
        o4w2E6Cxv7qXdvNIavQUX3+4nac31Ek=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6C52E2C142;
        Mon, 25 Apr 2022 07:37:13 +0000 (UTC)
Date:   Mon, 25 Apr 2022 09:37:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: minor cleanup in non-memcg_kmem version of
 mem_cgroup_from_obj()
Message-ID: <YmZPqAOLO7XkBsW8@dhcp22.suse.cz>
References: <c60767c9-03fe-2c9b-9844-752ef0df5b03@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c60767c9-03fe-2c9b-9844-752ef0df5b03@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23-04-22 05:23:03, Vasily Averin wrote:
> Replace leading spaces by tab:
>  WARNING: please, no spaces at the start of a line
>  #X: FILE: include/linux/memcontrol.h:1480:
>  +       return NULL;$
> 
> Fixes: commit 8380ce479010 ("mm: fork: fix kernel_stack memcg stats for various stack implementations")

Please drop the Fixes tag. The tag is supposed to point to a functional
breakage and this is purely a style fix.

> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a68dce3873fc..294515d06dbe 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1753,7 +1753,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
>  
>  static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  {
> -       return NULL;
> +	return NULL;
>  }
>  
>  #endif /* CONFIG_MEMCG_KMEM */
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
