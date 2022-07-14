Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DDA5752AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbiGNQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiGNQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:22:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261CC62496
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657815749; x=1689351749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H7HDPGwlOFF7Yq4G5L3GwQFJTE8YQ724tcND/EmRbRo=;
  b=cqHgphymBtrLZLARnMvJdxF1sZBso/hrbA4qe7GN6eUmqb9JXAOy8eRQ
   1Qi9gq/IgzPcJ0nP/xlcZhEBSkUUVtVK+XzYYCHkLoz583HGwCLGMigW4
   fpKGEKS3wGggekPwpr9KN9//z5bm5pd+Tra5/ImKwfJucI5NFBf1znmbU
   5LRnvur64ybpf3/j8cCoICHLSbzH12dzHSMHKH5Muej5nILfnO45BM3v5
   065LPfwyuABBA75Gkyuh8VcNZmO85vcL0/R1SSbYWOWhc9QJP4nPAfRug
   Vm4gxmMPdGmbD63gsWgbySnv6+7Xz+0afY6/9nHmxaakSwHwdrccr5K6u
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286699858"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="286699858"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="738332920"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jul 2022 09:22:27 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC1be-0000qz-JY;
        Thu, 14 Jul 2022 16:22:26 +0000
Date:   Fri, 15 Jul 2022 00:21:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Tu <u9012063@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/net/vmxnet3/vmxnet3_drv.c:1557:13: warning: variable
 'delta_len' set but not used
Message-ID: <202207150027.C0HuxMn8-lkp@intel.com>
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

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220714-210938/William-Tu/vmxnet3-Add-XDP-support/20220707-213553
head:   4340e33d0526f1a236e07f564ab630fe1df9a776
commit: 4340e33d0526f1a236e07f564ab630fe1df9a776 vmxnet3: Add XDP support.
date:   3 hours ago
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220715/202207150027.C0HuxMn8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4340e33d0526f1a236e07f564ab630fe1df9a776
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220714-210938/William-Tu/vmxnet3-Add-XDP-support/20220707-213553
        git checkout 4340e33d0526f1a236e07f564ab630fe1df9a776
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/vmxnet3/vmxnet3_drv.c: In function '__vmxnet3_run_xdp':
>> drivers/net/vmxnet3/vmxnet3_drv.c:1557:13: warning: variable 'delta_len' set but not used [-Wunused-but-set-variable]
    1557 |         int delta_len;
         |             ^~~~~~~~~
>> drivers/net/vmxnet3/vmxnet3_drv.c:1556:18: warning: variable 'delta' set but not used [-Wunused-but-set-variable]
    1556 |         int err, delta;
         |                  ^~~~~


vim +/delta_len +1557 drivers/net/vmxnet3/vmxnet3_drv.c

  1546	
  1547	static int
  1548	__vmxnet3_run_xdp(struct vmxnet3_rx_queue *rq, void *data, int data_len,
  1549			  int headroom, int frame_sz, bool *need_xdp_flush)
  1550	{
  1551		struct xdp_frame *xdpf;
  1552		void *buf_hard_start;
  1553		struct xdp_buff xdp;
  1554		struct page *page;
  1555		void *orig_data;
> 1556		int err, delta;
> 1557		int delta_len;
  1558		u32 act;
  1559	
  1560		buf_hard_start = data;
  1561		xdp_init_buff(&xdp, frame_sz, &rq->xdp_rxq);
  1562		xdp_prepare_buff(&xdp, buf_hard_start, headroom, data_len, false);
  1563		orig_data = xdp.data;
  1564	
  1565		act = bpf_prog_run_xdp(rq->xdp_bpf_prog, &xdp);
  1566		rq->stats.xdp_packets++;
  1567	
  1568		switch (act) {
  1569		case XDP_DROP:
  1570			rq->stats.xdp_drops++;
  1571			break;
  1572		case XDP_PASS:
  1573			delta = xdp.data - orig_data;
  1574			delta_len = (xdp.data_end - xdp.data) - data_len;
  1575			/* FIXME */
  1576			break;
  1577		case XDP_TX:
  1578			xdpf = xdp_convert_buff_to_frame(&xdp);
  1579			if (!xdpf ||
  1580			    vmxnet3_xdp_xmit_back(rq->adapter, xdpf, NULL)) {
  1581				rq->stats.xdp_drops++;
  1582			} else {
  1583				rq->stats.xdp_tx++;
  1584			}
  1585			break;
  1586		case XDP_ABORTED:
  1587			trace_xdp_exception(rq->adapter->netdev, rq->xdp_bpf_prog,
  1588					    act);
  1589			rq->stats.xdp_aborted++;
  1590			break;
  1591		case XDP_REDIRECT:
  1592			page = alloc_page(GFP_ATOMIC);
  1593			if (!page) {
  1594				rq->stats.rx_buf_alloc_failure++;
  1595				return XDP_DROP;
  1596			}
  1597			xdp_init_buff(&xdp, PAGE_SIZE, &rq->xdp_rxq);
  1598			xdp_prepare_buff(&xdp, page_address(page),
  1599					 XDP_PACKET_HEADROOM,
  1600					 data_len, false);
  1601			memcpy(xdp.data, data, data_len);
  1602			err = xdp_do_redirect(rq->adapter->netdev, &xdp,
  1603					      rq->xdp_bpf_prog);
  1604			if (!err) {
  1605				rq->stats.xdp_redirects++;
  1606			} else {
  1607				__free_page(page);
  1608				rq->stats.xdp_drops++;
  1609			}
  1610			*need_xdp_flush = true;
  1611			break;
  1612		default:
  1613			bpf_warn_invalid_xdp_action(rq->adapter->netdev,
  1614						    rq->xdp_bpf_prog, act);
  1615			break;
  1616		}
  1617		return act;
  1618	}
  1619	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
