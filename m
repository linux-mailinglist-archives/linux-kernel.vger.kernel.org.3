Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E249F7C6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347974AbiA1LCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiA1LCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:02:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1985BC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:02:17 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z19so10917860lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Fyd0Ziaw1nr9AJZhmIrLx7uDIDl3wwWJvaUZ/WDOfAY=;
        b=GSwTgVNkQwIXutDy4LJ+Pwz+w3RjKAOT8ZkOgm7LDkta98Gg0Y1EjmIZARNDa6YaB5
         jE1qDp61AAfJ4diwimfVnVXtP4/aEpzlAi8saI2jQhcM9UnTPMJJIN9WGlIJjLluGHwk
         g0MxLlZ+0gOhWroxDbTarCXUNrklE9bPKvdg3caq4sAaJ3ZBU4nqji0sArNBw0zpNR3x
         wmWj2NeRVdSC27djFl3Sb6wxVZjpHRwqMX4Q+DrQDuWqUbNLX2MgTLJcwhh7ELYDCN3m
         0SNGDAXN1/ck1b+92HmmHolroauyLmzxUIf7uEg09gkbrZ+9N9brweLGNDKKNH0HQLb2
         KJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Fyd0Ziaw1nr9AJZhmIrLx7uDIDl3wwWJvaUZ/WDOfAY=;
        b=BNnvog5zjTqHRxBlPHsoYoqiU5aHaoDIqdOqK3WYRy3Emy4YxSojwF/wzdeD+0s81k
         BJZTG50Z4mBh2BLtdsBn2p+F2oZCHaTqRK9VQRiB/g+xozZkrCrO3Waq/i8Eh6Vm0PG4
         3hgqj0/7pFYv71nE4Il3XEe9vg+lSJ4eYoRgHf/Ht0CYc3KFMVqrNsltQ5F8QaoEAVD1
         GXXZKaG5OvLhXV6awZ8VEtVpWj2YOEMd+QCBnMgJD4+VnAMVcl6ZYZQ4LrXW/oTZ1SY6
         hQAg2bkeSTX7ju+jSwKf/dWnJOYBA5L4a1bmcUlYI9Gwn+zs51CpJEva4a/xxr5AUKxz
         GzMg==
X-Gm-Message-State: AOAM530W8qfSBA4OsYlhM7bTtmtmULk+J1B7Ld16NoRpiUDr2ILtUI3q
        rGc3obBZNIkpnLtiDuZJaN4=
X-Google-Smtp-Source: ABdhPJwcbSofihC8mwwpTjjmMQDl55yQOMDYd/zmv1r8lmOwtwaC0Sqt1ujnP6YGEpl+Sb9sRAD9zQ==
X-Received: by 2002:a05:6512:3e2a:: with SMTP id i42mr5693806lfv.636.1643367735532;
        Fri, 28 Jan 2022 03:02:15 -0800 (PST)
Received: from [192.168.50.104] (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id p34sm2490471lfa.309.2022.01.28.03.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:02:14 -0800 (PST)
Message-ID: <4eee8241e35fac1fa05eee3525a10672396c18ec.camel@gmail.com>
Subject: Re: [PATCH 01/16] tools: Move gfp.h and slab.h from radix-tree to
 lib
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 12:02:13 +0100
In-Reply-To: <YfKf74qdUXrPPZHZ@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <777d0cfcf531357cfe39d53987aa964a3a42ce8b.1643206612.git.karolinadrobnik@gmail.com>
         <YfKf74qdUXrPPZHZ@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 13:36 +0000, Matthew Wilcox wrote:
> On Thu, Jan 27, 2022 at 02:21:19PM +0100, Karolina Drobnik wrote:
> > diff --git a/tools/testing/radix-tree/linux.c
> > b/tools/testing/radix-tree/linux.c
> > index 2d9c59df60de..81539f543954 100644
> > --- a/tools/testing/radix-tree/linux.c
> > +++ b/tools/testing/radix-tree/linux.c
> > @@ -14,7 +14,6 @@
> >  
> >  int nr_allocated;
> >  int preempt_count;
> > -int kmalloc_verbose;
> >  int test_verbose;
> >  
> >  struct kmem_cache {
> > @@ -78,32 +77,6 @@ void kmem_cache_free(struct kmem_cache *cachep,
> > void *objp)
> >         pthread_mutex_unlock(&cachep->lock);
> >  }
> >  
> > -void *kmalloc(size_t size, gfp_t gfp)
> > -{
> > -       void *ret;
> > -
> > -       if (!(gfp & __GFP_DIRECT_RECLAIM))
> > -               return NULL;
> > -
> > -       ret = malloc(size);
> > -       uatomic_inc(&nr_allocated);
> > -       if (kmalloc_verbose)
> > -               printf("Allocating %p from malloc\n", ret);
> > -       if (gfp & __GFP_ZERO)
> > -               memset(ret, 0, size);
> > -       return ret;
> > -}
> > -
> > -void kfree(void *p)
> > -{
> > -       if (!p)
> > -               return;
> > -       uatomic_dec(&nr_allocated);
> > -       if (kmalloc_verbose)
> > -               printf("Freeing %p to malloc\n", p);
> > -       free(p);
> > -}
> > -
> >  struct kmem_cache *
> >  kmem_cache_create(const char *name, unsigned int size, unsigned
> > int align,
> >                 unsigned int flags, void (*ctor)(void *))
> 
> I don't think it makes much sense to move kmalloc() and not to move
> the kmem_cache* functions.  They're all provided by slab in the
> kernel
> proper, so while you don't use them, I think keeping all the memory
> allocation functions together is preferable.

I wasn't sure if these functions would be used by other test suites, so
I left them here. But I can move them if you think it's better to keep
them together.


