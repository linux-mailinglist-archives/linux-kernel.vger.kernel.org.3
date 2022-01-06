Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC7486AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbiAFTtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243448AbiAFTtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:49:46 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB85C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 11:49:46 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id g80so10748330ybf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 11:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbhQRKPGAPIggyJ9g0z3APWYzIh00WCb+c/Ib6TJvS0=;
        b=sDxbFfhK1nEmkRcTPx63AQ977Nu23761bQrToW1bQHcWatqJH7SfH878mibQ9GMd7V
         CCyl2heLhLtiEnasD2XmAJpX8ca9VlqIlksG7LkCNihEB4k2kSn61zG601UvBTzOM/kK
         Ued+kUloR25hJeZCRSZhc2aF546992zyUQLvWtZJhFPa2owFdlUpBJyZs5U4hSEYvxua
         QX40oSECEmvH+d5pu3CzKkS+Aa/OjpwKMFxwyIpwsSRCwcQ5RQS9biF0g08QbHYssAvq
         NWJavuW3WlE6cbFHgTK/QkHxbG9KCszCEfTJrlBpJ4o2VJETyN3TrY/LGQ6gE2AKvNv3
         g+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbhQRKPGAPIggyJ9g0z3APWYzIh00WCb+c/Ib6TJvS0=;
        b=NHN+uwfm7HBT2EKJWKX3hAFTQ2aN9yHq/DK4a0glpe9Ekn2Bp88LOs4Ncq4OTkZz2+
         o55cYKIxV2ruIzt/xF6LNxBVxWodn4ZxcSc572xIgAzLZBgD4hjLJ+fSYDPu3+mSUrti
         wdbhxm/Y8AqD0p7zwN5z/a581vQaa2eqe9fn+yvsGdKv0oMoVqYlhR9uripBFfe4lyHC
         GP7O2/JfxKA5TR8iyPrFYNBHdkU8aILlrej/CLiopwvflO0u95R3ZSQRxhP8ZT8U6goQ
         4cqg6KnXcPKwWpkIuuKRhkIPaMXPgUnlgbjbcAYI5tL5fSo8WVqL9b8/TGrwbm8/W/Sw
         BIcA==
X-Gm-Message-State: AOAM530068Kxl7jdlDuFwVcCHESpBBWVtDGw2iMQDWlFSRYxYhfoWEIh
        ZcKjAAte6txjTn9ZBha7NnV/R6O8+4yCdR9XMS3IaQ==
X-Google-Smtp-Source: ABdhPJzhLhBTrEscfrMN5lRJwFkPPO7E04w4k35eQVF99NqhWbVBKh8uSp+2s1JWppRIKs1+fNz0nXBVpSOTS1jwJD0=
X-Received: by 2002:a25:ef50:: with SMTP id w16mr2171464ybm.192.1641498585390;
 Thu, 06 Jan 2022 11:49:45 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1640262603-19339-2-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NvPJ3S1xq5xm+52OoUGDyuMSxGOLJbopPa3+-QmLnVYeQ@mail.gmail.com>
 <b02204ea-0683-2879-5843-4cfb31d44d27@linux.alibaba.com> <CABk29Nts4sysjmRcnZ_DWmMzhUrianp55Zgf-Nod8m+aUKiWeA@mail.gmail.com>
 <b7b06597-b3f1-677d-863b-e6cbf6664389@linux.alibaba.com>
In-Reply-To: <b7b06597-b3f1-677d-863b-e6cbf6664389@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 6 Jan 2022 11:49:34 -0800
Message-ID: <CABk29Nv9TmfP8oN=bm_2rNvK32AVAZ4TjsGZCQUGQ8ZhgdM4kA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/core: Cookied forceidle accounting per cpu
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:10 AM cruzzhao <cruzzhao@linux.alibaba.com> wrote:
>
> >
> > That motivation makes more sense to me. Have you considered
> > accumulating this at the cgroup level (ie. attributing it as another
> > type of usage)?
>
> I've already read the patch "sched: CGroup tagging interface for core
> scheduling", but it hasn't been merged into linux-next. IMO it's better
> to do this at the cgroup level after the cgroup tagging interface is
> introduced.
>
> Best,
> Cruz Zhao

There are no plans to introduce cgroup-level tagging for core sched.
But the accounting is a separate issue. Similar to how tasks account
usage both to themselves and to their cgroup hierarchy, we could
account forced idle in a similar way, and add another field to
cpu_extra_stat_show. That still gives you the total system forced idle
time by looking at the root cgroup, and allows you to slice the
accounting by different job groups. It also makes the accounting a
single value per cgroup rather than a per-cpu value (I still don't see
the value of attributing to specific cpus, as I described in my prior
reply).
