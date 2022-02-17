Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149B64B96B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiBQDdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:33:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBQDdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:33:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45B9237D5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645068780; x=1676604780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sHJQU3LZDI8CFLw154dsnIfpTQs01Vlr4mh6G6TUZP4=;
  b=OwKTgsfa0F7jNQNXKhamXDdvrv//14q58KoG//tAd97WjT/Bht8U5ZfD
   14M62d583pwI3+oAEbBkpNyrvNcKpK+nLShoupvbTRTnFcLyu7hhwvFH/
   nimhWyD6nhZt4OqwX7oHdvlJbxU+03qVDJE18qfwjLUZJkxKv6kQTuN9h
   6xqPPGUpy/pdryWqEvE1Obrz9d23bCMwXAJpX5fSa7EVHA/2sZg2/m3Gx
   kiBbT6i+P8D74ZJ7cMwORc8Qo8tGltrXkjIPeNzttS9BpYhxJ4rMsIrto
   e5jBTcYXXGUd3yUcoj59n9NKGn6H9gZj54D5EbFMsw7H7HIP55TD5oqz5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="230742628"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="230742628"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 19:32:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="545324915"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Feb 2022 19:32:58 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKXXN-000BNd-JU; Thu, 17 Feb 2022 03:32:57 +0000
Date:   Thu, 17 Feb 2022 11:32:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 41/42] ERROR:
 modpost: "netfs_page_mkwrite" [fs/afs/kafs.ko] undefined!
Message-ID: <202202171144.nlLFprPL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   5cb7f190822d09757b30cd9539e57eef72552d1f
commit: b1f2f7eee31062dfb5b817b8b98980273c39a6bf [41/42] afs: Use the netfs write helpers
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220217/202202171144.nlLFprPL-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b1f2f7eee31062dfb5b817b8b98980273c39a6bf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout b1f2f7eee31062dfb5b817b8b98980273c39a6bf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "netfs_page_mkwrite" [fs/afs/kafs.ko] undefined!
ERROR: modpost: "mas_walk" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "mas_destroy" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "mas_expected_entries" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "xa_store_range" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "mas_store" [fs/netfs/netfs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
