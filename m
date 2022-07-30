Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2307585991
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiG3J1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiG3J1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:27:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26434402F9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659173221; x=1690709221;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v0t6Mw5FkkrDAFJJglO338wfwpFvRm/ORaLw6qzfvFg=;
  b=C5H4cdSy+5P/l8kYhusMG5hN633kiWV6VDlppshUmisbM4JM/io7Gb9o
   L7gDrK36N4NbiDEhSryNecmHyYa4RVddbBgAwfwaaMMZ+EU2Bv6ptrdlj
   Zr4l4f+3feryzJ7kReYlIzvJ0/HK3QB58FVvbrpFoOidFcylBXYd1JMuI
   a8XCD7wvKkSy48zsPsAtKJoIo0FWGVd1FwSgb9EfrTDR/seck4E1Wn0Ul
   FsA/aHkN/ACtVqQdHshZhZyu76GhEFeuOjAjyaoFK/ETU0JbVPtkSVJcq
   XO0v+1xT4He3RvA7MgjnsLzIU/zD1BxB95EiI8IcCZSjJP1lKVTpBChGe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289674131"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="289674131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 02:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="629658467"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2022 02:26:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHikN-000CgZ-07;
        Sat, 30 Jul 2022 09:26:59 +0000
Date:   Sat, 30 Jul 2022 17:26:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/firmware/tegra/bpmp.c:505:53: sparse: sparse: incorrect type
 in initializer (different base types)
Message-ID: <202207301723.oloLOHki-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e65c6a46df94c8d76ea1129eb2d4564670c6f214
commit: bd778b893963d67d7eb01f49d84ffcd3eaf229dd firmware: tegra: bpmp: Fix Tegra234-only builds
date:   1 year, 2 months ago
config: arm64-randconfig-s051-20220730 (https://download.01.org/0day-ci/archive/20220730/202207301723.oloLOHki-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bd778b893963d67d7eb01f49d84ffcd3eaf229dd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bd778b893963d67d7eb01f49d84ffcd3eaf229dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/firmware/tegra/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/tegra/bpmp.c:505:53: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] mrq @@     got restricted __le32 [usertype] @@
   drivers/firmware/tegra/bpmp.c:505:53: sparse:     expected unsigned int [usertype] mrq
   drivers/firmware/tegra/bpmp.c:505:53: sparse:     got restricted __le32 [usertype]

vim +505 drivers/firmware/tegra/bpmp.c

983de5f97169ab5 Thierry Reding 2016-08-19  502  
d78b5bde0ffc33d Timo Alho      2018-10-22  503  bool tegra_bpmp_mrq_is_supported(struct tegra_bpmp *bpmp, unsigned int mrq)
d78b5bde0ffc33d Timo Alho      2018-10-22  504  {
d78b5bde0ffc33d Timo Alho      2018-10-22 @505  	struct mrq_query_abi_request req = { .mrq = cpu_to_le32(mrq) };
d78b5bde0ffc33d Timo Alho      2018-10-22  506  	struct mrq_query_abi_response resp;
d78b5bde0ffc33d Timo Alho      2018-10-22  507  	struct tegra_bpmp_message msg = {
d78b5bde0ffc33d Timo Alho      2018-10-22  508  		.mrq = MRQ_QUERY_ABI,
d78b5bde0ffc33d Timo Alho      2018-10-22  509  		.tx = {
d78b5bde0ffc33d Timo Alho      2018-10-22  510  			.data = &req,
d78b5bde0ffc33d Timo Alho      2018-10-22  511  			.size = sizeof(req),
d78b5bde0ffc33d Timo Alho      2018-10-22  512  		},
d78b5bde0ffc33d Timo Alho      2018-10-22  513  		.rx = {
d78b5bde0ffc33d Timo Alho      2018-10-22  514  			.data = &resp,
d78b5bde0ffc33d Timo Alho      2018-10-22  515  			.size = sizeof(resp),
d78b5bde0ffc33d Timo Alho      2018-10-22  516  		},
d78b5bde0ffc33d Timo Alho      2018-10-22  517  	};
edb2bca2ac48ad5 Jon Hunter     2020-07-12  518  	int err;
d78b5bde0ffc33d Timo Alho      2018-10-22  519  
edb2bca2ac48ad5 Jon Hunter     2020-07-12  520  	err = tegra_bpmp_transfer(bpmp, &msg);
edb2bca2ac48ad5 Jon Hunter     2020-07-12  521  	if (err || msg.rx.ret)
d78b5bde0ffc33d Timo Alho      2018-10-22  522  		return false;
d78b5bde0ffc33d Timo Alho      2018-10-22  523  
d78b5bde0ffc33d Timo Alho      2018-10-22  524  	return resp.status == 0;
d78b5bde0ffc33d Timo Alho      2018-10-22  525  }
d78b5bde0ffc33d Timo Alho      2018-10-22  526  EXPORT_SYMBOL_GPL(tegra_bpmp_mrq_is_supported);
d78b5bde0ffc33d Timo Alho      2018-10-22  527  

:::::: The code at line 505 was first introduced by commit
:::::: d78b5bde0ffc33d20f014b3ad4d7aaac8b79d34e firmware: tegra: Add helper to check for supported MRQs

:::::: TO: Timo Alho <talho@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
