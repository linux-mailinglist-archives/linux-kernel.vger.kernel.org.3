Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1208955B380
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiFZSZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiFZSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:25:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA682B49F;
        Sun, 26 Jun 2022 11:25:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so8604988pju.1;
        Sun, 26 Jun 2022 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0kDdey0EndqmLRkA5ufbfPEkjggzxpyPuYdCNjCML98=;
        b=oJCB4VrJV+qklpSu/rT4sY9QsRgrlincz9patMBGhaBU+DFih5XiCmuneU1OnuVV5q
         NnjRtT/g545wQVvjyiJrDjfOATO5np4zuBAjts050pIUeewf3hcYx6ILf/OaLkGmFbLg
         PKktTfit5UKUPkpqVYRAS1ax9eMc7FuKCHAaQBAi5R7wuitUQOvPHch7WnM9+YjsUMT/
         IlKs56ZgF0lkWIgRpTGJSlyNMLxJXbcTudvkqhSsnJwCCyj3TVHb/0AxzRjViupzf3m7
         zBbF2fXa4h7HW7G7GIWl7fOLaQmZwGfbEkjaIWkaRaVJujDhANBiMhyYAXx85LXB6Lyx
         UgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0kDdey0EndqmLRkA5ufbfPEkjggzxpyPuYdCNjCML98=;
        b=ix9mOnkS3223Ws00dAR9WHIEzVLzyPb9dGNppd/dKhdLchCBnAlz8p+BSwA9SWdMpa
         lWL7w0XIkR43gWWQp7tLqUvQjHt9BqDW1Ifp1USNuo7T5Uqv60pjM4kRtpy7Axh13WY1
         1U9EoV05XeIaWAVngcjDbbM1XF9YJ1tss9iioWjShY9lFfD0sVp/vGnpoX9WuDkwsIhS
         BLECdDbHj1QSPL0QGGTPmJSQ/udQtQiJyfYvtGBPKoIIA6pWm8dyjoodjjxEOAZi4jyG
         PR5MV9d4itM894WXrHNp+tH9TvwONNWz0p9kbDSZNtJa1hHc5S9rbCeu3VX8pSVQy8kP
         8F2Q==
X-Gm-Message-State: AJIora/US9rl6R3gPx5h+qZ5D84ybCkP+p7lAGZhHMhD+w8MUq6u8mMX
        SQqq0qmE53VWVEbzlxA95zQ=
X-Google-Smtp-Source: AGRyM1vnPeWJtc6NU5leOmihMN0R1mQx3CPZvVya1FvBIkIBQ9zly+tLU6u5RCOe1H/p9vAnwD30Xg==
X-Received: by 2002:a17:902:b085:b0:16a:417a:83a8 with SMTP id p5-20020a170902b08500b0016a417a83a8mr10833221plr.49.1656267926290;
        Sun, 26 Jun 2022 11:25:26 -0700 (PDT)
Received: from Mahakal ([2401:4900:1cc4:27af:3c7b:fbbd:ca8e:e9dc])
        by smtp.gmail.com with ESMTPSA id ll11-20020a17090b21cb00b001ec86a0490csm5458697pjb.32.2022.06.26.11.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jun 2022 11:25:26 -0700 (PDT)
Date:   Sun, 26 Jun 2022 23:55:21 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com,
        inux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chinmoyghosh2001@gmail.com, mintupatel89@gmail.com,
        vimal.kumar32@gmail.com
Subject: Re: [PATCH] Common clock: =?utf-8?B?4oCL?= =?utf-8?B?4oCLVG8=?= list
 active consumers of clocks
Message-ID: <20220626182517.GA26001@Mahakal>
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
 <20220610194013.DD39DC34114@smtp.kernel.org>
 <20220622170219.GA6978@Mahakal>
 <20220624010550.582BBC341C7@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624010550.582BBC341C7@smtp.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 06:05:48PM -0700, Stephen Boyd wrote:
> Quoting <Vishal Badole> (2022-06-22 10:02:20)
> > 
> > From f2e9d78bd0f135206fbfbf2e0178a5782b972939 Mon Sep 17 00:00:00 2001
> > From: Vishal Badole <badolevishal1116@gmail.com>
> > Date: Tue, 21 Jun 2022 09:55:51 +0530
> > Subject: [PATCH] Common clock: To list active consumers of clocks
> 
> That patch is still malformed. Please try again. Also, stop sending it
> as a reply-to the previous patch. Thanks!
>
We have applied and checked the patch on top of the mainline and not
able to see that it is malformed. We will share revised patch using git
send mail.
> > 
> > This feature lists the name of clocks and their consumer devices.
> > Using this feature user can easily check which device is using a
> > perticular clock. Consumers without dev_id are listed as no_dev_id.
> > 
> > Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> > Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> > Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> > Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> > Acked-by: Vimal Kumar <vimal.kumar32@gmail.com>
> 
> The acked-by tag is largely for maintainer use. Please remove it. See
> Documentation/process/5.Posting.rst for more info.
> 
Agreed, We will update this in the revised patch.

> > Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> > ---
> >  drivers/clk/clk.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index ed11918..b191009 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3018,6 +3018,63 @@ static int clk_summary_show(struct seq_file *s, void *data)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(clk_summary);
> >  
> > +static void clk_consumer_show_one(struct seq_file *s, struct clk_core *core, int level)
> > +{
> > +       struct clk *clk_user;
> > +       const char *consumer;
> > +
> > +       hlist_for_each_entry(clk_user, &core->clks, clks_node) {
> > +               if (!clk_user->dev_id)
> > +                       consumer = "no_dev_id";
> > +               else
> > +                       consumer = clk_user->dev_id;
> 
> We can just pass NULL if there isn't a dev_id and get a nice "(NULL)"
> print instead of "no_dev_id".
> 
Agreed, we will replace "no_dev_id" with "deviceless" in the revised
patch.
> > +
> > +               seq_printf(s, "%*s%-*s %30s %5d %7d ",
> > +                          level * 3 + 1, "",
> > +                          30 - level * 3, clk_user->core->name, consumer,
> > +                          clk_user->core->enable_count, clk_user->core->prepare_count);
> 
> It would be great to not print the core enable count here and instead
> have two levels of enable accounting so we can print the per-user count.
> Basically, one in the 'struct clk_core' and one in the 'struct clk'. If
> that isn't done then this print is going to duplicate the count for
> every 'struct clk' and be meaningless.
>
We will add enable count member to struct clock to represent per user
count and will print that one along with clock and consumer name
> > +
> > +               if (clk_user->core->ops->is_enabled)
> > +                       seq_printf(s, " %8c\n", clk_core_is_enabled(clk_user->core) ? 'Y' : 'N');
> > +               else if (!clk_user->core->ops->enable)
> > +                       seq_printf(s, " %8c\n", 'Y');
> > +               else
> > +                       seq_printf(s, " %8c\n", '?');
> 
> I don't think we need any of these prints. They're already covered in
> the summary. And the summary should be able to print the users. See
> regulator_summary_show_subtree() for inspiration. It looks like they
> print "deviceless" for the "no_dev_id" case so maybe just use that
> instead of NULL print.
> 
We will remove above prints in the revised patch. We are facing indentation issue whle printing consumer in summary
as given below
                                 enable  prepare  protect                            duty  hardware            per-user
  clock                          count    count    count        rateccuracy phase  cycle    enable  consumer   count
  clk_mcasp0_fixed                   0        0        0           24576000     0  50000         Y   
  deviceless        0

In this case it will be better to have a separate debugfs entry as
clK_consumer to print clock, consumer and per-user count.
> > +       }
> > +}
> > +
> > +static void clk_consumer_show_subtree(struct seq_file *s, struct clk_core *c, int level)
> > +{
> > +       struct clk_core *child;
> > +
> > +       clk_consumer_show_one(s, c, level);
> > +
> > +       hlist_for_each_entry(child, &c->children, child_node)
> > +               clk_consumer_show_subtree(s, child, level + 1);
> > +}
> > +
> > +static int clk_consumer_show(struct seq_file *s, void *data)
> > +{
> > +       struct clk_core *c;
> > +       struct hlist_head **lists = (struct hlist_head **)s->private;
> > +
> > +       seq_puts(s, "                                                              enable   prepare   hardware\n");
> > +       seq_puts(s, "   clock                                       consumer        count     count     enable\n");
> > +       seq_puts(s, "-----------------------------------------------------------------------------------------\n");
> > +       clk_prepare_lock();
> > +
> > +       /*Traversing Linked List to print clock consumer*/
> 
> Please run scripts/checkpatch.pl, as this comment needs space after /*
> and before */
> 
We will update this in revised patch.
> > +
> > +       for (; *lists; lists++)
> > +               hlist_for_each_entry(c, *lists, child_node)
> > +                       clk_consumer_show_subtree(s, c, 0);
> > +
> > +       clk_prepare_unlock();
> > +
> > +       return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(clk_consumer);
> > +
> >  static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
> >  {
> >         int phase;
