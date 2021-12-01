Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF5F465813
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbhLAVDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:03:02 -0500
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:45420 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353723AbhLAVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:00:56 -0500
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 61217182CF665;
        Wed,  1 Dec 2021 20:57:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 3CF5820032;
        Wed,  1 Dec 2021 20:56:32 +0000 (UTC)
Message-ID: <a233e728e7de8919fbaefaad862bdf06849cab8c.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: co-maintain random.c
From:   Joe Perches <joe@perches.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 01 Dec 2021 12:56:31 -0800
In-Reply-To: <1c2862682ff04463c7ca1f58f1c46aec4d6af03d.camel@perches.com>
References: <20211130184315.258150-1-Jason@zx2c4.com>
         <1c2862682ff04463c7ca1f58f1c46aec4d6af03d.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.90
X-Stat-Signature: x5hit3ehn4ckbfq9yhyoxxwr8cge5hny
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3CF5820032
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/YWNWwFEBfHU/ShRskkPMY58QGSkX936c=
X-HE-Tag: 1638392192-891200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-30 at 17:01 -0800, Joe Perches wrote:
> On Tue, 2021-11-30 at 13:43 -0500, Jason A. Donenfeld wrote:
> > random.c is a bit understaffed, and folks want more prompt reviews. I've
> > got the crypto background and the interest to do these reviews, and have
> > authored parts of the file already.
[]
> It's been over 2 years since Ted even acked a patch.

That's not true.

> $ git log --no-merges --format=email drivers/char/random.c | \
>   grep -Pi "^Subject:|^Date:|^\w+-by:.*tytso" | \
>   grep -B2 tytso

This was a bad script as it didn't allow "Signed-off-by:"
My apologies to Ted for my mistake.

$ git log --no-merges --format=email drivers/char/random.c | \
  grep -Pi "^Subject:|^Date:|^[\w\-]+-by:.*tytso" | \
  grep -B2 tytso
Date: Tue, 10 Mar 2020 12:09:12 +0000
Subject: [PATCH] random: avoid warnings for !CONFIG_NUMA builds
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 25 Feb 2020 11:27:04 -0500
Subject: [PATCH] random: fix data races at timer_rand_state
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 21 Feb 2020 21:10:37 +0100
Subject: [PATCH] random: always use batched entropy for get_random_u{32,64}
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 10 Feb 2020 13:00:13 +0000
Subject: [PATCH] random: add arch_get_random_*long_early()
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 10 Feb 2020 13:00:12 +0000
Subject: [PATCH] random: split primary/secondary crng init paths
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 7 Jan 2020 16:56:11 -0500
Subject: [PATCH] random: remove some dead code of poolinfo
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 7 Jan 2020 16:55:34 -0500
Subject: [PATCH] random: fix typo in add_timer_randomness()
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 7 Jun 2019 14:25:15 -0400
Subject: [PATCH] random: Add and use pr_fmt()
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 7 Jun 2019 14:25:14 -0400
Subject: [PATCH] random: convert to ENTROPY_BITS for better code readability
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 7 Jan 2020 16:10:28 -0500
Subject: [PATCH] random: remove unnecessary unlikely()
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Dec 2019 00:20:51 -0800
Subject: [PATCH] random: remove kernel.random.read_wakeup_threshold
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Dec 2019 00:20:50 -0800
Subject: [PATCH] random: delete code to pull data into pools
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Dec 2019 00:20:49 -0800
Subject: [PATCH] random: remove the blocking pool
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Dec 2019 00:20:48 -0800
Subject: [PATCH] random: make /dev/random be almost like /dev/urandom
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Dec 2019 00:20:47 -0800
Subject: [PATCH] random: ignore GRND_RANDOM in getentropy(2)
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Dec 2019 00:20:46 -0800
Subject: [PATCH] random: add GRND_INSECURE to return best-effort
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Dec 2019 00:20:45 -0800
Subject: [PATCH] random: Add a urandom_read_nowait() for random APIs that
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Dec 2019 00:20:44 -0800
Subject: [PATCH] random: Don't wake crng_init_wait when crng_init == 1
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 13 Nov 2019 16:16:25 -0500
Subject: [PATCH] char/random: silence a lockdep splat with printk()
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Fri, 23 Aug 2019 14:24:51 +0800
Subject: [PATCH] fdt: add support for rng-seed
Reviewed-by: Theodore Ts'o <tytso@mit.edu> # drivers/char/random.c
--
Date: Wed, 22 May 2019 12:02:16 -0400
Subject: [PATCH] random: fix soft lockup when trying to read from an
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 20 Apr 2019 00:09:51 -0400
Subject: [PATCH] random: add a spinlock_t to struct batched_entropy
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 19 Apr 2019 23:48:20 -0400
Subject: [PATCH] random: document get_random_int() family
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 19 Apr 2019 23:35:16 -0400
Subject: [PATCH] random: fix CRNG initialization when random.trust_cpu=1
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 19 Apr 2019 23:27:05 -0400
Subject: [PATCH] random: move rand_initialize() earlier
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 20 Feb 2019 16:06:38 -0500
Subject: [PATCH] random: only read from /dev/random after its pool has
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 2 Nov 2018 12:04:47 +0100
Subject: [PATCH] drivers/char/random.c: make primary_crng static
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 2 Nov 2018 12:04:46 +0100
Subject: [PATCH] drivers/char/random.c: remove unused stuct poolinfo::poolbits
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 2 Nov 2018 12:04:45 +0100
Subject: [PATCH] drivers/char/random.c: constify poolinfo_table
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Mon, 27 Aug 2018 14:51:54 -0700
Subject: [PATCH] random: make CPU trust a boot parameter
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 31 Jul 2018 21:11:00 +0200
Subject: [PATCH] random: Make crng state queryable
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 22 Jul 2018 10:51:50 -0400
Subject: [PATCH] random: remove preempt disabled region
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 17 Jul 2018 18:24:27 -0400
Subject: [PATCH] random: add a config option to trust the CPU's hwrng
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 22 Jun 2018 09:15:32 +1000
Subject: [PATCH] random: Return nbytes filled from hw RNG
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 22 Jun 2018 09:15:31 +1000
Subject: [PATCH] random: Fix whitespace pre random-bytes work
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 14 Jul 2018 23:55:57 -0400
Subject: [PATCH] random: mix rdrand with entropy sent in from userspace
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Mon, 9 Apr 2018 15:29:32 +0200
Subject: [PATCH] random: convert to ->poll_mask
Acked-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 25 Apr 2018 01:12:32 -0400
Subject: [PATCH] random: rate limit unseeded randomness warnings
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Apr 2018 18:51:28 -0400
Subject: [PATCH] random: fix possible sleeping allocation from irq context
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 11 Apr 2018 16:32:17 -0400
Subject: [PATCH] random: add new ioctl RNDRESEEDCRNG
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 12 Apr 2018 00:50:45 -0400
Subject: [PATCH] random: crng_reseed() should lock the crng instance that it
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 11 Apr 2018 15:23:56 -0400
Subject: [PATCH] random: set up the NUMA crng instances after the CRNG is
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 11 Apr 2018 14:58:27 -0400
Subject: [PATCH] random: use a different mixing algorithm for
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 11 Apr 2018 13:27:52 -0400
Subject: [PATCH] random: fix crng_ready() test
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 1 Mar 2018 00:22:47 +0100
Subject: [PATCH] drivers/char/random.c: remove unused dont_count_entropy
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 28 Feb 2018 13:43:28 -0800
Subject: [PATCH] random: optimize add_interrupt_randomness
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 25 Feb 2017 18:21:33 -0400
Subject: [PATCH] random: use a tighter cap in credit_entropy_bits_safe()
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Fri, 30 Jun 2017 16:37:13 +0200
Subject: [PATCH] random: reorder READ_ONCE() in get_random_uXX
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 8 Jun 2017 04:16:59 -0400
Subject: [PATCH] random: suppress spammy warnings about unseeded randomness
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Wed, 7 Jun 2017 23:06:55 -0400
Subject: [PATCH] random: warn when kernel uses unseeded randomness
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 7 Jun 2017 19:58:56 -0400
Subject: [PATCH] random: add wait_for_random_bytes() API
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 15 Jun 2017 00:45:26 +0200
Subject: [PATCH] random: silence compiler warnings and fix race
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 7 Jun 2017 19:45:31 -0400
Subject: [PATCH] random: invalidate batched entropy after crng init
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 7 Jun 2017 19:01:32 -0400
Subject: [PATCH] random: use lockless method of accessing and updating
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 30 Apr 2017 19:49:21 +1200
Subject: [PATCH] fix race in drivers/char/random.c:get_reg()
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 31 Jan 2017 14:36:07 -0200
Subject: [PATCH] random: move random_min_urandom_seed into CONFIG_SYSCTL ifdef
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 22 Jan 2017 16:34:08 +0100
Subject: [PATCH] random: convert get_random_int/long into get_random_u32/u64
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 6 Jan 2017 19:32:01 +0100
Subject: [PATCH] random: use chacha20 for get_random_int/long
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 27 Dec 2016 23:41:22 +0100
Subject: [PATCH] random: fix comment for unused random_min_urandom_seed
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 27 Dec 2016 23:40:59 +0100
Subject: [PATCH] random: remove variable limit
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 27 Dec 2016 23:39:31 +0100
Subject: [PATCH] random: remove stale urandom_init_wait
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 15 Dec 2016 12:42:33 +0100
Subject: [PATCH] random: remove stale maybe_reseed_primary_crng
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Wed, 27 Jul 2016 23:30:25 -0400
Subject: [PATCH] random: use for_each_online_node() to iterate over NUMA nodes
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 3 Jul 2016 17:01:26 -0400
Subject: [PATCH] random: strengthen input validation for RNDADDTOENTCNT
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 4 May 2016 13:29:18 -0400
Subject: [PATCH] random: add backtracking protection to the CRNG
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 2 May 2016 02:04:41 -0400
Subject: [PATCH] random: make /dev/urandom scalable for silly userspace
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 12 Jun 2016 18:13:36 -0400
Subject: [PATCH] random: replace non-blocking pool with a Chacha20-based CRNG
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 4 May 2016 21:08:39 -0400
Subject: [PATCH] random: properly align get_random_int_hash
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 2 May 2016 02:14:34 -0400
Subject: [PATCH] random: add interrupt callback to VMBus IRQ handler
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 13 Jun 2016 10:10:51 -0400
Subject: [PATCH] random: print a warning for the first ten uninitialized
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 12 Jun 2016 18:11:51 -0400
Subject: [PATCH] random: initialize the non-blocking pool via
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Tue, 26 Aug 2014 23:16:35 -0400
Subject: [PATCH] random: add and use memzero_explicit() for clearing data
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Thu, 17 Jul 2014 05:27:30 -0400
Subject: [PATCH] random: limit the contribution of the hw rng to at most half
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 17 Jul 2014 04:13:05 -0400
Subject: [PATCH] random: introduce getrandom(2) system call
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 18 Jul 2014 17:26:41 -0400
Subject: [PATCH] random: check for increase of entropy_count because of signed
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 15 Jun 2014 16:59:24 -0400
Subject: [PATCH] random: use registers from interrupted code for CPU's w/o a
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 14 Jun 2014 23:38:36 -0400
Subject: [PATCH] random: add_hwgenerator_randomness() for feeding entropy from
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 14 Jun 2014 21:43:13 -0400
Subject: [PATCH] random: use an improved fast_mix() function
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 14 Jun 2014 03:06:57 -0400
Subject: [PATCH] random: clean up interrupt entropy accounting for archs w/o
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 10 Jun 2014 23:18:16 -0400
Subject: [PATCH] random: only update the last_pulled time if we actually
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 10 Jun 2014 23:09:20 -0400
Subject: [PATCH] random: remove unneeded hash of a portion of the entropy pool
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 10 Jun 2014 22:46:37 -0400
Subject: [PATCH] random: always update the entropy pool under the spinlock
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 15 Jun 2014 21:04:32 -0400
Subject: [PATCH] random: fix nasty entropy accounting bug
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
--
Date: Fri, 16 May 2014 21:40:41 -0400
Subject: [PATCH] random: fix BUG_ON caused by accounting simplification
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 25 Apr 2014 00:36:37 -0700
Subject: [PATCH] random: export add_disk_randomness
Acked-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Mon, 17 Mar 2014 16:36:30 -0700
Subject: [PATCH] random: Add arch_has_random[_seed]()
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 17 Mar 2014 16:36:29 -0700
Subject: [PATCH] random: If we have arch_get_random_seed*(), try it before
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 17 Mar 2014 16:36:28 -0700
Subject: [PATCH] random: Use arch_get_random_seed*() at init time and once a
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 17 Dec 2013 21:16:39 -0500
Subject: [PATCH] random: use the architectural HWRNG for the SHA's IV in
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 6 Dec 2013 21:28:03 -0500
Subject: [PATCH] random: clarify bits/bytes in wakeup thresholds
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sat, 7 Dec 2013 09:49:55 -0500
Subject: [PATCH] random: entropy_bytes is actually bits
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 5 Dec 2013 19:32:19 -0500
Subject: [PATCH] random: simplify accounting code
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 5 Dec 2013 19:19:29 -0500
Subject: [PATCH] random: tighten bound on random_read_wakeup_thresh
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 29 Nov 2013 20:09:37 -0500
Subject: [PATCH] random: forget lock in lockless accounting
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 29 Nov 2013 15:56:16 -0500
Subject: [PATCH] random: simplify accounting logic
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 29 Nov 2013 15:50:06 -0500
Subject: [PATCH] random: fix comment on "account"
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 29 Nov 2013 15:02:33 -0500
Subject: [PATCH] random: simplify loop in random_read
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 29 Nov 2013 14:59:45 -0500
Subject: [PATCH] random: fix description of get_random_bytes
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 29 Nov 2013 14:58:16 -0500
Subject: [PATCH] random: fix comment on proc_do_uuid
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 29 Nov 2013 14:58:06 -0500
Subject: [PATCH] random: fix typos / spelling errors in comments
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Mon, 11 Nov 2013 12:20:34 +0100
Subject: [PATCH] random32: add prandom_reseed_late() and call when nonblocking
Acked-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sun, 3 Nov 2013 18:24:08 -0500
Subject: [PATCH] random: add debugging code to detect early use of
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sun, 3 Nov 2013 16:40:53 -0500
Subject: [PATCH] random: initialize the last_time field in struct
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sun, 3 Nov 2013 07:56:17 -0500
Subject: [PATCH] random: don't zap entropy count in rand_initialize()
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sun, 3 Nov 2013 06:54:51 -0500
Subject: [PATCH] random: printk notifications for urandom pool initialization
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sun, 3 Nov 2013 00:15:05 -0400
Subject: [PATCH] random: make add_timer_randomness() fill the nonblocking pool
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 3 Oct 2013 12:02:37 -0400
Subject: [PATCH] random: convert DEBUG_ENT to tracepoints
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 3 Oct 2013 01:08:15 -0400
Subject: [PATCH] random: push extra entropy to the output pools
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Wed, 2 Oct 2013 21:10:35 -0400
Subject: [PATCH] random: drop trickle mode
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sun, 22 Sep 2013 16:04:19 -0400
Subject: [PATCH] random: adjust the generator polynomials in the mixing
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sun, 22 Sep 2013 15:24:02 -0400
Subject: [PATCH] random: speed up the fast_mix function by a factor of four
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sun, 22 Sep 2013 15:14:32 -0400
Subject: [PATCH] random: cap the rate which the /dev/urandom pool gets
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sat, 21 Sep 2013 19:42:41 -0400
Subject: [PATCH] random: optimize the entropy_store structure
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 12 Sep 2013 14:27:22 -0400
Subject: [PATCH] random: optimize spinlock use in add_device_randomness()
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 12 Sep 2013 14:10:25 -0400
Subject: [PATCH] random: fix the tracepoint for get_random_bytes(_arch)
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Tue, 10 Sep 2013 23:16:17 -0400
Subject: [PATCH] random: account for entropy loss due to overwrites
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 10 Sep 2013 23:16:17 -0400
Subject: [PATCH] random: allow fractional bits to be tracked
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 10 Sep 2013 23:16:17 -0400
Subject: [PATCH] random: statically compute poolbitshift, poolbytes, poolbits
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 21 Sep 2013 18:06:02 -0400
Subject: [PATCH] random: mix in architectural randomness earlier in
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Sat, 21 Sep 2013 13:58:22 -0400
Subject: [PATCH] random: allow architectures to optionally define
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Tue, 10 Sep 2013 10:52:35 -0400
Subject: [PATCH] random: run random_int_secret_init() run after all
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
--
Date: Mon, 4 Mar 2013 11:59:12 -0500
Subject: [PATCH] random: fix locking dependency with the tasklist_lock
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
--
Date: Tue, 6 Nov 2012 10:42:42 -0500
Subject: [PATCH] random: prime last_data value per fips requirements
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Mon, 15 Oct 2012 23:43:29 +0200
Subject: [PATCH] random: fix debug format strings
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 15 Oct 2012 23:42:55 +0200
Subject: [PATCH] random: make it possible to enable debugging without rebuild
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 27 Jul 2012 22:26:08 -0400
Subject: [PATCH] random: mix in architectural randomness in extract_buf()
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Mon, 23 Jul 2012 09:47:57 -0700
Subject: [PATCH] random: Add comment to random_initialize()
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 14 Jul 2012 20:27:52 -0400
Subject: [PATCH] random: remove rand_initialize_irq()
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Wed, 4 Jul 2012 16:19:30 -0400
Subject: [PATCH] random: add tracepoints for easier debugging and verification
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 5 Jul 2012 10:35:23 -0400
Subject: [PATCH] random: add new get_random_bytes_arch() function
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 5 Jul 2012 10:21:01 -0400
Subject: [PATCH] random: use the arch-specific rng in xfer_secondary_pool
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Wed, 4 Jul 2012 11:16:01 -0400
Subject: [PATCH] random: create add_device_randomness() interface
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Wed, 4 Jul 2012 10:38:30 -0400
Subject: [PATCH] random: use lockless techniques in the interrupt path
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Mon, 2 Jul 2012 07:52:16 -0400
Subject: [PATCH] random: make 'add_interrupt_randomness()' do something sane
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Date: Fri, 6 Jul 2012 14:03:18 -0400
Subject: [PATCH] random: fix up sparse warnings
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
--
Date: Thu, 22 Dec 2011 16:28:01 -0500
Subject: [PATCH] random: Use arch-specific RNG to initialize the entropy store
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
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


