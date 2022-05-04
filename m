Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E198A519385
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbiEDBfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbiEDBfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:35:16 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749AF20BD8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:31:42 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id z144so18106745vsz.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 18:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGRn2T0VMRPgqL8N4asL2R4bnXM/z5CuvCoeNoDGm/0=;
        b=n8tgslGE/cIbNMc/8xWjtECQvrKEb1JENIFN0173WK6xmffIwoXSaAiBK3AbQVGNNc
         IVZlqizaa9fCMkailAm/+NMr3vL4vr0hPzVQkUIAZwtAsDZbi3BtPzXaSbmAX5mHl/OP
         U9O+CueUAI2caDAN9uvDTMk5LZ4aVZcLVXnWd1dhZcVRP821y4YZ8XQCuBCSzUtAo55h
         iWd9qLHiyI0Il5piLCYCFbyZo38jK7IEvlJ0VK3lMxvkQVDwFQUGpNCeEznBlQ2bsWiB
         EEYUC4/gcPWzjegopgaLFWnbezK9GvQOUL52XJEmzwnEE4ZrVRYRhuHxd3Ci81rKImj5
         MnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGRn2T0VMRPgqL8N4asL2R4bnXM/z5CuvCoeNoDGm/0=;
        b=3fwVrXaQMIToK2jA3CBWK6urdcypGiPSnJ9XBtr1kGQ+a5dL/mYmMzbOzQw2/jQOJ4
         158b2j/wuCKwlvaT9lNN3wj7Oxr3vQ/VZawGdKvyI4gvucmYe/QtawqhHjMM9UBSWlWl
         CW+8LAVolj1yWE59kIS6wCN3NhDM0syaxqRvB4iwC73Vl5lutjjFfIpuzhWPBjwpdiAD
         1fBGSDj6yDFu/o0lzCueC8NrLmgHmtS39uNGNtcUOXUlY7Eiq2tF40ispHIZnUB54grO
         IkBraB3JKjdGiarAm/EgeR43unnBlITOWxsCKo4uTgGqQmp4v63jBzOWDAqqpJTZ9uXl
         3s8g==
X-Gm-Message-State: AOAM531LFuViqj1t/14h6kUA8QgmQMslT7XVWL2C2FV9K36ml4aSp8aR
        XzomVmxNLBmSqZ/uk5x3rBoFJi4JgEYBQC2N8lt8CA==
X-Google-Smtp-Source: ABdhPJwsf3b9O/caCqzX/9BgtkrFdL2f5WcP7kRbQugM77uDVVCBf5+E7hT0BZj+8MC2zgvTCXycs7Nrg/wht/5kns8=
X-Received: by 2002:a67:fd0b:0:b0:31b:e36d:31b1 with SMTP id
 f11-20020a67fd0b000000b0031be36d31b1mr5768157vsr.44.1651627901488; Tue, 03
 May 2022 18:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld> <87o80eh65f.fsf@nvdebian.thelocal>
 <e47bf89c-cee7-3006-5c1b-c76f640c3e23@intel.com> <87mtfygoxs.fsf@nvdebian.thelocal>
 <9fb22767-54de-d316-7e6b-5aac375c9c49@intel.com>
In-Reply-To: <9fb22767-54de-d316-7e6b-5aac375c9c49@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 3 May 2022 18:31:30 -0700
Message-ID: <CAAPL-u9UkG1WMQm5u1eAe+4-d04aqVAXc9H0gLSegYoHctkCnw@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Tue, May 3, 2022 at 4:54 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/3/22 15:35, Alistair Popple wrote:
> > Not entirely true. The GPUs on POWER9 have performance counters capable of
> > collecting this kind of information for memory accessed from the GPU. I will
> > admit though that sadly most people probably don't have a P9 sitting under their
> > desk :)
>
> Well, x86 CPUs have performance monitoring hardware that can
> theoretically collect physical access information too.  But, this
> performance monitoring hardware wasn't designed for this specific use
> case in mind.  So, in practice, these events (PEBS) weren't very useful
> for driving memory tiering.

The PEBS events without any filtering might not be useful for memory
tiering, but the PEBS events with hardware-based data source filtering
can be useful in driving promotions in memory tiering. Certainly,
because these events are not designed for this specific use case in
mind, there are inefficiencies using them for memory tiering, e.g.
instead of just getting a heat counter for each hot page, we can get
events repeatedly on the hot pages.

> Are you saying that the GPUs on POWER9 have performance counters that
> can drive memory tiering in practice?  I'd be curious if there's working
> code to show how they get used.  Maybe the hardware is better than the
> x86 PMU or the software consuming it is more clever than what we did.
> But, I'd love to see it either way.
