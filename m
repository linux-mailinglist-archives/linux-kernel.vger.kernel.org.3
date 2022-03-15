Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30D64D9BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348586AbiCONPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348532AbiCONPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:15:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C95522ED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647350036; x=1678886036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lXi+TJeciYOlWP98vV7JQtcsMHzxFAaTYXkd3Tpuj74=;
  b=VXtMidie8L3mlUI+6qMVo0eoDu8JWTm07xDxGu5Kul0HmkBhQp6Mm3Cl
   kUn+IepKJz+lYKLHFutFsAjbYE2YN6SzWgRu6xZ3njCjwjAoBQuGFd8Lj
   fH2CE95tN0hmzsVdUmvRjsaK7QQz+QuE06uK3o/p2Sbm79zWgh2n65Blg
   SppHoIz09bdOPG7LFPXw8yUiGHZabrGyENb+Vf4G7l22dO5I/0cgQkMWX
   hpZafFMN3hk5uHBvq4rVc/XXYV7EEICO2uXY789DJ3k1Qkkl4jrhnzhIQ
   BX0E4p+xZUz7I/g4swQS/iP8BObVXhUSoYiABIweWJP7Ahh3/LMginRIC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319514577"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="319514577"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="540428974"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2022 06:13:54 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU6zp-000B0k-JO; Tue, 15 Mar 2022 13:13:53 +0000
Date:   Tue, 15 Mar 2022 21:13:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 164/179] fs/ceph/cache.h:139:34: error:
 too few arguments to function call, expected 2, have 1
Message-ID: <202203152117.IvekpOeL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   af564d7369d44fbbe697a5f631fe3bba5ebecd59
commit: 09f7fc259e5dd9ab97313b62bdfc9b56abf0ef1d [164/179] fscache: Convert fscache_set_page_dirty() to fscache_dirty_folio()
config: riscv-randconfig-r042-20220314 (https://download.01.org/0day-ci/archive/20220315/202203152117.IvekpOeL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 09f7fc259e5dd9ab97313b62bdfc9b56abf0ef1d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ceph/super.c:22:
>> fs/ceph/cache.h:139:34: error: too few arguments to function call, expected 2, have 1
           return filemap_dirty_folio(folio);
                  ~~~~~~~~~~~~~~~~~~~      ^
   include/linux/writeback.h:393:6: note: 'filemap_dirty_folio' declared here
   bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
        ^
   1 error generated.


vim +139 fs/ceph/cache.h

   135	
   136	static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
   137			struct folio *folio)
   138	{
 > 139		return filemap_dirty_folio(folio);
   140	}
   141	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
