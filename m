Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCCE592E88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbiHOLxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHOLxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:53:34 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBD8255A4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:53:33 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-116c7286aaaso7879805fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TdskLPmIbAyOq9eCsahbNYyGc9A7bTYZyyy0Fjq3SWQ=;
        b=ukm9NNt1gt8+eKKU06N09UP2lDd04CwWg8LFKgAv7RwL4f5yV+T2ol2lXSFcQxj+4V
         I7Ja6+4fmqT1Wt6JuPG7h/O87dpqdCP6FKqK1KqFhJGpwQMJEI231MQbTdHZiDuB//4p
         wRH7DGupH+fCL7ZLLfhYz9fNDNl7qWqPbnw0dwBAM2o8f11Cr0lktnAwH9EbC0bqbwmu
         dMoxVJn30tr6cWPNsGce1RQ8XgXDxE5kv8piWQcHO+il+ezDyPp8WeL899rzXTgkevZd
         O3sl29ixw4SIkOEqNduPWZvCtVfBN0i6Nxnzzy/akT4nuM5HfWZFCQ3zAeZlQL1cm4rB
         2Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TdskLPmIbAyOq9eCsahbNYyGc9A7bTYZyyy0Fjq3SWQ=;
        b=U251odvQdQX3bsOyP1ybsrJiLf1CJKZ0T6KpD1m2HtB/drwJHR+FUTij83+zCPVcu3
         0m4/fAe3f6QLKLkr35oEElbqO0BC1cmbF4DmAlK0SIaEjuMie9MQiHrgF16GLXBDSD/l
         3mnaRa/2Qof7CV6zOddyQe4Zpe7D31pKgRWNouljoviiKMaIkjOtn8RqFy/LTkzS0w/a
         HdFMtTLMe93+rfcby6bgAi9YZjW4GKJ4UOosXjBsDTFVBJQOH32i/+sjXE7YOw7cKV+1
         oggscK+YsX/Loat97wFaKalGglDCAPlS4r9HAhtw+pzFQv58S5OPJVKsZKxJDDLhY21h
         V29A==
X-Gm-Message-State: ACgBeo06fhKzCSbeht0dSycnnmmZM3xOm7Eco57fv9toDTozLnynrYx5
        jI3kX4dQokKrEPJKzGNEO9ltjyi/n6HZPwydzMTmcw==
X-Google-Smtp-Source: AA6agR5lVn4oD/R2kJBw+cr78Fs9yc2izh1uySkaoLWbf9tCb4FXJw8Ek7dErBdHdr9pcQYA5+3oOb1GJqEJ0pmU7/4=
X-Received: by 2002:a05:6870:e98b:b0:10d:fe5c:f818 with SMTP id
 r11-20020a056870e98b00b0010dfe5cf818mr6697591oao.106.1660564412211; Mon, 15
 Aug 2022 04:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220815070122.113871-1-shaozhengchao@huawei.com>
In-Reply-To: <20220815070122.113871-1-shaozhengchao@huawei.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Mon, 15 Aug 2022 07:53:21 -0400
Message-ID: <CAM0EoMnc3Mc1+SNbKeRf0ecJ4g66=1xqFJ4X=Gb=s125TPucPQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sched: make tcf_action_dump_1() static
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You shouldnt have so many line changes to remove the EXPORT and change
"int" to "static int".
What am i missing?
Unnecessary line changes add extra effort to git archeology

cheers,
jamal

On Mon, Aug 15, 2022 at 2:58 AM Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>
> Function tcf_action_dump_1() is not used outside of act_api.c, so remove
> the superfluous EXPORT_SYMBOL() and marks it static.
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  include/net/act_api.h |   1 -
>  net/sched/act_api.c   | 100 +++++++++++++++++++++---------------------
>  2 files changed, 49 insertions(+), 52 deletions(-)
>
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 9cf6870b526e..d51b3f931771 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -215,7 +215,6 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
>  int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[], int bind,
>                     int ref, bool terse);
>  int tcf_action_dump_old(struct sk_buff *skb, struct tc_action *a, int, int);
> -int tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int, int);
>
>  static inline void tcf_action_update_bstats(struct tc_action *a,
>                                             struct sk_buff *skb)
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index b69fcde546ba..9fd98bf5c724 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -510,6 +510,55 @@ tcf_action_dump_terse(struct sk_buff *skb, struct tc_action *a, bool from_act)
>         return -1;
>  }
>
> +int
> +tcf_action_dump_old(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
> +{
> +       return a->ops->dump(skb, a, bind, ref);
> +}
> +
> +static int
> +tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
> +{
> +       int err = -EINVAL;
> +       unsigned char *b = skb_tail_pointer(skb);
> +       struct nlattr *nest;
> +       u32 flags;
> +
> +       if (tcf_action_dump_terse(skb, a, false))
> +               goto nla_put_failure;
> +
> +       if (a->hw_stats != TCA_ACT_HW_STATS_ANY &&
> +           nla_put_bitfield32(skb, TCA_ACT_HW_STATS,
> +                              a->hw_stats, TCA_ACT_HW_STATS_ANY))
> +               goto nla_put_failure;
> +
> +       if (a->used_hw_stats_valid &&
> +           nla_put_bitfield32(skb, TCA_ACT_USED_HW_STATS,
> +                              a->used_hw_stats, TCA_ACT_HW_STATS_ANY))
> +               goto nla_put_failure;
> +
> +       flags = a->tcfa_flags & TCA_ACT_FLAGS_USER_MASK;
> +       if (flags &&
> +           nla_put_bitfield32(skb, TCA_ACT_FLAGS,
> +                              flags, flags))
> +               goto nla_put_failure;
> +
> +       if (nla_put_u32(skb, TCA_ACT_IN_HW_COUNT, a->in_hw_count))
> +               goto nla_put_failure;
> +
> +       nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
> +       if (!nest)
> +               goto nla_put_failure;
> +       err = tcf_action_dump_old(skb, a, bind, ref);
> +       if (err > 0) {
> +               nla_nest_end(skb, nest);
> +               return err;
> +       }
> +
> +nla_put_failure:
> +       nlmsg_trim(skb, b);
> +       return -1;
> +}
>  static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
>                            struct netlink_callback *cb)
>  {
> @@ -1132,57 +1181,6 @@ static void tcf_action_put_many(struct tc_action *actions[])
>         }
>  }
>
> -int
> -tcf_action_dump_old(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
> -{
> -       return a->ops->dump(skb, a, bind, ref);
> -}
> -
> -int
> -tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
> -{
> -       int err = -EINVAL;
> -       unsigned char *b = skb_tail_pointer(skb);
> -       struct nlattr *nest;
> -       u32 flags;
> -
> -       if (tcf_action_dump_terse(skb, a, false))
> -               goto nla_put_failure;
> -
> -       if (a->hw_stats != TCA_ACT_HW_STATS_ANY &&
> -           nla_put_bitfield32(skb, TCA_ACT_HW_STATS,
> -                              a->hw_stats, TCA_ACT_HW_STATS_ANY))
> -               goto nla_put_failure;
> -
> -       if (a->used_hw_stats_valid &&
> -           nla_put_bitfield32(skb, TCA_ACT_USED_HW_STATS,
> -                              a->used_hw_stats, TCA_ACT_HW_STATS_ANY))
> -               goto nla_put_failure;
> -
> -       flags = a->tcfa_flags & TCA_ACT_FLAGS_USER_MASK;
> -       if (flags &&
> -           nla_put_bitfield32(skb, TCA_ACT_FLAGS,
> -                              flags, flags))
> -               goto nla_put_failure;
> -
> -       if (nla_put_u32(skb, TCA_ACT_IN_HW_COUNT, a->in_hw_count))
> -               goto nla_put_failure;
> -
> -       nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
> -       if (nest == NULL)
> -               goto nla_put_failure;
> -       err = tcf_action_dump_old(skb, a, bind, ref);
> -       if (err > 0) {
> -               nla_nest_end(skb, nest);
> -               return err;
> -       }
> -
> -nla_put_failure:
> -       nlmsg_trim(skb, b);
> -       return -1;
> -}
> -EXPORT_SYMBOL(tcf_action_dump_1);
> -
>  int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[],
>                     int bind, int ref, bool terse)
>  {
> --
> 2.17.1
>
