Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8AB5AA0D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiIAUVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiIAUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:20:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199635A899
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662063658; x=1693599658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eqgR6mBDJvknmAziS504tuv7HvznGcW0L/v53TAjfQo=;
  b=O/tNry8VhzJ0PNA7ks8Wg2Td+LBN9EdD7H+6/zese8cvgPZ1lDuNKAxp
   9c/1re4FW/t6ZULlk4GZVHbVkQKaM0802pFWbCYlYYwsakIxzMRPh+IKo
   FZNB0+0zV7wbA+EGvNIf6dS5jKGJOSIVLaOMh+OrGt+z4qze/HhdITGmM
   THGOYy/0elsQX4fSne6oNfa10I/yew4QGyaGkwfynXIaWqzCsETG/jr/1
   25t1LTdsr7AaJ79NgiDRzrSw0blXzGWCTKskMOkgrve4nBse1opJONS18
   GOJPIHfBTfhyhINqOa4WF5ZtALPm1NM+zWDWDDdTO9h9h5gJg6mu48odq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="357536890"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="357536890"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="563607469"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2022 13:20:54 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTqgI-0000jr-0l;
        Thu, 01 Sep 2022 20:20:54 +0000
Date:   Fri, 2 Sep 2022 04:20:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:pr/49 2/11] drivers/iommu/io-pgtable-dart.c:176:24:
 sparse: sparse: Using plain integer as NULL pointer
Message-ID: <202209020428.kbFTcWgT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux pr/49
head:   db5fe20b7f88a8443b0a3dd88bcfb35f1639624f
commit: d37982729eab5e80525ade0e5859409c284a8283 [2/11] iommu/io-pgtable: Move Apple DART support to its own file
config: alpha-randconfig-s042-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020428.kbFTcWgT-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/d37982729eab5e80525ade0e5859409c284a8283
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/49
        git checkout d37982729eab5e80525ade0e5859409c284a8283
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/io-pgtable-dart.c:176:24: sparse: sparse: Using plain integer as NULL pointer

vim +176 drivers/iommu/io-pgtable-dart.c

   161	
   162	static  dart_iopte *dart_get_l2(struct dart_io_pgtable *data, unsigned long iova)
   163	{
   164		dart_iopte pte, *ptep;
   165		int tbl = dart_get_table(data, iova);
   166	
   167		ptep = data->pgd[tbl];
   168		if (!ptep)
   169			return NULL;
   170	
   171		ptep += dart_get_l1_index(data, iova);
   172		pte = READ_ONCE(*ptep);
   173	
   174		/* Valid entry? */
   175		if (!pte)
 > 176			return 0;
   177	
   178		/* Deref to get level 2 table */
   179		return iopte_deref(pte, data);
   180	}
   181	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
