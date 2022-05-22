Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7373E53011D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 07:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiEVFmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 01:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiEVFmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 01:42:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7A43A5DF
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 22:42:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so14769065pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBI59+/Mk1qcvOSbPvYhnqJ5zoTVecAGEJlppXiLu6Y=;
        b=O/ph2IYRp0V2AhfsaXi9hMpSgWZnCWLqgH2Y1fhsQ4BTcb29O2tpqYIvertEUoZJvU
         2KyONSlo9FbFjT/ZgjQcJ2mXq9Ax980XqP34dHTA7HV/j9BfKN6Tbwdgtz++f51xT9vI
         aRe0v+4hxg4W+myKeX1IARf5Adt41maG9WVkk5N4nzzBp9yG2MxFucBsNn2MlDcpPMrZ
         8ERA+hOm01p9hg38D7aZcddaBNMl3OhjzwM4fwCmDLB15Yzx0onEil3kIcst6U2oqXtA
         JYtmPIOrcvaQEjIHl40Sl7arNZbd5D0olOBrO2HH0W0Riy+P+PGQMlu7aA4PcA+vVJRq
         GJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBI59+/Mk1qcvOSbPvYhnqJ5zoTVecAGEJlppXiLu6Y=;
        b=tXJwuHdJxEp9EssQDlRGPrnUVcVqH6LKiBLljeUL1ucOjw6WpD+736TyLy1oBdsW0S
         tDbjKaFJIIUqBbVY71GOmjlUb+S/7rEYBjdBzoBord2Nwki47L4HOMox2Jq5i3Uw3Xuq
         cm26lQuJVSR3Uqug5++eH2C2jEohOci+i/32emeM38pwgUBElyyDSAYGjjYBD181hUl5
         DkslfPetC78nH5dox+WHg7sfAvH1WL0TtYFZTxZrIXbfDNJ65he6+Z03J4dsK1sdx3zV
         h+ubN4no+ZssSXrclmrPPak9KoxUeKHU1owQ9Pgy7q8o4Jp0ifUdmToZxLvpVfdicNP2
         lPag==
X-Gm-Message-State: AOAM530LPg92ZLY8xs7zUNmX9IAbY8w7cucw1SJLJ0RCk5bNwt1KUh6j
        2gOG/lExAU92K/LwfgtqtaXXmxMu9tPoa4xuLXS7Ow==
X-Google-Smtp-Source: ABdhPJwR4FMIytVbwpKHhsZNCCzLlAtdPgrtrkhOElmwuPvCrD2KIe9ndhBtVpJiB5yO0xWGi24/9ogYkEZNoiZ8TZY=
X-Received: by 2002:a17:902:b094:b0:15c:dee8:74c8 with SMTP id
 p20-20020a170902b09400b0015cdee874c8mr17212912plr.6.1653198141149; Sat, 21
 May 2022 22:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <0c73ce5c-3625-6187-820e-1277e168b3bc@openvz.org>
 <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org> <YomzXwN9rvCGAZJ0@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <1621d82a-439d-0657-2b7e-5e90c42c2087@openvz.org> <YonH2AqfEFYKrUV2@n2.us-central1-a.c.spheric-algebra-350919.internal>
In-Reply-To: <YonH2AqfEFYKrUV2@n2.us-central1-a.c.spheric-algebra-350919.internal>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 21 May 2022 22:42:10 -0700
Message-ID: <CALvZod7pMwN+bO5HXySiOg5k-G4s15mR0K5b_AShMdK+_DbRtg@mail.gmail.com>
Subject: Re: [PATCH v4] tracing: add 'accounted' entry into output of
 allocation tracepoints
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vasily Averin <vvs@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 10:19 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
[...]
>
> No strong opinion but just a concern that maybe later someone want add
> something similar like 'reclaimable=true/false', 'dma=true/false', ...
> and I would prefer more general solution. (especially if we'll not
> change tracepoints after release because of backward compatibility)
>

There is no contract for tracepoints to be stable and can be changed.

> > For my task it's not important to know SLAB flags, I just need to understand,
> > is current allocation accounted or not.
>
> SLAB_ACCOUNT, SLAB_RECLAIM_ACCOUNT, SLAB_DMA, ... etc are SLAB flags.
>
> 'if current allocation is accounted or not' depends on SLAB_ACCOUNT
> flag is set or not.
>

allocation can be accounted due to __GFP_ACCOUNT as well.
