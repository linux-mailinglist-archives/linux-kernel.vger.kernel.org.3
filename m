Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356C65A1FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 06:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbiHZEQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 00:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbiHZEQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:16:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA0BB01B;
        Thu, 25 Aug 2022 21:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FC77B82F5C;
        Fri, 26 Aug 2022 04:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92375C433C1;
        Fri, 26 Aug 2022 04:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661487386;
        bh=dWUP5SzBKFkPPFrG5kSA+6oPlRpqgdw42NE7/hoQ1Qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiTEg+idY8oPIckibp+T6MYEKDON0WivdR/932DAeaZTSHjcPqZZ6m8grGU6QywGI
         IaX+jY3R4IUpB7/4unSU8I/6n/nx88snyehJEKZcB5xsSt1m8MhYr2lU4ewqdYLMXv
         A7GuWyh2bpOeWyAA+TIsFiKl5FG2i+sS2wEkgpAFPZ0BYkXWUkXjnNp7wV32pvEpAT
         6adymDIBYkqb4ycxpjaJXy42FBqdTeZTUTep08rEQoWQBfqZOYAaz2uIHvAUgIgLrX
         OR92z3HcoYRgavC0A6gjfQULOQ3ZgLOfstWQpG5+y64WVuj7cr/uiuSqqe0GC3nLtz
         bglc4YvtgzDjg==
Date:   Fri, 26 Aug 2022 07:16:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org, yejiajian2018@email.szu.edu.cn,
        skhan@linuxfoundation.org, akiyks@gmail.com,
        zhangyinan2019@email.szu.edu.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/mm/page_owner.rst: update experimental data
Message-ID: <YwhJDJQkymdN0E2N@kernel.org>
References: <20220825172934.4344-1-caoyixuan2019@email.szu.edu.cn>
 <87ilmgyz34.fsf@meer.lwn.net>
 <YwgwVsKYLUq0kbMo@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwgwVsKYLUq0kbMo@debian.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 09:30:46AM +0700, Bagas Sanjaya wrote:
> On Thu, Aug 25, 2022 at 12:09:35PM -0600, Jonathan Corbet wrote:
> > >  - Without page owner::
> > >  
> > >     text    data     bss     dec     hex filename
> > > -   48392   2333     644   51369    c8a9 mm/page_alloc.o
> > > +   58581   3166     652   62399    f3bf mm/page_alloc.o
> > >  
> > >  - With page owner::
> > >  
> > >     text    data     bss     dec     hex filename
> > > -   48800   2445     644   51889    cab1 mm/page_alloc.o
> > > -   6662     108      29    6799    1a8f mm/page_owner.o
> > > -   1025       8       8    1041     411 mm/page_ext.o
> > > +   59085   3294     652   63031    f637 mm/page_alloc.o
> > > +   7464     125      28    7617    1dc1 mm/page_owner.o
> > > +   1396      32       8    1436     59c mm/page_ext.o
> > >  
> > > -Although, roughly, 8 KB code is added in total, page_alloc.o increase by
> > > -520 bytes and less than half of it is in hotpath. Building the kernel with
> > > +Although, roughly, 9 KB code is added in total, page_alloc.o increase by
> > > +632 bytes and less than half of it is in hotpath. Building the kernel with
> > >  page owner and turning it on if needed would be great option to debug
> > >  kernel memory problem.
> > 
> > This seems like a fine patch...but I do have to wonder if it really
> > makes sense to maintain this information, which will surely be subject
> > to frequent change.  Perhaps the whole thing is better replaced with a
> > line saying that enabling page owner adds ~9KB?
> > 
> 
> The size figure above is from size(1) from binutils, for which the
> command is run (maybe) against vmlinux.
> 
> So I would like to say "Enabling page owner increases vmlinux size by
> several kilobytes."

Looks like original text tried to emphasize that there is no significant
change to page allocator code, and I think it's worth keeping it. E.g.
leaving something like

"Although, enabling page owner increases kernel size by several kilobytes,
most of this code is outside page allocator and its hot path."
 
instead of size(1) output and the sentences before and after it.

> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara



-- 
Sincerely yours,
Mike.
