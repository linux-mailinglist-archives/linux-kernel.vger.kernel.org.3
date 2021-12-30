Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE1A4818FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 04:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhL3Dkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 22:40:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:11299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhL3Dkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 22:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640835635; x=1672371635;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G9bhw6lK69v9UqzRrTa+rxQYOccgG+9CcWUhlVJGeoo=;
  b=bCH7DM/P7X7uqmRo5q7HI8eVGPqXD21WnIZIe/le5LINPrLQBvctUKXo
   xoIq4FyaI5KtDbSwsBpxMHOcKlj/i6KCX9VcFrwcZaEX0rKat5mlGXNPr
   F9z9RYVL5UbrUpn+UcNqo2+A8PDunXOt/c4cRLEBBV4tdHmveXPtNEEsf
   4ogFWCKkBepSBqYJp1Teu5+uIwj6y0OllOLOziEi4havNgwCjVQWoXKqE
   IJ/qRx8IJwqX2NyoCpvC8XjRQnq+Gp7z8jfRj5rxXoHJM9aIYiE0N5mb0
   68K5r6/PDCQgndS2bB3MASXRrW04jrjDHYZ9hW+kbRN5+CQa9nyUd4/WX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241410922"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="241410922"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 19:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="470528513"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 19:40:33 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2mIr-0009hU-1j; Thu, 30 Dec 2021 03:40:33 +0000
Date:   Thu, 30 Dec 2021 11:40:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 4/33] fs/erofs/data.c:291:16: error: too few
 arguments to function 'iomap_readpage'
Message-ID: <202112301130.El4IhQ3g-lkp@intel.com>
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
config: sparc64-buildonly-randconfig-r002-20211230 (https://download.01.org/0day-ci/archive/20211230/202112301130.El4IhQ3g-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/goldwynr/linux/commit/0a74a7494220c731edd0f327149f56a4da3419c4
        git remote add goldwynr https://github.com/goldwynr/linux
        git fetch --no-tags goldwynr iomap
        git checkout 0a74a7494220c731edd0f327149f56a4da3419c4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/erofs/data.c: In function 'erofs_readpage':
>> fs/erofs/data.c:291:16: error: too few arguments to function 'iomap_readpage'
     291 |         return iomap_readpage(page, &erofs_iomap_ops);
         |                ^~~~~~~~~~~~~~
   In file included from fs/erofs/internal.h:19,
                    from fs/erofs/data.c:7:
   include/linux/iomap.h:235:5: note: declared here
     235 | int iomap_readpage(struct page *page, const struct iomap_ops *ops,
         |     ^~~~~~~~~~~~~~
   fs/erofs/data.c: In function 'erofs_readahead':
>> fs/erofs/data.c:296:16: error: too few arguments to function 'iomap_readahead'
     296 |         return iomap_readahead(rac, &erofs_iomap_ops);
         |                ^~~~~~~~~~~~~~~
   In file included from fs/erofs/internal.h:19,
                    from fs/erofs/data.c:7:
   include/linux/iomap.h:237:6: note: declared here
     237 | void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
         |      ^~~~~~~~~~~~~~~
   fs/erofs/data.c:296:16: error: 'return' with a value, in function returning void [-Werror=return-type]
     296 |         return iomap_readahead(rac, &erofs_iomap_ops);
         |                ^~~~~~~~~~~~~~~
   fs/erofs/data.c:294:13: note: declared here
     294 | static void erofs_readahead(struct readahead_control *rac)
         |             ^~~~~~~~~~~~~~~
   fs/erofs/data.c: In function 'erofs_readpage':
   fs/erofs/data.c:292:1: error: control reaches end of non-void function [-Werror=return-type]
     292 | }
         | ^
   cc1: some warnings being treated as errors


vim +/iomap_readpage +291 fs/erofs/data.c

eadcd6b5a1eb39 Gao Xiang 2021-08-13  284  
771c994ea51f57 Gao Xiang 2021-08-05  285  /*
771c994ea51f57 Gao Xiang 2021-08-05  286   * since we dont have write or truncate flows, so no inode
771c994ea51f57 Gao Xiang 2021-08-05  287   * locking needs to be held at the moment.
771c994ea51f57 Gao Xiang 2021-08-05  288   */
771c994ea51f57 Gao Xiang 2021-08-05  289  static int erofs_readpage(struct file *file, struct page *page)
771c994ea51f57 Gao Xiang 2021-08-05  290  {
771c994ea51f57 Gao Xiang 2021-08-05 @291  	return iomap_readpage(page, &erofs_iomap_ops);
771c994ea51f57 Gao Xiang 2021-08-05  292  }
771c994ea51f57 Gao Xiang 2021-08-05  293  
771c994ea51f57 Gao Xiang 2021-08-05  294  static void erofs_readahead(struct readahead_control *rac)
771c994ea51f57 Gao Xiang 2021-08-05  295  {
771c994ea51f57 Gao Xiang 2021-08-05 @296  	return iomap_readahead(rac, &erofs_iomap_ops);
771c994ea51f57 Gao Xiang 2021-08-05  297  }
771c994ea51f57 Gao Xiang 2021-08-05  298  

:::::: The code at line 291 was first introduced by commit
:::::: 771c994ea51f572539ca3961c6a7706862b147e2 erofs: convert all uncompressed cases to iomap

:::::: TO: Gao Xiang <hsiangkao@linux.alibaba.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
