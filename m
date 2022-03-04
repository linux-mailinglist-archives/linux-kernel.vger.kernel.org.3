Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075134CCBFA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiCDCt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiCDCt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:49:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BC71BE8D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646362119; x=1677898119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AZPvg0J8d+7aufXHsMxjExG5LQV7/fU+w3gOmM8L4/s=;
  b=Ch6OU1k19ZpQkqY1QXHzw10ImWYldMW+ZISAGqrRmh65nBB0wVADtzdS
   d8xXJN6FteFofLsFNoqVBzoUGabufxymChF3WgeQl8wIXTOANy2G78RJz
   QSuLfEhZ8KIck8B36tCubcx1vzitC3Q5JV34j+b23pWmqs0huInW5jjOO
   B4WQSHs0twMvm43heAeNE4VYwTr8qbQaBaHIc1EQ8vV8FkwCTFO09pMon
   Ia6GE2TnnANYK5pJdWZvmjfPDhSr7xVD7W8OcxxWCALkcw0JCOqK6rvui
   ZSWd6vvneL45kXfIk8D5QHSlgYPiYGmKQnPD9SJA0nnZxXvxBxPPWybdw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="234487302"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="234487302"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 18:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="631030059"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2022 18:48:38 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPxzi-0001CG-1C; Fri, 04 Mar 2022 02:48:38 +0000
Date:   Fri, 4 Mar 2022 10:47:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 12/15] flow_dissector.c:undefined
 reference to `__nf_ct_ext_find'
Message-ID: <202203041002.W3fh0bhL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   608a724032f9807149638d5f7bde065500e8c4ba
commit: 9c1bc3d863d9e8437347149391ad3918eb95ed36 [12/15] netfilter: extensions: introduce extension genid count
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220304/202203041002.W3fh0bhL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=9c1bc3d863d9e8437347149391ad3918eb95ed36
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 9c1bc3d863d9e8437347149391ad3918eb95ed36
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: net/core/flow_dissector.o: in function `skb_flow_dissect_ct':
>> flow_dissector.c:(.text+0x67c): undefined reference to `__nf_ct_ext_find'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
