Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA9B4E994E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiC1OXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243788AbiC1OXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:23:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6F5E14B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:21:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 474A637A;
        Mon, 28 Mar 2022 14:21:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 474A637A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648477312; bh=Y3Y/2457ssyb9KSS/EmviC1H0li72e06vAGHngedrWU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=s+cF2a4cJpl8vmUwehAlegkYvbO7qZ9HIkD8LrtCZyNEQtGwMt39izzTpQU50z+0b
         j/GdVqQHXAWWusSaEK2Bv399409m3ck6oAH9tmcZYqUkzaeo1ehHQJurMhGIpEbtK9
         R9HBwAXPbWbL7Ogdr11N3R8l2XaA4zAlW0qNh88cX+OxduL3l49Av3+1YmDd6Wx3tm
         T8T9qmn3fCItdAfGmaeFvF8Brx+8/eR3MmHacLNA28Qfi2lEjLu6S/x3Cl4dQxz7XZ
         KtMU1yj/KdBItl+6zCvjPUAoLp/uShYgTLHTIShdo57gkfecagBNo7ZuK6k+n4+cLJ
         8Ot9v7f0ZdJmA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RAS updates for 5.18
In-Reply-To: <Yj4orVIbqcyTQcY7@zn.tnic>
References: <YjtZAvQnshp1pZIh@zn.tnic>
 <CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com>
 <Yj4orVIbqcyTQcY7@zn.tnic>
Date:   Mon, 28 Mar 2022 08:21:51 -0600
Message-ID: <87pmm69myo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@suse.de> writes:

> On Fri, Mar 25, 2022 at 01:01:15PM -0700, Linus Torvalds wrote:
>> [ I've written this kind of reply multiple times before and I
>> _thought_ we had something in the docs about this, but I can't find
>> them, so here goes again ]
>
> Thanks!
>
> I had a faint notion that I had read you telling people that their
> diffstat was bogus but I couldn't find anything relevant for the short
> time I was searching.
>
> How about I start a maintainers-specific documentation in
> Documentation/process/ - we already have maintainer handbooks there -
> and put that there?

Maybe something that looks like:

  https://lore.kernel.org/lkml/87wnghd78t.fsf@meer.lwn.net/

:)

Thanks,

jon
