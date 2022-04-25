Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559E750E55B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbiDYQRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiDYQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:17:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC4311D237
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650903262; x=1682439262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WBn5aaEUhHvrn0ap/cb1ti0T5AJm6Qpd5cGnOkTMLus=;
  b=Wq7LSPMmD8q+8CbjJvxb/+oOkmicsT6TR9amE0w9eTr5aygHfc49wjcG
   mvA8wM0evllfk+JS6Cha97DKwK0LDfxkcK5HrD6gNum7CFYqMNsWmbf/w
   99eMGZ7xC6OvXZOYo3dURGk2Cb0y6fwPcxeqn8UBQs3ZTN8j7WVmEwsX9
   nNBF8bSKlezaL0oHGXBH0NaFMrR8QeTrDQ7PLLOZOhgP2UhydrjMLaQDf
   gp66kqk8KG0QYE4tyWPy+nM2oymC5C86X6Swqj54eE+UWEqCgjS/zGXnM
   woWW1h7L4CSFxzosDFU/f9fUhU6RIg8OsKUA9ZJwWpRJzl659lVrkzwqG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252661756"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="252661756"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="649766444"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2022 09:14:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj1Lw-0002g6-Je;
        Mon, 25 Apr 2022 16:14:20 +0000
Date:   Tue, 26 Apr 2022 00:13:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 26/44]
 output.c:undefined reference to `__fscache_begin_write_operation'
Message-ID: <202204260017.dkV0wVa6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 1cdfbd29bdd34acf57d11846369b44dbab7b4d3a [26/44] netfs: Dispatch write requests to process a writeback slice
config: csky-randconfig-r011-20220425 (https://download.01.org/0day-ci/archive/20220426/202204260017.dkV0wVa6-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/1cdfbd29bdd34acf57d11846369b44dbab7b4d3a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 1cdfbd29bdd34acf57d11846369b44dbab7b4d3a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: fs/netfs/output.o: in function `netfs_set_up_write_to_cache':
>> output.c:(.text+0x932): undefined reference to `__fscache_begin_write_operation'
>> csky-linux-ld: output.c:(.text+0x96c): undefined reference to `__fscache_begin_write_operation'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
