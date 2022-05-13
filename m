Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9AD5259C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376543AbiEMCka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376457AbiEMCk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:40:26 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A88284927
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:40:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j6so6453070pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtvUV6zT7Ei7z7xfN5FJ0eQzKGzKa5OtK6n50sHbFso=;
        b=Ijq56PSZuO2toBDYBakVHR7A8XQ1FMENZJSFqvWXq2XVvscaFxG7KG6sbh7RT5pPLp
         /kjxOq8oHxgU6xQvPzqF68WoHmt7bTpDVqBEl0jEuKPyor85Qe+TMUEjiBXi68nBet3y
         fGZbqUELrTsUVQ3UQ1KgqxGzUAbZzhLMirQ9m/X2AZHEiTTurD8U5hnSoWBshm2EAbew
         63gXeq3wB2kzYfhpg/UKnKg8/ln8Jh3Vi+ndPzH1HIITCLSgeUWFbaePHuqsp3JJ3qXy
         63JcyMI3kqEda3swGQLvFsmyXV7B4GZRRyP7lAzvXG2EdL0l3QpLKOlJ83chneqK8AtZ
         uXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtvUV6zT7Ei7z7xfN5FJ0eQzKGzKa5OtK6n50sHbFso=;
        b=U7hJoPXyHP8WarZmU18mLs/j7ulhQxdnym4u7lVU3Ll+KIkK+I43Th1BwBG1ZDayot
         uwD3jH3XLn0gl3k9z0s95/vRisGujLL3sFNKLYQKV37ZXuEJVAESwcoSx+46/3h1Yvs4
         7eALTpfgKW16dEtakI/H5NzJSZ9NcZnCONFrRGnPIWVA20N6YMBb4ntdvobTqE/c1Gfs
         KVEvWXlzabzpls0LeltWuMpVfodQJdmYcaquRBvSmF/mXmPwjhxFXTxXjKOgQMAPReHX
         5GIGiKBRh3V9qsZucqfkbIvT/L69sBo4xc4pbwZY0S2RTu8tY8KuGArE9SbsreJjJDSv
         2WQQ==
X-Gm-Message-State: AOAM530QZDWA9ldvYQLAA3X++B/w0EfOSybnEKXq2J8M2RaCSeKItSei
        V5VPAXTlhMKUcmrdHlNMG7/8rEupcYJH8gB+5Q1rxnt6
X-Google-Smtp-Source: ABdhPJzIxxaqgu3vOLZoIjHVAIopPDnxRh5xRoBTBYgoUlcN5j+ZD7mWvkDYqaZ9RDmuQKKWuRi+wMi9x6dqixnZqt8=
X-Received: by 2002:a63:1856:0:b0:3da:eae6:ca4f with SMTP id
 22-20020a631856000000b003daeae6ca4fmr2056278pgy.587.1652409625866; Thu, 12
 May 2022 19:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220317065024.2635069-1-maobibo@loongson.cn> <3a441789-b3e4-236e-2e44-e7a1c7258a94@redhat.com>
 <YmrB/7ehG2kj2RMn@xz-m1.local> <20220512173620.2f5175c7a321e6ccea6e58e9@linux-foundation.org>
 <8c1fc6d4-7d3a-85dd-ebd9-fc8e221f1878@loongson.cn> <69c4f018-2012-8af5-569b-289d2a8a80f5@loongson.cn>
 <20220512184908.0852e1efcb6fd78aea52b557@linux-foundation.org>
In-Reply-To: <20220512184908.0852e1efcb6fd78aea52b557@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 12 May 2022 19:40:13 -0700
Message-ID: <CAHbLzkp-as+a9boJr5nU4TNzxhfn_zzEx+74-gv+WKGHyHg0PA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge page
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maobibo <maobibo@loongson.cn>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 6:49 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 May 2022 09:29:07 +0800 maobibo <maobibo@loongson.cn> wrote:
>
> >
> >
> > >> and/or changelogging.
> > > Sorry for the late response, the mail is filtered and I did not notice that. The result is not so obvious after bandwidth is improved between nodes, it is only about 1% improvement for specint2006 for 32 core on my box.
> > >
> > > Now I do not see negative effective about this patch unless user wants to keep some cores separated from khugepaged daemon process.
> >
> > Can we provide an extra parameter to let khugepaged daemon scheduling binded to node or freely? If can, I will provide updated patch.
>
> It has always surprised me that we have a single khugepaged thread.  If
> we had a thread per node, you'd be all fixed up, yes?

Actually I was thinking about this before, but I didn't see too much
benefit with this approach TBH. The khugepaged scans vmas and the
mapped pages may spread on all nodes. It is not like kswapd which
could scan the LRUs for the specific node.

>
> Ditto ksmd.
>
