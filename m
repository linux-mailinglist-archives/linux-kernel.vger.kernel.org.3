Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5B52FFEA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbiEVASA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiEVAR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:17:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A803F8BE
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653178677; x=1684714677;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UFGskL+eS8xPSlZ84GUBDgnXZ977kPt49KhEnWAKE4k=;
  b=h5R2GyYLbZB4PUVRJtxBl1+ba9aiyOKruisC0TNrtuf+X3ioGWXQzbFw
   a4G7Ime1gHh4k8tZkmDess3RRTGkzWw0lGiYEs2MRQm7MxzBn3NuYedtf
   /fcN/J+Q3ryW7XwbFGVP93D33Ui5jwPs4BditXgPTnzkkUSyyaADh68sk
   HSEy2fG+O+YLwFYwuaTaoCw9bB4qbKrUvG52zwXhCk5K0auxAE4HMA+jI
   LXtrfYA6OTJhZvYBeLzE3pBhjU3fv1CkqMPl7nYjAS1QbPSHw0TbCVyrh
   vFT67mMS3n1AFak1prLm6Ei3C9AvMy8hm1t5XhP36zNT2YWNOQ+SwdbN0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="270501390"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="270501390"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 17:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="607590377"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 May 2022 17:17:56 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsZIB-0006lD-NM;
        Sun, 22 May 2022 00:17:55 +0000
Date:   Sun, 22 May 2022 08:17:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 1/3] m68k-linux-ld: kernel/bpf/syscall.o:undefined
 reference to `skb_map_ops'
Message-ID: <202205220841.yXC3cJWK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   9f6c12a2c218c56af7d37feeaf21c5b62a8192a0
commit: ef56eb898b1d5c229db544d5933e9c686132ef28 [1/3] bpf: introduce skb map
config: m68k-randconfig-r022-20220522 (https://download.01.org/0day-ci/archive/20220522/202205220841.yXC3cJWK-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/ef56eb898b1d5c229db544d5933e9c686132ef28
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout ef56eb898b1d5c229db544d5933e9c686132ef28
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> m68k-linux-ld: kernel/bpf/syscall.o:(.rodata+0x54a): undefined reference to `skb_map_ops'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
