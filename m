Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3E54D182
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbiFOTXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346636AbiFOTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:23:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE39340CF;
        Wed, 15 Jun 2022 12:23:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso2965820pjk.0;
        Wed, 15 Jun 2022 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jnmsYqY8r/8n+6BI3/ARV7uucGEqi263lyl2VeQ797o=;
        b=EiKUCoeidcB1eZpVF9cI1BmtH9ZCjRfQssRQT+12o8f0e5fO6OgscrnrVCSEkpj4n5
         6/pylGxk2uSgxaiXnvJdSx8hvA9CdEQrKnxompTLQ/smxB8BQSTR8/sDi9AGLmlYUtJi
         J5ntdR7Mc9cI9FRPNDxit1UYi525JQ0sR+Q3nYm5vZBfkbBwTELaAVJ8mXmCw/8yeN6L
         bYV7Tl8fyHeEsDUaBq1l6TKmDxN9gAbIFHPHYyRFYHh/lB654o7IK3KRNApNfX5jVpTR
         cJYRSdyBLa8ik3RsvDp3S5kDCGzOvwyXg4CLKavHzo5VdEEuE9mQ2QAJKBuQmpWJ3E1b
         Gx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jnmsYqY8r/8n+6BI3/ARV7uucGEqi263lyl2VeQ797o=;
        b=yQCuwkmGlYy1zOaiaHv2PdEm6S/kiZDpUWeJYJSWC7ftx/DN/DAwdH54tl6qXBIcRU
         E9veoWi3pDPxpCLUOAt00P5jk9XeyAuas99D6Mtyv+iWbrgsF5VvnZqO/gKMiBrtrj8O
         3z70GNSn9VZuphZNFWLzp4GQ352wMLU1nG95DHkGarUtGGYcfEgRWiTL7hKw9+AfAtvR
         dcCrvSkI7f38JDFsB+nUCLay//5btcQugK3kdu94RkkrrIh2gk8bs0X4aH3Wdbbudwmb
         NEHdO6TO1e969dXnrtCmW1dy0Niu1JUgyqoNHtRsF+G0zw9IR5gI4fZBlmC3KzCxigt4
         KBzw==
X-Gm-Message-State: AJIora9n/h2KMSbSNEMwI5jQgYhYcQ/rD4ufTIYAX2MgC4edhsRLj9yT
        kWv+NI1auZmoq4fybNIAtGzTmOOIigOLhAlc
X-Google-Smtp-Source: AGRyM1v1B4TWmb3BFQ6203lyo+4zZbJ3kSZJwZQK8XeK6m+ABxgN/YA1beyUff65nGv6kVOaqa0pJg==
X-Received: by 2002:a17:90b:2248:b0:1ea:8403:d81c with SMTP id hk8-20020a17090b224800b001ea8403d81cmr11951251pjb.97.1655321011873;
        Wed, 15 Jun 2022 12:23:31 -0700 (PDT)
Received: from Mahakal ([2401:4900:1f28:3cf0:518a:5c2b:4000:9bcf])
        by smtp.gmail.com with ESMTPSA id l13-20020a637c4d000000b003fc5fd21752sm10379401pgn.50.2022.06.15.12.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2022 12:23:31 -0700 (PDT)
Date:   Thu, 16 Jun 2022 00:53:27 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, mintu patel <mintupatel89@gmail.com>,
        chinmoy ghosh <chinmoyghosh2001@gmail.com>
Subject: Re: [PATCH 5.4] Common =?utf-8?Q?clock=3A_?=
 =?utf-8?B?4oCL4oCLVG8=?= list active consumers of clocks
Message-ID: <20220615192325.GA21290@Mahakal>
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
 <20220610194013.DD39DC34114@smtp.kernel.org>
 <CAOUcgRfB-r3aERYeLumExgpTVzsDsBuyOWT+nCJ_OfOv1g0L9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUcgRfB-r3aERYeLumExgpTVzsDsBuyOWT+nCJ_OfOv1g0L9g@mail.gmail.com>
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

Hi Stephen,
Thanks for reviewing and giving your valueable review points for this
patch. Shortly I will attach a revised patch based on your review
points.

Thanks,
Vishal
On Tue, Jun 14, 2022 at 11:25:01PM +0530, chinmoy ghosh wrote:
> Agreed here .
> I feel , if  dev_id <https://elixir.bootlin.com/linux/latest/C/ident/dev_id>
> is not from dts property then dont think we can easily find out consumers
> from clk_hw_create_clk.Depends on how the legacy driver maintained the BSP
> code.
> Check the next .
> 
> Thanks
> Chinmoy
> 
> On Sat, Jun 11, 2022 at 1:10 AM Stephen Boyd <sboyd@kernel.org> wrote:
> 
> > Why "5.4" in the subject?
> >
> > Quoting Vishal Badole (2022-05-31 11:28:35)
> > > This feature lists the name of clocks and their consumer devices. This
> > > debug feature can be used to check the active clocks and the devices who
> > > have enabled them.
> > >
> > > for example:
> > > debian@beaglebone:~$ cat /sys/kernel/debug/clk/clk_devices_name
> > >             clock_name                                  devices_name
> > >       ----------------
> > > -------------------------------------------------------------------------
> > >              l4-wkup-clkctrl:0008:0              44e07000.target-module
> > >                     l4ls-clkctrl:0074:0
> >  4804c000.target-module
> > >                     l4ls-clkctrl:0058:0
> >  48311fe0.target-module
> > >                  l4-rtc-clkctrl:0000:0
> >  44e3e074.target-module
> > >                           clk_32768_ck
> > > 44e3e000.rtc
> > >                    l4ls-clkctrl:00d8:0
> >  480c8000.target-module
> > >    cpsw-125mhz-clkctrl:0014:0              4a101200.target-module
> > >
> > > Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> > > Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> > > Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> > > Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> >
> > Where are the Co-developed-by tags? Also, your SoB should be last.
> >
> > > ---
> > >  drivers/clk/Kconfig |   8 ++++
> > >  drivers/clk/clk.c   | 120
> > +++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 127 insertions(+), 1 deletion(-)
> >
> > The patch is malformed. Not sure what's happening with your MUA.
> >
> > >
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index c44247d..549cdda 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -23,6 +23,14 @@ config COMMON_CLK
> > >  menu "Common Clock Framework"
> > >   depends on COMMON_CLK
> > >
> > > +config DEBUG_CLK_CONSUMER
> > > + bool "Debug feature to list clocks and their active consumers"
> >
> > Don't think we need a new config for this. Just add it to the existing
> > CONFIG_DEBUGFS area.
> >
> > > + depends on DEBUG_FS && COMMON_CLK
> > > + help
> > > +  Clock consumer debug feature supports for clock debugging. Chose y
> > > +  to get debug entry in file system to list clocks and their active
> > > +  consumer devices.
> > > +
> > >  config COMMON_CLK_WM831X
> > >   tristate "Clock driver for WM831x/2x PMICs"
> > >   depends on MFD_WM831X
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 13332f8..dccbd35 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -105,6 +105,84 @@ struct clk {
> > >   struct hlist_node clks_node;
> > >  };
> > >
> > > +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> > > +/*Linked List Node*/
> > > +struct clk_dev_list {
> > > + struct list_head list;
> > > + const char *clk_name;
> > > + const char *dev_name;
> > > +};
> > > +
> > > +/*Declare and init the head node of the linked list*/
> > > +LIST_HEAD(head_node);
> > > +
> > > +static void clk_dev_entry(struct clk *clk_ptr)
> > > +{
> > > + struct clk_dev_list *new_node_ptr = NULL;
> > > + struct clk_dev_list *temp_node_ptr = NULL;
> > > + int repeat_count = 0;
> > > + static bool is_first_node;
> > > + const char *clk_name_ptr = NULL;
> > > + const char *dev_name_ptr = NULL;
> > > +
> > > + if (clk_ptr->dev) {
> > > + dev_name_ptr = dev_name(clk_ptr->dev);
> > > +
> > > + clk_name_ptr = clk_ptr->core->name;
> > > +
> > > + if (is_first_node) {
> > > + /* Iterate the list to check duplicate entry */
> > > + list_for_each_entry(temp_node_ptr, &head_node, list) {
> > > + if (temp_node_ptr->clk_name == clk_name_ptr &&
> > > +    temp_node_ptr->dev_name == dev_name_ptr) {
> > > + repeat_count++;
> > > + break;
> > > + }
> > > + }
> > > + }
> > > +
> > > + is_first_node = 1;
> > > +
> > > + if (!repeat_count && clk_ptr->core->enable_count) {
> > > + /*Creating Node*/
> > > + new_node_ptr = kmalloc(sizeof(*new_node_ptr),
> > > +       GFP_KERNEL);
> > > + if (!new_node_ptr)
> > > + return;
> > > +
> > > + /*Assgin the data that is received*/
> >
> > Typo in Assign.
> >
> > > + new_node_ptr->clk_name = clk_name_ptr;
> > > + new_node_ptr->dev_name = dev_name_ptr;
> > > +
> > > + /*Init the list within the struct*/
> > > + INIT_LIST_HEAD(&new_node_ptr->list);
> > > +
> > > + /*Add Node to Linked List*/
> > > + list_add_tail(&new_node_ptr->list, &head_node);
> > > + }
> > > + }
> > > +}
> > > +
> > > +/* Function to remove the clk and device entry */
> > > +static void clk_dev_dentry(struct clk *clk)
> > > +{
> > > + struct clk_dev_list *temp_node_ptr = NULL;
> > > + struct clk_dev_list *cur_node_ptr = NULL;
> > > +
> > > + if (clk->dev) {
> > > + /* Go through the list and free the memory */
> > > + list_for_each_entry_safe(cur_node_ptr, temp_node_ptr,
> > > + &head_node, list) {
> > > + if (cur_node_ptr->clk_name == clk->core->name &&
> > > +    cur_node_ptr->dev_name == dev_name(clk->dev)) {
> > > + list_del(&cur_node_ptr->list);
> > > + kfree(cur_node_ptr);
> > > + }
> > > + }
> > > + }
> > > +}
> > > +#endif
> > > +
> > >  /***           runtime pm          ***/
> > >  static int clk_pm_runtime_get(struct clk_core *core)
> > >  {
> > > @@ -1020,6 +1098,9 @@ void clk_disable(struct clk *clk)
> > >   return;
> > >
> > >   clk_core_disable_lock(clk->core);
> > > +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> > > + clk_dev_dentry(clk);
> > > +#endif
> > >  }
> > >  EXPORT_SYMBOL_GPL(clk_disable);
> > >
> > > @@ -1181,10 +1262,21 @@ EXPORT_SYMBOL_GPL(clk_restore_context);
> > >   */
> > >  int clk_enable(struct clk *clk)
> > >  {
> > > +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> > > + int ret = 0;
> > > +#endif
> > >   if (!clk)
> > >   return 0;
> > >
> > > +#ifndef CONFIG_DEBUG_CLK_CONSUMER
> > >   return clk_core_enable_lock(clk->core);
> > > +#else
> > > + ret = clk_core_enable_lock(clk->core);
> > > + if (!ret)
> > > + clk_dev_entry(clk);
> > > +
> > > + return ret;
> > > +#endif
> >
> > Not sure what this is doing.
> >
> > >  }
> > >  EXPORT_SYMBOL_GPL(clk_enable);
> > >
> > > @@ -2986,6 +3078,29 @@ static void clk_dump_one(struct seq_file *s,
> > struct
> > > clk_core *c, int level)
> > >     clk_core_get_scaled_duty_cycle(c, 100000));
> > >  }
> > >
> > > +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> > > +static int clk_devices_show(struct seq_file *s, void *data)
> > > +{
> > > + struct clk_dev_list *clk_dev_node;
> > > +
> > > + seq_puts(s, "            clock_name
> > >  devices_name\n");
> > > + seq_puts(s,
> > >
> > "-------------------------------------------------------------------------\n");
> > > +
> > > + clk_prepare_lock();
> > > +
> > > + /*Traversing Linked List and Print its Members*/
> > > + list_for_each_entry(clk_dev_node, &head_node, list) {
> >
> > It's hard to read but we already have a list of all clk consumers for a
> > clk_hw pointer, see clk_core_link_consumer(). And we stash the device
> > consuming it with clk_hw_create_clk(). That should be sufficient.
> >
> >
> > > + seq_printf(s, "%35s %35s\n", clk_dev_node->clk_name,
> > > +   clk_dev_node->dev_name);
> > > + }
> > > +
> > > + clk_prepare_unlock();
> > > +
> > > + return 0;
> > > +}
> > > +DEFINE_SHOW_ATTRIBUTE(clk_devices);
> > > +#endif
> > > +
> > >  static void clk_dump_subtree(struct seq_file *s, struct clk_core *c, int
> > > level)
> > >  {
> > >   struct clk_core *child;
> > > @@ -3256,7 +3371,10 @@ static int __init clk_debug_init(void)
> > >      &clk_summary_fops);
> > >   debugfs_create_file("clk_orphan_dump", 0444, rootdir, &orphan_list,
> > >      &clk_dump_fops);
> > > -
> > > +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> > > + debugfs_create_file("clk_devices_name", 0444, rootdir, NULL,
> >
> > Call it 'clk_consumers' please.
> >
> > > +    &clk_devices_fops);
> >
