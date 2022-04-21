Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13023509823
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385253AbiDUGrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385151AbiDUGqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:46:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6DE15FE1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523380; x=1682059380;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hP+HJeiujUXVOn/pXwmLSvx5EzeoI053mksxSLnbVSk=;
  b=nguVb86CLKWk8Fkwvtd6cVRTD0NyAl5a7mcztAvTaWijo7zp02YRuguS
   6pk2IdxUFnBbEDIGv6Ysh6bMJfrfc4Ip8I8PHu0cZsYtJOOefPRa/rkMd
   ae023W9ahczqYtkxkCdKBUOya+wGjpleNtdYrfwILelVtJy4Pu7WxYUgK
   7reBmUVM/N8Owrt+aK/qQgVFW65pzaefdoVKBC7wbcI+hqwCt+WlV23Cv
   lzXazahOAnoUK9zVbTMviz0GY3HQh1ke4yRscJ6t3swP9ala3v8A3eXNt
   MJTV0YEPMGBUKSowPTF/lNppky/W0u83yLRBYNwqdPczIUXhoXPkpEVl5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="350704633"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="350704633"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:42:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="532792000"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2022 23:42:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQWg-000805-P6;
        Thu, 21 Apr 2022 06:42:50 +0000
Date:   Thu, 21 Apr 2022 14:42:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Novikov <i.m.novikov@yadro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [vkoul-dmaengine:next 26/38]
 drivers/dma/ptdma/ptdma-dmaengine.c:262:1: warning: no previous prototype
 for 'pt_tx_status'
Message-ID: <202204210451.7D2dVECE-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
head:   643a4a85b0bc7efeb5732fb4563c43c77ba0c6ac
commit: d965068259d13fde49487b45064106d3d0c57a74 [26/38] dmaengine: PTDMA: support polled mode
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220421/202204210451.7D2dVECE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?id=d965068259d13fde49487b45064106d3d0c57a74
        git remote add vkoul-dmaengine https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
        git fetch --no-tags vkoul-dmaengine next
        git checkout d965068259d13fde49487b45064106d3d0c57a74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/dma/ptdma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/ptdma/ptdma-dmaengine.c:262:1: warning: no previous prototype for 'pt_tx_status' [-Wmissing-prototypes]
     262 | pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
         | ^~~~~~~~~~~~


vim +/pt_tx_status +262 drivers/dma/ptdma/ptdma-dmaengine.c

   260	
   261	enum dma_status
 > 262	pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
   263			struct dma_tx_state *txstate)
   264	{
   265		struct pt_device *pt = to_pt_chan(c)->pt;
   266		struct pt_cmd_queue *cmd_q = &pt->cmd_q;
   267	
   268		pt_check_status_trans(pt, cmd_q);
   269		return dma_cookie_status(c, cookie, txstate);
   270	}
   271	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
