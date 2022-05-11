Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F03524143
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbiEKX6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiEKX6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:58:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CB54001
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652313515; x=1683849515;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mohrSDeusi6Uu0f3QFEPYKV/c/nmAe69Za8Ruf4Me0o=;
  b=J2DK3Yfs0/MRv9FLoUgxCh7xy27yP9n2KW4p5HyuhUzy8ReWjqQmqhq7
   D5k5573dktQQ57kFnuYMG2WZVi0rSKebv4lSv2jJblq1Y7auSqswlH5Pj
   FoVeilAWxtWt88hWoxywRq2Pix7Fk0fkeio8HlZNrbWI4UlH2q7sGxi2P
   neNABVFNy8EBoTocnSdxFDX6vauAlzhdSvTUCdtAARxH6JHUA+F183uXf
   oKKZziE4CcoKt688u/2bP+HjSxD2pwsti5RWAcmeYjmK8N/4h53yIq2dw
   +bWHWhuYYxjr/BTuMvAs1vVcx6iyN2nCYJHnrSMc6mOcMn+/+RNCPkvd3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249739338"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="249739338"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 16:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="603142488"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2022 16:58:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nowDw-000JhM-6O;
        Wed, 11 May 2022 23:58:32 +0000
Date:   Thu, 12 May 2022 07:57:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 146/150]
 drivers/regulator/da9121-regulator.o: warning: objtool:
 da9121_check_device_type.constprop.0.cold()+0xd4: unreachable instruction
Message-ID: <202205120752.iz59VMBM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   305e905f70311e1b49cc730931a19c3e364f4d8c
commit: 45dc9d706619a6814e4063d5431483f94badb5a1 [146/150] x86: Add straight-line-speculation mitigation
config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120752.iz59VMBM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/45dc9d706619a6814e4063d5431483f94badb5a1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout 45dc9d706619a6814e4063d5431483f94badb5a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/ fs/ kernel// lib/ mm// net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/regulator/da9121-regulator.o: warning: objtool: da9121_check_device_type.constprop.0.cold()+0xd4: unreachable instruction
--
>> drivers/target/target_core_spc.o: warning: objtool: spc_emulate_inquiry_std()+0x2b9: unreachable instruction
--
>> drivers/ptp/ptp_clockmatrix.o: warning: objtool: _enable_pll_tod_sync()+0x36: unreachable instruction
--
>> drivers/media/v4l2-core/v4l2-ctrls-core.o: warning: objtool: std_init()+0xab: unreachable instruction
--
>> drivers/media/pci/saa7134/saa7134-cards.o: warning: objtool: saa7134_tuner_callback()+0xc4: unreachable instruction
--
>> net/core/dev.o: warning: objtool: gro_list_prepare()+0x35d: unreachable instruction
--
>> fs/ext4/super.o: warning: objtool: handle_mount_opt()+0x84: unreachable instruction
--
>> net/sched/act_mpls.o: warning: objtool: tcf_mpls_init()+0x197: unreachable instruction
--
>> net/ethtool/ioctl.o: warning: objtool: dev_ethtool()+0x177: unreachable instruction
--
>> lib/zstd/fse_decompress.o: warning: objtool: FSE_decompress_usingDTable()+0x18c: unreachable instruction
--
>> lib/zstd/huf_decompress.o: warning: objtool: HUF_decompress1X2_usingDTable_internal()+0xca: unreachable instruction
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
