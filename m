Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA956D455
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 07:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGKFfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 01:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKFfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 01:35:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96D11808
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657517718; x=1689053718;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=R1N2LYQ3qh5Dq/vXVLASWRAWmxcB+ZLyY5e7k5Tm7To=;
  b=j7QTHPtrlliRTRH3EG4amTDZ/5S2ZokJr5pZDdaZVEz4gz5clxA6ppOH
   duMlH37E5mQnCxqQIOcJ+t/Iz+P31C5AUQIZeqIVEiahaRsgrC5pK9d1o
   2FK95mJbmqZ71XTFWtWAtf7eqZS3SG+pAlwQMN+/KSy3Aq79/F3LCRVMm
   QYAxu6DhAoFfovmY009u9jYPLW9r1GxuW4eicNV3Ps0ZCWzOi5KsPjPIL
   YWnZuVwC58Ezf85QHsWSuA8CFphNQxZaejfwhNHQSKfL+TDMFHflSWxfL
   Jk4/etc/liej9a0XfXEiAltWGaODMz3XPBAfYwVXPJSfbJfI8aU1VlJo6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="285707477"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="285707477"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 22:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="662421271"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2022 22:35:16 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAm4i-0000TM-0x;
        Mon, 11 Jul 2022 05:35:16 +0000
Date:   Mon, 11 Jul 2022 13:34:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [alobakin:xdp_hints 20/52]
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2553:3: error: call to
 undeclared function 'xdp_set_data_meta_invalid'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202207111325.Zy0bi2Yw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux xdp_hints
head:   e9f4215398901c2e3f477da53abc668ce7b7e320
commit: 62a8828e246dd5ebf5aa0dc2b4cc68960eb3dea4 [20/52] net, xdp: move XDP metadata helpers into new xdp_meta.h
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220711/202207111325.Zy0bi2Yw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 77a38f6839980bfac61babb40d83772c51427011)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/alobakin/linux/commit/62a8828e246dd5ebf5aa0dc2b4cc68960eb3dea4
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin xdp_hints
        git checkout 62a8828e246dd5ebf5aa0dc2b4cc68960eb3dea4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/ drivers/net/ethernet/freescale/dpaa/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2553:3: error: call to undeclared function 'xdp_set_data_meta_invalid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   xdp_set_data_meta_invalid(&xdp);
                   ^
>> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2567:19: error: call to undeclared function 'xdp_data_meta_unsupported'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   *xdp_meta_len = xdp_data_meta_unsupported(&xdp) ? 0 :
                                   ^
   2 errors generated.


vim +/xdp_set_data_meta_invalid +2553 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c

d57e57d0cd04be Camelia Groza          2020-11-25  2525  
86c0c196cbe48f Camelia Groza          2020-11-25  2526  static u32 dpaa_run_xdp(struct dpaa_priv *priv, struct qm_fd *fd, void *vaddr,
d57e57d0cd04be Camelia Groza          2020-11-25  2527  			struct dpaa_fq *dpaa_fq, unsigned int *xdp_meta_len)
86c0c196cbe48f Camelia Groza          2020-11-25  2528  {
86c0c196cbe48f Camelia Groza          2020-11-25  2529  	ssize_t fd_off = qm_fd_get_offset(fd);
86c0c196cbe48f Camelia Groza          2020-11-25  2530  	struct bpf_prog *xdp_prog;
d57e57d0cd04be Camelia Groza          2020-11-25  2531  	struct xdp_frame *xdpf;
86c0c196cbe48f Camelia Groza          2020-11-25  2532  	struct xdp_buff xdp;
86c0c196cbe48f Camelia Groza          2020-11-25  2533  	u32 xdp_act;
a1e031ffb422bb Camelia Groza          2020-11-25  2534  	int err;
86c0c196cbe48f Camelia Groza          2020-11-25  2535  
86c0c196cbe48f Camelia Groza          2020-11-25  2536  	xdp_prog = READ_ONCE(priv->xdp_prog);
547aabcac3251c Toke Høiland-Jørgensen 2021-06-24  2537  	if (!xdp_prog)
86c0c196cbe48f Camelia Groza          2020-11-25  2538  		return XDP_PASS;
86c0c196cbe48f Camelia Groza          2020-11-25  2539  
43b5169d8355cc Lorenzo Bianconi       2020-12-22  2540  	xdp_init_buff(&xdp, DPAA_BP_RAW_SIZE - DPAA_TX_PRIV_DATA_SIZE,
43b5169d8355cc Lorenzo Bianconi       2020-12-22  2541  		      &dpaa_fq->xdp_rxq);
be9df4aff65f18 Lorenzo Bianconi       2020-12-22  2542  	xdp_prepare_buff(&xdp, vaddr + fd_off - XDP_PACKET_HEADROOM,
be9df4aff65f18 Lorenzo Bianconi       2020-12-22  2543  			 XDP_PACKET_HEADROOM, qm_fd_get_length(fd), true);
86c0c196cbe48f Camelia Groza          2020-11-25  2544  
ae680bcbd06ae9 Camelia Groza          2020-11-25  2545  	/* We reserve a fixed headroom of 256 bytes under the erratum and we
ae680bcbd06ae9 Camelia Groza          2020-11-25  2546  	 * offer it all to XDP programs to use. If no room is left for the
ae680bcbd06ae9 Camelia Groza          2020-11-25  2547  	 * xdpf backpointer on TX, we will need to copy the data.
ae680bcbd06ae9 Camelia Groza          2020-11-25  2548  	 * Disable metadata support since data realignments might be required
ae680bcbd06ae9 Camelia Groza          2020-11-25  2549  	 * and the information can be lost.
ae680bcbd06ae9 Camelia Groza          2020-11-25  2550  	 */
ae680bcbd06ae9 Camelia Groza          2020-11-25  2551  #ifdef CONFIG_DPAA_ERRATUM_A050385
ae680bcbd06ae9 Camelia Groza          2020-11-25  2552  	if (unlikely(fman_has_errata_a050385())) {
ae680bcbd06ae9 Camelia Groza          2020-11-25 @2553  		xdp_set_data_meta_invalid(&xdp);
ae680bcbd06ae9 Camelia Groza          2020-11-25  2554  		xdp.data_hard_start = vaddr;
ae680bcbd06ae9 Camelia Groza          2020-11-25  2555  		xdp.frame_sz = DPAA_BP_RAW_SIZE;
ae680bcbd06ae9 Camelia Groza          2020-11-25  2556  	}
ae680bcbd06ae9 Camelia Groza          2020-11-25  2557  #endif
ae680bcbd06ae9 Camelia Groza          2020-11-25  2558  
86c0c196cbe48f Camelia Groza          2020-11-25  2559  	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
86c0c196cbe48f Camelia Groza          2020-11-25  2560  
86c0c196cbe48f Camelia Groza          2020-11-25  2561  	/* Update the length and the offset of the FD */
86c0c196cbe48f Camelia Groza          2020-11-25  2562  	qm_fd_set_contig(fd, xdp.data - vaddr, xdp.data_end - xdp.data);
86c0c196cbe48f Camelia Groza          2020-11-25  2563  
86c0c196cbe48f Camelia Groza          2020-11-25  2564  	switch (xdp_act) {
86c0c196cbe48f Camelia Groza          2020-11-25  2565  	case XDP_PASS:
ae680bcbd06ae9 Camelia Groza          2020-11-25  2566  #ifdef CONFIG_DPAA_ERRATUM_A050385
ae680bcbd06ae9 Camelia Groza          2020-11-25 @2567  		*xdp_meta_len = xdp_data_meta_unsupported(&xdp) ? 0 :
ae680bcbd06ae9 Camelia Groza          2020-11-25  2568  				xdp.data - xdp.data_meta;
ae680bcbd06ae9 Camelia Groza          2020-11-25  2569  #else
86c0c196cbe48f Camelia Groza          2020-11-25  2570  		*xdp_meta_len = xdp.data - xdp.data_meta;
ae680bcbd06ae9 Camelia Groza          2020-11-25  2571  #endif
d57e57d0cd04be Camelia Groza          2020-11-25  2572  		break;
d57e57d0cd04be Camelia Groza          2020-11-25  2573  	case XDP_TX:
d57e57d0cd04be Camelia Groza          2020-11-25  2574  		/* We can access the full headroom when sending the frame
d57e57d0cd04be Camelia Groza          2020-11-25  2575  		 * back out
d57e57d0cd04be Camelia Groza          2020-11-25  2576  		 */
d57e57d0cd04be Camelia Groza          2020-11-25  2577  		xdp.data_hard_start = vaddr;
d57e57d0cd04be Camelia Groza          2020-11-25  2578  		xdp.frame_sz = DPAA_BP_RAW_SIZE;
d57e57d0cd04be Camelia Groza          2020-11-25  2579  		xdpf = xdp_convert_buff_to_frame(&xdp);
d57e57d0cd04be Camelia Groza          2020-11-25  2580  		if (unlikely(!xdpf)) {
d57e57d0cd04be Camelia Groza          2020-11-25  2581  			free_pages((unsigned long)vaddr, 0);
d57e57d0cd04be Camelia Groza          2020-11-25  2582  			break;
d57e57d0cd04be Camelia Groza          2020-11-25  2583  		}
d57e57d0cd04be Camelia Groza          2020-11-25  2584  
d57e57d0cd04be Camelia Groza          2020-11-25  2585  		if (dpaa_xdp_xmit_frame(priv->net_dev, xdpf))
d57e57d0cd04be Camelia Groza          2020-11-25  2586  			xdp_return_frame_rx_napi(xdpf);
d57e57d0cd04be Camelia Groza          2020-11-25  2587  
a1e031ffb422bb Camelia Groza          2020-11-25  2588  		break;
a1e031ffb422bb Camelia Groza          2020-11-25  2589  	case XDP_REDIRECT:
a1e031ffb422bb Camelia Groza          2020-11-25  2590  		/* Allow redirect to use the full headroom */
a1e031ffb422bb Camelia Groza          2020-11-25  2591  		xdp.data_hard_start = vaddr;
a1e031ffb422bb Camelia Groza          2020-11-25  2592  		xdp.frame_sz = DPAA_BP_RAW_SIZE;
a1e031ffb422bb Camelia Groza          2020-11-25  2593  
a1e031ffb422bb Camelia Groza          2020-11-25  2594  		err = xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
a1e031ffb422bb Camelia Groza          2020-11-25  2595  		if (err) {
a1e031ffb422bb Camelia Groza          2020-11-25  2596  			trace_xdp_exception(priv->net_dev, xdp_prog, xdp_act);
a1e031ffb422bb Camelia Groza          2020-11-25  2597  			free_pages((unsigned long)vaddr, 0);
a1e031ffb422bb Camelia Groza          2020-11-25  2598  		}
86c0c196cbe48f Camelia Groza          2020-11-25  2599  		break;
86c0c196cbe48f Camelia Groza          2020-11-25  2600  	default:
c8064e5b4adac5 Paolo Abeni            2021-11-30  2601  		bpf_warn_invalid_xdp_action(priv->net_dev, xdp_prog, xdp_act);
86c0c196cbe48f Camelia Groza          2020-11-25  2602  		fallthrough;
86c0c196cbe48f Camelia Groza          2020-11-25  2603  	case XDP_ABORTED:
86c0c196cbe48f Camelia Groza          2020-11-25  2604  		trace_xdp_exception(priv->net_dev, xdp_prog, xdp_act);
86c0c196cbe48f Camelia Groza          2020-11-25  2605  		fallthrough;
86c0c196cbe48f Camelia Groza          2020-11-25  2606  	case XDP_DROP:
86c0c196cbe48f Camelia Groza          2020-11-25  2607  		/* Free the buffer */
86c0c196cbe48f Camelia Groza          2020-11-25  2608  		free_pages((unsigned long)vaddr, 0);
86c0c196cbe48f Camelia Groza          2020-11-25  2609  		break;
86c0c196cbe48f Camelia Groza          2020-11-25  2610  	}
86c0c196cbe48f Camelia Groza          2020-11-25  2611  
86c0c196cbe48f Camelia Groza          2020-11-25  2612  	return xdp_act;
86c0c196cbe48f Camelia Groza          2020-11-25  2613  }
86c0c196cbe48f Camelia Groza          2020-11-25  2614  

:::::: The code at line 2553 was first introduced by commit
:::::: ae680bcbd06ae9189e0102f8cdb5fd938b00725f dpaa_eth: implement the A050385 erratum workaround for XDP

:::::: TO: Camelia Groza <camelia.groza@nxp.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
