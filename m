Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A558B2EB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 02:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbiHFAF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 20:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiHFAFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 20:05:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE83D12AB5;
        Fri,  5 Aug 2022 17:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77F74B829D8;
        Sat,  6 Aug 2022 00:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F54C433D6;
        Sat,  6 Aug 2022 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659744351;
        bh=mwUbPBYbpjlx0Ck1uwp4vA3CrzrvGUmVGR8nHBrzkRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=al4PJ1GM200DeBhIH0jRzLDmeyQO+D7WT08RSs/AI49NrU1CzLwvElTmC15UIR1tv
         +UWwssdlqHfxVQnGiH5k61jRRQPtkeyalZsNXo8ZQFqNOJsychR5+kM+9jME5Hqo1Z
         EDk/2CCsEy113ycYtnMfv7r7JtN8YmtXNNK9KsQQ=
Date:   Fri, 5 Aug 2022 17:05:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 5.20-rc1
Message-Id: <20220805170550.7b8d738155ad7083d680cf9a@linux-foundation.org>
In-Reply-To: <CAHk-=wheFdrnTLNhw6+2ekT_AuJHXHTWEKVQyJrA864mmjFKtQ@mail.gmail.com>
References: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
        <CAHk-=wheFdrnTLNhw6+2ekT_AuJHXHTWEKVQyJrA864mmjFKtQ@mail.gmail.com>
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

On Fri, 5 Aug 2022 16:20:44 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 3, 2022 at 1:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > There are 6-7 conflicts with your tree here.  All very minor, mainly
> > related to the rename of Documentation/vm to Documentation/mm.
> 
> What? No. Yeah, the doc conflicts were annoying enough, with the
> Chinese translations having incorrect pointers to the original sources
> both before and after the move in the MM tree.
> 
> But that xfs conflict was positively nasty and definitely not minor.
> Had to look up Darrick Wong's "here's how to do it" message from the
> linux-next days.
> 
> So I think I got it all right, but "very minor" it wasn't.

Huh.  sorry, there was no XFS conflict with your tree when I did my
test merge and I don't recall seeing emails from Darrick or Stephen on
this one :(

I guess that taking a peek at linux-next would be a good way to get at
the tested resolution for these things?

Emails which might prove useful later in this merge window are:


EIF tree: https://lkml.kernel.org/r/20220726194643.47f6c020@canb.auug.org.au
bitmap tree: https://lkml.kernel.org/r/20220726194151.71e511e7@canb.auug.org.au
crypto: https://lkml.kernel.org/r/20220718195342.6817be63@canb.auug.org.au
bitmap again: https://lkml.kernel.org/r/20220715211409.4fba48e8@canb.auug.org.au
