Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56E4F4902
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389366AbiDEV71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457372AbiDEQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D207830B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649173162; x=1680709162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uqbvEjpy37SgrPedx6qx+fegeygTqQ92MlL6Re99mYM=;
  b=g0E5F7UhrFc9R3Vi8Z1q08mGCtaJ8vwlwOHUskIBG/FMHW744Cg4Fsb5
   G6gZuXHMIjhaFsg0cVnlLlYZscT5mYtG0JMeF0wc7QbQgy3zP1lv3g9dS
   zbE6RrQvlqsSQUM6erT/ZMkb5eQs++TT60IsHCBnT+sSydEG33Jrkn8D9
   +xIIkjQAWHCqAEwKZE622a+6t2n+ypyKi72dlwOlCBfQo5PJL52rG+pbH
   II5ybE7C2lkh4Tk4OUsyszG5vPkV+XrlgWtcxIB+pMUP2x/vu67JSfx9w
   qbDSY4ni5r1BE5cwc4DarCQx+kqZyoRnuUtUNs7kR0yjusufUIBeddKDl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="242923051"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="242923051"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="549102787"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2022 08:39:15 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nblH0-0003UB-MM;
        Tue, 05 Apr 2022 15:39:14 +0000
Date:   Tue, 5 Apr 2022 23:38:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 38/40] ERROR:
 modpost: "netfs_page_mkwrite" [fs/afs/kafs.ko] undefined!
Message-ID: <202204052331.l5wJgtp5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: 2726127983997dfb5bb1bc83d69cec5baeea5694 [38/40] afs: Use the netfs write helpers
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220405/202204052331.l5wJgtp5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2726127983997dfb5bb1bc83d69cec5baeea5694
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 2726127983997dfb5bb1bc83d69cec5baeea5694
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "netfs_put_subrequest" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "netfs_page_mkwrite" [fs/afs/kafs.ko] undefined!
ERROR: modpost: "mas_walk" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "mas_destroy" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "mas_expected_entries" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "mas_store" [fs/netfs/netfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
