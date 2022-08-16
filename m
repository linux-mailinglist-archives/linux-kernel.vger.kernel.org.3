Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AB25955F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiHPJNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiHPJMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:12:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5B4E832A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:28:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 12so8563069pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QSsvuBZDO6bQt7jMT8PKkHwExip9fgIO0FXnSkmtOLk=;
        b=RzaFy7uxM7dLXAC9uTuCwFu9xZdylyuHTcQY5sXMgf0qcUR6F80o4FSfYUl6LsKb18
         eKKaEDcBFEj8KEE25R4eiQicNoE0nvyA3uPLEGN99i4S/biwNeKT0tSs5OPdGvNRFRMf
         mdlNRYmF1cJ8IPEjPhj9GRA00wL4UX6cChiP1CF2ym3e0aRyvi+gjWODjd4/ADB+8Dfa
         mDu2BnrGYmPOX/rPV8H1oKf36tM839ayW4AmRUr802rWpP44jEsGUfDGqU+Tp0BUq8qc
         V2+u2gSlgj1xW5lGb9yD766+99jRW6GV8siW5uZvhoOYmf3Fhm83/IQEBQtGitVBSGD0
         qLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QSsvuBZDO6bQt7jMT8PKkHwExip9fgIO0FXnSkmtOLk=;
        b=YAe0erkWaUdg8iD6vXUboH0sly+9zBtIVdueA6mJmjpVJGFU0yF8THeMdCC84wZAj9
         h+9Xr/q9JbhtS7uQ3ZmLUxyOj7u1NFDvBbK8VOJRuqc3yP42TWGXDGwUYEOOqI8LWrty
         3eNB/GwDtACHxAeyf1eiIjOFMe/L1TgnY/G4PPZaLXaQ/Q7YKdc7Lq0F+T4guc+MaJjo
         V5p98VfbmEoFt2/Q5eJ0vOtCa66zXW4yJY1moN2Ow25IocF3v6LluVRFl/m/8NoCW4yV
         Q3xC9q0xhc6axNoBjCZCR7uduRnYPBTM7GF9GR4lcAmzKLl2hnhv2OPXP+pZwOTSLk7r
         4OuA==
X-Gm-Message-State: ACgBeo0MlJNXbxtenUmP7xZdy0YIYIyxfpx0cvznbqQAs1sQCfwS+yeq
        IsG5gZBiMygab8ylUY8wI9h1M2PJvzG6gIqDuKk=
X-Google-Smtp-Source: AA6agR5wV0PU2vDVLQdX/PykJTt0lAPchfJeZlpJSA2oyYNGfI8UR1V2chbA+AUAkd867MAAwENWmLXSJRl7W/vUKhE=
X-Received: by 2002:a63:505a:0:b0:421:a16a:d286 with SMTP id
 q26-20020a63505a000000b00421a16ad286mr16819349pgl.441.1660634901715; Tue, 16
 Aug 2022 00:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
 <20220812055710.357820-5-aneesh.kumar@linux.ibm.com> <87wnbacjsh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <cd1c13ee-6fc3-bde8-96f9-8c3c93441275@linux.ibm.com>
In-Reply-To: <cd1c13ee-6fc3-bde8-96f9-8c3c93441275@linux.ibm.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Tue, 16 Aug 2022 15:28:08 +0800
Message-ID: <CAC=cRTMZZ9bqyC7pnxD1zUWqfBiQ9U7im+8EYa_8GVK8iA7HXQ@mail.gmail.com>
Subject: Re: [PATCH v14 04/10] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 1:10 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 8/15/22 8:09 AM, Huang, Ying wrote:
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >

[snip]

> >>
> >> +/*
> >> + * Default abstract distance assigned to the NUMA node onlined
> >> + * by DAX/kmem if the low level platform driver didn't initialize
> >> + * one for this NUMA node.
> >> + */
> >> +#define MEMTIER_DEFAULT_DAX_ADISTANCE       (MEMTIER_ADISTANCE_DRAM * 2)
> >
> > If my understanding were correct, this is targeting Optane DCPMM for
> > now.  The measured results in the following paper is,
> >
> > https://arxiv.org/pdf/2002.06018.pdf
> >
> > Section: 2.1 Read/Write Latencies
> >
> > "
> > For read access, the latency of DCPMM was 400.1% higher than that of
> > DRAM. For write access, it was 407.1% higher.
> > "
> >
> > Section: 2.2 Read/Write Bandwidths
> >
> > "
> > For read access, the throughput of DCPMM was 37.1% of DRAM. For write
> > access, it was 7.8%
> > "
> >
> > According to the above data, I think the MEMTIER_DEFAULT_DAX_ADISTANCE
> > can be "5 * MEMTIER_ADISTANCE_DRAM".
> >
>
> If we look at mapping every 100% increase in latency as a memory tier, we essentially
> will have 4 memory tier here. Each memory tier is covering a range of abstract distance 128.
> which makes a total adistance increase from MEMTIER_ADISTANCE_DRAM by 512. This puts
> DEFAULT_DAX_DISTANCE at 1024 or  MEMTIER_ADISTANCE_DRAM * 2

If my understanding were correct, you are suggesting to use a kind of
logarithmic mapping from latency to abstract distance?  That is,

  abstract_distance = log2(latency)

While I am suggesting to use a kind of linear mapping from latency to
abstract distance.  That is,

  abstract_distance = C * latency

I think that linear mapping is easy to understand.

Are there some good reasons to use logarithmic mapping?

Best Regards,
Huang, Ying
