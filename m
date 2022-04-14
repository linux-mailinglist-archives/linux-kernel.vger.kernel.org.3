Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59325007A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiDNH5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbiDNH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:56:58 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E0530F7E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:54:33 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ebf3746f87so46989957b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHScB9zVQ0Ljr9Sb/cRUcY7IzVf6n2YKRFUZpSVWquY=;
        b=ZZeYOv1AdyqI8YkaFK+P2tv6O4lkkR6u3mlvdQAORx0n3eHsRCpfpitKcEt6AUIwCT
         xdqM0pIQyHON2fZ2cq3quKQDpm0W/w+cNLaiBIU2lvSFPASvyC9g8358HmEWH22DC+UT
         cUvw4nIq8lBwO0NuJteh3HHFJetxXYYH2nrzy/hkCQq+DH3PnaXTP9zGKf4ZXlVYZVBb
         rKi7ukzHVehJm0Twa/jsO46WPpd8nlOLOj8OKS9Sp0Ewhtln7XWU0xfqTGEqKKKtj0Qz
         j0uT16zr++MtJkTenLXjGcYrdv+X+RVrd5gk/09cYs0WClTcKMPrGhKmTd8mJCYNzxEO
         sezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHScB9zVQ0Ljr9Sb/cRUcY7IzVf6n2YKRFUZpSVWquY=;
        b=Thg5FhlBb2QoQ18uDv93DVA6JuHL8AUunZ61iXnxXMlHQ4z2blrmr9FxBVT8hdlz2s
         7lEGDr+XalFFNUpeHiaBNZ8VujmULOo67SEzzZWhuigrZ46WiAXN0KXUkJ7tlDosV2GU
         5vHd50/EUofneAK9zsrgkeQx0D8LvX3DAMTs7d1P2Lo41AQTchuI62P0Fm6eQtH1/000
         cQpnGRr+zSJQkZBwQI17NjMQ4qI/mpjOVJNVb3yII8gz2BmKTbWg/CFA1/1aZQh1dcvR
         tZWd4P45ygZ7m9rJ2wTV/l0u+R5CHr1fjHbE9L+jLrC7mxiO2XfMqccQZmvjxWoULBn9
         uqEA==
X-Gm-Message-State: AOAM531NsHNU66jFCIpFfmsYE796Ssb1fh+GhdQtz/HnvxC0j0m8OXc2
        LxEJYgwEEQRlPllxSAnHsBAKxL6RfNt2ZZIstr3m2w==
X-Google-Smtp-Source: ABdhPJzbjexPGBOV/a+JtlZyLyl3oGZIbjIDDSmZ12BTSJdD57n+EU7HscmFeENd6jY8U258FCgjQJF87f/Ob6E/m84=
X-Received: by 2002:a0d:d946:0:b0:2ef:67ce:47c with SMTP id
 b67-20020a0dd946000000b002ef67ce047cmr58878ywe.228.1649922872356; Thu, 14 Apr
 2022 00:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu> <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
 <CAKfTPtBWUvvFMsSnfcKsOpHFdvxvSWpjfuLpjwwQrwhQc7+xuw@mail.gmail.com> <20220413235719.xs72pm2kgihia46g@airbuntu>
In-Reply-To: <20220413235719.xs72pm2kgihia46g@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Apr 2022 09:54:20 +0200
Message-ID: <CAKfTPtBtzmgJNM=2ekmE0-HT+r=qLqBJ6R1cggkGCNHbb3FPdQ@mail.gmail.com>
Subject: Re: Scheduling tasks on idle cpu
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "Valentin.Schneider@arm.com" <Valentin.Schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Wei Wang <wvw@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 at 01:57, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/12/22 11:07, Vincent Guittot wrote:
> > On Tue, 12 Apr 2022 at 10:39, David Laight <David.Laight@aculab.com> wrote:
> > > Yes I want the CFS scheduler to pick an idle cpu in preference
> > > to an active RT one.
> >
> > When task 34512 wakes up, scheduler checks if prev or this cpu are
> > idle which is not the case for you. Then, it compares the load of prev
> > and this_cpu and seems to select this_cpu (cpu17).
> >
> > Once cpu17 selected, it will try to find an idle cpu which shares LLC
> > but it seems that the scheduler didn't find one and finally keeps task
> > 34512 on this_cpu.
> >
> > Note that during the next tick, a load balance will be trigger if
> > this_cpu still have both RT and task 34512,
>
> David said there are idle cpus
>
>         "  There are two physical cpu with 20 cores each (with hyperthreading).
>         16, 18, 34, 36 and 38 were idle. So both 16 and 18 should be on the
>         same NUMA node. All the others are running the same RT thread code.  "
>
> Except for the possibility of them becoming idle just after the task has woken
> up, shouldn't one of them have been picked?

we don't loop on all cpus in the LLC to find an idle one but compute a
reasonable number of iteration based on the avg_idle

David can rerun is use case after disabling sched_feat(SIS_PROP)

>
> Thanks
>
> --
> Qais Yousef
