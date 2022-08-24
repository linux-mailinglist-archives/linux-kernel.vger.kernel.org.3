Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253CF59F01E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiHXAOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 20:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHXAOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:14:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D57CAA8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661300053; x=1692836053;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q5+fJkkrhpEKqDfwbpQXxS4H0y9eE92M/bKUxlyZw9A=;
  b=JaZvuzevIMR2frlx0ybnwtOkmtWIyhFAN4/xhcggrFSjWXuVwx1kjj3T
   NzL1pdXh33gYXzWjQk0wjPL7dV6xhmkXO8Z79HoltYNaFFiWC97tvvbjj
   qqVGDfCAEBoBHNfnmKMQISsKjaaW9WYO6Czi6zC5cJCHIABgZ/mWG9guc
   6+3T18QpnI/6PyXQGqYVM+WsVJMWXsPfWSuW+khS5WgXROUxzV6edOnNI
   ANedEMl+Ukmgmn2kxwbd5TC9w72OF3K4ynuaj2PdD3g0+Hc3VrSzeDeMO
   ek4aIREbM9A3gFB1aan8Slqxdi2SXYRlgU6gHmuL2W1kVSg/JBJGh4PIZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="380117549"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="380117549"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 17:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="735676840"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2022 17:14:11 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQe27-0000kM-0j;
        Wed, 24 Aug 2022 00:14:11 +0000
Date:   Wed, 24 Aug 2022 08:13:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 7/22]
 fs/netfs/misc.c:22:46: warning: format specifies type 'unsigned long' but
 the argument has type 'size_t' (aka 'unsigned int')
Message-ID: <202208240851.chpv1GAP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   14725009c14bfa32267af313901825cea6f069a6
commit: a5251be6cee44d7d393c0784487530e6dae512bb [7/22] netfs: Provide invalidatepage and releasepage calls
config: hexagon-buildonly-randconfig-r004-20220823 (https://download.01.org/0day-ci/archive/20220824/202208240851.chpv1GAP-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project b04d01c009d7f66bcca9138d2ce40999eedf104d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a5251be6cee44d7d393c0784487530e6dae512bb
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout a5251be6cee44d7d393c0784487530e6dae512bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/misc.c:22:46: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
           _enter("{%lx},%lx,%lx", folio_index(folio), offset, length);
                         ~~~                           ^~~~~~
                         %zx
   fs/netfs/internal.h:164:65: note: expanded from macro '_enter'
   #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
                                               ~~~                 ^~~~~~~~~~~
   include/linux/printk.h:131:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   fs/netfs/misc.c:22:54: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
           _enter("{%lx},%lx,%lx", folio_index(folio), offset, length);
                             ~~~                               ^~~~~~
                             %zx
   fs/netfs/internal.h:164:65: note: expanded from macro '_enter'
   #define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
                                               ~~~                 ^~~~~~~~~~~
   include/linux/printk.h:131:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +22 fs/netfs/misc.c

    10	
    11	/**
    12	 * netfs_invalidate_folio - Invalidate or partially invalidate a folio
    13	 * @folio: Folio proposed for release
    14	 * @offset: Offset of the invalidated region
    15	 * @length: Length of the invalidated region
    16	 *
    17	 * Invalidate part or all of a folio for a network filesystem.  The folio will
    18	 * be removed afterwards if the invalidated region covers the entire folio.
    19	 */
    20	void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
    21	{
  > 22		_enter("{%lx},%lx,%lx", folio_index(folio), offset, length);
    23	
    24		folio_wait_fscache(folio);
    25	}
    26	EXPORT_SYMBOL(netfs_invalidate_folio);
    27	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
