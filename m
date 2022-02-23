Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02FC4C0A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiBWDZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiBWDZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:25:00 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E21751E41
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:24:33 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id c1so3952131pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UBCffEif1jdF0yN7RTCvuEffHuLFPiypPx80tPtta4U=;
        b=mNTTSYB1a354+R9HJGidtEfr7ne1yp0eayHsfwMLZJDhOGJhc4VV+7fB55RYZIxjbP
         6bRPDuJiP4RjCnPyPqtS4SEefRz6oZs46FS25aJDClb5yum2vH+cZ0RPaCTnp5VevHXr
         YGogeT6K4jMFFz7QFxy1ZEz/Ya/LnbdanwQNM5X6onIBXupCfYEN/bvNHO/ktGSoRCp+
         kdCwYvDXcXxjm5pWP2P3m2HqihAUB57ENIH57nyXabRUPs4eHBbt8ioV7XDzWyZGrP8G
         uwnf9FULfuiE3TXZYu550wxcYMrdL3INEv3jusx9KZ75NFI7B+sbZQCqGmi+0sll/uRW
         XJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UBCffEif1jdF0yN7RTCvuEffHuLFPiypPx80tPtta4U=;
        b=sLNRmIqi5zvEr6aPkO8w+8uZznTcAFAc38lQ0aLhq3oP6jo4IXAH5vql8PvM72uiRO
         cWR7rymELelj1M9B3NcK4QJa6hoT6vWsYDWhQcg/njICZ8AC//4nXgOAiH2aZkgidA/6
         xaOEhDCw/eAr775GkNmMMBB25yQ/+Nff7g5lPdSiDX/3RiqlU4Luxadt1EYfgymNSdhE
         biCDbvUP+XTNYeKql4j8QuptmaReA7EbIp41tihMTkTrKSjaCNCV83SZbigrbCBuUVnM
         cZLrmAs2N+rzLWVET3P9Go+dfikme6Y9f846sDSzii4KI/MuDoNqPinYQwScxvalEJwj
         /RYg==
X-Gm-Message-State: AOAM532Rbi3Lf1msqVEkuvE/EH6LOPlR/jZ8hvKlrgMKq2jog1sT94l8
        kODdU4Ok9qlHxjQ1zn6y9qI=
X-Google-Smtp-Source: ABdhPJy02H/cvtT8Xyn+UrRfVn92L2YEnqS2a9gDo7C5tgl/TPssQnnupPpwy2mA8feNjw/UIlEk+w==
X-Received: by 2002:a63:e817:0:b0:373:8abb:2c51 with SMTP id s23-20020a63e817000000b003738abb2c51mr22196666pgh.185.1645586672598;
        Tue, 22 Feb 2022 19:24:32 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id w2sm18224124pfb.139.2022.02.22.19.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 19:24:32 -0800 (PST)
Date:   Wed, 23 Feb 2022 03:24:27 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 3/5] mm/slab: Do not call kmalloc_large() for unsupported
 size
Message-ID: <YhWo6yKaHHE2O1xc@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-4-42.hyeyoo@gmail.com>
 <YhO1g3k00TeM8PTQ@casper.infradead.org>
 <YhSaeKIBNbG81I07@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <YhVAjMqYPNUBC4rY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhVAjMqYPNUBC4rY@casper.infradead.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:59:08PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 22, 2022 at 08:10:32AM +0000, Hyeonggon Yoo wrote:
> > On Mon, Feb 21, 2022 at 03:53:39PM +0000, Matthew Wilcox wrote:
> > > On Mon, Feb 21, 2022 at 10:53:34AM +0000, Hyeonggon Yoo wrote:
> > > > SLAB's kfree() does not support freeing an object that is allocated from
> > > > kmalloc_large(). Fix this as SLAB do not pass requests larger than
> > > > KMALLOC_MAX_CACHE_SIZE directly to page allocator.
> > > 
> > > I was wondering if we wanted to go in the other direction and get rid of
> > > kmalloc cache sizes larger than, say, 64kB from the SLAB allocator.
> > 
> > Good point.
> > 
> > Hmm.. I don't think SLAB is benefiting from queueing that large objects,
> > and maximum size is still limited to what buddy allocator supports.
> > 
> > I'll try reducing kmalloc caches up to order-1 page like SLUB.
> > That would be easier to maintain.
> 
> If you have time to investigate these kinds of things, I think SLUB would
> benefit from caching order-2 and order-3 slabs as well.  Maybe not so much
> now that Mel included order-2 and order-3 caching in the page allocator.
> But it'd be interesting to have numbers.

That's interesting topic. But I think this is slightly different topic.
AFAIK It's rare that a workload would benefit more from using slab for
large size objects (8K, 16K, ... etc) than using page allocator.

And yeah, caching high order slabs may affect the numbers even if page
allocator caches high order pages. SLUB already caches them and SLUB can
cache more slabs by tuning number of cpu partial slabs (s->cpu_partial_slabs)
and number of node partial slabs. (s->min_partial)

I need to investigate what actually Mel did and learn how it affects
SLUB. So it will take some time. Thanks!

--
Hyeonggon
