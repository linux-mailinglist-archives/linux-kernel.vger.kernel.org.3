Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD444AA92E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 14:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380013AbiBENih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 08:38:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:11317 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352408AbiBENid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644068313; x=1675604313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=62a3FU6l3Fa9XlrSiuApE0UV2m5LcQQ4wpG5mDpaXhg=;
  b=Ua6eUedUuPzL9GWA5Z+wmInuV4HYp+YgKhPPcFc+/5ax2SgPW32h+6ve
   Qd1E8CZowVdx6e2+5S7/pKwXtay+YEmfgMkUwbLzOmhp/Tkst/YGSo+6f
   T8X4dRKyFiJbUa2anwfnZDa5fpjd+QpAIy36hCsG1zXtOUzLy+QyVRrgS
   T2Qmzltv52dM+1N2n/cINEbuJkNZDEYQMrTPeQp5spSZ4i6NBrawh2O8L
   vdgWLTtI/i80HSJh5bGmD1TfHGy27DOEPfmDKx3W5gBR+iR051rRjagZP
   6eZb6A5OSEeo1SU68fW9OfueE2O0wBayjYGni+LKmTx39YFtMf+CDTEdd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248274532"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="248274532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 05:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="539510177"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Feb 2022 05:38:32 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGLGp-000Z59-GN; Sat, 05 Feb 2022 13:38:31 +0000
Date:   Sat, 5 Feb 2022 21:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bigeasy-staging:nettree 20/30]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h:114:40: error: too
 many arguments to function call, expected 2, have 3
Message-ID: <202202052116.njaUzsdI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git nettree
head:   5be59eb9de8284e8ddfb8d34f5d61396a480d37c
commit: 61fe48994376312cf8a4bceaf0ac624f20148330 [20/30] wireless: brcmfmac:: Use netif_rx().
config: hexagon-randconfig-r041-20220204 (https://download.01.org/0day-ci/archive/20220205/202202052116.njaUzsdI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project dee058c670593b999fec19c458dbbd882ad9de56)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git/commit/?id=61fe48994376312cf8a4bceaf0ac624f20148330
        git remote add bigeasy-staging https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git
        git fetch --no-tags bigeasy-staging nettree
        git checkout 61fe48994376312cf8a4bceaf0ac624f20148330
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:30:
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h:114:40: error: too many arguments to function call, expected 2, have 3
           ifp->drvr->proto->rxreorder(ifp, skb, inirq);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~           ^~~~~
   1 error generated.


vim +114 drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h

85b8413371225e drivers/net/wireless/brcm80211/brcmfmac/proto.h          Hante Meuleman   2013-11-29  110  
bbd1f932e7c45e drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h Arend van Spriel 2016-04-11  111  static inline void
687006e20c445c drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h Thomas Gleixner  2020-09-29  112  brcmf_proto_rxreorder(struct brcmf_if *ifp, struct sk_buff *skb, bool inirq)
bbd1f932e7c45e drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h Arend van Spriel 2016-04-11  113  {
687006e20c445c drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h Thomas Gleixner  2020-09-29 @114  	ifp->drvr->proto->rxreorder(ifp, skb, inirq);
bbd1f932e7c45e drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h Arend van Spriel 2016-04-11  115  }
85b8413371225e drivers/net/wireless/brcm80211/brcmfmac/proto.h          Hante Meuleman   2013-11-29  116  

:::::: The code at line 114 was first introduced by commit
:::::: 687006e20c445c2461f5a03fe1361ede946f1996 net: brcmfmac: Convey execution context via argument to brcmf_netif_rx()

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
