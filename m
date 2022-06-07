Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ADD53F6E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbiFGHKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbiFGHJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:09:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5758813C6;
        Tue,  7 Jun 2022 00:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654585790; x=1686121790;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b7w0Jo4X5Q0tbJ+Lb1gNZkkGF0RFAjloOAMdaSUTUHM=;
  b=aKVsvKxQhE3yKVlXRWjUoihs2OB74OR01RPGt5hXLb2dhEGkq/IehFff
   4ezjB8ds9G+/8KU9lL75emBVPY9wiWjfaFLmPNO+aCbP0GRq/YuwlL4Ti
   AfkGDenUke08OspHDgfB9pyyMj27VHPS9PL5yaNaWYKuvUtnFhW1qmvqQ
   8Js/snQZQ8tPrHBlxCAFUEnxqjivm1oRrkS/DZzyW1NPJvXQOuIIry3bM
   VtaJbWMv2Vdl8ngpBMhL2K9IDsRvaS2QdaI7/a7BN/U4kemS66VpBfTO1
   /huZtwlKtdR151hBuU2ENEuG8OBblV+vGCz5zkr9R5u7MUeFaMIDD0i5s
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="340335748"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="340335748"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="579488785"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2022 00:09:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyTLV-000DSR-GA;
        Tue, 07 Jun 2022 07:09:45 +0000
Date:   Tue, 7 Jun 2022 15:09:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 728/1207] fs/xfs/xfs_file.c:1266:31: sparse:
 sparse: incorrect type in return expression (different base types)
Message-ID: <202206071511.FI7WLdZo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   73d0e32571a0786151eb72634f1a4c5891166176
commit: d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c [728/1207] xfs: support CoW in fsdax mode
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220607/202206071511.FI7WLdZo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
        git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
        git fetch --no-tags linux-next master
        git checkout d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/xfs/xfs_file.c:1266:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted vm_fault_t @@
   fs/xfs/xfs_file.c:1266:31: sparse:     expected int
   fs/xfs/xfs_file.c:1266:31: sparse:     got restricted vm_fault_t
>> fs/xfs/xfs_file.c:1260:1: sparse: sparse: symbol 'xfs_dax_fault' was not declared. Should it be static?
>> fs/xfs/xfs_file.c:1314:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] ret @@     got int @@
   fs/xfs/xfs_file.c:1314:21: sparse:     expected restricted vm_fault_t [usertype] ret
   fs/xfs/xfs_file.c:1314:21: sparse:     got int

Please review and possibly fold the followup patch.

vim +1266 fs/xfs/xfs_file.c

  1257	
  1258	#ifdef CONFIG_FS_DAX
  1259	int
> 1260	xfs_dax_fault(
  1261		struct vm_fault		*vmf,
  1262		enum page_entry_size	pe_size,
  1263		bool			write_fault,
  1264		pfn_t			*pfn)
  1265	{
> 1266		return dax_iomap_fault(vmf, pe_size, pfn, NULL,
  1267				(write_fault && !vmf->cow_page) ?
  1268					&xfs_dax_write_iomap_ops :
  1269					&xfs_read_iomap_ops);
  1270	}
  1271	#else
  1272	int
  1273	xfs_dax_fault(
  1274		struct vm_fault		*vmf,
  1275		enum page_entry_size	pe_size,
  1276		bool			write_fault,
  1277		pfn_t			*pfn)
  1278	{
  1279		return 0;
  1280	}
  1281	#endif
  1282	
  1283	/*
  1284	 * Locking for serialisation of IO during page faults. This results in a lock
  1285	 * ordering of:
  1286	 *
  1287	 * mmap_lock (MM)
  1288	 *   sb_start_pagefault(vfs, freeze)
  1289	 *     invalidate_lock (vfs/XFS_MMAPLOCK - truncate serialisation)
  1290	 *       page_lock (MM)
  1291	 *         i_lock (XFS - extent map serialisation)
  1292	 */
  1293	static vm_fault_t
  1294	__xfs_filemap_fault(
  1295		struct vm_fault		*vmf,
  1296		enum page_entry_size	pe_size,
  1297		bool			write_fault)
  1298	{
  1299		struct inode		*inode = file_inode(vmf->vma->vm_file);
  1300		struct xfs_inode	*ip = XFS_I(inode);
  1301		vm_fault_t		ret;
  1302	
  1303		trace_xfs_filemap_fault(ip, pe_size, write_fault);
  1304	
  1305		if (write_fault) {
  1306			sb_start_pagefault(inode->i_sb);
  1307			file_update_time(vmf->vma->vm_file);
  1308		}
  1309	
  1310		if (IS_DAX(inode)) {
  1311			pfn_t pfn;
  1312	
  1313			xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> 1314			ret = xfs_dax_fault(vmf, pe_size, write_fault, &pfn);
  1315			if (ret & VM_FAULT_NEEDDSYNC)
  1316				ret = dax_finish_sync_fault(vmf, pe_size, pfn);
  1317			xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
  1318		} else {
  1319			if (write_fault) {
  1320				xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
  1321				ret = iomap_page_mkwrite(vmf,
  1322						&xfs_buffered_write_iomap_ops);
  1323				xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
  1324			} else {
  1325				ret = filemap_fault(vmf);
  1326			}
  1327		}
  1328	
  1329		if (write_fault)
  1330			sb_end_pagefault(inode->i_sb);
  1331		return ret;
  1332	}
  1333	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
