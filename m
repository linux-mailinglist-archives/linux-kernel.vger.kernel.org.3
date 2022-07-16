Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16057576C31
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiGPGaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGPGaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:30:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D30913E04
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657952943; x=1689488943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BSxeApOVZnvL7IN2ly5/2Xwxn+MNXBj3EfIHjMyYEtY=;
  b=fOjxn2NtJX9161RlS6t3vbv0xlp4g/+OkBjiEgc/881SV8+1oaYhaTfX
   J3+KPRFKFigxotcz4isQJ9b54yxqwzB97FHqTtO2FcWgQKAv1nklD1yzo
   F6ghUre+2Dz+C9rNle4Ot1AiZ2lho1hHJHJpTIzeSvriWqh5dnkMafzXc
   q0No1D8O5CPoYhsr7vrI//YsFaC3jGPOo5F+XTa1RpLI1EHQ99UILKY5Y
   dWLRs55nIK8l4WGxPg1Ege/TB5O7PDeZZz7pauGKhy+B7LwMzI/V3I5uv
   EIYtcVTDKbK24EVkW9MMqgow74w7ASkyZmwrqxvu7G5/+zZ9hMfsg0P6s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="311624437"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="311624437"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 23:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="593967796"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Jul 2022 23:29:00 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCbIS-0001Da-2m;
        Sat, 16 Jul 2022 06:29:00 +0000
Date:   Sat, 16 Jul 2022 14:28:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc 15/24] f_fs.c:undefined reference to
 `wrong_size_cmpxchg'
Message-ID: <202207161421.rzT6feio-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc
head:   84a3fd7f92957f64c411595a9efcc2eed18db2be
commit: 5faed77192c5455fe17fb4e6aea87e5bcc48a13d [15/24] COVER
config: nios2-randconfig-r005-20220715 (https://download.01.org/0day-ci/archive/20220716/202207161421.rzT6feio-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/5faed77192c5455fe17fb4e6aea87e5bcc48a13d
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc
        git checkout 5faed77192c5455fe17fb4e6aea87e5bcc48a13d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/usb/gadget/function/f_fs.o: in function `__generic_cmpxchg_local':
>> f_fs.c:(.text+0x37d0): undefined reference to `wrong_size_cmpxchg'
   f_fs.c:(.text+0x37d0): relocation truncated to fit: R_NIOS2_CALL26 against `wrong_size_cmpxchg'
>> nios2-linux-ld: f_fs.c:(.text+0x3804): undefined reference to `wrong_size_cmpxchg'
   f_fs.c:(.text+0x3804): relocation truncated to fit: R_NIOS2_CALL26 against `wrong_size_cmpxchg'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
