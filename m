Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA50535349
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348549AbiEZSVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348370AbiEZSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:21:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0564E3A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653589266; x=1685125266;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8NqVggT4gUzHrI0Lkp1miHSQ0Wr06BT1kkAR0n4u4o0=;
  b=P/ZCAe8NmS+Jrv4sbZaaj+E+c/nmPBx4YmQ6x3yWFo923IS6IW+Y5PYf
   dPr662nGdXRYmEoT22h8TL9tR2vmhu0mItRY+EbZW7L12bVRWhdu563lP
   B10lvIdtYuoFsS+HW+t376bkWoUCVSJ0ju9OUQIhs90YPjHBI2VYCvCO+
   6tZ8XPZsLFsxOnO/ZYeN9/PNWkxneMmF0vbg357XEAHdkeDsCnMV8eJgu
   PjxuOXlAPLo+bZ/Z8qO0E2+0kcw2W0LND6s/koLiTSbqcg/IL6oT8Ddxg
   RYTvjMe0qeKE5gHGOfAebRt7wvrY/gZDSTLDrVfA6QHeTROu5hMUDgXoB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="337288556"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="337288556"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 11:21:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="574016253"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 May 2022 11:21:03 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuI6Y-000462-9P;
        Thu, 26 May 2022 18:21:02 +0000
Date:   Fri, 27 May 2022 02:20:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-for-sfrench 5/9]
 fs/cifs/file.c:2735:36: error: no member named 'max_frmr_depth' in 'struct
 smbd_connection'
Message-ID: <202205270254.xD5T2pAa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-for-sfrench
head:   ba04fd019482403a282ad499323f5cdd1ee5216a
commit: b4eb9ac0feb7aff675a958612c9d2b2052f53690 [5/9] cifs: Change the I/O paths to use an iterator rather than a page list
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220527/202205270254.xD5T2pAa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6f4644d194da594562027a5d458d9fb7a20ebc39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b4eb9ac0feb7aff675a958612c9d2b2052f53690
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-for-sfrench
        git checkout b4eb9ac0feb7aff675a958612c9d2b2052f53690
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/cifs/file.c:2735:36: error: no member named 'max_frmr_depth' in 'struct smbd_connection'
                                   max_pages = server->smbd_conn->max_frmr_depth;
                                               ~~~~~~~~~~~~~~~~~  ^
   1 error generated.


vim +2735 fs/cifs/file.c

  2662	
  2663	/*
  2664	 * Write back the locked page and any subsequent non-locked dirty pages.
  2665	 */
  2666	static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
  2667							 struct writeback_control *wbc,
  2668							 struct folio *folio,
  2669							 loff_t start, loff_t end)
  2670	{
  2671		struct inode *inode = mapping->host;
  2672		struct TCP_Server_Info *server;
  2673		struct cifs_writedata *wdata;
  2674		struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
  2675		struct cifs_credits credits_on_stack;
  2676		struct cifs_credits *credits = &credits_on_stack;
  2677		struct cifsFileInfo *cfile = NULL;
  2678		unsigned int xid, wsize, len;
  2679		loff_t i_size = i_size_read(inode);
  2680		size_t max_len;
  2681		long count = wbc->nr_to_write;
  2682		int rc;
  2683	
  2684		/* The folio should be locked, dirty and not undergoing writeback. */
  2685		if (folio_start_writeback(folio))
  2686			WARN_ON(1);
  2687	
  2688		count -= folio_nr_pages(folio);
  2689		len = folio_size(folio);
  2690	
  2691		xid = get_xid();
  2692		server = cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
  2693	
  2694		rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY, &cfile);
  2695		if (rc) {
  2696			cifs_dbg(VFS, "No writable handle in writepages rc=%d\n", rc);
  2697			goto err_xid;
  2698		}
  2699	
  2700		rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->wsize,
  2701						   &wsize, credits);
  2702		if (rc != 0)
  2703			goto err_close;
  2704	
  2705		wdata = cifs_writedata_alloc(cifs_writev_complete);
  2706		if (!wdata) {
  2707			rc = -ENOMEM;
  2708			goto err_uncredit;
  2709		}
  2710	
  2711		wdata->sync_mode = wbc->sync_mode;
  2712		wdata->offset = folio_pos(folio);
  2713		wdata->pid = cfile->pid;
  2714		wdata->credits = credits_on_stack;
  2715		wdata->cfile = cfile;
  2716		wdata->server = server;
  2717		cfile = NULL;
  2718	
  2719		/* Find all consecutive lockable dirty pages, stopping when we find a
  2720		 * page that is not immediately lockable, is not dirty or is missing,
  2721		 * or we reach the end of the range.
  2722		 */
  2723		if (start < i_size) {
  2724			/* Trim the write to the EOF; the extra data is ignored.  Also
  2725			 * put an upper limit on the size of a single storedata op.
  2726			 */
  2727			max_len = wsize;
  2728			max_len = min_t(unsigned long long, max_len, end - start + 1);
  2729			max_len = min_t(unsigned long long, max_len, i_size - start);
  2730	
  2731			if (len < max_len) {
  2732				int max_pages = INT_MAX;
  2733	
  2734				if (server->smbd_conn)
> 2735					max_pages = server->smbd_conn->max_frmr_depth;
  2736				max_pages -= folio_nr_pages(folio);
  2737	
  2738				if (max_pages > 0)
  2739					cifs_extend_writeback(mapping, &count, start,
  2740							      max_pages, max_len, &len);
  2741			}
  2742			len = min_t(loff_t, len, max_len);
  2743		}
  2744	
  2745		wdata->bytes = len;
  2746	
  2747		/* We now have a contiguous set of dirty pages, each with writeback
  2748		 * set; the first page is still locked at this point, but all the rest
  2749		 * have been unlocked.
  2750		 */
  2751		folio_unlock(folio);
  2752	
  2753		if (start < i_size) {
  2754			iov_iter_xarray(&wdata->iter, WRITE, &mapping->i_pages, start, len);
  2755	
  2756			rc = adjust_credits(wdata->server, &wdata->credits, wdata->bytes);
  2757			if (rc)
  2758				goto err_wdata;
  2759	
  2760			if (wdata->cfile->invalidHandle)
  2761				rc = -EAGAIN;
  2762			else
  2763				rc = wdata->server->ops->async_writev(wdata,
  2764								      cifs_writedata_release);
  2765			if (rc >= 0) {
  2766				kref_put(&wdata->refcount, cifs_writedata_release);
  2767				goto err_close;
  2768			}
  2769		} else {
  2770			/* The dirty region was entirely beyond the EOF. */
  2771			cifs_pages_written_back(inode, start, len);
  2772			rc = 0;
  2773		}
  2774	
  2775	err_wdata:
  2776		kref_put(&wdata->refcount, cifs_writedata_release);
  2777	err_uncredit:
  2778		add_credits_and_wake_if(server, credits, 0);
  2779	err_close:
  2780		if (cfile)
  2781			cifsFileInfo_put(cfile);
  2782	err_xid:
  2783		free_xid(xid);
  2784		if (rc == 0) {
  2785			wbc->nr_to_write = count;
  2786		} else if (is_retryable_error(rc)) {
  2787			cifs_pages_write_redirty(inode, start, len);
  2788		} else {
  2789			cifs_pages_write_failed(inode, start, len);
  2790			mapping_set_error(mapping, rc);
  2791		}
  2792		/* Indication to update ctime and mtime as close is deferred */
  2793		set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
  2794		return rc;
  2795	}
  2796	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
