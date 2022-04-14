Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6F501F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347691AbiDNXiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiDNXiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F25DBB905
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9D5A62193
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EC6C385A1;
        Thu, 14 Apr 2022 23:35:39 +0000 (UTC)
Date:   Thu, 14 Apr 2022 19:35:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Plumbers conf presentation on -fanalyze?
Message-ID: <20220414193537.399dbbb5@rorschach.local.home>
In-Reply-To: <3119c35ba1fa7247e87d7acb56e85ea99092d0a4.camel@HansenPartnership.com>
References: <CAKwvOdnb-DiAnq4bT7XiJpFtqyJYpWNw1shEp8gWYpVmUpRBaA@mail.gmail.com>
        <8c5012c88989a8f05a3b67540b9172336c57ddf7.camel@redhat.com>
        <CAKwvOdmXYa-A76CGitoAFNQz3rab37AJafQVN-=QSRVDA8y1fg@mail.gmail.com>
        <3119c35ba1fa7247e87d7acb56e85ea99092d0a4.camel@HansenPartnership.com>
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

On Thu, 14 Apr 2022 19:30:24 -0400
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > I didn't see an answer to that question on
> > https://lpc.events/event/16/page/185-faqs.
> > cc' James + Stephen who might be able to answer that more precisely
> > than I could.  
> 
> It's going to be hybrid ... I thought we actually managed to announce
> that but forgot to put it on the front page.  However, there is a
> caveat: to minimize the risk of technical issues, we'd very much like
> the content producers (speakers etc) to be in person.  This won't be a
> blanket requirement but we'll be unhappy if you try to have a MC with
> mostly virtual speakers for instance.

Yes, virtual will be mostly for audience participation, as there's so
many things that can go wrong with trying to present at a live event
virtually. This *is* the first time we are doing it, so the unknowns
are limitless.

Having a MC topic with a virtual host is fine, as long as there's
co-hosts that can still be there physically in case there's technical
issues.

-- Steve
