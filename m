Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB84960B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350820AbiAUO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:27:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:46623 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381038AbiAUO0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642775211; x=1674311211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uT0gNVIEza70ATD5U6xLjkp/fDqKnZkhSLcmfuYoAj8=;
  b=H/3p/nKwKZ9qdxIPsuJFhfwF3hIPffvwOTSofaHCD1g9ATn4my5rZ0vv
   /G8tVIKthGZL51s9tHvZW6gspME5uSc+osNUUDsxY5FAbbOZDOcg0t0qm
   m++uWau+gijK8AdjZ1RbibW2MQFwss/VQ3wRCmJK4w1oK5+KLPjC2FRNO
   HbkPgoLrl8+EofH3lD89dfvujOJz7rhvKdHSEV3+jHJTuhKZqv9F1yTYT
   EjPpzqDBVGgKid2Ao5VlLnhpbu6Dusiq1lSA+MOClPi3xOoic1lwexnkQ
   jbcp+iyki8UIrEwZZgSDHKEDKrE0r+nqfPFVQgpGmgbOvyDK75CimZItN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="270082335"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="270082335"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 06:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="626747895"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2022 06:26:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAusK-000FNI-Ej; Fri, 21 Jan 2022 14:26:48 +0000
Date:   Fri, 21 Jan 2022 22:26:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 20/30]
 fs/netfs/read_helper.c:1256:7: error: implicit declaration of function
 'netfs_is_cache_enabled'
Message-ID: <202201212250.cPTkICQp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   41c3c11032cdbee08d6be046b0caa2776b4fd437
commit: 5dcff5ed720e69e0ffec5ade8d8a0df96d0b0369 [20/30] netfs: Add a netfs inode context
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220121/202201212250.cPTkICQp-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/5dcff5ed720e69e0ffec5ade8d8a0df96d0b0369
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout 5dcff5ed720e69e0ffec5ade8d8a0df96d0b0369
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/netfs/read_helper.c:979:14: warning: variable 'folio' is uninitialized when used here [-Wuninitialized]
                           folio_put(folio);
                                     ^~~~~
   fs/netfs/read_helper.c:928:21: note: initialize the variable 'folio' to silence this warning
           struct folio *folio;
                              ^
                               = NULL
>> fs/netfs/read_helper.c:1256:7: error: implicit declaration of function 'netfs_is_cache_enabled' [-Werror,-Wimplicit-function-declaration]
           if (!netfs_is_cache_enabled(ctx) &&
                ^
   1 warning and 1 error generated.


vim +/netfs_is_cache_enabled +1256 fs/netfs/read_helper.c

  1183	
  1184	/**
  1185	 * netfs_write_begin - Helper to prepare for writing
  1186	 * @file: The file to read from
  1187	 * @mapping: The mapping to read from
  1188	 * @pos: File position at which the write will begin
  1189	 * @len: The length of the write (may extend beyond the end of the folio chosen)
  1190	 * @aop_flags: AOP_* flags
  1191	 * @_folio: Where to put the resultant folio
  1192	 * @_fsdata: Place for the netfs to store a cookie
  1193	 *
  1194	 * Pre-read data for a write-begin request by drawing data from the cache if
  1195	 * possible, or the netfs if not.  Space beyond the EOF is zero-filled.
  1196	 * Multiple I/O requests from different sources will get munged together.  If
  1197	 * necessary, the readahead window can be expanded in either direction to a
  1198	 * more convenient alighment for RPC efficiency or to make storage in the cache
  1199	 * feasible.
  1200	 *
  1201	 * The calling netfs must provide a table of operations, only one of which,
  1202	 * issue_op, is mandatory.
  1203	 *
  1204	 * The check_write_begin() operation can be provided to check for and flush
  1205	 * conflicting writes once the folio is grabbed and locked.  It is passed a
  1206	 * pointer to the fsdata cookie that gets returned to the VM to be passed to
  1207	 * write_end.  It is permitted to sleep.  It should return 0 if the request
  1208	 * should go ahead; unlock the folio and return -EAGAIN to cause the folio to
  1209	 * be regot; or return an error.
  1210	 *
  1211	 * The calling netfs must initialise a netfs context contiguous to the vfs
  1212	 * inode before calling this.
  1213	 *
  1214	 * This is usable whether or not caching is enabled.
  1215	 */
  1216	int netfs_write_begin(struct file *file, struct address_space *mapping,
  1217			      loff_t pos, unsigned int len, unsigned int aop_flags,
  1218			      struct folio **_folio, void **_fsdata)
  1219	{
  1220		struct netfs_read_request *rreq;
  1221		struct netfs_i_context *ctx = netfs_i_context(file_inode(file ));
  1222		struct folio *folio;
  1223		unsigned int debug_index = 0, fgp_flags;
  1224		pgoff_t index = pos >> PAGE_SHIFT;
  1225		int ret;
  1226	
  1227		DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
  1228	
  1229	retry:
  1230		fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
  1231		if (aop_flags & AOP_FLAG_NOFS)
  1232			fgp_flags |= FGP_NOFS;
  1233		folio = __filemap_get_folio(mapping, index, fgp_flags,
  1234					    mapping_gfp_mask(mapping));
  1235		if (!folio)
  1236			return -ENOMEM;
  1237	
  1238		if (ctx->ops->check_write_begin) {
  1239			/* Allow the netfs (eg. ceph) to flush conflicts. */
  1240			ret = ctx->ops->check_write_begin(file, pos, len, folio, _fsdata);
  1241			if (ret < 0) {
  1242				trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
  1243				if (ret == -EAGAIN)
  1244					goto retry;
  1245				goto error;
  1246			}
  1247		}
  1248	
  1249		if (folio_test_uptodate(folio))
  1250			goto have_folio;
  1251	
  1252		/* If the folio is beyond the EOF, we want to clear it - unless it's
  1253		 * within the cache granule containing the EOF, in which case we need
  1254		 * to preload the granule.
  1255		 */
> 1256		if (!netfs_is_cache_enabled(ctx) &&

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
