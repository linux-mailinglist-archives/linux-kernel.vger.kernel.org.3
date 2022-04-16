Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2283B5032F3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiDPCEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiDPCEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:04:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35704198EF8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 18:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650074067; x=1681610067;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=T8H5Ltb5e8iIyPXsYRF99kIlGxOR0jkXZT+KohzbSc8=;
  b=VsTdNscWUjQ0y0Xj3mIowK+cLbstgr3YD4CgipUOHVMq/VSYeGlJ/LZV
   zE8wgiuS1KShqKy4u2eS/BBSDwrPbmJJCqR3GXlISkMnF5C/maIvCYdO4
   +dm9DTa3Y+P3tkXtBA7v6BSI9jhlfOSuNc9bVUwA5etxpzQb93NcMJP/A
   WoU8+Kd/LkA6J8/yXb97Xv4DT1ClfFik9itr8V6guLWIpqQ4EKNxjlkwX
   EfbJ4j0dE0cC9GUjq8SckLacPnxj+G2qrjpDD8+6JvNhdrKLevJl2xGTc
   ZfaW3MgFVegAK2QIwrrGvyw7TgbomzCPRHIzSeoOTswBHeQyPIQPdZk/l
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263009923"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="263009923"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 17:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701229812"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2022 17:46:41 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfWaG-0002az-O9;
        Sat, 16 Apr 2022 00:46:40 +0000
Date:   Sat, 16 Apr 2022 08:45:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [ammarfaizi2-block:bpf/bpf-next/master 9/17]
 drivers/net/ethernet/intel/i40e/i40e_xsk.c:192:3: error: fallthrough
 annotation does not directly precede switch label
Message-ID: <202204160853.tLrEcpJe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block bpf/bpf-next/master
head:   0fb53aabc5fcdf848ec7adc777baff25a1c6c335
commit: b8aef650e54982728660919a0cf9cdacb079ef86 [9/17] i40e, xsk: Terminate Rx side of NAPI when XSK Rx queue gets full
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220416/202204160853.tLrEcpJe-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8e43cbab33765c476337571e5ed11b005199dd0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b8aef650e54982728660919a0cf9cdacb079ef86
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bpf/bpf-next/master
        git checkout b8aef650e54982728660919a0cf9cdacb079ef86
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:192:3: error: fallthrough annotation does not directly precede switch label
                   fallthrough; /* handle aborts by dropping packet */
                   ^
   include/linux/compiler_attributes.h:222:41: note: expanded from macro 'fallthrough'
   # define fallthrough                    __attribute__((__fallthrough__))
                                           ^
   1 error generated.


vim +192 drivers/net/ethernet/intel/i40e/i40e_xsk.c

0a714186d3c0f7c Björn Töpel        2018-08-28  141  
0a714186d3c0f7c Björn Töpel        2018-08-28  142  /**
0a714186d3c0f7c Björn Töpel        2018-08-28  143   * i40e_run_xdp_zc - Executes an XDP program on an xdp_buff
0a714186d3c0f7c Björn Töpel        2018-08-28  144   * @rx_ring: Rx ring
0a714186d3c0f7c Björn Töpel        2018-08-28  145   * @xdp: xdp_buff used as input to the XDP program
0a714186d3c0f7c Björn Töpel        2018-08-28  146   *
0a714186d3c0f7c Björn Töpel        2018-08-28  147   * Returns any of I40E_XDP_{PASS, CONSUMED, TX, REDIR}
0a714186d3c0f7c Björn Töpel        2018-08-28  148   **/
0a714186d3c0f7c Björn Töpel        2018-08-28  149  static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
0a714186d3c0f7c Björn Töpel        2018-08-28  150  {
0a714186d3c0f7c Björn Töpel        2018-08-28  151  	int err, result = I40E_XDP_PASS;
0a714186d3c0f7c Björn Töpel        2018-08-28  152  	struct i40e_ring *xdp_ring;
0a714186d3c0f7c Björn Töpel        2018-08-28  153  	struct bpf_prog *xdp_prog;
0a714186d3c0f7c Björn Töpel        2018-08-28  154  	u32 act;
0a714186d3c0f7c Björn Töpel        2018-08-28  155  
0a714186d3c0f7c Björn Töpel        2018-08-28  156  	/* NB! xdp_prog will always be !NULL, due to the fact that
0a714186d3c0f7c Björn Töpel        2018-08-28  157  	 * this path is enabled by setting an XDP program.
0a714186d3c0f7c Björn Töpel        2018-08-28  158  	 */
0a714186d3c0f7c Björn Töpel        2018-08-28  159  	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
0a714186d3c0f7c Björn Töpel        2018-08-28  160  	act = bpf_prog_run_xdp(xdp_prog, xdp);
2f86c806a8a89f3 Kevin Laatz        2019-08-27  161  
346497c78d15cdd Magnus Karlsson    2020-12-02  162  	if (likely(act == XDP_REDIRECT)) {
346497c78d15cdd Magnus Karlsson    2020-12-02  163  		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
b8aef650e549827 Maciej Fijalkowski 2022-04-13  164  		if (!err)
f6c10b48f8c8da4 Magnus Karlsson    2021-05-10  165  			return I40E_XDP_REDIR;
b8aef650e549827 Maciej Fijalkowski 2022-04-13  166  		if (xsk_uses_need_wakeup(rx_ring->xsk_pool) && err == -ENOBUFS)
b8aef650e549827 Maciej Fijalkowski 2022-04-13  167  			result = I40E_XDP_EXIT;
b8aef650e549827 Maciej Fijalkowski 2022-04-13  168  		else
b8aef650e549827 Maciej Fijalkowski 2022-04-13  169  			result = I40E_XDP_CONSUMED;
b8aef650e549827 Maciej Fijalkowski 2022-04-13  170  		goto out_failure;
346497c78d15cdd Magnus Karlsson    2020-12-02  171  	}
346497c78d15cdd Magnus Karlsson    2020-12-02  172  
0a714186d3c0f7c Björn Töpel        2018-08-28  173  	switch (act) {
0a714186d3c0f7c Björn Töpel        2018-08-28  174  	case XDP_PASS:
0a714186d3c0f7c Björn Töpel        2018-08-28  175  		break;
0a714186d3c0f7c Björn Töpel        2018-08-28  176  	case XDP_TX:
0a714186d3c0f7c Björn Töpel        2018-08-28  177  		xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
0a714186d3c0f7c Björn Töpel        2018-08-28  178  		result = i40e_xmit_xdp_tx_ring(xdp, xdp_ring);
f6c10b48f8c8da4 Magnus Karlsson    2021-05-10  179  		if (result == I40E_XDP_CONSUMED)
f6c10b48f8c8da4 Magnus Karlsson    2021-05-10  180  			goto out_failure;
0a714186d3c0f7c Björn Töpel        2018-08-28  181  		break;
b8aef650e549827 Maciej Fijalkowski 2022-04-13  182  	case XDP_DROP:
b8aef650e549827 Maciej Fijalkowski 2022-04-13  183  		result = I40E_XDP_CONSUMED;
b8aef650e549827 Maciej Fijalkowski 2022-04-13  184  		break;
0a714186d3c0f7c Björn Töpel        2018-08-28  185  	default:
c8064e5b4adac5e Paolo Abeni        2021-11-30  186  		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
5463fce643e8d04 Jeff Kirsher       2020-06-03  187  		fallthrough;
0a714186d3c0f7c Björn Töpel        2018-08-28  188  	case XDP_ABORTED:
b8aef650e549827 Maciej Fijalkowski 2022-04-13  189  		result = I40E_XDP_CONSUMED;
f6c10b48f8c8da4 Magnus Karlsson    2021-05-10  190  out_failure:
0a714186d3c0f7c Björn Töpel        2018-08-28  191  		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
5463fce643e8d04 Jeff Kirsher       2020-06-03 @192  		fallthrough; /* handle aborts by dropping packet */
0a714186d3c0f7c Björn Töpel        2018-08-28  193  	}
0a714186d3c0f7c Björn Töpel        2018-08-28  194  	return result;
0a714186d3c0f7c Björn Töpel        2018-08-28  195  }
0a714186d3c0f7c Björn Töpel        2018-08-28  196  

:::::: The code at line 192 was first introduced by commit
:::::: 5463fce643e8d041f54378b28b35940fd5e5a5a4 ethernet/intel: Convert fallthrough code comments

:::::: TO: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
:::::: CC: Tony Nguyen <anthony.l.nguyen@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
