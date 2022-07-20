Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF957AD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiGTBmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242093AbiGTBl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:41:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6A26B768
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F5D8CE1E9B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CA1C341C6;
        Wed, 20 Jul 2022 01:37:23 +0000 (UTC)
Date:   Tue, 19 Jul 2022 21:37:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        linux@rasmusvillemoes.dk, willy@infradead.org
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Message-ID: <20220719213704.5f4a5d61@rorschach.local.home>
In-Reply-To: <19c1a301-13ca-d7cf-c0f6-a63f75b7f8eb@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
        <20220719191522.4002a5fb@gandalf.local.home>
        <7462e934-f746-eef7-ff92-0eeb8cc08b82@gmail.com>
        <20220719200507.361b06ee@rorschach.local.home>
        <a674920f-68b0-0b72-5375-da7c062543cc@gmail.com>
        <20220719211156.75ea9255@rorschach.local.home>
        <19c1a301-13ca-d7cf-c0f6-a63f75b7f8eb@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 21:31:49 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> > No, my response is, why should we replace something that is working
> > just fine?  
> For you. For your code.

For the current working kernel.

> 
> Look, Steve, I've tried to work with you. And I've given you reasons why 
> seq_buf doesn't work for vsprintf.c, and more general cases. You have 

Please post the lore links, I'll go back and read them.

> not responded _at all_ with technical reasons or discussion, all you've 
> done from the very start is lecture me on process.

That's because process *is* the way things get into upstream. I guess
you fail to understand that.

> 
> And, to be blunt, the time to have the printbuf vs. seq_buf discussion 
> was months ago. I tried to start that discussion with you, and you 
> ghosted on IRC when I started talking about the things in seq_buf that 
> would have to change.

Look, that was when I was traveling. And when I'm traveling I pretty
much do not respond to IRC.

> 
> Like I said, I'll CC you when v5 is posted.

OK.

-- Steve

