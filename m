Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAD528D07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbiEPS3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344948AbiEPS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:29:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA4F3EA92
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652725746; x=1684261746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yhh8Cx5O7qRBIB3057P0bgz78ubgQpZ9gqj4BRCdavE=;
  b=KwmfklKBEEiuGSy7Uv1G5Gr6tHNDSmcD47pzhZSc8bdCaCyNIYUVzhVm
   mJcsi3Px3UFV4jebc2mrHRa7iU3IDRQl5MswynEfGa5WS9dDPRBvdA/6d
   2Z6j/SLMaov1J/V5vLwYrdkrEalrAXr+vhjFhqXAeOikZtPr5V1A4fXbz
   c60zmGr6rJUwtZKJBCtiuTq6YHRSOqRQawNbB9TyqlohCNU3/+I4sgl5R
   u9zaM5XO3YyjtDgOGp5chAalHQiYvWFWrKsEV6rFeMvemIac+jn6k1ZBZ
   PjPz4VrhrgXMul3ik0kA+bz9Ow5H3O1Yf3WqXqy74NsJLhZJ6uo7GlhTo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="258488512"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="258488512"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 11:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="604975389"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 May 2022 11:28:42 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqfSU-0000Ft-07;
        Mon, 16 May 2022 18:28:42 +0000
Date:   Tue, 17 May 2022 02:28:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 6458/6574]
 arch/x86/events/intel/uncore_nhmex.o: warning: objtool:
 nhmex_rbox_msr_enable_event()+0x89: unreachable instruction
Message-ID: <202205170256.mknqzhrd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   cbfc4f42bd5fbf033342ee467c5614254167e3a8
commit: 370d33da35e31c1544eb77bcf2539f09b1064b9c [6458/6574] x86: Add straight-line-speculation mitigation
config: x86_64-randconfig-a015-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170256.mknqzhrd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=370d33da35e31c1544eb77bcf2539f09b1064b9c
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 370d33da35e31c1544eb77bcf2539f09b1064b9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/ drivers/ fs/ net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/events/intel/uncore_nhmex.o: warning: objtool: nhmex_rbox_msr_enable_event()+0x89: unreachable instruction
--
>> drivers/regulator/max8998.o: warning: objtool: max8998_get_voltage_register()+0x58: unreachable instruction
--
>> drivers/regulator/qcom_spmi-regulator.o: warning: objtool: spmi_regulator_of_parse()+0x396: unreachable instruction
--
>> drivers/regulator/tps65910-regulator.o: warning: objtool: tps65911_get_voltage_sel()+0x83: unreachable instruction
--
>> drivers/nfc/nfcmrvl/fw_dnld.o: warning: objtool: fw_dnld_rx_work()+0xa5: unreachable instruction
--
>> net/netrom/af_netrom.o: warning: objtool: nr_getsockopt()+0xdf: unreachable instruction
--
>> net/netrom/nr_in.o: warning: objtool: nr_state3_machine()+0xa6: unreachable instruction
--
>> fs/fuse/dev.o: warning: objtool: fuse_notify()+0x50: unreachable instruction
--
>> fs/fuse/inode.o: warning: objtool: fuse_parse_param()+0x12c: unreachable instruction
--
>> net/ax25/af_ax25.o: warning: objtool: ax25_getsockopt()+0x109: unreachable instruction
--
>> net/can/raw.o: warning: objtool: raw_getsockopt()+0xc0: unreachable instruction
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
