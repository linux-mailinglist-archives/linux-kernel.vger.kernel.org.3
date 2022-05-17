Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7652A517
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbiEQOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349171AbiEQOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:41:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96FB1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:41:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y41so17039781pfw.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZRXMYALDTEfzJrYaNW6lXt081qNZ509LXFQ98V4Tb4=;
        b=RBLPzCKSyloEyfcJ2gJauS7uRn/AF2xeL0KIWvJBn6UXtfxcXiwt37LSNcoTLV8qLK
         Q3+2v7M+t7qfnPr3MLVHsQ0/tv0+xX/afV6m/Vb3TX9gh65F1VYYT8LSBAFpHMzE9Jz3
         hGyw6ibm/y+myZpdRju0tdCqZh0oRpb1G/LPoKGhQvX4dHbPvXVeL9KpZ6tx3MU4dQFv
         81FyFOQmeXqqWvIZl1HX/hMz/7BExDq9W4XKcw04AYzMXkpncUmMGsXSXJs0ecuuYeHn
         0wGVupkAjsbm1mrOGgVyn5jhfTzIbtdKt9nVggWcwQogBZNsTKCMAhbiSCsnQTInVb+1
         EfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZRXMYALDTEfzJrYaNW6lXt081qNZ509LXFQ98V4Tb4=;
        b=OJaaABuiiN5h2+q2u1zYp7YUqnotP+5gBy9ff+CVXQo3nOtwo0NBHMV+2FeSP2ghpg
         xVLLJw8j+U1/FRmNlZfku4jY+nfSSsDkZGWsbI1P+qR79Dt2YjrqjZ1m18sJfYoZjsRy
         slOOak0oIKZFwNfiQyeKBb3KpCoCmAtWQBLTepWIMAhoNnrDbdHIlj+1WpkZHwUih6nz
         iQvSMRNpV4Vl2p5B+3tJiMmSAyEC2rS4n9gF9PzKuRdYMn33ob4TM8ItZVRl7Y3BVmYW
         1Q7xIa6wni2tesfOSlCJmfaxL3BEhX0ySAC0eA3EtBfmDuOS/YrCesW0QZq2nQe5w3ve
         KL2g==
X-Gm-Message-State: AOAM530YB6Ak2sA7ORt92W/BjVD+2ol+ThVtIl3NH4n/b8qSHRBeDUiF
        COd9LMQUa2zQBiWL0fRa1Vmh3tY5xPf5xYk54RRrpw==
X-Google-Smtp-Source: ABdhPJythY7CcBjNDjJNkMiS8VsvtM0EExDHS3VL0rsXDMq/FB+LdQvTc0tfhf5HXXCtdzluspt5T40ewEXQsN+l+6k=
X-Received: by 2002:a63:d4c:0:b0:3f5:cc48:9fa3 with SMTP id
 12-20020a630d4c000000b003f5cc489fa3mr2158954pgn.509.1652798516626; Tue, 17
 May 2022 07:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220517143320.99649-1-songmuchun@bytedance.com>
In-Reply-To: <20220517143320.99649-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 17 May 2022 07:41:45 -0700
Message-ID: <CALvZod4Qd6Sr=PDGwkiJu54kGMmj_=MMDzGjJZZAzYDqgGm53A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg reviewer
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, May 17, 2022 at 7:34 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> I have been focusing on mm for the past two years. e.g. developing,
> fixing bugs, reviewing.  I have fixed lots of races (including memcg).
> I would like to help people working on memcg or related by reviewing
> their work.  Let me be Cc'd on patches related to memcg.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

Thanks for your continuous help.
