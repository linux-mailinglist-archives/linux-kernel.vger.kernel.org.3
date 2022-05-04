Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048B9519963
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiEDIRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiEDIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:17:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9072252D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651652040; x=1683188040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NrYiaktX3BK/d5o8lnJUohv0jOT3lFCCaQ61Z0o7OtY=;
  b=JVt/ZO5m5fmB/wIyHi+91aK/hpc4w/bHr52TS5ubxmJRJ9YEV7a9MKOG
   oMnftgLsXYA/zRRNgm9LZv+AmjyZCbzh7BGQZicdHP0CfCVGjXoZqnjbV
   Pw9W2zT2lMk3ZUyokPmnEFAolThKibrUIzz7WQLWY8ni62nmFBbHX7hA8
   6VS9N2T1HqPOTk9Kqmu/tnTd4X4oKCnbSEtoKuDpgbWDdyb/q5i8UbdSO
   dvTWjiMe47I4QCj20kI7VyioufkpB2QAm6OgyNmq6nPpn12AsRFBshig5
   zgmBhpDH1CbrksivZ5zG3lfLYoLOUkSubHwtGFeCeYKVpUnV7rKNtnvwc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="330684910"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="330684910"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="516925644"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2022 01:13:59 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmA90-000BCP-CZ;
        Wed, 04 May 2022 08:13:58 +0000
Date:   Wed, 4 May 2022 16:13:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:flexcpy/next-20220502 8/34]
 drivers/net/wireless/intel/iwlwifi/dvm/calib.c:68:20: error: 'struct
 iwl_calib_result' has no member named 'hdr'
Message-ID: <202205041603.z4FBgjkQ-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git flexcpy/next-20220502
head:   1dbd8181297512b190aca23477043ac635daba4e
commit: ebd8c465eee86d64d9d8f2204db5971e6588174a [8/34] iwlwifi: calib: Prepare to use mem_to_flex_dup()
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220504/202205041603.z4FBgjkQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=ebd8c465eee86d64d9d8f2204db5971e6588174a
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees flexcpy/next-20220502
        git checkout ebd8c465eee86d64d9d8f2204db5971e6588174a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the kees/flexcpy/next-20220502 HEAD 1dbd8181297512b190aca23477043ac635daba4e builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/dvm/calib.c: In function 'iwl_calib_set':
>> drivers/net/wireless/intel/iwlwifi/dvm/calib.c:68:20: error: 'struct iwl_calib_result' has no member named 'hdr'
      68 |         memcpy(&res->hdr, cmd, len);
         |                    ^~


vim +68 drivers/net/wireless/intel/iwlwifi/dvm/calib.c

6e21f2c109edd7 drivers/net/wireless/iwlwifi/iwl-calib.c       Tomas Winkler 2008-09-03  58  
e19918855dc482 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2012-03-06  59  int iwl_calib_set(struct iwl_priv *priv,
ebd8c465eee86d drivers/net/wireless/intel/iwlwifi/dvm/calib.c Kees Cook     2021-07-31  60  		  const struct iwl_calib_cmd *cmd, int len)
6e21f2c109edd7 drivers/net/wireless/iwlwifi/iwl-calib.c       Tomas Winkler 2008-09-03  61  {
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  62  	struct iwl_calib_result *res, *tmp;
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  63  
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  64  	res = kmalloc(sizeof(*res) + len - sizeof(struct iwl_calib_hdr),
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  65  		      GFP_ATOMIC);
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  66  	if (!res)
6e21f2c109edd7 drivers/net/wireless/iwlwifi/iwl-calib.c       Tomas Winkler 2008-09-03  67  		return -ENOMEM;
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17 @68  	memcpy(&res->hdr, cmd, len);
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  69  	res->cmd_len = len;
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  70  
e19918855dc482 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2012-03-06  71  	list_for_each_entry(tmp, &priv->calib_results, list) {
ebd8c465eee86d drivers/net/wireless/intel/iwlwifi/dvm/calib.c Kees Cook     2021-07-31  72  		if (tmp->cmd.hdr.op_code == res->cmd.hdr.op_code) {
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  73  			list_replace(&tmp->list, &res->list);
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  74  			kfree(tmp);
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  75  			return 0;
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  76  		}
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  77  	}
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  78  
f02c2fd383f4c7 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2011-11-17  79  	/* wasn't in list already */
e19918855dc482 drivers/net/wireless/iwlwifi/iwl-agn-calib.c   Johannes Berg 2012-03-06  80  	list_add_tail(&res->list, &priv->calib_results);
6e21f2c109edd7 drivers/net/wireless/iwlwifi/iwl-calib.c       Tomas Winkler 2008-09-03  81  
6e21f2c109edd7 drivers/net/wireless/iwlwifi/iwl-calib.c       Tomas Winkler 2008-09-03  82  	return 0;
6e21f2c109edd7 drivers/net/wireless/iwlwifi/iwl-calib.c       Tomas Winkler 2008-09-03  83  }
6e21f2c109edd7 drivers/net/wireless/iwlwifi/iwl-calib.c       Tomas Winkler 2008-09-03  84  

:::::: The code at line 68 was first introduced by commit
:::::: f02c2fd383f4c771c75daf391abdbdcb88848439 iwlagn: dynamically allocate & reflect calibration data

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Wey-Yi Guy <wey-yi.w.guy@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
