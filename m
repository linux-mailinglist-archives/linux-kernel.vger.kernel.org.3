Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F91D4B7CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245629AbiBPBsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:48:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbiBPBsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:48:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E652B276
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644976100; x=1676512100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a+U9kYjINT0TVggGNSEIkCtrmskZlm2d6lqeF9SOxwU=;
  b=HOk89bKKuACybiwxJZnORbLmSkdugWLAeUozA2GSWqKwbDwULdMgAhbI
   AYdK3KhBuVyPV5ylfxQI07OOLd5tnWw6pqY8CkHgRq7B23CH57RawWfrR
   XSm3X4q/BpoOcHaG+DHfZ5QtzFzGoHSeoktjgpdU0I+K8ok312efQ0TLa
   yYlbRRjbt8+Z1w+abt+xun6zxKKs54/SltzfA8rMesaqLMwbpOUHjMpZh
   +J6+TQGoH3QThkbRueXbJxSqAS+ICccK57Qib/aUY8/ZckFyCRXjADpWU
   LDAb3wQmbTxn77wyd1z2J26hbf1WOn/oCIZ2Mdd7VrcAeGhhg7vtCC6gP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250238362"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250238362"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 17:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="704068458"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2022 17:48:18 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK9QY-000AGU-4I; Wed, 16 Feb 2022 01:48:18 +0000
Date:   Wed, 16 Feb 2022 09:47:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 36/43]
 fs/netfs/crypto.c:76:10: warning: comparison of distinct pointer types
 ('typeof (len) *' (aka 'unsigned int *') and 'typeof (((1UL) << (12)) -
 offset) *' (aka 'unsigned long *'))
Message-ID: <202202160929.hhL3XUja-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   d40df0841e9f8de3713a19dd3f0ba283c860cb93
commit: dcba644aa7bbb5bfb44d4a5c3abd187c51544bcd [36/43] netfs: Perform content encryption
config: riscv-randconfig-r033-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160929.hhL3XUja-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/dcba644aa7bbb5bfb44d4a5c3abd187c51544bcd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout dcba644aa7bbb5bfb44d4a5c3abd187c51544bcd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/crypto.c:76:10: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'unsigned int *') and 'typeof (((1UL) << (12)) - offset) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                           seg = min(len, PAGE_SIZE - offset);
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   1 warning generated.


vim +76 fs/netfs/crypto.c

    45	
    46	/*
    47	 * Populate a scatterlist from folios in an xarray.
    48	 */
    49	static int netfs_xarray_to_sglist(struct xarray *xa, loff_t pos, size_t len,
    50					  struct scatterlist *sg, unsigned int n_sg)
    51	{
    52		struct scatterlist *p = sg;
    53		struct folio *folio = NULL;
    54		size_t seg, offset, skip = 0;
    55		loff_t start = pos;
    56		pgoff_t index = start >> PAGE_SHIFT;
    57		int j;
    58	
    59		XA_STATE(xas, xa, index);
    60	
    61		sg_init_table(sg, n_sg);
    62	
    63		rcu_read_lock();
    64	
    65		xas_for_each(&xas, folio, ULONG_MAX) {
    66			if (xas_retry(&xas, folio))
    67				continue;
    68			if (WARN_ON(xa_is_value(folio)) || WARN_ON(folio_test_hugetlb(folio)))
    69				break;
    70			for (j = (folio_index(folio) < index) ? index - folio_index(folio) : 0;
    71			     j < folio_nr_pages(folio); j++
    72			     ) {
    73				struct page *subpage = folio_file_page(folio, j);
    74	
    75				offset = (pos + skip) & ~PAGE_MASK;
  > 76				seg = min(len, PAGE_SIZE - offset);
    77	
    78				sg_set_page(p++, subpage, seg, offset);
    79	
    80				len -= seg;
    81				skip += seg;
    82				if (len == 0)
    83					break;
    84			}
    85			if (len == 0)
    86				break;
    87		}
    88	
    89		rcu_read_unlock();
    90		if (len > 0) {
    91			kdebug("*** Insufficient source (%zx)", len);
    92			//WARN_ON(len > 0);
    93			return -EIO;
    94		}
    95	
    96		sg_mark_end(p - 1);
    97		return p - sg;
    98	}
    99	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
