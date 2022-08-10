Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF02258F3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiHJVyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHJVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:54:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33347804BA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C91C8B81EA8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58739C433D6;
        Wed, 10 Aug 2022 21:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660168472;
        bh=AcqHgSNkf3IX7o9edWdCysQ90+uzp4H5UomIiuXQ1N0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y9/kE+sO1wUIhDBFMxUYua6SQbiIyXn2/rXvGAyuLqGIl+akwW83S93IbKS1Yolgt
         R9uahdGRzi6mnXeYehUV7q/mH6MDIfWjSggm2rHAyhX8eD7zFVWdFKj7f2SLK9Iy8M
         envc9Zmlf82P0FwynTmJE0cuKeH0RNF/m3i6gnLg=
Date:   Wed, 10 Aug 2022 14:54:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, chris@chris-wilson.co.uk
Subject: Re: i915: crash with 5.19-rc2
Message-Id: <20220810145431.71d9bfda20decb357cc208ec@linux-foundation.org>
In-Reply-To: <YvPYQeMjfyruTeGe@casper.infradead.org>
References: <584ae788-05e3-5824-8c85-cbb833677850@redhat.com>
        <f0dd80b2-97e1-c320-8517-7ebdb027f58a@redhat.com>
        <4a204620-7639-c844-455-10e55b372bcf@google.com>
        <YvPYQeMjfyruTeGe@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 17:09:37 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Aug 10, 2022 at 08:55:32AM -0700, Hugh Dickins wrote:
> > This is not a bug in zram or i915, but what Matthew fixes in
> > https://lore.kernel.org/lkml/20220730042518.1264767-1-willy@infradead.org/
> 
> Thanks for tracking that down, Hugh.  Nice to know it's a crash rather
> than a data corruption.  The fix is in Andrew's tree, so I think it's
> already destined for upstream soon.

Yes, that's in the hotfixes queue for sending upstream Fridayish.

> Andrew, I have two fixes that I don't see in your tree:

Is it expected to be in my tree?  It's a huge v1 patch series on which
I wasn't cc'ed?

> https://lore.kernel.org/linux-mm/20220808193430.3378317-2-willy@infradead.org/T/#u
> https://lore.kernel.org/linux-mm/20220808193430.3378317-4-willy@infradead.org/T/#u
> 
> The first is of minor importance, the second I believe Hugh has hit in
> his testing.

In that case the second patch should be pulled out of that series, have
its changelog made to describe the runtime effects and have a Cc:stable
added, please.

