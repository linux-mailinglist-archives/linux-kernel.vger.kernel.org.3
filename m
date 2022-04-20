Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20B6508F22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381428AbiDTSOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346995AbiDTSOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:14:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7582E46179
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:11:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id t11so5132956eju.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxAOnHHQAuaDftNo97RhXRpBzyhCyWX+rYpgSqBanog=;
        b=H82Ttv0fMzHZmjNmOtCUeEiVe10WxevectgYNVA7oQgqJ5e0pzu+yzRWJCPGwScNqH
         96iIApghwrOMhWT2nCbvgXyVr+F5lZ2EE+rO9v5m7Bk93rknMNoalfpqkF4m1RdduOr0
         8RjpV8cIJDS0e2dfJoYkltk14Hzv95dymYL2q9ih2QDYN3v2O3IofMFcqa1vXrKJBosR
         VryNKWLHGjh+8/dAW9YcoTXhhM1Tmbt0kXiPVr+q1NMffga++dXKYt1Ptv1RoIjXQ7pA
         TitSX15S52w8mrlkQUxi3rF15SnvXBFhLi82p1E4+WBJTLXCabsam3wpyhmsDgVWjK9/
         dHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxAOnHHQAuaDftNo97RhXRpBzyhCyWX+rYpgSqBanog=;
        b=HeCyx/yEs8dJnpgAm42zd4Zo1fqiiLs1K8UdIsHZWc+pAjmBWYr6JUEcWNZT3aoDzU
         hbT2CiX6W/fMoOqFAvJMH/9QcESmCeurZxLeOjM/oukIF3COF6ehgtORhZd0u7uzUm6a
         fReJjKNTdufGdXCSH7tuw/43sAshWn4Fn4Iy6xy7ypfziO8DpOiocsvqswFrLRWQvB5f
         mNKnOI7dpvhb26r6yRf1Ipsz3slCJkW+W6L+wvOVRDdjCnrROVj9hRXhWFea68eyzWvZ
         v5btSjo0PVdwFm/W7IyIOpstH9hYOQWAeVt/ZaOfox3oQX1tl8tdnK4SP2FToCrysBOT
         wGBA==
X-Gm-Message-State: AOAM531WXj25Y9hBwLSHJEUahGf9Ojfwcgc+1izUhc9xcZBys1u5hmbv
        it0TX9FqjlLqvULzWrE6seZxgrA1Tstm0Rxsm2QM4DBIniMgRA==
X-Google-Smtp-Source: ABdhPJzAVSxEpjxjTX1BO/NeyLRm5DZcMrROYGLHEs8GiLHGKOxKYM3IT3RvpsSWD8yPy6Vnd4cEEQjkcB6ed6goyyU=
X-Received: by 2002:a17:907:8a26:b0:6e1:2646:ef23 with SMTP id
 sc38-20020a1709078a2600b006e12646ef23mr20364325ejc.109.1650478285979; Wed, 20
 Apr 2022 11:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220416081355.2155050-1-jcmvbkbc@gmail.com> <CANpmjNNW0kLf2Ou6i_dNeRLO=Qrru4bOEfJ=be=Dfig4wnQ67g@mail.gmail.com>
 <CAMo8BfJM0JHqh8Nz3LuK7Ccu7WB1Cup0mX+RYvO1yft_K4hyLQ@mail.gmail.com> <Yl/Mh4gjG1hYW2nA@elver.google.com>
In-Reply-To: <Yl/Mh4gjG1hYW2nA@elver.google.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 20 Apr 2022 11:11:14 -0700
Message-ID: <CAMo8BfLANCoLa4zXO4aYmX0Wk7fV7_wei04MveLHu=d2RDZ77w@mail.gmail.com>
Subject: Re: [PATCH] xtensa: enable KCSAN
To:     Marco Elver <elver@google.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 2:04 AM Marco Elver <elver@google.com> wrote:
> So the right thing to do might be to implement the builtin atomics using
> the kernel's atomic64_* primitives. However, granted, the builtin
> atomics might not be needed on xtensa (depending on configuration).
> Their existence is due to some compiler instrumentation emitting
> builtin-atomics (Clang's GCOV), folks using them accidentally and
> blaming KCSAN (also https://paulmck.livejournal.com/64970.html).
>
> So I think it's fair to leave them to BUG() until somebody complains (at
> which point they need to be implemented). I leave it to you.

Sure, that was my plan.

> > > Did the kcsan_test pass?
> >
> > current results are the following on QEMU:
> >
> >      # test_missing_barrier: EXPECTATION FAILED at
> > kernel/kcsan/kcsan_test.c:1313
> >      Expected match_expect to be true, but is false
> >      # test_atomic_builtins_missing_barrier: EXPECTATION FAILED at
> > kernel/kcsan/kcsan_test.c:1356
> >      Expected match_expect to be true, but is false
> >  # kcsan: pass:27 fail:2 skip:0 total:29
> >  # Totals: pass:193 fail:4 skip:0 total:197
> >
> > and the following on the real hardware:
> >
> >     # test_concurrent_races: EXPECTATION FAILED at kernel/kcsan/kcsan_test.c:762
> >     Expected match_expect to be true, but is false
> >     # test_write_write_struct_part: EXPECTATION FAILED at
> > kernel/kcsan/kcsan_test.c:910
> >     Expected match_expect to be true, but is false
> >     # test_assert_exclusive_access_writer: EXPECTATION FAILED at
> > kernel/kcsan/kcsan_test.c:1077
> >     Expected match_expect_access_writer to be true, but is false
> >     # test_assert_exclusive_bits_change: EXPECTATION FAILED at
> > kernel/kcsan/kcsan_test.c:1098
> >     Expected match_expect to be true, but is false
> >     # test_assert_exclusive_writer_scoped: EXPECTATION FAILED at
> > kernel/kcsan/kcsan_test.c:1136
> >     Expected match_expect_start to be true, but is false
> >     # test_missing_barrier: EXPECTATION FAILED at kernel/kcsan/kcsan_test.c:1313
> >     Expected match_expect to be true, but is false
> >     # test_atomic_builtins_missing_barrier: EXPECTATION FAILED at
> > kernel/kcsan/kcsan_test.c:1356
> >     Expected match_expect to be true, but is false
> > # kcsan: pass:22 fail:7 skip:0 total:29
> > # Totals: pass:177 fail:20 skip:0 total:197
>
> Each test case is run with varying number of threads - am I correctly
> inferring that out of all test cases, usually only one such run failed,
> and runs with different number of threads (of the same test case)
> succeeded?

For most of the failures -- yes.
For the test_missing_barrier and test_atomic_builtins_missing_barrier
on the hardware it was the opposite: only one subtest succeeded while
all others failed. Does it mean that the xtensa memory model is
insufficiently weak?

> If that's the case, I think we can say that it works, and the failures
> are due to flakiness with either higher or lower threads counts. I know
> that some test cases might still be flaky under QEMU TCG because of how
> it does concurrent execution of different CPU cores.

Thanks for taking a look.
I'll post v2 with a couple additional minor changes.

-- 
Thanks.
-- Max
