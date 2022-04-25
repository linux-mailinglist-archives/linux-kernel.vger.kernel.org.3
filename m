Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E859C50E4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbiDYP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243037AbiDYP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:56:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777683A5D1;
        Mon, 25 Apr 2022 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650902000; x=1682438000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pOPEGCHnvjVwA0raKpTtQf9A6l+ZYep4d2AzfqFxgnE=;
  b=fGySLy0FaviT+3TG+eZOc5vGRwVdoQt26aHGzQI2sg49tl1wV6AlZFMe
   XfObs8geao+EmKfgUfJKaCPW5KUoT/u2zJgd2QOdnn0wCS9UCQ/Jr6vg8
   GYeiG5gTuGRaCEXkeBLW01xQAIFJROMph9EV/WvJB33vP40ysXiEy0bTV
   7PmwjQqCpqlW/LwDOy+ZgHajZYk0BH2ZQN6LL/y3lEK+HDYpXNN8qMHSk
   uj4kT1lRFf84dzvog8xQvKvaP32UXJMVblUiFApE1rzAAvAfPKIK1fcCI
   iHirCgpFQPjbdHbtwUSQGrxdg0QMX14f83fntHMKHToS7YLAHfcJbcwuq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264804504"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264804504"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:53:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704612125"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 08:53:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj11Z-0002dq-CB;
        Mon, 25 Apr 2022 15:53:17 +0000
Date:   Mon, 25 Apr 2022 23:53:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-doc@vger.kernel.org
Subject: [linux-stable-rc:linux-5.15.y 5378/5978]
 arch/powerpc/kvm/book3s_hv_rm_xics.c:887: warning: This comment starts with
 '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202204252334.Cd2IsiII-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   81d8d30c35edf29c5c70186ccb14dac4a5ca38a8
commit: 2d67222b2380949f2e00b35104a2cc0a62b4631b [5378/5978] powerpc: Fix build errors with newer binutils
config: powerpc64-randconfig-r023-20220425 (https://download.01.org/0day-ci/archive/20220425/202204252334.Cd2IsiII-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=2d67222b2380949f2e00b35104a2cc0a62b4631b
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 2d67222b2380949f2e00b35104a2cc0a62b4631b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/kvm/book3s_hv_rm_xics.c:887: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Host Operations poked by RM KVM


vim +887 arch/powerpc/kvm/book3s_hv_rm_xics.c

0c2a66062470cd Suresh Warrier 2015-12-17  885  
0c2a66062470cd Suresh Warrier 2015-12-17  886  /**
0c2a66062470cd Suresh Warrier 2015-12-17 @887   * Host Operations poked by RM KVM
0c2a66062470cd Suresh Warrier 2015-12-17  888   */
0c2a66062470cd Suresh Warrier 2015-12-17  889  static void rm_host_ipi_action(int action, void *data)
0c2a66062470cd Suresh Warrier 2015-12-17  890  {
0c2a66062470cd Suresh Warrier 2015-12-17  891  	switch (action) {
0c2a66062470cd Suresh Warrier 2015-12-17  892  	case XICS_RM_KICK_VCPU:
0c2a66062470cd Suresh Warrier 2015-12-17  893  		kvmppc_host_rm_ops_hv->vcpu_kick(data);
0c2a66062470cd Suresh Warrier 2015-12-17  894  		break;
0c2a66062470cd Suresh Warrier 2015-12-17  895  	default:
0c2a66062470cd Suresh Warrier 2015-12-17  896  		WARN(1, "Unexpected rm_action=%d data=%p\n", action, data);
0c2a66062470cd Suresh Warrier 2015-12-17  897  		break;
0c2a66062470cd Suresh Warrier 2015-12-17  898  	}
0c2a66062470cd Suresh Warrier 2015-12-17  899  

:::::: The code at line 887 was first introduced by commit
:::::: 0c2a66062470cd1f6d11ae6db31059f59d3f725f KVM: PPC: Book3S HV: Host side kick VCPU when poked by real-mode KVM

:::::: TO: Suresh Warrier <warrier@linux.vnet.ibm.com>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
