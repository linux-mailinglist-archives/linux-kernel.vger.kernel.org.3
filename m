Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB34A4B3B89
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiBMNN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:13:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBMNN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:13:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08F65B8B9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644758002; x=1676294002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nqpkp0FvmjBB8C0xD6iCQqt7RV8GjYvbcI3MggF6kYE=;
  b=iqpu62EdtRZ+afbyuJOIkBxY6qaxuMyqaNR+/utsYvWiR40/yQKtq1DU
   uj20QR2GQw/l02Acb+XanWJCuJxBEKNedgo5up1RqmtVlBZU4EjYteRkS
   2WNFYSWEZqVATfLdcQM+X2qqzgsRdGIxqNaq3Wf/j77+ezBiw1NXo2Ema
   p/R2LxqOaCYCHQeou5HBa59acDJBkRxxnbufYJWJ7hMoRZdOW678R5Q+F
   Q6lDIOy/PesWm9mEQTy0b1dmxWDy8KQcniEPDrrVvgLOuPXcLECdwDPBL
   OjvD0LfOEwvv6chNt9f65lYCO3kkjKg7alKJHMFibzq9PCrJFl9u+Xbny
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="229910729"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="229910729"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 05:13:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="679945758"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 05:13:21 -0800
Date:   Sun, 13 Feb 2022 21:12:07 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [kbuild-all] drivers/md/dm-integrity.c:2567:1: warning: the
 frame size of 1040 bytes is larger than 1024 bytes
Message-ID: <YgkDp/gjx7Wk0dPZ@rli9-dbox>
References: <202202131837.WoH0aQil-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202131837.WoH0aQil-lkp@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 06:49:59PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
> commit: db87a7199229b75c9996bf78117eceb81854fce2 powerpc/bug: Remove specific powerpc BUG_ON() and WARN_ON() on PPC32
> date:   6 months ago
> config: powerpc-randconfig-r035-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131837.WoH0aQil-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db87a7199229b75c9996bf78117eceb81854fce2
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout db87a7199229b75c9996bf78117eceb81854fce2
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/md/ lib/zstd/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/md/dm-integrity.c: In function 'do_journal_write':
> >> drivers/md/dm-integrity.c:2567:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Sorry for the false positive, kindly ignore this report.

>     2567 | }
>          | ^
> 
> 
> vim +2567 drivers/md/dm-integrity.c
> 
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2425  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2426  static void do_journal_write(struct dm_integrity_c *ic, unsigned write_start,
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2427  			     unsigned write_sections, bool from_replay)
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2428  {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2429  	unsigned i, j, n;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2430  	struct journal_completion comp;
> a7c3e62bdc71d3 Mikulas Patocka 2017-07-19  2431  	struct blk_plug plug;
> a7c3e62bdc71d3 Mikulas Patocka 2017-07-19  2432  
> a7c3e62bdc71d3 Mikulas Patocka 2017-07-19  2433  	blk_start_plug(&plug);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2434  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2435  	comp.ic = ic;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2436  	comp.in_flight = (atomic_t)ATOMIC_INIT(1);
> b5e8ad92c3ac0b Arnd Bergmann   2017-08-15  2437  	init_completion(&comp.comp);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2438  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2439  	i = write_start;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2440  	for (n = 0; n < write_sections; n++, i++, wraparound_section(ic, &i)) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2441  #ifndef INTERNAL_VERIFY
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2442  		if (unlikely(from_replay))
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2443  #endif
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2444  			rw_section_mac(ic, i, false);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2445  		for (j = 0; j < ic->journal_section_entries; j++) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2446  			struct journal_entry *je = access_journal_entry(ic, i, j);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2447  			sector_t sec, area, offset;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2448  			unsigned k, l, next_loop;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2449  			sector_t metadata_block;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2450  			unsigned metadata_offset;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2451  			struct journal_io *io;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2452  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2453  			if (journal_entry_is_unused(je))
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2454  				continue;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2455  			BUG_ON(unlikely(journal_entry_is_inprogress(je)) && !from_replay);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2456  			sec = journal_entry_get_sector(je);
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2457  			if (unlikely(from_replay)) {
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2458  				if (unlikely(sec & (unsigned)(ic->sectors_per_block - 1))) {
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2459  					dm_integrity_io_error(ic, "invalid sector in journal", -EIO);
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2460  					sec &= ~(sector_t)(ic->sectors_per_block - 1);
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2461  				}
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2462  			}
> f6f72f32c22c0b Mikulas Patocka 2020-03-22  2463  			if (unlikely(sec >= ic->provided_data_sectors))
> f6f72f32c22c0b Mikulas Patocka 2020-03-22  2464  				continue;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2465  			get_area_and_offset(ic, sec, &area, &offset);
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2466  			restore_last_bytes(ic, access_journal_data(ic, i, j), je);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2467  			for (k = j + 1; k < ic->journal_section_entries; k++) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2468  				struct journal_entry *je2 = access_journal_entry(ic, i, k);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2469  				sector_t sec2, area2, offset2;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2470  				if (journal_entry_is_unused(je2))
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2471  					break;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2472  				BUG_ON(unlikely(journal_entry_is_inprogress(je2)) && !from_replay);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2473  				sec2 = journal_entry_get_sector(je2);
> f6f72f32c22c0b Mikulas Patocka 2020-03-22  2474  				if (unlikely(sec2 >= ic->provided_data_sectors))
> f6f72f32c22c0b Mikulas Patocka 2020-03-22  2475  					break;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2476  				get_area_and_offset(ic, sec2, &area2, &offset2);
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2477  				if (area2 != area || offset2 != offset + ((k - j) << ic->sb->log2_sectors_per_block))
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2478  					break;
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2479  				restore_last_bytes(ic, access_journal_data(ic, i, k), je2);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2480  			}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2481  			next_loop = k - 1;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2482  
> 6f1c819c219f78 Kent Overstreet 2018-05-20  2483  			io = mempool_alloc(&ic->journal_io_mempool, GFP_NOIO);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2484  			io->comp = &comp;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2485  			io->range.logical_sector = sec;
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2486  			io->range.n_sectors = (k - j) << ic->sb->log2_sectors_per_block;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2487  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2488  			spin_lock_irq(&ic->endio_wait.lock);
> 8b3bbd490d880d Mikulas Patocka 2019-04-29  2489  			add_new_range_and_wait(ic, &io->range);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2490  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2491  			if (likely(!from_replay)) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2492  				struct journal_node *section_node = &ic->journal_tree[i * ic->journal_section_entries];
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2493  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2494  				/* don't write if there is newer committed sector */
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2495  				while (j < k && find_newer_committed_node(ic, &section_node[j])) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2496  					struct journal_entry *je2 = access_journal_entry(ic, i, j);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2497  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2498  					journal_entry_set_unused(je2);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2499  					remove_journal_node(ic, &section_node[j]);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2500  					j++;
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2501  					sec += ic->sectors_per_block;
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2502  					offset += ic->sectors_per_block;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2503  				}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2504  				while (j < k && find_newer_committed_node(ic, &section_node[k - 1])) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2505  					struct journal_entry *je2 = access_journal_entry(ic, i, k - 1);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2506  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2507  					journal_entry_set_unused(je2);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2508  					remove_journal_node(ic, &section_node[k - 1]);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2509  					k--;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2510  				}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2511  				if (j == k) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2512  					remove_range_unlocked(ic, &io->range);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2513  					spin_unlock_irq(&ic->endio_wait.lock);
> 6f1c819c219f78 Kent Overstreet 2018-05-20  2514  					mempool_free(io, &ic->journal_io_mempool);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2515  					goto skip_io;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2516  				}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2517  				for (l = j; l < k; l++) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2518  					remove_journal_node(ic, &section_node[l]);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2519  				}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2520  			}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2521  			spin_unlock_irq(&ic->endio_wait.lock);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2522  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2523  			metadata_block = get_metadata_sector_and_offset(ic, area, offset, &metadata_offset);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2524  			for (l = j; l < k; l++) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2525  				int r;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2526  				struct journal_entry *je2 = access_journal_entry(ic, i, l);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2527  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2528  				if (
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2529  #ifndef INTERNAL_VERIFY
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2530  				    unlikely(from_replay) &&
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2531  #endif
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2532  				    ic->internal_hash) {
> 6d39a1241ebc3b Kees Cook       2018-08-07  2533  					char test_tag[max_t(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2534  
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2535  					integrity_sector_checksum(ic, sec + ((l - j) << ic->sb->log2_sectors_per_block),
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2536  								  (char *)access_journal_data(ic, i, l), test_tag);
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2537  					if (unlikely(memcmp(test_tag, journal_entry_tag(ic, je2), ic->tag_size)))
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2538  						dm_integrity_io_error(ic, "tag mismatch when replaying journal", -EILSEQ);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2539  				}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2540  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2541  				journal_entry_set_unused(je2);
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2542  				r = dm_integrity_rw_tag(ic, journal_entry_tag(ic, je2), &metadata_block, &metadata_offset,
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2543  							ic->tag_size, TAG_WRITE);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2544  				if (unlikely(r)) {
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2545  					dm_integrity_io_error(ic, "reading tags", r);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2546  				}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2547  			}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2548  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2549  			atomic_inc(&comp.in_flight);
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2550  			copy_from_journal(ic, i, j << ic->sb->log2_sectors_per_block,
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2551  					  (k - j) << ic->sb->log2_sectors_per_block,
> 9d609f85b7eb96 Mikulas Patocka 2017-04-18  2552  					  get_data_sector(ic, area, offset),
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2553  					  complete_copy_from_journal, io);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2554  skip_io:
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2555  			j = next_loop;
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2556  		}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2557  	}
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2558  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2559  	dm_bufio_write_dirty_buffers_async(ic->bufio);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2560  
> a7c3e62bdc71d3 Mikulas Patocka 2017-07-19  2561  	blk_finish_plug(&plug);
> a7c3e62bdc71d3 Mikulas Patocka 2017-07-19  2562  
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2563  	complete_journal_op(&comp);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2564  	wait_for_completion_io(&comp.comp);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2565  
> 9b5948267adc9e Mikulas Patocka 2021-01-08  2566  	dm_integrity_flush_buffers(ic, true);
> 7eada909bfd7ac Mikulas Patocka 2017-01-04 @2567  }
> 7eada909bfd7ac Mikulas Patocka 2017-01-04  2568  
> 
> :::::: The code at line 2567 was first introduced by commit
> :::::: 7eada909bfd7ac90a4522e56aa3179d1fd68cd14 dm: add integrity target
> 
> :::::: TO: Mikulas Patocka <mpatocka@redhat.com>
> :::::: CC: Mike Snitzer <snitzer@redhat.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
