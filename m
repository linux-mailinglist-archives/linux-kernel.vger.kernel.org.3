Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340F75A2BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiHZPyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344464AbiHZPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:54:03 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEAAD1E36
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:54:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-324ec5a9e97so46245627b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1I+WVUoccPp9vrUi65iwN+Kmin/tDt7ushY0CzzmR9M=;
        b=hZ3j7t8cp2f6xKL7lhj5xq43bcZTE5tNTktAmUKpd7yBzSRGbVAfn60/eaW7YBwUdQ
         mOxIXeJ0VIWVDqj4uFkd8bNG8UNpjedlnfSzFUSg3hNR1w1WvAcB/6IRWUUAda5HS31f
         VjILd3q0pabOIM5xo0Zta5zj0fDe3ylFkGFZmN3LmtVUte6ZS4Q7S78oeuX/8AbY9XCG
         nw6fTd02qAK8mDV04gZepERhgRBQd20EUEJHPdPyiyIDpegDxwzq+vPjnBOT38wc8527
         B0kLH4cic2Me+/RsnOHVOWpF8uz+H3lGbwIDaCZebpG/lIbszDoNu6cONQ3WPETf6217
         6NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1I+WVUoccPp9vrUi65iwN+Kmin/tDt7ushY0CzzmR9M=;
        b=4eAn0giuyS2ACiqG0gZp2atzuayMzJNw29kSacZ1N5nrffzrq4unOF/WEqP3O8LSI1
         3+Vq1twuIgC3nmRW3V/lsIflgbZSBjGvPMjau8kvB7x24l2H/R/tqmSTeqPKW6YB1/bG
         S+RvcndA1xZgP8Nfi11iz4Hhhr3T28pHegqHU7SY04HN6rCLDDqr4+pvkmkND5g8bAjN
         MucfVwFJ4zjXK/nTnyr5YhlyYLfGqwzbIFoR2Vt7t38Of3vW3Ir3zqUAGQNOkF8yqKWm
         lfoEL1hwMgwX0IERG+Y2K6IBwxYByeWi2xHp0j+NfHlZIIayQ0Oy056WRLKCX2SQ2s+j
         bn6A==
X-Gm-Message-State: ACgBeo0nbB7I+MnjBF8ZsZGIcbzsTO20inskIKL+vefo2FbZXfwiFH/D
        B+g9ZoFpjmfAT3Ck62JX404kw3qWvZUCo2rBO4HzYg==
X-Google-Smtp-Source: AA6agR6UudbNYTJh4hdxTWxHgzWDcCX5y8Jq+6w0Pp+0L3yvnUxg8ivpYwFE9QYZswn/qI7ObG15OgiAYZtnKCYgBkQ=
X-Received: by 2002:a05:690c:82e:b0:338:f953:5e6b with SMTP id
 by14-20020a05690c082e00b00338f9535e6bmr312967ywb.55.1661529241558; Fri, 26
 Aug 2022 08:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220825053738.476903-1-imagedong@tencent.com>
 <CANn89iJTW6DDrzfzya8-B14SkhCURopnHqQV9JqvOqSCXnQy2g@mail.gmail.com>
 <CADxym3bw8H7E6i1CuV=AU6X+AnzWgx0YOwzcJVBjbTALpt2iFA@mail.gmail.com>
 <CANn89iKVpRMDPgiQ1O6=H1M05iXX3o7rGARa1Z6HptWnAgi_Sg@mail.gmail.com> <CADxym3YQLntBwweRud1Q_S+p9Wux8sVuj0CEuw=GxK8_L4tj0g@mail.gmail.com>
In-Reply-To: <CADxym3YQLntBwweRud1Q_S+p9Wux8sVuj0CEuw=GxK8_L4tj0g@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Aug 2022 08:53:50 -0700
Message-ID: <CANn89iJ7QGD1OQBhPDNMLqAHN86tjPnvMJEz98ffi_vDfVcg5Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skb: fix kfree_skb event output error in perf
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Menglong Dong <imagedong@tencent.com>,
        David Ahern <dsahern@kernel.org>,
        Hao Peng <flyingpeng@tencent.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Aug 26, 2022 at 8:44 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> On Fri, Aug 26, 2022 at 11:07 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> >
> >
> > On Thu, Aug 25, 2022 at 9:47 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
> >>
> >> On Thu, Aug 25, 2022 at 11:32 PM Eric Dumazet <edumazet@google.com> wrote:
> >> >
> >> > On Wed, Aug 24, 2022 at 10:37 PM <menglong8.dong@gmail.com> wrote:
> >> > >
> >> > > From: Menglong Dong <imagedong@tencent.com>
> >> > >
> >> > > As Eric reported, the 'reason' field is not presented when trace the
> >> > > kfree_skb event by perf:
> >> > >
> >> > > $ perf record -e skb:kfree_skb -a sleep 10
> >> > > $ perf script
> >> > >   ip_defrag 14605 [021]   221.614303:   skb:kfree_skb:
> >> > >   skbaddr=0xffff9d2851242700 protocol=34525 location=0xffffffffa39346b1
> >> > >   reason:
> >> > >
> >> > > The cause seems to be passing kernel address directly to TP_printk(),
> >> > > which is not right.
> >> >
> >> > Why ?
> >> >
> >>
> >> I think it is because of how perf passes data to the user space. From
> >> what 'perf_output_sample()' do, we can know that perf passes the data
> >> of entry (with other data) to the user, and the user generates the output
> >> string from the format string (which can be obtained from
> >> /sys/kernel/debug/tracing/event/skb/kfree_skb/format) and the entry data.
> >>
> >> Therefore, perf can't get the string of drop reasons from the entry, only
> >> the enum.
> >>
> >> > It seems this adds an expensive copy of a string that should reside in
> >> > rodata section of vmlinux, thus can not disappear...
> >> > (Also the ring buffer entry will have a dynamic size ?)
> >> >
> >>
> >> It indeed will add additional cost, but it seems unavoidable. In the old
> >> version, __print_symbolic() is used, which will loop all the drop reason
> >> from a array and find corresponding string:
> >>
> >>     TP_printk("skbaddr=%p protocol=%u location=%p reason: %s",
> >>           __entry->skbaddr, __entry->protocol, __entry->location,
> >>           __print_symbolic(__entry->reason,
> >>                    TRACE_SKB_DROP_REASON))
> >>
> >> And I think the cost of coping strings may be less than this loop? as the
> >> drop reasons are getting more and more.
> >
> >
> > We are back to original feedback about all this stuff.
> >
> > Please measure the tax on a workload dropping 5,000,000 packets per second
> > when/if a "perf -e skb:kfree_skb" is attempted by a clueless admin :)
> >
>
> Okay, I'll do such a test.
>
> > If just using an integer instead of a string has a measurable impact, we probably should stick to an integer.
> >
> > kfree_skb tracing is really for experts, they probably can have a tool to understand what a particular integer value means.
> >
> > Then we can also make sure to only add new values to the end of the enum, to have stable integer values among different kernel versions.
> >
>
> In fact, this is exactly what I wanted to do. Users can get little information
> from the output of perf or ftrace for the kfree_skb event without a
> tools, such as dropwatch.
>
> I keep adding new values to the end of the enum. And I tried to
> make the enum as uapi, as user space tools need the enum to
> understand what the integer values mean. Hmm......that commit
> was rejected :)

I think that your initial proposal was to stuff __FILE__ or __LINE__
which was a no go, because they would require anyone having fresh
kernel source to make any mapping.

Also, we added SKB_NOT_DROPPED_YET in first position in the list.

UAPI would have made this kind of change not possible.

I am not suggesting to make enum skb_drop_reason UAPI, I want this to
be clear :)

>
> I'll do the test to see the impact between integer, string copy and
> __print_symbolic. Then we can decide the solutions.
>
> Thanks!
> Menglong Dong
>
> >>
> >> > trace_safe_str() is using is_kernel_rodata() which should return true
> >> > for drop_reasons[X] ?
> >> >
> >> > $ grep drop_reasons net/core/dropreason_str.c
> >> > const char * const drop_reasons[] = {
> >> > ...
> >> >
> >> >
> >> >
> >> > >
> >> > > Therefore, fix this by adding a '__string' field to the TP_STRUCT of
> >> > > kfree_skb, which is 'reason_str', and passing it to TP_printk().
> >> > >
> >> > > (Not sure if we should still keep the 'reason' field in
> >> > > TP_STRUCT__entry)
> >> >
> >> > Maybe for event/trace filtering purposes ?
> >> >
> >> > >
> >> > > Reported-by: Eric Dumazet <edumazet@google.com>
> >> > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> >> > > ---
> >> > >  include/trace/events/skb.h | 4 +++-
> >> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> > >
> >> > > diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> >> > > index 45264e4bb254..7235554141c3 100644
> >> > > --- a/include/trace/events/skb.h
> >> > > +++ b/include/trace/events/skb.h
> >> > > @@ -24,6 +24,7 @@ TRACE_EVENT(kfree_skb,
> >> > >                 __field(void *,         location)
> >> > >                 __field(unsigned short, protocol)
> >> > >                 __field(enum skb_drop_reason,   reason)
> >> > > +               __string(reason_str, drop_reasons[reason])
> >> > >         ),
> >> > >
> >> > >         TP_fast_assign(
> >> > > @@ -31,11 +32,12 @@ TRACE_EVENT(kfree_skb,
> >> > >                 __entry->location = location;
> >> > >                 __entry->protocol = ntohs(skb->protocol);
> >> > >                 __entry->reason = reason;
> >> > > +               __assign_str(reason_str, drop_reasons[reason]);
> >> > >         ),
> >> > >
> >> > >         TP_printk("skbaddr=%p protocol=%u location=%p reason: %s",
> >> > >                   __entry->skbaddr, __entry->protocol, __entry->location,
> >> > > -                 drop_reasons[__entry->reason])
> >> > > +                 __get_str(reason_str))
> >> > >  );
> >> > >
> >> > >  TRACE_EVENT(consume_skb,
> >> > > --
> >> > > 2.37.2
> >> > >
