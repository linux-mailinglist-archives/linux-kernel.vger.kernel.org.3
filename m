Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8507A4D9196
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbiCOAcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbiCOAb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:31:57 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DE1175
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:30:47 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2dbc48104beso184483477b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ttzvwq9I0TQ4jif4LoygDGblVs4Yoa7tTQiwPFiKh50=;
        b=KGCqtvYnBAQFT/k3LjS2ZZZ6j05TmB+/SyqBL+kerzHGgZxZsPQfGJCFaEJMlXHt4T
         x+7dJidm19+MqgNrAn+poyVBx2+enjkHGJvc3aYPkP2DkjIFzgrR5CiSwKzN8CGc6biU
         hKK+loUR7vR3dht3k0gEmbUo9KvvBsWUe4UckHjPwUI2kbTYhjaOajmLKTv79rV+tLOZ
         /uIURzZuSEu0u2Un3sQlO0LOraXWE+fxguup9wNjOuA449Qb0TT8PuIPlaS3PDl4MxT0
         fX4Z0xpsMd3MboCuUvnZy79Nd+0So0I3q87Fg4telQhMGITPU16Dk2tsE8WHthY1qu6t
         FD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ttzvwq9I0TQ4jif4LoygDGblVs4Yoa7tTQiwPFiKh50=;
        b=ZtJ3LeH4DyG4NyiGUJul5ltSH4CJwhFuOETg2T7PzerItJfv5QtnSYIkW5X4CJR/2s
         pyeXsY1SCfJnhnH6bGMPi9YlwUpNh+6G3xpNeQYfLiZng62RZbiexaodDwZ1xvml9NGQ
         mjw+q1a8BWu/3KE5ZENEVS8D/2L75RuFW8lADOJCjTULhcHZjbnxR7Iu1B8vZm0V7A7z
         pOCRwpy7Wob65M8BzVZItoIfNXVmAL+MD5RhQbFQm8qcWPRghal3Ss46MLyY/B1te/6g
         JVR8Le5Om15Mlps7xVwzEEPmMyp+gwXm64VF4wKAP8Imh9ywrKTs1OWcJVolAyAMgv/U
         nkZg==
X-Gm-Message-State: AOAM532wbLT00B+5uF2OMyYf6FXrJxuTMSf8aXTblo1U/liw+tPoaKih
        /uN0Ar7PdQKYOayf60HKIuePFvZw0q/Z44bYDNqjjQ==
X-Google-Smtp-Source: ABdhPJzV01kz+3runqlJgLVnrU+8jKbFGJJ69oIyiRID9W0kmo3HsU0lQJPgZxLL6vdhu3wVwzpjuR8AAKDwRd64vKs=
X-Received: by 2002:a81:320b:0:b0:2e5:457e:245e with SMTP id
 y11-20020a81320b000000b002e5457e245emr9755350ywy.306.1647304245921; Mon, 14
 Mar 2022 17:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <f87a8c0d-527d-a9bc-9653-ff955e0e95b4@bytedance.com>
 <20220312120309.GB6235@worktop.programming.kicks-ass.net> <a528d7bf-a634-00b6-42ab-dcb516567c34@bytedance.com>
 <20220313090222.GL28057@worktop.programming.kicks-ass.net> <e57c7166-b484-0d32-e4e8-5a47ef0bb53c@bytedance.com>
In-Reply-To: <e57c7166-b484-0d32-e4e8-5a47ef0bb53c@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 14 Mar 2022 17:30:35 -0700
Message-ID: <CABk29NsBEZ63eQ-avDBHe1LYj+wJNSTkCxPDQ=eTNS9_i9e0NA@mail.gmail.com>
Subject: Re: [External] Re: Subject: [PATCH] sched/fair: prioritize normal
 task over sched_idle task with vruntime offset
To:     chenying <chenying.kernel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Benjamin Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duanxiongchun@bytedance.com, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        zhoufeng.zf@bytedance.com, ligang.bdlg@bytedance.com
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

On Sun, Mar 13, 2022 at 3:07 AM chenying <chenying.kernel@bytedance.com> wrote:
>
> If I set the sched_idle_vruntime_offset to a relatively small value
> (e.g. 10 minutes), can this issues be avoided?

That's still long enough to cause lockups.

Is the issue that you have a large number of sched_idle entities, and
the occasional latency sensitive thing that wakes up for a short
duration? Have you considered approaching this from the other
direction (ie. if we have a latency sensitive thing wake onto a cpu
running only sched idle stuff, we could change entity placement to
position the latency sensitive thing further left on the timeline,
akin to !GENTLE_FAIR_SLEEPERS).
