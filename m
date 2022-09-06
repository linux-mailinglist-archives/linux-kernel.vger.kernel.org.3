Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B175AF107
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbiIFQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiIFQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:45:58 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B007D1D9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:26:14 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id u189so2567316vsb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qWqKHZiBSUvvhZpZjD/yzrJmLWryuuaO5L0LEQDTi4s=;
        b=EIhZg8ciLWYDMyyUzN7GFoF8lcbwbgHGJkKE/grsIBvBxtStqQ0H/T6ygmWizAHLIx
         zyWz8Db5P1WWLFnfLMw2vzm38/tNm1Za6S2kpLdBGo7gc8Q8DfeOAXm5Q8DbOm9ORLpS
         pjEbx5D5KAYzg/WAyxxXPYq13DN+mop9YVBULZDlUBunYuZ5qTJUR++cVwiRjO1YrqOi
         Sv6x8mTxUfhHdYyT/Rt40vJHdpaE6TOpQ04DqAuuloYGkhlwwWyGa5OliTfJxLVHrZGC
         T5D+2Tvgg4bdpAkjNg7KoTLJag0cXx/kYzYpbfePTl3tHkP+L6OkilvafrdALxZFhBaj
         7Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qWqKHZiBSUvvhZpZjD/yzrJmLWryuuaO5L0LEQDTi4s=;
        b=lZzBOpRetigfBgIy/lq71kNuAkyObtMLdULsdrN+isiBEsZCYCWiCFUazKXuqSR9FJ
         5N/PIi8sNVL8WcsnQUZF1EL+LRm73yQQhn/WUPUuVIo7fK4JFlHHFyGs5rJl9KvGPoM/
         Jw/XJD91uojG0LWfqBeA7gto+DW9XntUbXgI6DR994p1wO8DC917PeoEr6LoZi8t9MAn
         veiFj95u10A18ltV9VHHzQ1W/e5pufiyXFmFC5MfHzOhLotuboNh6pSVqpIIXNmN9I23
         qPEP85nPYUaxxIba7APvvNeu+5VtDPHVm+TxRtxMaO0WKCx+w7Llpu8z3jxiqYfZeweV
         3a+w==
X-Gm-Message-State: ACgBeo1bElijSk4bjCnMbsema6v96l1PxjGUbxgFx6e3ep9l2z4omIJH
        GdGsMDRvOG4r1qiXX4jwTXhd2KkoJnpgapDRCvM=
X-Google-Smtp-Source: AA6agR5OXUgfVTiPYg0kuxS0IxHXK6ZAEZ3seconDonMcALp3qrjUUR9IRXVOkWGkxUyyNMKFgzwTZ3m7IxsOb45xSU=
X-Received: by 2002:a67:f751:0:b0:388:82bf:aaea with SMTP id
 w17-20020a67f751000000b0038882bfaaeamr16282789vso.55.1662481573478; Tue, 06
 Sep 2022 09:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <YxcK+HXLQ8WBS9Ee@hirez.programming.kicks-ass.net> <xhsmhy1uwbtbc.mognet@vschneid.remote.csb>
 <YxdbaWaO8lWWqT9q@hirez.programming.kicks-ass.net> <xhsmhv8q0bj6m.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhv8q0bj6m.mognet@vschneid.remote.csb>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 6 Sep 2022 09:26:02 -0700
Message-ID: <CAAH8bW-F9e48hbimtgtmv09z7+LiC516KzN55USZZBhq3wv4OQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits mess
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
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

On Tue, Sep 6, 2022 at 8:45 AM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 06/09/22 16:38, Peter Zijlstra wrote:
> > On Tue, Sep 06, 2022 at 01:06:47PM +0100, Valentin Schneider wrote:
> >
> >>   #define nr_cpumask_bits nr_cpu_ids
> >
> > That assumes the CPU space is dense; is this so? That is, you can have 4
> > CPUs while the highest cpu number is vastly larger than 4.

It's quite common. One can configure qemu to give to the user one cpu at
start, and hotplug more on demand. In that case those unattached CPUS
are set in cpu_possible_mask.

> > It's uncommon, but not unheard of I think. ISTR some BIOSes leaving
> > holes in the CPU space when there were empty CPU sockets on the
> > motherboard.

Didn't get my hands on that particular board, but I suspect that those missed
CPUs will be set in possible mask, and unset in present, online and active
masks.

> I'd assume this would be visible in the cpu_possible_mask and thus be
> properly reflected in nr_cpu_ids. Otherwise that would already break with
> CONFIG_CPUMASK_OFFSTACK=y, I think.

Yes.

The nr_cpu_ids is set as:
  find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1

For all board and VM configurations I've been working with, the
cpu_possible_mask
was dense up to nr_cpu_ids.The holes that may appear if HOTPLUG is enabled
or by any other reason are all in the present mask, and therefore
nr_cpu_ids is set
correctly.
