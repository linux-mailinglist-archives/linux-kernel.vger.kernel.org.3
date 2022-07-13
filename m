Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD13057354B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiGMLZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiGMLY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:24:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA47E7CCE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657711497; x=1689247497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x2z96YWffgva57e/5SCnO/eg4fgCYmVKHGKY6tfFCw8=;
  b=FbMufuyRf04N4dP5XOEb3Ut4dngu7WWf3eiVsbk1FFIIkhvhSf21o+gy
   ig2NmDMgZonkyh+c8lQ8MpWux42MV2uva32cHeiAy2rHNKvAayJWaXw9m
   y5JPiwY4zFhpoUSMihzPJwsThmpi+blQBvOUIRaG9Dv/n7nQ9+czON1yP
   Nwc9VGLZDS6aTW5B5CfU3zAWha6j6NtnFCZIFez3xE4WUABw6TqTeAGzS
   rc397h9UXmAXo+FAGy+XeX+8SE++scOGmUYxDT9FU/7JfL0UEnybvyIuM
   qseolRw14fSRRS+3E0Cp5z1pVzN0HGbmVrFSVRDHykevP4Q3wMNDsVp1u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="283939006"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="283939006"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 04:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="663322624"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jul 2022 04:24:56 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBaUB-0003Pj-PA;
        Wed, 13 Jul 2022 11:24:55 +0000
Date:   Wed, 13 Jul 2022 19:24:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta5 4/4] include/net/sch_generic.h:819: undefined
 reference to `__qdisc_calculate_pkt_len'
Message-ID: <202207131955.CE8BXrij-lkp@intel.com>
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

tree:   https://github.com/cilium/linux.git pr/meta5
head:   3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5
commit: 3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5 [4/4] bpf: Add fd-based API to attach tc BPF programs
config: arc-buildonly-randconfig-r005-20220712 (https://download.01.org/0day-ci/archive/20220713/202207131955.CE8BXrij-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/cilium/linux/commit/3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta5
        git checkout 3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: net/core/dev.o: in function `__dev_xmit_skb':
>> include/net/sch_generic.h:819: undefined reference to `__qdisc_calculate_pkt_len'
>> arc-elf-ld: include/net/sch_generic.h:819: undefined reference to `__qdisc_calculate_pkt_len'


vim +819 include/net/sch_generic.h

378a2f090f7a47 Jarek Poplawski 2008-08-04  811  
a2da570d62fcb9 Eric Dumazet    2011-01-20  812  static inline void qdisc_calculate_pkt_len(struct sk_buff *skb,
a2da570d62fcb9 Eric Dumazet    2011-01-20  813  					   const struct Qdisc *sch)
5f86173bdf1598 Jussi Kivilinna 2008-07-20  814  {
3dd186e5096ad4 Daniel Borkmann 2022-06-13  815  #ifdef CONFIG_NET_XGRESS
a2da570d62fcb9 Eric Dumazet    2011-01-20  816  	struct qdisc_size_table *stab = rcu_dereference_bh(sch->stab);
a2da570d62fcb9 Eric Dumazet    2011-01-20  817  
a2da570d62fcb9 Eric Dumazet    2011-01-20  818  	if (stab)
a2da570d62fcb9 Eric Dumazet    2011-01-20 @819  		__qdisc_calculate_pkt_len(skb, stab);
3a682fbd732d3d David S. Miller 2008-07-20  820  #endif
a2da570d62fcb9 Eric Dumazet    2011-01-20  821  }
a2da570d62fcb9 Eric Dumazet    2011-01-20  822  

:::::: The code at line 819 was first introduced by commit
:::::: a2da570d62fcb9e8816f6920e1ec02c706b289fa net_sched: RCU conversion of stab

:::::: TO: Eric Dumazet <eric.dumazet@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
