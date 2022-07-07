Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA745698E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiGGDqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGGDqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:46:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D9F2FFE5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 20:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657165563; x=1688701563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CiaL/0t12M0EyShum44yee40gauuDoNRXzSLUk11JmY=;
  b=btpE1aTBmgDwD1moLynxOsWs31kLviTwtA5yGvTNA+tovBpNN4VGYPvP
   QWhPbr6+ect5KfxUrig06JcOV67DfKepaLyPq6u+SK5fyvLMu2Rz5sBfm
   hXKFgVXUgFwwGCeTTlTI/A/yWJjtEfVxJ9qL9Gnorqhjc7R19YgErlTkj
   PXrn2KEPIWdpyvFk3pNEyMet7ZW/RVy+r/fQ98ftC5uhZ4b95awlu5Sy7
   0+NQe2BiXemYZ7dOeT9/qpXArVByFBGefvmbtr4O6DHfW9E6g21Nysh00
   DJA//fg0rBzdU5d9KvY11PReE/cRiLJpgAVPzv4836uT977AiUxtR7hRP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="370240176"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="370240176"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 20:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="568339854"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 20:46:00 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9ISm-000LOR-9c;
        Thu, 07 Jul 2022 03:46:00 +0000
Date:   Thu, 7 Jul 2022 11:44:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [sbates130272-p2pmem:p2pdma_user_cmb_v8 5/21]
 kernel/dma/direct.c:467:21: error: implicit declaration of function
 'sg_is_dma_bus_address'; did you mean 'sg_dma_address'?
Message-ID: <202207070932.TlwOuRSB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/sbates130272/linux-p2pmem.git p2pdma_user_cmb_v8
head:   a2dd359c3f1baca6c0438adec8900b7fe57f92af
commit: 8d3e7a5dd204152609cd4eee448224f071493784 [5/21] dma-direct: support PCI P2PDMA pages in dma-direct map_sg
config: xtensa-randconfig-r015-20220706 (https://download.01.org/0day-ci/archive/20220707/202207070932.TlwOuRSB-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/sbates130272/linux-p2pmem/commit/8d3e7a5dd204152609cd4eee448224f071493784
        git remote add sbates130272-p2pmem https://github.com/sbates130272/linux-p2pmem.git
        git fetch --no-tags sbates130272-p2pmem p2pdma_user_cmb_v8
        git checkout 8d3e7a5dd204152609cd4eee448224f071493784
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/iommu/ kernel/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/dma/direct.c: In function 'dma_direct_unmap_sg':
>> kernel/dma/direct.c:467:21: error: implicit declaration of function 'sg_is_dma_bus_address'; did you mean 'sg_dma_address'? [-Werror=implicit-function-declaration]
     467 |                 if (sg_is_dma_bus_address(sg))
         |                     ^~~~~~~~~~~~~~~~~~~~~
         |                     sg_dma_address
>> kernel/dma/direct.c:468:25: error: implicit declaration of function 'sg_dma_unmark_bus_address' [-Werror=implicit-function-declaration]
     468 |                         sg_dma_unmark_bus_address(sg);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +467 kernel/dma/direct.c

   455	
   456	/*
   457	 * Unmaps segments, except for ones marked as pci_p2pdma which do not
   458	 * require any further action as they contain a bus address.
   459	 */
   460	void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
   461			int nents, enum dma_data_direction dir, unsigned long attrs)
   462	{
   463		struct scatterlist *sg;
   464		int i;
   465	
   466		for_each_sg(sgl,  sg, nents, i) {
 > 467			if (sg_is_dma_bus_address(sg))
 > 468				sg_dma_unmark_bus_address(sg);
   469			else
   470				dma_direct_unmap_page(dev, sg->dma_address,
   471						      sg_dma_len(sg), dir, attrs);
   472		}
   473	}
   474	#endif
   475	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
