Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8F4819D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 06:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhL3Fcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 00:32:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:55886 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhL3Fck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 00:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640842360; x=1672378360;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OkS5YZfhWa6pM5BROioFOgX0PCQrS5atewPEsrj/oH4=;
  b=KLiX0i04Sor5AgcZ004/lV/ul+pKlZbKlDKXGaEDY8IQD5FLx1g+GLsj
   drXhL+vK1edZ6qH+RI/bgyZcghVLuEhFemzyNiJvyg8P+VTfhD5a83Jd0
   j83nRw6WR7ykozTHJkPzXyu0cEgfPOv4djNgP1autAoZOwwqmrh68cVCZ
   +jt7z2NcQh85RS9a9+sp//Z5kGGYdaBx8TAK0fsV4Gunttil33O534VW9
   3HQHAObCxGaKEkvmm8vQHa4wbnIlkuScBDdT5g35eAwFQnp6s6QRdKjKo
   XAgDym6zVSo+AoYiDv3gzRoN8RfSY++EWxo0SLXxo8SHZqHS4u2vMIq4V
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="222291938"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="222291938"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 21:32:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="470551302"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 21:32:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2o3K-0009nS-0j; Thu, 30 Dec 2021 05:32:38 +0000
Date:   Thu, 30 Dec 2021 13:32:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 4/33] fs/erofs/data.c:291:46: error: too few
 arguments to function call, expected 3, have 2
Message-ID: <202112301319.grQYJV0u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/goldwynr/linux iomap
head:   30c74a8c201365178cae26d0d7aefa120c3245ab
commit: 0a74a7494220c731edd0f327149f56a4da3419c4 [4/33] iomap: Introduce iomap_readpage_ops
config: mips-randconfig-r022-20211230 (https://download.01.org/0day-ci/archive/20211230/202112301319.grQYJV0u-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/goldwynr/linux/commit/0a74a7494220c731edd0f327149f56a4da3419c4
        git remote add goldwynr https://github.com/goldwynr/linux
        git fetch --no-tags goldwynr iomap
        git checkout 0a74a7494220c731edd0f327149f56a4da3419c4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/erofs/data.c:291:46: error: too few arguments to function call, expected 3, have 2
           return iomap_readpage(page, &erofs_iomap_ops);
                  ~~~~~~~~~~~~~~                       ^
   include/linux/iomap.h:235:5: note: 'iomap_readpage' declared here
   int iomap_readpage(struct page *page, const struct iomap_ops *ops,
       ^
   fs/erofs/data.c:296:46: error: too few arguments to function call, expected 3, have 2
           return iomap_readahead(rac, &erofs_iomap_ops);
                  ~~~~~~~~~~~~~~~                      ^
   include/linux/iomap.h:237:6: note: 'iomap_readahead' declared here
   void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
        ^
   2 errors generated.


vim +291 fs/erofs/data.c

eadcd6b5a1eb398 Gao Xiang 2021-08-13  284  
771c994ea51f572 Gao Xiang 2021-08-05  285  /*
771c994ea51f572 Gao Xiang 2021-08-05  286   * since we dont have write or truncate flows, so no inode
771c994ea51f572 Gao Xiang 2021-08-05  287   * locking needs to be held at the moment.
771c994ea51f572 Gao Xiang 2021-08-05  288   */
771c994ea51f572 Gao Xiang 2021-08-05  289  static int erofs_readpage(struct file *file, struct page *page)
771c994ea51f572 Gao Xiang 2021-08-05  290  {
771c994ea51f572 Gao Xiang 2021-08-05 @291  	return iomap_readpage(page, &erofs_iomap_ops);
771c994ea51f572 Gao Xiang 2021-08-05  292  }
771c994ea51f572 Gao Xiang 2021-08-05  293  

:::::: The code at line 291 was first introduced by commit
:::::: 771c994ea51f572539ca3961c6a7706862b147e2 erofs: convert all uncompressed cases to iomap

:::::: TO: Gao Xiang <hsiangkao@linux.alibaba.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
