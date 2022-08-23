Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78959ED40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiHWUWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiHWUWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:22:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD559A690
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661284144; x=1692820144;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ia0anFfuwz443iX1tU5Mr1ZtxYNpdXSuAwNOm8ioSoQ=;
  b=b69nHnjhspS6x0vLYm1G2v1mMCRxjr5jdegov7zX3rwdoRmV5sGgXNJ2
   cWyWMTwLFPSunbih/pOFZRUrnboNGt6mha7vfadIhJsqPXUpMUtoV/bpc
   m1lYIxtJSlU4268byaNG0LxIu+RBvgSrOvaR8jZnMqwxrYOLHvevP93d/
   NxuhLAt2vlEGHxceEK1/GJp1uD/Ua4oWYCMkjmKCHclJuWLPPlAEadfHx
   llAIi3PV9KWUL1iwnnXt+BsgkLUGv4kVl8cIHI/9ofxmLCDB8XArSryYR
   RgnETzEb/l5QY8GdE34JSkcq1Xse9ztwIg3lfO6uBaCGoQzMIHJ0lr/XQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="293782188"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="293782188"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 12:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="638797454"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2022 12:49:02 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQZtV-0000Tj-1i;
        Tue, 23 Aug 2022 19:49:01 +0000
Date:   Wed, 24 Aug 2022 03:48:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Raed Salem <raeds@nvidia.com>, Huy Nguyen <huyn@nvidia.com>
Subject: [leon-rdma:xfrm-next 4/34] net/xfrm/xfrm_device.c:383:56: warning:
 suggest parentheses around '&&' within '||'
Message-ID: <202208240319.plmxMsEF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git xfrm-next
head:   a3d3cb4010b4294c2c6a60d398dd417f335982f3
commit: d7b5afa45594beb1a60cba94c0e9e2b645c6a881 [4/34] xfrm: add TX datapath support for IPsec full offload mode
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220824/202208240319.plmxMsEF-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?id=d7b5afa45594beb1a60cba94c0e9e2b645c6a881
        git remote add leon-rdma https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git
        git fetch --no-tags leon-rdma xfrm-next
        git checkout d7b5afa45594beb1a60cba94c0e9e2b645c6a881
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash net/xfrm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/xfrm/xfrm_device.c: In function 'xfrm_dev_offload_ok':
>> net/xfrm/xfrm_device.c:383:56: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
     383 |             (!dev || (dev == xfrm_dst_path(dst)->dev)) && !xdst->child->xfrm) {
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~


vim +383 net/xfrm/xfrm_device.c

   371	
   372	bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
   373	{
   374		int mtu;
   375		struct dst_entry *dst = skb_dst(skb);
   376		struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
   377		struct net_device *dev = x->xso.dev;
   378	
   379		if (!x->type_offload || x->encap)
   380			return false;
   381	
   382		if (x->xso.type == XFRM_DEV_OFFLOAD_FULL ||
 > 383		    (!dev || (dev == xfrm_dst_path(dst)->dev)) && !xdst->child->xfrm) {
   384			mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
   385			if (skb->len <= mtu)
   386				goto ok;
   387	
   388			if (skb_is_gso(skb) && skb_gso_validate_network_len(skb, mtu))
   389				goto ok;
   390		}
   391	
   392		return false;
   393	
   394	ok:
   395		if (dev && dev->xfrmdev_ops && dev->xfrmdev_ops->xdo_dev_offload_ok)
   396			return x->xso.dev->xfrmdev_ops->xdo_dev_offload_ok(skb, x);
   397	
   398		return true;
   399	}
   400	EXPORT_SYMBOL_GPL(xfrm_dev_offload_ok);
   401	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
