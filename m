Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58045551DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353513AbiFVRCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiFVRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:02:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041973EF0B;
        Wed, 22 Jun 2022 10:02:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so1757057pju.1;
        Wed, 22 Jun 2022 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-description:content-disposition:in-reply-to:user-agent;
        bh=pXIjVqh7UNlrSF8snJz0VCjdbj2n7TzPYTerNEzotLI=;
        b=he8SrFgDk4FZgath+IeSaTDbd47ndveK3t5y392ThdKTnUnzMZhM91r2pJLPzXKWaP
         8k65Z3FbXaKyE7lbXtPDEAjAq/7uAu5WofskgKdcM909J8CkbK8kXn5wa/Cy+mhiAEh6
         boVOPkpOybt4TCz6fRpOWCyc2YLP66NqX3tkLbSZY0IRuzcAnDtByVCqem7INXRHeNTz
         L9nHWG3noI02O9Y0pkU8PXdXxCmJMeF0Gaofu6iwdoy7hNNghKfQeHgTZmHv2BDqq5Se
         mxsr9xqORJY46HjmI+4k5/r9el52m4B88h9C3imCIEWa8k7b4VCKSSspyxU0Pq5k6dDy
         bHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-description:content-disposition:in-reply-to
         :user-agent;
        bh=pXIjVqh7UNlrSF8snJz0VCjdbj2n7TzPYTerNEzotLI=;
        b=p2B2x6lUfOXuzNUpLoz0F+8/VA9101iVtdmhLpER9IZLJ8uAfCYPjKR2eIMZ93ZO3G
         DaAJWCKUeCegVeqFsci37TxV7QPNodu3YUNk1MHXKtMrExAF2pZtLLjNKcBfzZMLLM5l
         r0uZt+MXy1bhbg9JuBMrEt/apAcvzhn0U8ZFhIduT6lgoo0s+kd0gOJWqPJkvE54V0q5
         YkH5q5KckmI0WCY5rV/qXP83xzEIrwIVJWajGB8bHHS4/bAHxHZF+VJi3SB9sGO4ZMM8
         TpWT89k+tELgfbXGsp5KtbKwRGll5nPLQftMsh3xoLHeLls7/6AGFqKAKlhhDAHt4/Yx
         JybA==
X-Gm-Message-State: AJIora+oW6iBw1fkK+pukqE+Cd9CmHajs9ljGKR5CWvDJfDcZaCJJkF+
        QONybSouLS1XZoo3ZxyTKXw=
X-Google-Smtp-Source: AGRyM1uAGqHGG/G1oXYd0S84V1DymZno8oCjguvQ1D5MRbhviAjOPGj/kFGXVX+KsJer1KFmsxetmg==
X-Received: by 2002:a17:902:ab8a:b0:16a:4521:a7b7 with SMTP id f10-20020a170902ab8a00b0016a4521a7b7mr5167702plr.57.1655917347433;
        Wed, 22 Jun 2022 10:02:27 -0700 (PDT)
Received: from Mahakal ([2401:4900:1cc4:6ac4:7541:33fc:3c9c:4592])
        by smtp.gmail.com with ESMTPSA id p8-20020aa78608000000b005183cf12184sm3984506pfn.133.2022.06.22.10.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 10:02:26 -0700 (PDT)
Date:   Wed, 22 Jun 2022 22:32:20 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chinmoyghosh2001@gmail.com, mintupatel89@gmail.com
Subject: Re: [PATCH] Common clock: =?utf-8?B?4oCL?= =?utf-8?B?4oCLVG8=?= list
 active consumers of clocks
Message-ID: <20220622170219.GA6978@Mahakal>
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
 <20220610194013.DD39DC34114@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: Thanks Stephen for the input, the patch has beed revised as below:
Content-Disposition: inline
In-Reply-To: <20220610194013.DD39DC34114@smtp.kernel.org>
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


From f2e9d78bd0f135206fbfbf2e0178a5782b972939 Mon Sep 17 00:00:00 2001
From: Vishal Badole <badolevishal1116@gmail.com>
Date: Tue, 21 Jun 2022 09:55:51 +0530
Subject: [PATCH] Common clock: To list active consumers of clocks

This feature lists the name of clocks and their consumer devices.
Using this feature user can easily check which device is using a
perticular clock. Consumers without dev_id are listed as no_dev_id.

Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Acked-by: Vimal Kumar <vimal.kumar32@gmail.com>
Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
---
 drivers/clk/clk.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ed11918..b191009 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3018,6 +3018,63 @@ static int clk_summary_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(clk_summary);
 
+static void clk_consumer_show_one(struct seq_file *s, struct clk_core *core, int level)
+{
+	struct clk *clk_user;
+	const char *consumer;
+
+	hlist_for_each_entry(clk_user, &core->clks, clks_node) {
+		if (!clk_user->dev_id)
+			consumer = "no_dev_id";
+		else
+			consumer = clk_user->dev_id;
+
+		seq_printf(s, "%*s%-*s %30s %5d %7d ",
+			   level * 3 + 1, "",
+			   30 - level * 3, clk_user->core->name, consumer,
+			   clk_user->core->enable_count, clk_user->core->prepare_count);
+
+		if (clk_user->core->ops->is_enabled)
+			seq_printf(s, " %8c\n", clk_core_is_enabled(clk_user->core) ? 'Y' : 'N');
+		else if (!clk_user->core->ops->enable)
+			seq_printf(s, " %8c\n", 'Y');
+		else
+			seq_printf(s, " %8c\n", '?');
+	}
+}
+
+static void clk_consumer_show_subtree(struct seq_file *s, struct clk_core *c, int level)
+{
+	struct clk_core *child;
+
+	clk_consumer_show_one(s, c, level);
+
+	hlist_for_each_entry(child, &c->children, child_node)
+		clk_consumer_show_subtree(s, child, level + 1);
+}
+
+static int clk_consumer_show(struct seq_file *s, void *data)
+{
+	struct clk_core *c;
+	struct hlist_head **lists = (struct hlist_head **)s->private;
+
+	seq_puts(s, "                                                              enable   prepare   hardware\n");
+	seq_puts(s, "   clock                                       consumer        count     count     enable\n");
+	seq_puts(s, "-----------------------------------------------------------------------------------------\n");
+	clk_prepare_lock();
+
+	/*Traversing Linked List to print clock consumer*/
+
+	for (; *lists; lists++)
+		hlist_for_each_entry(c, *lists, child_node)
+			clk_consumer_show_subtree(s, c, 0);
+
+	clk_prepare_unlock();
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(clk_consumer);
+
 static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 {
 	int phase;
@@ -3437,6 +3494,8 @@ static int __init clk_debug_init(void)
 			    &clk_summary_fops);
 	debugfs_create_file("clk_orphan_dump", 0444, rootdir, &orphan_list,
 			    &clk_dump_fops);
+	debugfs_create_file("clk_consumer", 0444, rootdir, &all_lists,
+			    &clk_consumer_fops);
 
 	mutex_lock(&clk_debug_lock);
 	hlist_for_each_entry(core, &clk_debug_list, debug_node)
-- 
2.7.4

