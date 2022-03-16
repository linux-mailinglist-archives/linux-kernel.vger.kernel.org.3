Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349844DAF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355633AbiCPMQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355646AbiCPMQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:16:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D9165D20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647432921; x=1678968921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c0G4VUYvrTP/R6RlQWk4H8MLQILE6MfiAroMBPqIeA0=;
  b=SqalNWSUmUm9auoPFHdLuelHRxq8HHDdzFgd7yW0HNI+iDMhbeOHTP7p
   WHJ7NIFXo2782jU+Efiv+wimgt0sqYUs14dGnvd9VnkvHCbTiCkaCCf3N
   uZFzW7ByEi1ssEtnHYPkLPYq9jtj1PCVnn295o7i0uIMDH8iD7u2jm4kR
   JgnAl/JjZ97wQKNQCtdpc1jpuW4ug2nt/goHuTGM8KE16w4uytXLIm8eD
   CBFLxadPAPgNJb5jOEPW0OfvvJC7ly6BfR9hfYyX/d+h55lRxm4fw4d2e
   JlK1ZMrPq5tESmZaYp2ncMHR5pkgKPhyUs9xx9lTasiogvTU1zRGs3v1Y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256517104"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256517104"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="498412678"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Mar 2022 05:15:19 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUSYh-000CNt-5C; Wed, 16 Mar 2022 12:15:19 +0000
Date:   Wed, 16 Mar 2022 20:14:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [intel-tdx:guest-upstream 5/32] arch/x86/coco/tdx/tdx.c:29:6:
 warning: no previous prototype for '__tdx_hypercall_failed'
Message-ID: <202203162038.wMUgXWKE-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git guest-upstream
head:   8e1641a390cef993022d8c7fcd7e212e06ba7cd3
commit: 3878b00acc0802659680a4f4ed957d30a364961b [5/32] x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220316/202203162038.wMUgXWKE-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/3878b00acc0802659680a4f4ed957d30a364961b
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout 3878b00acc0802659680a4f4ed957d30a364961b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdx.c:29:6: warning: no previous prototype for '__tdx_hypercall_failed' [-Wmissing-prototypes]
      29 | void __tdx_hypercall_failed(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~


vim +/__tdx_hypercall_failed +29 arch/x86/coco/tdx/tdx.c

    27	
    28	/* Called from __tdx_hypercall() for unrecoverable failure */
  > 29	void __tdx_hypercall_failed(void)

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
