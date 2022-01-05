Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4189E485BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiAEWx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbiAEWv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:51:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B81C034000
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:51:57 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so1098914otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRh+AxN1SKs9JlRo4qZ0RFdMICo2/fomT2kNzxO2p68=;
        b=AJ2Hph8NuF5lvpIdO8l9446b1i/7pjZoaXMicjA5dBbx836WEQhoZQgyo6VPfnASCE
         UYtl7kgsDPaPZQZSQtWBBCe+2u96rE3xl/T8BbMJqVvZk84O0N/nw8FbV5hpY/MnDZrY
         Wqlt4xX6KARDAwsMOZA0r/ydD2JuVaTTtb0qn8i49xfmgIQJY/J+rP6blqhFu6A+YawG
         2rBFq+j0OossdgTcFcHtJaWeR99Rq9vAvukUQPSVzfPx9cgfUkOeWqxXqGwmsmXg/riT
         rbrPKObUcs6PlnIWoDtSHPGSoKKv2h3gXNP9IRxX823yKTSj1r5aWL+6X4oB8EJ76MzN
         btyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRh+AxN1SKs9JlRo4qZ0RFdMICo2/fomT2kNzxO2p68=;
        b=0w/s2G1HEoZOYJ2wJ9WLIhtiETxoETUdWpPE3IjMt6azinlFNltdnDHjS+lUSfYGhL
         LYMp9IiM4qW3mGHgdA252m1WpFy6oHKWPgAOfVgTW6aJYylFA2AEwQbv/vUCYpmIMgwB
         dzZjVjMMeiGi+a3lJ6Kwq4dxqrVpQX2Y1ldYpE0niMqmGVHHrxuJprpXMYL9U4ulrc48
         Z5c3psEBBMSLLkLHPEsRNmQJC/HED99i9ESbKRI8HKE7H54wpRFTN0wWu/JxPsufo8fB
         3cVDvN7oqBqVtmFta0ED96sybjoV/0Id/6mg8/qq3MycA1H1qoEgYpcLS4/o0eZmBon8
         n/pA==
X-Gm-Message-State: AOAM531YdeNNr2TlMLipESPYVvMXCPTnT30ctaWNiXinBw7ffejinWu0
        C8JxNSxUBvz3woJgsMfZAQXSq41Wzxci4ELfD4alwg==
X-Google-Smtp-Source: ABdhPJxb9CzJIsfVy90wyaAPuF99n20endVT8kYcg2HVTpgbJ2dwEq9m3bKWp7pg3xrsTOD/xM78FhWyEBD1Wue8bpg=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr42474949otn.299.1641423116181;
 Wed, 05 Jan 2022 14:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20211222133428.59977-1-likexu@tencent.com> <CALMp9eTgO4XuNHwuxWahZc7jQqZ10DchW8xXvecBH2ovGPLU9g@mail.gmail.com>
 <d3a9a73f-cdc2-bce0-55e6-e4c9f5c237de@gmail.com> <CALMp9eTm7R-69p3z9P37yXmD6QpzJhEJO564czqHQtDdCRK-SQ@mail.gmail.com>
 <CALMp9eTVjKztZC_11-DZo4MFhpxoVa31=p7Am2LYnEPuYBV8aw@mail.gmail.com>
 <22776732-0698-c61b-78d9-70db7f1b907d@gmail.com> <CALMp9eQQ7SvDNy3iKSrRTn9QUR9h1M-tSnuYO0Y4_-+bgV72sg@mail.gmail.com>
 <bf7fc07f-d49c-1c73-9a31-03585e99ff09@gmail.com>
In-Reply-To: <bf7fc07f-d49c-1c73-9a31-03585e99ff09@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 5 Jan 2022 14:51:44 -0800
Message-ID: <CALMp9eQmO1zS9urH_B8DeoLp30P7Yxxp9qMwavjmoyt_BSC23A@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: X86: Emulate APERF/MPERF to report actual vCPU frequency
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <likexu@tencent.com>,
        Dongli Cao <caodongli@kingsoft.com>,
        Li RongQing <lirongqing@baidu.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Thomas Gleixner (kernel-recipes.org)" <tglx@linutronix.de>,
        "Borislav Petkov (kernel-recipes.org)" <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:48 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> On 31/12/2021 9:29 am, Jim Mattson wrote:

> > At sched-in:
> > 1. Save host APERF/MPERF values from the MSRs.
> > 2. Load the "current" guest APERF/MPERF values into the MSRs (if the
> > vCPU configuration allows for unintercepted reads).
> >
> > At sched-out:
> > 1. Calculate the guest APERF/MPERF deltas for use in step 3.
> > 2. Save the "current" guest APERF/MPERF values.
> > 3. "Restore" the host APERF/MPERF values, but add in the deltas from step 1.
> >
> > Without any writes to IA32_MPERF, I would expect these MSRs to be
> > synchronized across all logical processors, and the proposal above
> > would break that synchronization.

I am learning more about IA32_APERF and IA32_MPERF this year. :-)

My worry above is unfounded. These MSRs only increment in C0, so they
are not likely to be synchronized.

This also raises another issue with your original fast-path
implementation: the host MSRs will continue to count while the guest
is halted. However, the guest MSRs should not count while the guest is
halted.
