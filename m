Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6274B4C2CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiBXNSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiBXNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:18:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B87615B983
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645708704; x=1677244704;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zv67j+TmKKjI2jzyZM1X97XAucCPekNl0nV1HBLv1Q4=;
  b=NPYlaQX4QHsUB4KC2FWgKn4W6F6Ju8khw4Xm8y9azA5vZ4r4SSlZSYOu
   7DHoJ8s2HQpZhnRx/lR87P5GVhamaMLsWXyAaXlDwFLfmltHiDxq0ij79
   CgCtn9l/ujytQQaoQ9Ff951BSvjUX8kwFku73pGrysL1lPwAXkQIF3urD
   pO3NqNnTcpQnkYlBc7nNxhTUoBI2u0TofJco++kHNx+yK+2Wc1cE/ZLHa
   xNk1Y/WeFyDwbvoVEgOiZ0U41mMZqbd/oPDfHuetlH/+NHl48ACN4Dubw
   90vU5S7b8t8uy0mb5rMflS1utqlhiPtkhfnSiasR4iganUWl3t9JiVGoi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251965047"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251965047"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 05:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="707451260"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2022 05:18:23 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNE0k-00037s-C4; Thu, 24 Feb 2022 13:18:22 +0000
Date:   Thu, 24 Feb 2022 21:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/parisc/kernel/toc.c:15:1: sparse: sparse: symbol
 '__pcpu_scope_toc_stack' was not declared. Should it be static?
Message-ID: <202202242157.Tl7rtYcV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23d04328444a8fa0ca060c5e532220dac8e8bc26
commit: d6ab9fc74513ae6501afcdae2547334a03b9a5c9 parisc: Enable TOC (transfer of contents) feature unconditionally
date:   6 weeks ago
config: parisc-randconfig-s032-20220224 (https://download.01.org/0day-ci/archive/20220224/202202242157.Tl7rtYcV-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6ab9fc74513ae6501afcdae2547334a03b9a5c9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d6ab9fc74513ae6501afcdae2547334a03b9a5c9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash arch/parisc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/parisc/kernel/toc.c:15:1: sparse: sparse: symbol '__pcpu_scope_toc_stack' was not declared. Should it be static?

vim +/__pcpu_scope_toc_stack +15 arch/parisc/kernel/toc.c

    14	
  > 15	static unsigned int __aligned(16) toc_lock = 1;
    16	DEFINE_PER_CPU_PAGE_ALIGNED(char [16384], toc_stack) __visible;
    17	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
