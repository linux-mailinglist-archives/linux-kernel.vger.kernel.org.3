Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE30506415
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiDSF7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiDSF7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:59:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120D2C12A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650347789; x=1681883789;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NQZ1ELKIhHGJPtksKnoCuYLI6cyUCLOezuWDOAdka/M=;
  b=iTw6fnQr99xOz5vBKlZ2P480JSLdm7A2yJVwb0lRhCEunPX3FPBPyMHX
   lDJFfVOmOXYFq3GlmWyav5FPTB3nSI2B0qm6/AfLkkOysC7QeKu6x39ex
   4WJpg8kkVZD9YDy5+7fNRPglZWNVWaBF59wPKrz49r/2ZVh+qx5HX3GB4
   DiatYUvAwX7nb8VzqYf1bo964N8Ig+xAtbdFaoL1cOlA5dqmG5KtC1Qyu
   8i/5dsFQBoX8BjZgKrWXTgH8cIYODaxpwGJhGVWiDbxMFSXeAGegxWo9V
   wnsXEFZByUPX7tDsEVQZDpoI2P9I9ud/BGMpBla/Dbg0IxL6AmNITvNRW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326583573"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="326583573"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="702068894"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2022 22:56:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nggqh-0005P8-IT;
        Tue, 19 Apr 2022 05:56:27 +0000
Date:   Tue, 19 Apr 2022 13:56:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1496/2356]
 drivers/crypto/ccp/ccp-dmaengine.c:650:17: error: implicit declaration of
 function 'list_del_rcu'; did you mean 'llist_del_all'?
Message-ID: <202204191349.4UyNaAJQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 87052c4c3bbc437e628c8d687fd5133d135333d0 [1496/2356] headers/deps: fs: Optimize <linux/fs.h> header dependencies
config: x86_64-randconfig-a003-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191349.4UyNaAJQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=87052c4c3bbc437e628c8d687fd5133d135333d0
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 87052c4c3bbc437e628c8d687fd5133d135333d0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/crypto/ccp/ccp-dmaengine.c: In function 'ccp_dma_release':
>> drivers/crypto/ccp/ccp-dmaengine.c:650:17: error: implicit declaration of function 'list_del_rcu'; did you mean 'llist_del_all'? [-Werror=implicit-function-declaration]
     650 |                 list_del_rcu(&dma_chan->device_node);
         |                 ^~~~~~~~~~~~
         |                 llist_del_all
   cc1: some warnings being treated as errors


vim +650 drivers/crypto/ccp/ccp-dmaengine.c

58ea8abf490415 Gary R Hook  2016-04-18  639  
54cce8ecb9254f Dāvis Mosāns 2022-02-28  640  static void ccp_dma_release(struct ccp_device *ccp)
54cce8ecb9254f Dāvis Mosāns 2022-02-28  641  {
54cce8ecb9254f Dāvis Mosāns 2022-02-28  642  	struct ccp_dma_chan *chan;
54cce8ecb9254f Dāvis Mosāns 2022-02-28  643  	struct dma_chan *dma_chan;
54cce8ecb9254f Dāvis Mosāns 2022-02-28  644  	unsigned int i;
54cce8ecb9254f Dāvis Mosāns 2022-02-28  645  
54cce8ecb9254f Dāvis Mosāns 2022-02-28  646  	for (i = 0; i < ccp->cmd_q_count; i++) {
54cce8ecb9254f Dāvis Mosāns 2022-02-28  647  		chan = ccp->ccp_dma_chan + i;
54cce8ecb9254f Dāvis Mosāns 2022-02-28  648  		dma_chan = &chan->dma_chan;
54cce8ecb9254f Dāvis Mosāns 2022-02-28  649  		tasklet_kill(&chan->cleanup_tasklet);
54cce8ecb9254f Dāvis Mosāns 2022-02-28 @650  		list_del_rcu(&dma_chan->device_node);
54cce8ecb9254f Dāvis Mosāns 2022-02-28  651  	}
54cce8ecb9254f Dāvis Mosāns 2022-02-28  652  }
54cce8ecb9254f Dāvis Mosāns 2022-02-28  653  

:::::: The code at line 650 was first introduced by commit
:::::: 54cce8ecb9254f971b40a72911c6da403720a2d2 crypto: ccp - ccp_dmaengine_unregister release dma channels

:::::: TO: Dāvis Mosāns <davispuh@gmail.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
