Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CC651CCA6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386687AbiEEXXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386657AbiEEXWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:22:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E0260064
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651792749; x=1683328749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P7Fx3eeBlpNLpzJeJ1UahMEOZ23iw3mOPDMvylQpeNY=;
  b=gz82vfepxaq3RaLhTTN6U7fO7Ldz1sx7oBkW+RKhRbgQOqcds0umyBA4
   yNT090B7kYrqDGXeKQv/bjiYJtUOCqg+H77biuEVsBcyigR+AYVsRs2/T
   M/yA+TPxa6NayC6Ol+HRCagKUp4f45BmFTautBckY/tUBY/FbzmlH0jRh
   dPcq4N+L4KUeSaTFLoUyNScCjrErj82IUU87/aMYq6vbW2Q6gGF5AEtar
   YinBIggLj15Ly8Jq04X7DMqksFwRAEbctZ2E/BJdcIZDWEBS9ErQDArOG
   8YKfw/4z/ASkLbcvrdtKHbnI7Z7P6cw9Qp9YCYMf42uOdX8zYO8ou7Scf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265875376"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="265875376"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735223528"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2022 16:19:08 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmkkV-000CpE-FV;
        Thu, 05 May 2022 23:19:07 +0000
Date:   Fri, 6 May 2022 07:18:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, build@wireguard.com,
        linux-kernel@vger.kernel.org
Subject: [zx2c4-wireguard:devel 1/1] lib/crypto/poly1305-selftest.c:1043:13:
 warning: no previous prototype for 'poly1305_selftest'
Message-ID: <202205060716.oQVkOKUQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git devel
head:   f9be522dcc12fe0f759dc5cf175be4d67e278589
commit: f9be522dcc12fe0f759dc5cf175be4d67e278589 [1/1] crypto: poly1305 - add library selftests
config: openrisc-randconfig-r032-20220505 (https://download.01.org/0day-ci/archive/20220506/202205060716.oQVkOKUQ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git/commit/?id=f9be522dcc12fe0f759dc5cf175be4d67e278589
        git remote add zx2c4-wireguard https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git
        git fetch --no-tags zx2c4-wireguard devel
        git checkout f9be522dcc12fe0f759dc5cf175be4d67e278589
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash lib/crypto/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/crypto/poly1305-selftest.c:1043:13: warning: no previous prototype for 'poly1305_selftest' [-Wmissing-prototypes]
    1043 | bool __init poly1305_selftest(void)
         |             ^~~~~~~~~~~~~~~~~


vim +/poly1305_selftest +1043 lib/crypto/poly1305-selftest.c

  1042	
> 1043	bool __init poly1305_selftest(void)
  1044	{
  1045		bool success = true;
  1046		size_t i, j;
  1047	
  1048		for (i = 0; i < ARRAY_SIZE(poly1305_testvecs); ++i) {
  1049			struct poly1305_desc_ctx poly1305;
  1050			u8 out[POLY1305_DIGEST_SIZE];
  1051	
  1052			memset(out, 0, sizeof(out));
  1053			memset(&poly1305, 0, sizeof(poly1305));
  1054			poly1305_init(&poly1305, poly1305_testvecs[i].key);
  1055			poly1305_update(&poly1305, poly1305_testvecs[i].input,
  1056					poly1305_testvecs[i].ilen);
  1057			poly1305_final(&poly1305, out);
  1058			if (memcmp(out, poly1305_testvecs[i].output,
  1059				   POLY1305_DIGEST_SIZE)) {
  1060				pr_err("poly1305 self-test %zu: FAIL\n", i + 1);
  1061				success = false;
  1062			}
  1063	
  1064			if (poly1305_testvecs[i].ilen <= 1)
  1065				continue;
  1066	
  1067			for (j = 1; j < poly1305_testvecs[i].ilen - 1; ++j) {
  1068				memset(out, 0, sizeof(out));
  1069				memset(&poly1305, 0, sizeof(poly1305));
  1070				poly1305_init(&poly1305, poly1305_testvecs[i].key);
  1071				poly1305_update(&poly1305, poly1305_testvecs[i].input, j);
  1072				poly1305_update(&poly1305,
  1073						poly1305_testvecs[i].input + j,
  1074						poly1305_testvecs[i].ilen - j);
  1075				poly1305_final(&poly1305, out);
  1076				if (memcmp(out, poly1305_testvecs[i].output,
  1077					   POLY1305_DIGEST_SIZE)) {
  1078					pr_err("poly1305 self-test %zu (split %zu): FAIL\n",
  1079					       i + 1, j);
  1080					success = false;
  1081				}
  1082	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
