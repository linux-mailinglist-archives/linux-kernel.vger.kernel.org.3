Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3B4FC295
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345967AbiDKQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiDKQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:42:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5C2654C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649695202; x=1681231202;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DcvGMYJPGm5dMWY6hpweF46q58A7DJuEoDeBpYdl5y8=;
  b=Ovkx36wJ6wLiD3AmgOu0kgpRcM8Q+1rxFEQOlFQwTnc+cbbus9sahmXl
   YytOT3AsDsIFYt01fWAmf9dp1z2scB8LuyFAuu+cra4Uvsr3+CIvsPErg
   t3a6oQtGFQJ0KFEeQH1zLS4stxo0cgwJ8IrTlzhr0jQbFbIPl7NppCwxC
   WHf1Wh5wypp8kLxKCOgx0E2gKV/17fiL0qeZ0nuZst7UNJnujZiUVTLDs
   1OVDffFEl4H8fwODg/BtKoiGbq/ohQ5HMYcadf04hBfoxerLlQHSiWBF9
   eM9AcIiU0R0ug/N8edXsfg9iMzOh7G5i6vJxqNtULgdAHeFg8nzpCvX0X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261008060"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261008060"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="660115704"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2022 09:40:00 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndx56-0001z5-07;
        Mon, 11 Apr 2022 16:40:00 +0000
Date:   Tue, 12 Apr 2022 00:39:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ohad Sharabi <osharabi@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 33/34]
 drivers/misc/habanalabs/gaudi/gaudi.c:5041:5: warning: no previous prototype
 for 'gaudi_get_dma_desc_list_size'
Message-ID: <202204120049.nXnmmmRn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   e3e6111dba082a2d77e80ae99a2de75adff9b875
commit: 7d3600a8f9ffc668f66678211d41eadb224a4dd8 [33/34] habanalabs: use for_each_sgtable_dma_sg for dma sgt
config: sparc-buildonly-randconfig-r006-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120049.nXnmmmRn-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=7d3600a8f9ffc668f66678211d41eadb224a4dd8
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 7d3600a8f9ffc668f66678211d41eadb224a4dd8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/habanalabs/gaudi/gaudi.c:5041:5: warning: no previous prototype for 'gaudi_get_dma_desc_list_size' [-Wmissing-prototypes]
    5041 | u32 gaudi_get_dma_desc_list_size(struct hl_device *hdev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/gaudi_get_dma_desc_list_size +5041 drivers/misc/habanalabs/gaudi/gaudi.c

  5040	
> 5041	u32 gaudi_get_dma_desc_list_size(struct hl_device *hdev,
  5042						struct sg_table *sgt)
  5043	{
  5044		struct scatterlist *sg, *sg_next_iter;
  5045		u32 count, dma_desc_cnt;
  5046		u64 len, len_next;
  5047		dma_addr_t addr, addr_next;
  5048	
  5049		dma_desc_cnt = 0;
  5050	
  5051		for_each_sgtable_dma_sg(sgt, sg, count) {
  5052			len = sg_dma_len(sg);
  5053			addr = sg_dma_address(sg);
  5054	
  5055			if (len == 0)
  5056				break;
  5057	
  5058			while ((count + 1) < sgt->nents) {
  5059				sg_next_iter = sg_next(sg);
  5060				len_next = sg_dma_len(sg_next_iter);
  5061				addr_next = sg_dma_address(sg_next_iter);
  5062	
  5063				if (len_next == 0)
  5064					break;
  5065	
  5066				if ((addr + len == addr_next) &&
  5067					(len + len_next <= DMA_MAX_TRANSFER_SIZE)) {
  5068					len += len_next;
  5069					count++;
  5070					sg = sg_next_iter;
  5071				} else {
  5072					break;
  5073				}
  5074			}
  5075	
  5076			dma_desc_cnt++;
  5077		}
  5078	
  5079		return dma_desc_cnt * sizeof(struct packet_lin_dma);
  5080	}
  5081	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
