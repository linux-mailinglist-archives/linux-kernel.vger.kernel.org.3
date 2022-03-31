Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF54EE4D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243104AbiCaXgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbiCaXgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:36:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34162193159
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3EEDB82298
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF975C340ED;
        Thu, 31 Mar 2022 23:34:12 +0000 (UTC)
Date:   Thu, 31 Mar 2022 19:34:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] ftrace: remove check of list iterator against head past
 the loop body
Message-ID: <20220331193411.2fdbeb88@gandalf.local.home>
In-Reply-To: <212AE797-912E-47D1-9DC4-03B5351AFC57@gmail.com>
References: <20220331223752.902726-1-jakobkoschel@gmail.com>
        <20220331191005.2954969f@gandalf.local.home>
        <212AE797-912E-47D1-9DC4-03B5351AFC57@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 01:22:58 +0200
Jakob Koschel <jakobkoschel@gmail.com> wrote:

> > Can you move this to the first declaration to keep the nice "upside-down
> > x-mas tree" look.  
> 
> Thanks, I'll fix that up. It seems like this is not applied on the entire kernel
> making treewide changes a bit more difficult. Is it documented somewhere, which
> parts of the kernel enforce this? Just looking two lines down from here it
> seems to be 'broken' already so just from looking at existing code it's often
> hard to judge.

It's one of those things that some maintainers prefer (I'm one of them ;-)
because it makes it easier to read IMHO.

But as you noticed, it's broken even in the same file. That's because I
don't strictly enforce it. If there's a lot of code that looks good to go
in, I don't ask to fix it. But as this was a small trivial patch, I figured
I'd mention it.

Thus, it's something that you do when asked, but don't worry about doing it
across the board, you are not going to upset anybody by forgetting to do it.

-- Steve
