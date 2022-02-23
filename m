Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A934C1AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiBWSZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiBWSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:25:12 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF48424AF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645640684; x=1677176684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GtToj3XA7dhDdUq8JlVvJnjByb1H4klR3e9Su2/tvTk=;
  b=Fn+EMP+rD8cbvImeO06+U1DUtUMLvLjZPJSWcKUItY5sJLBYBCsX0U0i
   iV2bUtYljbvbQ5TFaPErr51PTk4iAppknscroMfFftBHJhezNT3vjiLk/
   dnWx0q2x256SXt0dJhb1bVB0e63pRYZMynb1ubShuUgI0+pYjItNgMwZ9
   xMJ35Y1qez2hZVK2nEblWxk6837c685DCRwcapiTcDl495xXYH+mVb4Zz
   jI3sy5Rz5FNO/8OU6fo3430ybgiccE11J9l7gJn9F330YScax6EpBlcme
   IsC4gqr+8cg0PFq5+kVYEiR+9RZBOsUz4F5fibeaS4S30O90eZMOWXRmv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="249630411"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="249630411"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:24:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491309303"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 10:24:42 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMwJd-0001hA-KE; Wed, 23 Feb 2022 18:24:41 +0000
Date:   Thu, 24 Feb 2022 02:24:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1693/2340]
 drivers/net/dsa/lan9303-core.c:1098:2: error: implicit declaration of
 function 'vlan_vid_add'
Message-ID: <202202240246.JOktuuHV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: f2ea4c6dbf9c7f05dedc83b9c74d5ec82b9af164 [1693/2340] headers/deps: net: Optimize <linux/if_vlan.h>, remove <linux/if_vlan_api.h> inclusion
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220224/202202240246.JOktuuHV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f2ea4c6dbf9c7f05dedc83b9c74d5ec82b9af164
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout f2ea4c6dbf9c7f05dedc83b9c74d5ec82b9af164
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/dsa/ net/dsa/ net/smc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 97c5eeb4de3ad324ed2a4656b46465299cfd010a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> drivers/net/dsa/lan9303-core.c:1098:2: error: implicit declaration of function 'vlan_vid_add' [-Werror,-Wimplicit-function-declaration]
           vlan_vid_add(dp->cpu_dp->master, htons(ETH_P_8021Q), port);
           ^
>> drivers/net/dsa/lan9303-core.c:1111:2: error: implicit declaration of function 'vlan_vid_del' [-Werror,-Wimplicit-function-declaration]
           vlan_vid_del(dp->cpu_dp->master, htons(ETH_P_8021Q), port);
           ^
   2 errors generated.


vim +/vlan_vid_add +1098 drivers/net/dsa/lan9303-core.c

4d6a78b477dd96 Egil Hjelmeland 2017-09-19  1088  
a1292595e00607 Juergen Beisert 2017-04-18  1089  static int lan9303_port_enable(struct dsa_switch *ds, int port,
a1292595e00607 Juergen Beisert 2017-04-18  1090  			       struct phy_device *phy)
a1292595e00607 Juergen Beisert 2017-04-18  1091  {
430065e2671905 Mans Rullgard   2022-02-16  1092  	struct dsa_port *dp = dsa_to_port(ds, port);
a1292595e00607 Juergen Beisert 2017-04-18  1093  	struct lan9303 *chip = ds->priv;
a1292595e00607 Juergen Beisert 2017-04-18  1094  
430065e2671905 Mans Rullgard   2022-02-16  1095  	if (!dsa_port_is_user(dp))
74be4babe72fd1 Vivien Didelot  2019-08-19  1096  		return 0;
74be4babe72fd1 Vivien Didelot  2019-08-19  1097  
430065e2671905 Mans Rullgard   2022-02-16 @1098  	vlan_vid_add(dp->cpu_dp->master, htons(ETH_P_8021Q), port);
430065e2671905 Mans Rullgard   2022-02-16  1099  
9c84258ed68a1d Egil Hjelmeland 2017-08-05  1100  	return lan9303_enable_processing_port(chip, port);
a1292595e00607 Juergen Beisert 2017-04-18  1101  }
a1292595e00607 Juergen Beisert 2017-04-18  1102  
75104db0cb353e Andrew Lunn     2019-02-24  1103  static void lan9303_port_disable(struct dsa_switch *ds, int port)
a1292595e00607 Juergen Beisert 2017-04-18  1104  {
430065e2671905 Mans Rullgard   2022-02-16  1105  	struct dsa_port *dp = dsa_to_port(ds, port);
a1292595e00607 Juergen Beisert 2017-04-18  1106  	struct lan9303 *chip = ds->priv;
a1292595e00607 Juergen Beisert 2017-04-18  1107  
430065e2671905 Mans Rullgard   2022-02-16  1108  	if (!dsa_port_is_user(dp))
74be4babe72fd1 Vivien Didelot  2019-08-19  1109  		return;
74be4babe72fd1 Vivien Didelot  2019-08-19  1110  
430065e2671905 Mans Rullgard   2022-02-16 @1111  	vlan_vid_del(dp->cpu_dp->master, htons(ETH_P_8021Q), port);
430065e2671905 Mans Rullgard   2022-02-16  1112  
9c84258ed68a1d Egil Hjelmeland 2017-08-05  1113  	lan9303_disable_processing_port(chip, port);
b17c6b1f4538b6 Egil Hjelmeland 2017-12-29  1114  	lan9303_phy_write(ds, chip->phy_addr_base + port, MII_BMCR, BMCR_PDOWN);
a1292595e00607 Juergen Beisert 2017-04-18  1115  }
a1292595e00607 Juergen Beisert 2017-04-18  1116  

:::::: The code at line 1098 was first introduced by commit
:::::: 430065e2671905ac675f97b7af240cc255964e93 net: dsa: lan9303: add VLAN IDs to master device

:::::: TO: Mans Rullgard <mans@mansr.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
