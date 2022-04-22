Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2CB50C302
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiDVXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiDVXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:00:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970291ACD3B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650666688; x=1682202688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5wsfyJnh/mZmx2weShZGzuJ7IusKZVpSUdWv/JOQ0Hs=;
  b=cy/PgVKMx2B/XK+hCAXT6ttLd/Lz6dkKxiyO2HB3tor3bdLCOPLi9bTx
   oMXsJQz3On15vcaBAiNL7BD51wwztNcuBSDpToSK7Bnf3jeg0G6+/l6BV
   kisuCJVjqtM/NsXMPNhlNUn90sZMVTbB45sAvSw62H5Gv4KHT92k3dx1u
   SVneGWaijpyzK8tDb4yUFI11JJaoBy2wlyBunKXUiawSv6SYhEt6iigja
   nxOviiZXYz9ZCMDb9j4lCcunsOlnLd/TqDfhg/VskzUuc0mi322OTa2cR
   8UpFkN5cu7foh9lb87fwT0hIly66l/z2MpU93in2b8nRFYlPVHVfPycHe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263650248"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="263650248"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 15:31:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="594339808"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Apr 2022 15:31:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni1o6-000AcT-Ou;
        Fri, 22 Apr 2022 22:31:18 +0000
Date:   Sat, 23 Apr 2022 06:30:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 35/44]
 fs/netfs/buffered_write.c:618:58: error: 'struct netfs_i_context' has no
 member named 'cache'
Message-ID: <202204230648.v4eUOGe3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: f343507aeda88b2f1a528a659b8fadaa9b6b0f79 [35/44] netfs: Implement buffered writes through netfs_file_write_iter()
config: openrisc-randconfig-r014-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230648.v4eUOGe3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f343507aeda88b2f1a528a659b8fadaa9b6b0f79
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout f343507aeda88b2f1a528a659b8fadaa9b6b0f79
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:26,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/netfs/buffered_write.c:9:
   fs/netfs/buffered_write.c: In function 'copy_folio_from_iter_atomic':
   include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/netfs/buffered_write.c:28:40: note: in expansion of macro 'min'
      28 |                 unsigned int psize   = min(PAGE_SIZE - offset, size);
         |                                        ^~~
   fs/netfs/buffered_write.c: In function 'netfs_subsume_into_existing':
   include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/netfs/buffered_write.c:94:25: note: in expansion of macro 'min'
      94 |         target->from  = min(target->from, folio_pos(folio) + offset);
         |                         ^~~
   include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y)       __careful_cmp(x, y, >)
         |                         ^~~~~~~~~~~~~
   fs/netfs/buffered_write.c:95:25: note: in expansion of macro 'max'
      95 |         target->to    = max(target->to,   folio_pos(folio) + offset + len);
         |                         ^~~
   In file included from include/asm-generic/bug.h:22,
                    from ./arch/openrisc/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/openrisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/netfs/buffered_write.c:9:
   fs/netfs/buffered_write.c: In function 'netfs_commit_folio':
   fs/netfs/internal.h:270:36: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     270 | #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
         |                                    ^~~~~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   fs/netfs/internal.h:270:26: note: in expansion of macro 'no_printk'
     270 | #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
         |                          ^~~~~~~~~
   fs/netfs/buffered_write.c:254:9: note: in expansion of macro '_enter'
     254 |         _enter("e=%llx o=%lx l=%lx", end, offset, len);
         |         ^~~~~~
   fs/netfs/internal.h:270:36: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     270 | #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
         |                                    ^~~~~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   fs/netfs/internal.h:270:26: note: in expansion of macro 'no_printk'
     270 | #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
         |                          ^~~~~~~~~
   fs/netfs/buffered_write.c:254:9: note: in expansion of macro '_enter'
     254 |         _enter("e=%llx o=%lx l=%lx", end, offset, len);
         |         ^~~~~~
   fs/netfs/buffered_write.c: In function 'netfs_perform_write':
>> fs/netfs/buffered_write.c:618:58: error: 'struct netfs_i_context' has no member named 'cache'
     618 |                                 fscache_update_cookie(ctx->cache, NULL, &pos);
         |                                                          ^~


vim +618 fs/netfs/buffered_write.c

   460	
   461	/*
   462	 * Write data into a prereserved region of the pagecache attached to a netfs
   463	 * inode.
   464	 */
   465	static ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter)
   466	{
   467		struct netfs_dirty_region *spare_region = NULL;
   468		struct file *file = iocb->ki_filp;
   469		struct inode *inode = file_inode(file);
   470		struct netfs_i_context *ctx = netfs_i_context(inode);
   471		struct folio *folio;
   472		enum netfs_handle_nonuptodate nupt;
   473		ssize_t written = 0, ret;
   474		loff_t i_size, pos = iocb->ki_pos;
   475		bool always_fill = false;
   476		bool locked = false;
   477	
   478		MA_STATE(mas, &ctx->dirty_regions, pos / PAGE_SIZE,
   479			 (pos + iov_iter_count(iter) - 1) / PAGE_SIZE);
   480	
   481		ret = ctx->ops->validate_for_write(inode, file);
   482		if (ret < 0)
   483			return ret;
   484	
   485		do {
   486			size_t plen;
   487			size_t offset;	/* Offset into pagecache folio */
   488			size_t bytes;	/* Bytes to write to folio */
   489			size_t copied;	/* Bytes copied from user */
   490	
   491			folio = netfs_grab_folio_for_write(file->f_mapping,
   492							   pos / PAGE_SIZE,
   493							   iov_iter_count(iter));
   494			if (!folio) {
   495				ret = -ENOMEM;
   496				goto out;
   497			}
   498	
   499			plen = folio_size(folio);
   500			offset = pos - folio_file_pos(folio);
   501			bytes = min_t(size_t, plen - offset, iov_iter_count(iter));
   502			locked = true;
   503	
   504			if (!folio_test_uptodate(folio)) {
   505				folio_unlock(folio); /* Avoid deadlocking fault-in */
   506				locked = false;
   507			}
   508	
   509			/* Bring in the user page that we will copy from _first_.
   510			 * Otherwise there's a nasty deadlock on copying from the same
   511			 * page as we're writing to, without it being marked
   512			 * up-to-date.
   513			 *
   514			 * Not only is this an optimisation, but it is also required to
   515			 * check that the address is actually valid, when atomic
   516			 * usercopies are used, below.
   517			 */
   518			if (unlikely(fault_in_iov_iter_readable(iter, bytes))) {
   519				ret = -EFAULT;
   520				goto error_folio;
   521			}
   522	
   523			if (fatal_signal_pending(current)) {
   524				ret = -EINTR;
   525				goto error_folio;
   526			}
   527	
   528			if (!locked) {
   529				ret = folio_lock_killable(folio);
   530				if (ret < 0)
   531					goto error_folio;
   532			}
   533	
   534	redo_prefetch:
   535			/* See if we need to prefetch the area we're going to modify.
   536			 * We need to do this before we get a lock on the folio in case
   537			 * there's more than one writer competing for the same cache
   538			 * block.
   539			 */
   540			nupt = netfs_handle_nonuptodate_folio(ctx, file, folio,
   541							      offset, bytes, always_fill);
   542			_debug("nupt %u", nupt);
   543			switch (nupt) {
   544			case NETFS_JUST_PREFETCH:
   545				ret = netfs_prefetch_for_write(file, folio, bytes);
   546				if (ret < 0) {
   547					_debug("prefetch = %zd", ret);
   548					goto error_folio;
   549				}
   550				nupt = NETFS_FOLIO_IS_UPTODATE;
   551				fallthrough;
   552			case NETFS_FOLIO_IS_UPTODATE:
   553				break;
   554			case NETFS_MODIFY_AND_CLEAR:
   555				zero_user_segment(&folio->page, 0, offset);
   556				break;
   557			case NETFS_WHOLE_FOLIO_MODIFY:
   558				break;
   559			}
   560	
   561			/* Preallocate the space we need in the dirty region list. */
   562			ret = mas_expected_entries(&mas, 1);
   563			if (ret < 0)
   564				goto error_folio;
   565	
   566			if (!spare_region) {
   567				spare_region = netfs_alloc_dirty_region();
   568				if (IS_ERR(spare_region)) {
   569					ret = PTR_ERR(spare_region);
   570					spare_region = NULL;
   571					goto error_folio;
   572				}
   573			}
   574	
   575			if (mapping_writably_mapped(folio_file_mapping(folio)))
   576				flush_dcache_folio(folio);
   577			copied = copy_folio_from_iter_atomic(folio, offset, bytes, iter);
   578			flush_dcache_folio(folio);
   579	
   580			/*  Deal with a (partially) failed copy */
   581			if (!folio_test_uptodate(folio)) {
   582				if (copied == 0) {
   583					ret = -EFAULT;
   584					goto error_folio;
   585				}
   586				if (copied < bytes) {
   587					iov_iter_revert(iter, copied);
   588					always_fill = true;
   589					goto redo_prefetch;
   590				}
   591				switch (nupt) {
   592				case NETFS_JUST_PREFETCH:
   593				case NETFS_FOLIO_IS_UPTODATE:
   594					/* We have the folio locked, so it really ought
   595					 * to be uptodate.
   596					 */
   597					WARN(true, "Locked folio %lx became non-uptodate\n",
   598					     folio_index(folio));
   599					ret = -EIO;
   600					goto error_folio;
   601				case NETFS_MODIFY_AND_CLEAR:
   602					zero_user_segment(&folio->page, offset + copied, plen);
   603					fallthrough;
   604				case NETFS_WHOLE_FOLIO_MODIFY:
   605					folio_mark_uptodate(folio);
   606					break;
   607				}
   608			}
   609	
   610			/* Update the inode size if we moved the EOF marker */
   611			pos += copied;
   612			i_size = i_size_read(inode);
   613			if (pos > i_size) {
   614				if (ctx->ops->update_i_size) {
   615					ctx->ops->update_i_size(inode, pos);
   616				} else {
   617					i_size_write(inode, pos);
 > 618					fscache_update_cookie(ctx->cache, NULL, &pos);
   619				}
   620			}
   621	
   622			netfs_commit_folio(ctx, file, &spare_region, &mas,
   623					   folio, offset, copied);
   624	
   625			folio_mark_dirty(folio);
   626			folio_unlock(folio);
   627			folio_put(folio);
   628			folio = NULL;
   629	
   630			cond_resched();
   631	
   632			written += copied;
   633	
   634			balance_dirty_pages_ratelimited(file->f_mapping);
   635		} while (iov_iter_count(iter));
   636	
   637	out:
   638		if (likely(written)) {
   639			netfs_commit_region(ctx, &mas, iocb->ki_pos, written);
   640	
   641			iocb->ki_pos += written;
   642	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
