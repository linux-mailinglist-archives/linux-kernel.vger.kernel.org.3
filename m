Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EBE4B5F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiBOA3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:29:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiBOA3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:29:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52953119417
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644884969; x=1676420969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ncMI0EhhO9hE9xejvboOh/fi9Wowt90vvpLp8QRli4E=;
  b=XI3iOZTToPeympPGnh5f2172EhRt9yrbgc14tLQEDYvErSWTq4BVyKiL
   4n5rMubAwhIihslLXqSBh9dNdoZBcke5dBZgfu4PSWP4R16MOoYMGugJY
   fwr50hdtZcky+4J9PrVAI3ZobevK08xPMbyd39579OlPZlHELmGfY43n9
   Rh/Sj0ot8eWrHWyU9AXHJgMaiLoU2jB/DmDpKGtkEvBxbI+30Ek5MLlMo
   re9iR2faUtb2Cu/tWxUIkxgC8ScBRBMVOd5lpIUg7UW/VdObtTBibyK9t
   gok9a62yTv96jOgLKkCfSsviRQX9Uw7VKGLkotyABUad+1TLcC0NcV2FU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250423171"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="250423171"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 16:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="703350293"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2022 16:29:26 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJlig-00096I-60; Tue, 15 Feb 2022 00:29:26 +0000
Date:   Tue, 15 Feb 2022 08:29:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 28/39]
 fs/netfs/write_helper.c:665:32: error: no member named 'cache' in 'struct
 netfs_i_context'
Message-ID: <202202150844.OSL410Oz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   b995bc7182f60aa2b4d8930a7446f10dfbcebcc2
commit: f923e34430afd434b984d1d604f3ec3898f63ad8 [28/39] netfs: Implement buffered writes through netfs_file_write_iter()
config: hexagon-randconfig-r034-20220214 (https://download.01.org/0day-ci/archive/20220215/202202150844.OSL410Oz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f923e34430afd434b984d1d604f3ec3898f63ad8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout f923e34430afd434b984d1d604f3ec3898f63ad8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> fs/netfs/write_helper.c:28:26: warning: comparison of distinct pointer types ('typeof ((1UL << 18) - offset) *' (aka 'unsigned long *') and 'typeof (size) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
                   unsigned int psize   = min(PAGE_SIZE - offset, size);
                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/netfs/write_helper.c:125:18: warning: comparison of distinct pointer types ('typeof (target->from) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
           target->from  = min(target->from, folio_pos(folio) + offset);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/netfs/write_helper.c:126:18: warning: comparison of distinct pointer types ('typeof (target->to) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset + len) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
           target->to    = max(target->to,   folio_pos(folio) + offset + len);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>> fs/netfs/write_helper.c:665:32: error: no member named 'cache' in 'struct netfs_i_context'
                                   fscache_update_cookie(ctx->cache, NULL, &pos);
                                                         ~~~  ^
   3 warnings and 1 error generated.


vim +665 fs/netfs/write_helper.c

   507	
   508	/*
   509	 * Write data into a prereserved region of the pagecache attached to a netfs
   510	 * inode.
   511	 */
   512	static ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
   513					   enum netfs_write_type write_type)
   514	{
   515		struct netfs_dirty_region *spare_region = NULL;
   516		struct file *file = iocb->ki_filp;
   517		struct netfs_i_context *ctx = netfs_i_context(file_inode(file));
   518		struct folio *folio;
   519		enum netfs_handle_nonuptodate nupt;
   520		ssize_t written = 0, ret;
   521		loff_t i_size, pos = iocb->ki_pos;
   522		bool always_fill = false;
   523		bool locked = false;
   524	
   525		MA_STATE(mas, &ctx->dirty_regions, pos / PAGE_SIZE,
   526			 (pos + iov_iter_count(iter) - 1) / PAGE_SIZE);
   527	
   528		ret = ctx->ops->validate_for_write(file_inode(file), file);
   529		if (ret < 0)
   530			return ret;
   531	
   532		do {
   533			size_t plen;
   534			size_t offset;	/* Offset into pagecache folio */
   535			size_t bytes;	/* Bytes to write to folio */
   536			size_t copied;	/* Bytes copied from user */
   537	
   538			folio = netfs_grab_folio_for_write(file->f_mapping,
   539							   pos / PAGE_SIZE,
   540							   iov_iter_count(iter));
   541			if (!folio) {
   542				ret = -ENOMEM;
   543				goto out;
   544			}
   545	
   546			plen = folio_size(folio);
   547			offset = pos - folio_file_pos(folio);
   548			bytes = min_t(size_t, plen - offset, iov_iter_count(iter));
   549			locked = true;
   550	
   551			if (!folio_test_uptodate(folio)) {
   552				folio_unlock(folio); /* Avoid deadlocking fault-in */
   553				locked = false;
   554			}
   555	
   556			/* Bring in the user page that we will copy from _first_.
   557			 * Otherwise there's a nasty deadlock on copying from the same
   558			 * page as we're writing to, without it being marked
   559			 * up-to-date.
   560			 *
   561			 * Not only is this an optimisation, but it is also required to
   562			 * check that the address is actually valid, when atomic
   563			 * usercopies are used, below.
   564			 */
   565			if (unlikely(fault_in_iov_iter_readable(iter, bytes))) {
   566				ret = -EFAULT;
   567				goto error_folio;
   568			}
   569	
   570			if (fatal_signal_pending(current)) {
   571				ret = -EINTR;
   572				goto error_folio;
   573			}
   574	
   575			if (!locked) {
   576				ret = folio_lock_killable(folio);
   577				if (ret < 0)
   578					goto error_folio;
   579			}
   580	
   581	redo_prefetch:
   582			/* See if we need to prefetch the area we're going to modify.
   583			 * We need to do this before we get a lock on the folio in case
   584			 * there's more than one writer competing for the same cache
   585			 * block.
   586			 */
   587			nupt = netfs_handle_nonuptodate_folio(ctx, file, folio,
   588							      offset, bytes, always_fill);
   589			_debug("nupt %u", nupt);
   590			switch (nupt) {
   591			case NETFS_JUST_PREFETCH:
   592				ret = netfs_prefetch_for_write(file, folio, bytes);
   593				if (ret < 0) {
   594					_debug("prefetch = %zd", ret);
   595					goto error_folio;
   596				}
   597				nupt = NETFS_FOLIO_IS_UPTODATE;
   598				fallthrough;
   599			case NETFS_FOLIO_IS_UPTODATE:
   600				break;
   601			case NETFS_MODIFY_AND_CLEAR:
   602				zero_user_segment(&folio->page, 0, offset);
   603				break;
   604			case NETFS_WHOLE_FOLIO_MODIFY:
   605				break;
   606			}
   607	
   608			/* Preallocate the space we need in the dirty region list. */
   609			ret = mas_expected_entries(&mas, 1);
   610			if (ret < 0)
   611				goto error_folio;
   612	
   613			if (!spare_region) {
   614				spare_region = netfs_alloc_dirty_region();
   615				if (IS_ERR(spare_region)) {
   616					ret = PTR_ERR(spare_region);
   617					spare_region = NULL;
   618					goto error_folio;
   619				}
   620			}
   621	
   622			if (mapping_writably_mapped(folio_file_mapping(folio)))
   623				flush_dcache_folio(folio);
   624			copied = copy_folio_from_iter_atomic(folio, offset, bytes, iter);
   625			flush_dcache_folio(folio);
   626	
   627			/*  Deal with a (partially) failed copy */
   628			if (!folio_test_uptodate(folio)) {
   629				if (copied == 0) {
   630					ret = -EFAULT;
   631					goto error_folio;
   632				}
   633				if (copied < bytes) {
   634					iov_iter_revert(iter, copied);
   635					always_fill = true;
   636					goto redo_prefetch;
   637				}
   638				switch (nupt) {
   639				case NETFS_JUST_PREFETCH:
   640				case NETFS_FOLIO_IS_UPTODATE:
   641					/* We have the folio locked, so it really ought
   642					 * to be uptodate.
   643					 */
   644					WARN(true, "Locked folio %lx became non-uptodate\n",
   645					     folio_index(folio));
   646					ret = -EIO;
   647					goto error_folio;
   648				case NETFS_MODIFY_AND_CLEAR:
   649					zero_user_segment(&folio->page, offset + copied, plen);
   650					fallthrough;
   651				case NETFS_WHOLE_FOLIO_MODIFY:
   652					folio_mark_uptodate(folio);
   653					break;
   654				}
   655			}
   656	
   657			/* Update the inode size if we moved the EOF marker */
   658			pos += copied;
   659			i_size = i_size_read(file_inode(file));
   660			if (pos > i_size) {
   661				if (ctx->ops->update_i_size) {
   662					ctx->ops->update_i_size(file, pos);
   663				} else {
   664					i_size_write(file_inode(file), pos);
 > 665					fscache_update_cookie(ctx->cache, NULL, &pos);
   666				}
   667			}
   668	
   669			netfs_commit_folio(ctx, file, &spare_region, &mas,
   670					   folio, offset, copied, write_type);
   671	
   672			folio_mark_dirty(folio);
   673			folio_unlock(folio);
   674			folio_put(folio);
   675			folio = NULL;
   676	
   677			cond_resched();
   678	
   679			written += copied;
   680	
   681			balance_dirty_pages_ratelimited(file->f_mapping);
   682		} while (iov_iter_count(iter));
   683	
   684	out:
   685		if (likely(written)) {
   686			if (write_type == NETFS_ORDINARY_WRITE)
   687				netfs_commit_region(ctx, &mas, iocb->ki_pos, written);
   688	
   689			iocb->ki_pos += written;
   690	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
