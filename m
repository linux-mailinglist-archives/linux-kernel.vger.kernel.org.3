Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB2D5136F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbiD1OhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346564AbiD1Og7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:36:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C8B646C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651156425; x=1682692425;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P7R3NniOUVQ571w6+hROLmu3RMmQFSvj5HRSEytbIvI=;
  b=Vb0vfedW2WpSesfbzbTVnYiacFZp17J/ThNERALEECbvHm/dJqhrYt+t
   Vx7I5waUZV6hCC2vlwgqurAOwCOyZl3Ha/N1U2QCsW4jgopmh9DUQgxjo
   QPHno60VjD78Jp1oN2oPgaHtFAuoGhfWVep6N4PpCOisuntkK9efybCeX
   ERJ+FFdAFGWNTeGW+BaQIAFvcG2sjo4yPqBGs9qBshmk40sqcdgWo3jJG
   Nqzj6C1MIBh9ZqgGySlO/76myp+iZ5ESSfZ0Y75JpAX7N8bAqhjYQYlfo
   12JVzgX2e+6udu8CZK74kV1kSiJe8V8WUYrlgjMJJR0Rm5uyG6x1SEoBL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266121038"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="266121038"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 07:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="565624406"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2022 07:33:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk5DB-0005Rk-85;
        Thu, 28 Apr 2022 14:33:41 +0000
Date:   Thu, 28 Apr 2022 22:32:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 25/45]
 ld.lld: error: undefined symbol: fscache_begin_cache_operation
Message-ID: <202204282239.2Pg6F5y5-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   a20ca5707a9b524115f5ded439fed1f8e552dd6b
commit: 506cacdcdfd787336db327e5f38d5a378d5998fd [25/45] fscache: Add a function to begin an cache op from a netfslib request
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220428/202204282239.2Pg6F5y5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/506cacdcdfd787336db327e5f38d5a378d5998fd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout 506cacdcdfd787336db327e5f38d5a378d5998fd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: fscache_begin_cache_operation
   >>> referenced by file.c
   >>>               afs/file.o:(afs_req_ops) in archive fs/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
