Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65D4470EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbhLJXev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbhLJXeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:34:50 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDA1C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:31:14 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so11164746otv.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Nt8N5zIB+ZFt4PQrtKmfYcarGieoVBLX7P7L7hrAGs=;
        b=lhut3hdsX9eaiHdZIfjObVTJ/m4Yq0CvJzmo0iDf2hDdLp6d1/G/eo0+cAAoEtFhnl
         uYthJAs8RmTulkVXyVHvb/uUpY0LjZjZfKp0NQa08aaQXVFakm0LXgS9djyphNRGQcwd
         9L2/1NY467/DlJwIYxLrH1hMKpN0v8xmkSF0qbRobikdPnhP41S6rqkkRlsckWu+ky8y
         BXP+O0qbmUFZKuzWcrpD8wZEzwxsoewqDPCky2Uxf2VBVFlYenRoAwyNK1PVveWIAX5H
         Lhqnqo1TOpC2QbYJgS0om4HrkVGSw12tKDiVeP+6MPRIJVUXV9wttH6MmsjzvLWDtf+E
         6R/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Nt8N5zIB+ZFt4PQrtKmfYcarGieoVBLX7P7L7hrAGs=;
        b=7Os7OCrYzwa03MJ1+SIv+b9nsC1BOfBdBpiuLNbl6Ds63rjK7VCcRBdNTIKnMwO6Rk
         xpwVC74H3xU7loSLS0OasOMJGdoecrgFSGPOzVJLrEj1alZZ/hRV8eP/KMhJR8LykXTT
         uEPcjg0RD60qBvd+XBC5Jyx+sottcSe8qeKbgzFnxkMr/3LLI095aOGGO38boDKNpfzU
         UW2FiAMS82b+O376kPichQ+iRVJZqb7D/c1tePQS3BVwqJptkcSmbzzB5l6XeG34D21I
         FEt73RuOEqbRlpze0fCIv/jruikopWlrxofJ9awDQZcGeEQSWehVdrGIf5Fhl/I3sK2Y
         gFpw==
X-Gm-Message-State: AOAM5308jkh+VpBLRu5MJkYLrn+VI/YrNSfpfq0dDwP2mbQc8QHSxxTm
        qhV8Cfx8ePIq5HuvZ5XDYcJBCjIMwwdcwoD6cOg53HUuCAlhp1N2
X-Google-Smtp-Source: ABdhPJyVUCc8Ig3F7a/ryhRoRocvGMv/Eg80dXrFUB89zxKeGROVJVJBciFuVuGNoPnSIjppSLyW9lHk826uMz8o9VE=
X-Received: by 2002:a9d:68ca:: with SMTP id i10mr13271897oto.286.1639179073877;
 Fri, 10 Dec 2021 15:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20211130074221.93635-1-likexu@tencent.com> <20211130074221.93635-5-likexu@tencent.com>
 <CALMp9eRAxBFE5mYw=isUSsMTWZS2VOjqZfgh0r3hFuF+5npCAQ@mail.gmail.com>
 <0ca44f61-f7f1-0440-e1e1-8d5e8aa9b540@gmail.com> <CALMp9eTtsMuEsimONp7TOjJ-uskwJBD-52kZzOefSKXeCwn_5A@mail.gmail.com>
 <b6c1eb18-9237-f604-9a96-9e6ca397121c@redhat.com> <CALMp9eRy==yu1uQriqbeezeQ+mtFyfyP_iy9HdDiSZ27SnEfFg@mail.gmail.com>
 <c381aa2c-beb5-480f-1f24-a14de693e78f@redhat.com>
In-Reply-To: <c381aa2c-beb5-480f-1f24-a14de693e78f@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 10 Dec 2021 15:31:02 -0800
Message-ID: <CALMp9eTKrQVCQPm=hcA50JSUCctPaGLEP19biVbGAtBN54dQfA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] KVM: x86/pmu: Add pmc->intr to refactor kvm_perf_overflow{_intr}()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Like Xu <like.xu.linux@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 2:59 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 12/10/21 23:55, Jim Mattson wrote:
> >>
> >> Even for tracing the SDM says "Like the value returned by RDTSC, TSC
> >> packets will include these adjustments, but other timing packets (such
> >> as MTC, CYC, and CBR) are not impacted".  Considering that "stand-alone
> >> TSC packets are typically generated only when generation of other timing
> >> packets (MTCs and CYCs) has ceased for a period of time", I'm not even
> >> sure it's a good thing that the values in TSC packets are scaled and offset.
> >>
> >> Back to the PMU, for non-architectural counters it's not really possible
> >> to know if they count in cycles or not.  So it may not be a good idea to
> >> special case the architectural counters.
> >
> > In that case, what we're doing with the guest PMU is not
> > virtualization. I don't know what it is, but it's not virtualization.
>
> It is virtualization even if it is incompatible with live migration to a
> different SKU (where, as you point out below, multiple TSC frequencies
> might also count as multiple SKUs).  But yeah, it's virtualization with
> more caveats than usual.

It's not virtualization if the counters don't count at the rate the
guest expects them to count.

> > Exposing non-architectural events is questionable with live migration,
> > and TSC scaling is unnecessary without live migration. I suppose you
> > could have a migration pool with different SKUs of the same generation
> > with 'seemingly compatible' PMU events but different TSC frequencies,
> > in which case it might be reasonable to expose non-architectural
> > events, but I would argue that any of those 'seemingly compatible'
> > events are actually not compatible if they count in cycles.
> I agree.  Support for marshaling/unmarshaling PMU state exists but it's
> more useful for intra-host updates than for actual live migration, since
> these days most live migration will use TSC scaling on the destination.
>
> Paolo
>
> >
> > Unless, of course, Like is right, and the PMU counters do count fractionally.
> >
>
