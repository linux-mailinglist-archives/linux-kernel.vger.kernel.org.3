Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3650BDCE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352671AbiDVREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346528AbiDVREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:04:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187FA694B1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:01:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w16so2109529pfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJV3GlV2KoQdyezliIRHOvJPKg6R4osdv99xx1CZcIo=;
        b=NeLBxNsLeJVqpPQ4ADuaIMGol/yx7d7W9jTaQMVdmH5q1UJkhTyTwDiDbF8cCsNWG0
         GRIaF7CeL0Vx9y0fviCR7SY/1siBLcYSXTcXnXXyYyBHUUD8PwEWdODWLT4O5ia/2uDW
         1Wc4j2/kitmoTPZQGMcRkGNbUT3WLzOz1T2G9qOj79NUMJV+v6lKbxlpl9vLcJbtZgG/
         vqzNHHDx8nCZgVmTj+K8uZv2F0r1njTtoDa9XQxZU0se8Y2hgGHw3nkSPhnuw8BjdUWM
         8kNZGwQonyPvwHut92JJMPM87gGxr44hlitwuJBVnkP5fYUZLeoO8/qHz4EYasVGrg/W
         8EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJV3GlV2KoQdyezliIRHOvJPKg6R4osdv99xx1CZcIo=;
        b=AJ4IyPJciJBFXxDuGu+utXC91op8wpLrz6m4Bto/9A8maxVuBpqmxLmW/IZ/AZMQGT
         ac15tUHKX0Pxift9rhsjLM5OGlrhRnZYeWyNusnLa/b7x/PJ8j/yQw7Q7uXUvQ0DYGfO
         DCPLZAjJwDl02SkTZzpRz76tpA0zLdpVXoEjtaNWFkcjzByXGpUyA50j0kuTkmZP2sei
         vY85kp+yF/K6FqTbEMUuTTm37msm88raAdjJ2KpEU7WSSExiyzRUe41Yj3C55FUIPa+j
         n6Ydrc0CCHej/LcVaO972XmQtR7Ta1LJYPTjkbMkn2ULs3mus8aPOADVHSPDPnQKz7Xb
         cPCA==
X-Gm-Message-State: AOAM5312nF0f6GRbQR2V86gJ6ZbSzSAxIw93bzQqUobhoQv1cT1UkFAT
        1XaYDLSbdkjOhq7bsR/JbVophRlwlXZm9pzugp8=
X-Google-Smtp-Source: ABdhPJxLIJdxg9s+JC0etaHLQdHrfriwhAx0qNhcMRd3L9DLsxmSYWfY9eELllY9lmieTQEmEv6J5nRhGZKjz+B2QmU=
X-Received: by 2002:a63:90c3:0:b0:3aa:8b88:6dfd with SMTP id
 a186-20020a6390c3000000b003aa8b886dfdmr4600035pge.75.1650646872417; Fri, 22
 Apr 2022 10:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220407020953.475626-1-shy828301@gmail.com> <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn> <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
 <YmETEHnK/FiNbLO7@ziqianlu-desk1> <6f7210be7353d1c01dc9f872b2692b83f87f5452.camel@intel.com>
 <YmJKBaq1yj6/iBJ3@ziqianlu-desk1>
In-Reply-To: <YmJKBaq1yj6/iBJ3@ziqianlu-desk1>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 22 Apr 2022 10:00:59 -0700
Message-ID: <CAHbLzkriO6xWzyMNpcVFmyxSn=cqbz2qx+2mJ5d0m-beqPRCUg@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:24 PM Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Thu, Apr 21, 2022 at 04:34:09PM +0800, ying.huang@intel.com wrote:
> > On Thu, 2022-04-21 at 16:17 +0800, Aaron Lu wrote:
> > > On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
>
> ... ...
>
> > > > For swap-in latency, we can use pmbench, which can output latency
> > > > information.
> > > >
> > >
> > > OK, I'll give pmbench a run, thanks for the suggestion.
> >
> > Better to construct a senario with more swapin than swapout.  For
> > example, start a memory eater, then kill it later.
>
> What about vm-scalability/case-swapin?
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swapin
>
> I think you are pretty familiar with it but still:
> 1) it starts $nr_task processes and each mmaps $size/$nr_task area and
>    then consumes the memory, after this, it waits for a signal;
> 2) start another process to consume $size memory to push the memory in
>    step 1) to swap device;
> 3) kick processes in step 1) to start accessing their memory, thus
>    trigger swapins. The metric of this testcase is the swapin throughput.
>
> I plan to restrict the cgroup's limit to $size.
>
> Considering there is only one NVMe drive attached to node 0, I will run
> the test as described before:
> 1) bind processes to run on node 0, allocate on node 1 to test the
>    performance when reclaimer's node id is the same as swap device's.
> 2) bind processes to run on node 1, allocate on node 0 to test the
>    performance when page's node id is the same as swap device's.
>
> Ying and Yang,
>
> Let me know what you think about the case used and the way the test is
> conducted.

Looks fine to me. To measure the latency, you could also try the below
bpftrace script:

#! /usr/bin/bpftrace

kprobe:swap_readpage
{
        @start[tid] = nsecs;
}

kretprobe:swap_readpage
/@start[tid]/
{
        @us[comm] = hist((nsecs - @start[tid]) / 1000);
        delete(@start[tid]);
}
