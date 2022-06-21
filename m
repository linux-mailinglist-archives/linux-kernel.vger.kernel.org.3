Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12673553EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354842AbiFUWrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiFUWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:47:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98DA31DD7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655851639; x=1687387639;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7q0Ihm9VaccpU9vcxY+QR/y7r1q9Y11CDQYFArZ/uqI=;
  b=Han6Fn8TunUzjYs4RNdLdmyUGqPBL3zpSpGpeanAvdVgYHAobkmYd6Wl
   bAVptQJKM44q3aw6iwKrpnRbhnOBOBHNsiRApPVMP3wD5NrWRmTg3tNkk
   dPx4MpJ65au2aRE3HWBCe6x0yoXmbNpMMSUMtumTzg6Jgu+siXgzFAUca
   pVoxqFf7dcgf4QMA+RGvDAL29VhIrLSVbyWkSphIkpaDI4vAAGM4sdGwX
   B2RtTt8pA8YWACCF3eG1c+lGpDOqMPwt4/Cr/dsvEY9KFGxqL1JwmUW1V
   HnYPJ4eiUc9xeuCZjoMc4HM+Ppzm5nG9G3cfDVd1rrhHHfcy4EkJVk8G8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="341941281"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="341941281"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="690170687"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2022 15:47:17 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3meS-0000Vx-UB;
        Tue, 21 Jun 2022 22:47:16 +0000
Date:   Wed, 22 Jun 2022 06:47:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <quic_kvalo@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [kvalo-ath:ath12k-bringup 48/53]
 drivers/net/wireless/ath/ath12k/dbring.c:271:7: warning: variable 'ring' is
 used uninitialized whenever switch case is taken
Message-ID: <202206220630.i3KlrkEC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath12k-bringup
head:   cc108fac9c287f5624daedca923743587adcafd1
commit: 070381028567d9b8e0d82e6f244909e51902bc49 [48/53] ath12k: remove spectral support
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220622/202206220630.i3KlrkEC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=070381028567d9b8e0d82e6f244909e51902bc49
        git remote add kvalo-ath https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
        git fetch --no-tags kvalo-ath ath12k-bringup
        git checkout 070381028567d9b8e0d82e6f244909e51902bc49
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/wireless/ath/ath12k/ drivers/pci/endpoint/functions/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath12k/dbring.c:271:7: warning: variable 'ring' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case WMI_DIRECT_BUF_SPECTRAL:
                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/dbring.c:280:7: note: uninitialized use occurs here
           if (!ring) {
                ^~~~
   drivers/net/wireless/ath/ath12k/dbring.c:232:28: note: initialize the variable 'ring' to silence this warning
           struct ath12k_dbring *ring;
                                     ^
                                      = NULL
   1 warning generated.


vim +/ring +271 drivers/net/wireless/ath/ath12k/dbring.c

f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  228  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  229  int ath12k_dbring_buffer_release_event(struct ath12k_base *ab,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  230  				       struct ath12k_dbring_buf_release_event *ev)
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  231  {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  232  	struct ath12k_dbring *ring;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  233  	struct hal_srng *srng;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  234  	struct ath12k *ar;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  235  	struct ath12k_dbring_element *buff;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  236  	struct ath12k_dbring_data handler_data;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  237  	struct ath12k_buffer_addr desc;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  238  	u8 *vaddr_unalign;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  239  	u32 num_entry, num_buff_reaped;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  240  	u8 pdev_idx, rbm;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  241  	u32 cookie;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  242  	int buf_id;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  243  	int size;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  244  	dma_addr_t paddr;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  245  	int ret = 0;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  246  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  247  	pdev_idx = ev->fixed.pdev_id;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  248  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  249  	if (pdev_idx >= ab->num_radios) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  250  		ath12k_warn(ab, "Invalid pdev id %d\n", pdev_idx);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  251  		return -EINVAL;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  252  	}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  253  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  254  	if (ev->fixed.num_buf_release_entry !=
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  255  	    ev->fixed.num_meta_data_entry) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  256  		ath12k_warn(ab, "Buffer entry %d mismatch meta entry %d\n",
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  257  			    ev->fixed.num_buf_release_entry,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  258  			    ev->fixed.num_meta_data_entry);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  259  		return -EINVAL;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  260  	}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  261  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  262  	ar = ab->pdevs[pdev_idx].ar;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  263  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  264  	rcu_read_lock();
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  265  	if (!rcu_dereference(ab->pdevs_active[pdev_idx])) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  266  		ret = -EINVAL;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  267  		goto rcu_unlock;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  268  	}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  269  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  270  	switch (ev->fixed.module_id) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01 @271  	case WMI_DIRECT_BUF_SPECTRAL:
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  272  		break;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  273  	default:
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  274  		ring = NULL;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  275  		ath12k_warn(ab, "Recv dma buffer release ev on unsupp module %d\n",
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  276  			    ev->fixed.module_id);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  277  		break;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  278  	}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  279  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  280  	if (!ring) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  281  		ret = -EINVAL;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  282  		goto rcu_unlock;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  283  	}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  284  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  285  	srng = &ab->hal.srng_list[ring->refill_srng.ring_id];
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  286  	num_entry = ev->fixed.num_buf_release_entry;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  287  	size = sizeof(*buff) + ring->buf_sz + ring->buf_align - 1;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  288  	num_buff_reaped = 0;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  289  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  290  	spin_lock_bh(&srng->lock);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  291  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  292  	while (num_buff_reaped < num_entry) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  293  		desc.info0 = ev->buf_entry[num_buff_reaped].paddr_lo;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  294  		desc.info1 = ev->buf_entry[num_buff_reaped].paddr_hi;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  295  		handler_data.meta = ev->meta_data[num_buff_reaped];
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  296  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  297  		num_buff_reaped++;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  298  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  299  		ath12k_hal_rx_buf_addr_info_get(&desc, &paddr, &cookie, &rbm);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  300  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  301  		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID, cookie);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  302  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  303  		spin_lock_bh(&ring->idr_lock);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  304  		buff = idr_find(&ring->bufs_idr, buf_id);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  305  		if (!buff) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  306  			spin_unlock_bh(&ring->idr_lock);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  307  			continue;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  308  		}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  309  		idr_remove(&ring->bufs_idr, buf_id);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  310  		spin_unlock_bh(&ring->idr_lock);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  311  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  312  		dma_unmap_single(ab->dev, buff->paddr, ring->buf_sz,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  313  				 DMA_FROM_DEVICE);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  314  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  315  		if (ring->handler) {
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  316  			vaddr_unalign = buff->payload;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  317  			handler_data.data = PTR_ALIGN(vaddr_unalign,
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  318  						      ring->buf_align);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  319  			handler_data.data_sz = ring->buf_sz;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  320  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  321  			ring->handler(ar, &handler_data);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  322  		}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  323  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  324  		memset(buff, 0, size);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  325  		ath12k_dbring_bufs_replenish(ar, ring, buff, GFP_ATOMIC);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  326  	}
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  327  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  328  	spin_unlock_bh(&srng->lock);
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  329  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  330  rcu_unlock:
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  331  	rcu_read_unlock();
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  332  
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  333  	return ret;
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  334  }
f40abb4788a2a3 Vasanthakumar Thiagarajan 2022-02-01  335  

:::::: The code at line 271 was first introduced by commit
:::::: f40abb4788a2a3868606a29d99583421e0874350 ath12k: New driver for Qualcomm 11be hw family

:::::: TO: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
:::::: CC: Kalle Valo <quic_kvalo@quicinc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
