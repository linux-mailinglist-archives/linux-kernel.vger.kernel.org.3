Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7265472B2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 09:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiFKHqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 03:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFKHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 03:46:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8CBB44
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654933570; x=1686469570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oduHo1RFQ3stMxu/D+kXNU5eamN8lMTooY1qRApiuaY=;
  b=ai/TSra+4HHrDc5Munln0w3/e5GugstT/v8pfwOf60r8xrcHyPcqkIi2
   Ect2rCaSPsTAmukC4o9XnV63y6tg09dR4/LFtg8cIT/yUinV22O0LOl34
   +m9vUXYwJDaIzyA6H3Jkbcn+1JJ73QCEDPYpXIqPdcP8r1ndi53wcQfH4
   dKqQes4XdzoQz2Rqp52emnyWVznQEF0EQZrtMmcNg83boeVL55lpR6VfF
   GNhOGkp0xYVq1TR5sGa/damlrhlr3exiKbB7VlHab6eJTrZ+v6hBXFpSX
   QPACVOIkyfCzBdQUygNJvilImibAPmPBwq2EQPC5SwiMH/VweubfxcjG9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="276626490"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="276626490"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 00:46:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="616816996"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2022 00:46:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzvot-000Iid-I1;
        Sat, 11 Jun 2022 07:46:07 +0000
Date:   Sat, 11 Jun 2022 15:45:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 30/57]
 lib/iov_iter.c:1464:9: warning: comparison of distinct pointer types
 ('typeof (nr * ((1UL) << 12) - offset) *' (aka 'unsigned long *') and
 'typeof (maxsize) *' (aka 'unsigned int *'))
Message-ID: <202206111500.VcHCpPMw-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
commit: cce0a847405ef7d076fde956ba5dd1a4d7d901c2 [30/57] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
config: arm-randconfig-r034-20220610 (https://download.01.org/0day-ci/archive/20220611/202206111500.VcHCpPMw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ff4abe755279a3a47cc416ef80dbc900d9a98a19)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/cce0a847405ef7d076fde956ba5dd1a4d7d901c2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout cce0a847405ef7d076fde956ba5dd1a4d7d901c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/iov_iter.c:1464:9: warning: comparison of distinct pointer types ('typeof (nr * ((1UL) << 12) - offset) *' (aka 'unsigned long *') and 'typeof (maxsize) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
           return min(nr * PAGE_SIZE - offset, maxsize);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   lib/iov_iter.c:1628:9: warning: comparison of distinct pointer types ('typeof (nr * ((1UL) << 12) - offset) *' (aka 'unsigned long *') and 'typeof (maxsize) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
           return min(nr * PAGE_SIZE - offset, maxsize);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   2 warnings generated.


vim +1464 lib/iov_iter.c

  1430	
  1431	static ssize_t iter_xarray_get_pages(struct iov_iter *i,
  1432					     struct page **pages, size_t maxsize,
  1433					     unsigned maxpages, size_t *_start_offset)
  1434	{
  1435		unsigned nr, offset;
  1436		pgoff_t index, count;
  1437		size_t size = maxsize;
  1438		loff_t pos;
  1439	
  1440		if (!size || !maxpages)
  1441			return 0;
  1442	
  1443		pos = i->xarray_start + i->iov_offset;
  1444		index = pos >> PAGE_SHIFT;
  1445		offset = pos & ~PAGE_MASK;
  1446		*_start_offset = offset;
  1447	
  1448		count = 1;
  1449		if (size > PAGE_SIZE - offset) {
  1450			size -= PAGE_SIZE - offset;
  1451			count += size >> PAGE_SHIFT;
  1452			size &= ~PAGE_MASK;
  1453			if (size)
  1454				count++;
  1455		}
  1456	
  1457		if (count > maxpages)
  1458			count = maxpages;
  1459	
  1460		nr = iter_xarray_populate_pages(pages, i->xarray, index, count);
  1461		if (nr == 0)
  1462			return 0;
  1463	
> 1464		return min(nr * PAGE_SIZE - offset, maxsize);
  1465	}
  1466	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
