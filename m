Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33949AB67
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390603AbiAYEuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S252924AbiAYEaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:30:07 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD2C061759
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:09:23 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id u6so34990448uaq.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7THWnDwu6SHLsgQWF0gnHbecnS5BR6fB6kU5rm9DZ+Q=;
        b=a1v6fl3Zt3097PKf35FiEm1Gjm8t4SKgKunYAfwggN+XTff2PLnMoQU/XFEJ9bUrgc
         6Ksp5ckz46OOqVDPbbkWqQjbmPPDCVmAleyp11F0CU3ilj2fiRn4VQX3e/AtPUhJt3N7
         KyhLjObNOx0JY3aAxW+2kQbK/Yf9sdjAinSH9pNv8wxwlGkV0rzc0DrlvXfzWdIpZemT
         NEuyKn1k9981+6RzV9QhV8EzLwNAyCxuLsoLvbhVt5Iayyfd+lVAt8NjLYZDxOlKBgr3
         z3lDuCJJNKl0JK987e05DUpbBE5x7K40A8Dyopv0ugcTQwEGEe5LGvXFl3QH3DtT+tHr
         vruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7THWnDwu6SHLsgQWF0gnHbecnS5BR6fB6kU5rm9DZ+Q=;
        b=DEQrcPnSjZoEi5PgNqccRwBlPznnOLBsLCU8w0Yd8oeaeJytc0Yv+WMWA4BHjY9g3H
         iT/Aq7QdUfFq8xXoli6OsXe3G78nthK4jhLmwE5UJqw3RjEREEKRwxlu1fhl2Lx54FRO
         V66QQdzaoJd6hMbrhOVwM+gSCkHnOKeJiKBoFePc1lEPQSV07g71thYa1W325Vv+qV8k
         68O50/k4cvEKnv9wwCaPMvxGU8xTpZCiDm2mEyHCHGjY3Izy3/pwz6v6+/mBgXYaLbWK
         5B2pwCJRTQIQBFj8gqJu9nUj+2liB/gZ2E89V6QUK348Qm++zuG5gyCyUmcGdBapLBYS
         /EBg==
X-Gm-Message-State: AOAM533ibsAFlJpsPMSEMLu8BCieY+V1QQxWLQsQgJyOKb7pZ6OrmMUs
        mgSBGENhaTK8V5apbrBvQOHoyaUV2Q+Hc5vSXYZdhkAr
X-Google-Smtp-Source: ABdhPJzv+lWmRqD+06XtnDKVKFRx0Ezva/u1eh6A4bO/RLSfGP55YG0ch4ngCGCy8BFO+/xxydYv8V0bN5U9gyN0kEI=
X-Received: by 2002:a67:d315:: with SMTP id a21mr6785670vsj.51.1643080162787;
 Mon, 24 Jan 2022 19:09:22 -0800 (PST)
MIME-Version: 1.0
References: <6d32f7d201b8970d53f51b6c5717d472aed2987c.1642386715.git.baolin.wang@linux.alibaba.com>
 <bdc7a556-b826-8d82-91b-8664f8a655e@google.com>
In-Reply-To: <bdc7a556-b826-8d82-91b-8664f8a655e@google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 25 Jan 2022 08:39:10 +0530
Message-ID: <CAFqt6zbN9M5wFUzLAkH3k3Wrk1Byyyh-JTDqhb5AKca0jS5vBg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon: Remove redundant page validation
To:     David Rientjes <rientjes@google.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, sj@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:50 PM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 17 Jan 2022, Baolin Wang wrote:
>
> > It will never get a NULL page by pte_page() as discussed in thread [1],
> > thus remove the redundant page validation to fix below Smatch static
> > checker warning.
> >
> >     mm/damon/vaddr.c:405 damon_hugetlb_mkold()
> >     warn: 'page' can't be NULL.
> >
> > [1] https://lore.kernel.org/linux-mm/20220106091200.GA14564@kili/
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Reviewed-by: SeongJae Park <sj@kernel.org>
>
> Acked-by: David Rientjes <rientjes@google.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

>
