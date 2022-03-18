Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B94DDED1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiCRQ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbiCRQ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:26:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA516D8F5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647620687; x=1679156687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J2PaVNqYk6qB9qXc+nf6FtAkdfzo+V17yRfAfJeQSr8=;
  b=g0jFmt5himdVNFhK8UHyWvpnkB3tZpYwAW38RprLMzPy5h594QC22Yh9
   HR6l5VflZXKD27r2/CTIQZonEx+KN51j5qdLppdJ+xQ3Gdr47jHSLw+Jz
   X+zW6HAMkCcRrZzTx20SvTxBenLStR3Wx2IzRc3YFdTckEaoNYTqVFQGN
   ES7mc+MPc5NxYBjdie0i+QdYVii5AP/hGN0/roES603iwRwmd2/6b9mW9
   uzwJt3m0aLdi1+4uRUVcTWxvrrE8BZvcHTdugXhSQ1EKqIRf9AegmPJLG
   uS3z1+kW/38Qfk86aHv3bzjGLTo1p16jR6XjgeDS49G2eP2hQTvOLg2j5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="320377419"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="320377419"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 09:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="647527621"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2022 09:24:44 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVFPA-000Ez1-51; Fri, 18 Mar 2022 16:24:44 +0000
Date:   Sat, 19 Mar 2022 00:24:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: via-pmu-event.c:undefined reference to `input_event'
Message-ID: <202203190015.8LPNVVK5-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   551acdc3c3d2b6bc97f11e31dcf960bc36343bfc
commit: ebd722275f9cfc6752e29d2412fa3816ca05764b macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
date:   3 years, 8 months ago
config: m68k-randconfig-r021-20220317 (https://download.01.org/0day-ci/archive/20220319/202203190015.8LPNVVK5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebd722275f9cfc6752e29d2412fa3816ca05764b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ebd722275f9cfc6752e29d2412fa3816ca05764b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `via_pmu_event':
>> via-pmu-event.c:(.text+0x32): undefined reference to `input_event'
>> m68k-linux-ld: via-pmu-event.c:(.text+0x54): undefined reference to `input_event'
   m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `via_pmu_event_init':
>> via-pmu-event.c:(.init.text+0xe): undefined reference to `input_allocate_device'
>> m68k-linux-ld: via-pmu-event.c:(.init.text+0x56): undefined reference to `input_register_device'
>> m68k-linux-ld: via-pmu-event.c:(.init.text+0x68): undefined reference to `input_free_device'
   m68k-linux-ld: net/batman-adv/sysfs.o: in function `batadv_store_bool_attr':
   sysfs.c:(.text+0x36e): undefined reference to `strcmp'
   m68k-linux-ld: sysfs.c:(.text+0x3aa): undefined reference to `strcmp'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
