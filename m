Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE184D9D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349055AbiCOOQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiCOOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E784EA0B;
        Tue, 15 Mar 2022 07:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0486A61699;
        Tue, 15 Mar 2022 14:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AF0C340E8;
        Tue, 15 Mar 2022 14:15:25 +0000 (UTC)
Date:   Tue, 15 Mar 2022 10:15:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the ftrace tree with the nfsd tree
Message-ID: <20220315101524.6215285d@gandalf.local.home>
In-Reply-To: <A1869114-7192-4DF2-BD0F-B2A970F79CC2@oracle.com>
References: <20220315145828.413e9301@canb.auug.org.au>
        <A1869114-7192-4DF2-BD0F-B2A970F79CC2@oracle.com>
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

On Tue, 15 Mar 2022 13:33:30 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> >  af6b9668e85f ("tracing: Move the defines to create TRACE_EVENTS into their own files")
> > 
> > from the ftrace tree.
> > 
> > Well, this is a pain :-(  

Welcome to the include/trace directory ;-)

> 
> Apologies. Steven, can you take the sockaddr patches in your tree
> and resolve the x86_64 build issue?

My apologies, I forgot that there was changes in other trees that affect
this.

Anyway, I'll go and do a merge myself and see what happens. The point of
linux-next is to resolve these kinds of issues. I believe the reason you
took those changes was because you have a dependency on them, and I think
they should stay in your tree.

Let me do the merge myself and verify what Stephen did was correct or needs
to be updated. This will also need to be done for Linus as well.

Thanks,

-- Steve
