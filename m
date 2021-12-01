Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B12464456
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhLABE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:04:58 -0500
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:32792 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229450AbhLABEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:04:50 -0500
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 19E171800EC34;
        Wed,  1 Dec 2021 01:01:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 2001BC0002F2;
        Wed,  1 Dec 2021 01:01:28 +0000 (UTC)
Message-ID: <1c2862682ff04463c7ca1f58f1c46aec4d6af03d.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: co-maintain random.c
From:   Joe Perches <joe@perches.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Nov 2021 17:01:27 -0800
In-Reply-To: <20211130184315.258150-1-Jason@zx2c4.com>
References: <20211130184315.258150-1-Jason@zx2c4.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.69
X-Stat-Signature: y5kocm5d7ykj3ixi44npr8ehusxqr5fe
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2001BC0002F2
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19o6aprFOKsg6KQerTIMXn5XjRWnWLPFZU=
X-HE-Tag: 1638320488-960829
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-30 at 13:43 -0500, Jason A. Donenfeld wrote:
> random.c is a bit understaffed, and folks want more prompt reviews. I've
> got the crypto background and the interest to do these reviews, and have
> authored parts of the file already.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -15979,6 +15979,7 @@ F:	arch/mips/generic/board-ranchu.c
>  
>  RANDOM NUMBER DRIVER
>  M:	"Theodore Ts'o" <tytso@mit.edu>
> +M:	Jason A. Donenfeld <Jason@zx2c4.com>

Thank you.

I suggest you reverse the entry order too as Ted really
hasn't done much to random.c for quite awhile.

It's been over 2 years since Ted even acked a patch.

$ git log --no-merges --format=email drivers/char/random.c | \
  grep -Pi "^Subject:|^Date:|^\w+-by:.*tytso" | \
  grep -B2 tytso
Date: Fri, 23 Aug 2019 14:24:51 +0800
Subject: [PATCH] fdt: add support for rng-seed
Reviewed-by: Theodore Ts'o <tytso@mit.edu> # drivers/char/random.c
--
Date: Fri, 22 Jun 2018 09:15:32 +1000
Subject: [PATCH] random: Return nbytes filled from hw RNG
Acked-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 22 Jun 2018 09:15:31 +1000
Subject: [PATCH] random: Fix whitespace pre random-bytes work
Acked-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Mon, 9 Apr 2018 15:29:32 +0200
Subject: [PATCH] random: convert to ->poll_mask
Acked-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Fri, 6 Jan 2017 19:32:01 +0100
Subject: [PATCH] random: use chacha20 for get_random_int/long
Suggested-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Fri, 25 Apr 2014 00:36:37 -0700
Subject: [PATCH] random: export add_disk_randomness
Acked-by: "Theodore Ts'o" <tytso@mit.edu>
--
Date: Mon, 11 Nov 2013 12:20:34 +0100
Subject: [PATCH] random32: add prandom_reseed_late() and call when nonblocking
Acked-by: "Theodore Ts'o" <tytso@mit.edu>
--
Date: Mon, 23 Jul 2012 09:47:57 -0700
Subject: [PATCH] random: Add comment to random_initialize()
Suggested-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Thu, 22 Dec 2011 11:36:22 -0800
Subject: [PATCH] random: Use arch_get_random_int instead of cycle counter if
Acked-by: "Theodore Ts'o" <tytso@mit.edu>
--
Date: Tue, 29 May 2007 21:58:10 -0500
Subject: [PATCH] random: fix seeding with zero entropy
Acked-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Tue, 29 May 2007 21:54:27 -0500
Subject: [PATCH] random: fix error in entropy extraction
Acked-by: "Theodore Ts'o" <tytso@mit.edu>


