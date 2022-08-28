Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8E5A3BF6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 07:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiH1FJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 01:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiH1FJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:09:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06802A264
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 22:09:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r22so4964280pgm.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 22:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=l7+DYZRCx5ZauqP1rRn+UTrdtFWUMafg8H1buGzQKuY=;
        b=Z7dRJ4KPJmEss/nTOFQ+5wAOZ6o4yLtFkL51ChIVfTDnpXCtYKVYc9eOKD2ZgO/hca
         viTGGolhHNHIQ4XukyMA34UeDAxItzr/CoaonCNtfKTFxIEe+/XRCmv7vNfgHCkf7nTO
         fy9HGib6OSmPCr2Qia7LeMDgI1HQTZQG7dYyEwUa1PRb3mPGQrVBBxwjpDnPO85ttq6d
         rAZRFjtnfWFMBnaoK3tL+ePJ9pt7hRZkjRHU0Ud+mG81hqqJVyGU/GKHOKAx/ohHXyCw
         SFhNChAn7nSq92PDb04cX8uTwiWrwU3MoiEPLjtO1HFYIK/waNAGacnxbm9ZLDXefAYM
         G4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=l7+DYZRCx5ZauqP1rRn+UTrdtFWUMafg8H1buGzQKuY=;
        b=dQRqyirF3Y8n1ZfgFN7NVCRVGqw1WIK1uNQYGCzy6+60rnfo+aIO7Ecg/NJ8NMmqdf
         qsMecU652Ge0FoikFE6B63uv3KZ+/kzHYxdCxlfHjVQ1epFrvCvne9Q/zDDQSiQbXqUm
         qjLWMWQ39cpycvStEsOsvmLErUSUSKaDDP0RKKaaqY7XFmJJiOaHBjgu3FRImL8BOAIb
         0tmp0QwbQOPZ4h5BgtdgTGQT+SX+Jy1mQPeGHIuq0CGwofXiV7dYeeE4b9/rc3SdWoop
         H92yeGGaXef1x3HLELBf4CsUo4A8Lxs/SgYNA2XZXgIWedF9ti1RcXylKOmHFzJjEgc/
         SDVQ==
X-Gm-Message-State: ACgBeo34x/2svCliNmK+SM+uDwpslr3/Ktzpxm7FCJyAnN63rdtuI3S+
        MH1AA0Jw4mkgZvstvQkE4F0iWG9bqJ2oAjGIIrg=
X-Google-Smtp-Source: AA6agR52NIl5byfLg8tRKAPO5h19TrjkQpZ1BQH74TrUq9+SaBgeUuhmhOwAhM6Ik0YmZvSqaIlQzhneloz+ged6XTc=
X-Received: by 2002:a63:83c7:0:b0:42b:b618:31b4 with SMTP id
 h190-20020a6383c7000000b0042bb61831b4mr3180411pge.607.1661663350387; Sat, 27
 Aug 2022 22:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220825053738.476903-1-imagedong@tencent.com>
 <CANn89iJTW6DDrzfzya8-B14SkhCURopnHqQV9JqvOqSCXnQy2g@mail.gmail.com>
 <CADxym3bw8H7E6i1CuV=AU6X+AnzWgx0YOwzcJVBjbTALpt2iFA@mail.gmail.com>
 <CANn89iKVpRMDPgiQ1O6=H1M05iXX3o7rGARa1Z6HptWnAgi_Sg@mail.gmail.com>
 <CADxym3YQLntBwweRud1Q_S+p9Wux8sVuj0CEuw=GxK8_L4tj0g@mail.gmail.com> <CANn89iJ7QGD1OQBhPDNMLqAHN86tjPnvMJEz98ffi_vDfVcg5Q@mail.gmail.com>
In-Reply-To: <CANn89iJ7QGD1OQBhPDNMLqAHN86tjPnvMJEz98ffi_vDfVcg5Q@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Sun, 28 Aug 2022 13:08:59 +0800
Message-ID: <CADxym3bZB1o4rHp66K8hWQJv5nu_71A2f+8cMU-ZHfwOuwJ5cw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skb: fix kfree_skb event output error in perf
To:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Menglong Dong <imagedong@tencent.com>,
        David Ahern <dsahern@kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Aug 26, 2022 at 11:54 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Aug 26, 2022 at 8:44 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
[...]
>
> I think that your initial proposal was to stuff __FILE__ or __LINE__
> which was a no go, because they would require anyone having fresh
> kernel source to make any mapping.
>
> Also, we added SKB_NOT_DROPPED_YET in first position in the list.
>
> UAPI would have made this kind of change not possible.
>
> I am not suggesting to make enum skb_drop_reason UAPI, I want this to
> be clear :)
>

I think I finally figured out what is happening. (After a whole day of
research).

The old version uses TRACE_DEFINE_ENUM() to export the enum
to user space through the format:

        cat /tracing/events/skb/kfree_skb/format
        name: kfree_skb
        ID: 1528
        format:
                field:unsigned short common_type;       offset:0;
 size:2; signed:0;
                field:unsigned char common_flags;       offset:2;
 size:1; signed:0;
                field:unsigned char common_preempt_count;
offset:3;       size:1; signed:0;
                field:int common_pid;   offset:4;       size:4; signed:1;

                field:void * skbaddr;   offset:8;       size:8; signed:0;
                field:void * location;  offset:16;      size:8; signed:0;
                field:unsigned short protocol;  offset:24;
size:2; signed:0;
                field:enum skb_drop_reason reason;      offset:28;
 size:4; signed:0;

        print fmt: "skbaddr=%p protocol=%u location=%p reason: %s",
REC->skbaddr, REC->protocol, REC->location,
__print_symbolic(REC->reason, { 1, "NOT_SPECIFIED" }, { 2, "NO_SOCKET"
}, { 3, "PKT_TOO_SMALL" }, { 4, "TCP_CSUM" }, { 5, "SOCKET_FILTER" },
{ 6, "UDP_CSUM" }, { 7, "NETFILTER_DROP" }, { 8, "OTHERHOST" }, { 9,
"IP_CSUM" }, { 10, "IP_INHDR" }, { 11, "IP_RPFILTER" }, { 12,
"UNICAST_IN_L2_MULTICAST" }, { 13, "XFRM_POLICY" }, { 14, "IP_NOPROTO"
}, { 15, "SOCKET_RCVBUFF" }, { 16, "PROTO_MEM" }, { 17,
"TCP_MD5NOTFOUND" }, { 18, "TCP_MD5UNEXPECTED" }, { 19,
"TCP_MD5FAILURE" }, { 20, "SOCKET_BACKLOG" }, { 21, "TCP_FLAGS" }, {
22, "TCP_ZEROWINDOW" }, { 23, "TCP_OLD_DATA" }, { 24, "TCP_OVERWINDOW"
}, { 25, "TCP_OFOMERGE" }, { 26, "TCP_RFC7323_PAWS" }, { 27,
"TCP_INVALID_SEQUENCE" }, { 28, "TCP_RESET" }, { 29, "TCP_INVALID_SYN"
}, { 30, "TCP_CLOSE" }, { 31, "TCP_FASTOPEN" }, { 32, "TCP_OLD_ACK" },
{ 33, "TCP_TOO_OLD_ACK" }, { 34, "TCP_ACK_UNSENT_DATA" }, { 35,
"TCP_OFO_QUEUE_PRUNE" }, { 36, "TCP_OFO_DROP" }, { 37,
"IP_OUTNOROUTES" }, { 38, "BPF_CGROUP_EGRESS" }, { 39, "IPV6DISABLED"
}, { 40, "NEIGH_CREATEFAIL" }, { 41, "NEIGH_FAILED" }, { 42,
"NEIGH_QUEUEFULL" }, { 43, "NEIGH_DEAD" }, { 44, "TC_EGRESS" }, { 45,
"QDISC_DROP" }, { 46, "CPU_BACKLOG" }, { 47, "XDP" }, { 48,
"TC_INGRESS" }, { 49, "UNHANDLED_PROTO" }, { 50, "SKB_CSUM" }, { 51,
"SKB_GSO_SEG" }, { 52, "SKB_UCOPY_FAULT" }, { 53, "DEV_HDR" }, { 54,
"DEV_READY" }, { 55, "FULL_RING" }, { 56, "NOMEM" }, { 57, "HDR_TRUNC"
}, { 58, "TAP_FILTER" }, { 59, "TAP_TXFILTER" }, { 60, "ICMP_CSUM" },
{ 61, "INVALID_PROTO" }, { 62, "IP_INADDRERRORS" }, { 63,
"IP_INNOROUTES" }, { 64, "PKT_TOO_BIG" }, { 65, "MAX" })

perf will convert the enum to string by the information in format.
What the TRACE_DEFINE_ENUM() do can be seen in the
update_event_printk(), which will replace the enum name in the format
with its real value. And it seems that this is the right way to export
drop reason string to users.

And without this TRACE_DEFINE_ENUM(), the output will be like
this:

  print fmt: "skbaddr=%p protocol=%u location=%p reason: %s",
REC->skbaddr, REC->protocol, REC->location,
__print_symbolic(REC->reason, { SKB_DROP_REASON_NOT_SPECIFIED,
"NOT_SPECIFIED" } ...................

------------------------------------------------------------------------------------------------

And the string copy I committed before seems to add a lot
cost. Following is the time spend that I call trace_kfree_skb()
for 50,000,000 times (in ns) in a kernel module with __string()
field (kfree_skb event is enabled, of course):

5129727715
5133374989
5133208716
5131911803
5122289360
5113165536
5113767180
5133562923
5112673360
5127777968

And following is the time with 'drop_reason[reason]':

4004919507
4008643292
4007113108
4004181997
4011144465
4022534656
4022078663
4002597895
4072512068
3990457695

Following is the time that I use __print_symbolic() instead:

4050504157
4049853381
4064370880
4014673377
4063128507
4058000000
4070997417
4017538272
4003874038
4009775761

Seems __print_symbolic() is more efficient than I thought.

------------------------------------------------------------------------------------------

Now I'm not sure we can still keep this 'auto-generate', as we need
to define TRACE_DEFINE_ENUM. The script in
'net/core/Makefile' should be like this
to generate a header, which is used to define the array
'const char * const drop_reasons[]' and
TRACE_DEFINE_ENUM():

  clean-files := $(srctree)/include/net/dropreason_str.h

  quiet_cmd_dropreason_str = GEN     $@
  cmd_dropreason_str = awk -F ',' 'BEGIN{ print "\#include
<net/dropreason.h>\n"; \
      print "\#define __DEFINE_DROP_REASON(FN, FNe) \\"; last = "" }\
      /^enum skb_drop/ { dr=1; }\
      /^\};/ { dr=0; }\
      /^\tSKB_DROP_REASON_/ {\
          if (dr) {\
              if (length(last) != 0)\
                  printf "\tFN(%s) \\\n", last;\
              last = $$1;\
              sub(/\tSKB_DROP_REASON_/, "", last);\
          }\
      }\
      END{ printf "\tFNe(%s)\n", last; }' $< > $@

  $(srctree)/include/net/dropreason_str.h: $(srctree)/include/net/dropreason.h
      $(call cmd,dropreason_str)

  $(obj-y)/*: $(srctree)/include/net/dropreason_str.h

Then, we can define TRACE_DEFINE_ENUM in include/trace/events/skb.h:

  #undef EM
  #define EM(name) TRACE_DEFINE_ENUM(SKB_DROP_REASON_##name);
  __DEFINE_DROP_REASON(EM, EM)

Thanks!
Menglong Dong



> >
> > I'll do the test to see the impact between integer, string copy and
> > __print_symbolic. Then we can decide the solutions.
> >
> > Thanks!
> > Menglong Dong
> >
> > >>
> > >> > trace_safe_str() is using is_kernel_rodata() which should return true
> > >> > for drop_reasons[X] ?
> > >> >
> > >> > $ grep drop_reasons net/core/dropreason_str.c
> > >> > const char * const drop_reasons[] = {
> > >> > ...
> > >> >
> > >> >
> > >> >
> > >> > >
> > >> > > Therefore, fix this by adding a '__string' field to the TP_STRUCT of
> > >> > > kfree_skb, which is 'reason_str', and passing it to TP_printk().
> > >> > >
> > >> > > (Not sure if we should still keep the 'reason' field in
> > >> > > TP_STRUCT__entry)
> > >> >
> > >> > Maybe for event/trace filtering purposes ?
> > >> >
> > >> > >
> > >> > > Reported-by: Eric Dumazet <edumazet@google.com>
> > >> > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > >> > > ---
> > >> > >  include/trace/events/skb.h | 4 +++-
> > >> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >> > >
> > >> > > diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> > >> > > index 45264e4bb254..7235554141c3 100644
> > >> > > --- a/include/trace/events/skb.h
> > >> > > +++ b/include/trace/events/skb.h
> > >> > > @@ -24,6 +24,7 @@ TRACE_EVENT(kfree_skb,
> > >> > >                 __field(void *,         location)
> > >> > >                 __field(unsigned short, protocol)
> > >> > >                 __field(enum skb_drop_reason,   reason)
> > >> > > +               __string(reason_str, drop_reasons[reason])
> > >> > >         ),
> > >> > >
> > >> > >         TP_fast_assign(
> > >> > > @@ -31,11 +32,12 @@ TRACE_EVENT(kfree_skb,
> > >> > >                 __entry->location = location;
> > >> > >                 __entry->protocol = ntohs(skb->protocol);
> > >> > >                 __entry->reason = reason;
> > >> > > +               __assign_str(reason_str, drop_reasons[reason]);
> > >> > >         ),
> > >> > >
> > >> > >         TP_printk("skbaddr=%p protocol=%u location=%p reason: %s",
> > >> > >                   __entry->skbaddr, __entry->protocol, __entry->location,
> > >> > > -                 drop_reasons[__entry->reason])
> > >> > > +                 __get_str(reason_str))
> > >> > >  );
> > >> > >
> > >> > >  TRACE_EVENT(consume_skb,
> > >> > > --
> > >> > > 2.37.2
> > >> > >
