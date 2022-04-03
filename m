Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8370E4F0981
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358120AbiDCMrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 08:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiDCMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:47:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9A036E00
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 05:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648989932; x=1680525932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lza4SLm00DpD/Ajx/jQG5dlTf/X0ayTjG2glEWyyGNs=;
  b=IEsjkV+2u4465vTBM/K2xTETGORSmloA1L9MY9YR+AnvYE9QqKQatNcp
   +sx0V3SILCOQP2Z+aAGQ6lq9iwwASBcGbJMOcX1EPyIe9pBeTL7T8hkxP
   L47/1JUOzb31L0EDXOy+p1FEwT37OwFScuCOOjRYOoJQh/WgM2a92XORD
   blIHbCR390LEaCSzDE2jZTr91sB4V8fpe4gc1ZA66eZNISXug2lskO5K+
   bKsGbubatIY4cxk6ky5IPY3kHWwMzXM/9WaPc2aS9B762iwHdastYZGOA
   GolZZl1vpWBv2y97F0wCFSt2CCf+YuFu9ot9XYHo8zhD/T05ehsfviXGt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="260081269"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="260081269"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 05:45:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="548353847"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Apr 2022 05:45:30 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nazbl-0000y9-ME;
        Sun, 03 Apr 2022 12:45:29 +0000
Date:   Sun, 3 Apr 2022 20:45:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allen Chen <allen.chen@ite.com.tw>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: .tmp_gl_ite-it6505.o:undefined reference to `drm_dp_aux_unregister'
Message-ID: <202204032015.EG0gZxja-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
commit: b5c84a9edcd418cd055becad6a22439e7c5e3bf8 drm/bridge: add it6505 driver
date:   9 weeks ago
config: microblaze-randconfig-r032-20220403 (https://download.01.org/0day-ci/archive/20220403/202204032015.EG0gZxja-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5c84a9edcd418cd055becad6a22439e7c5e3bf8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b5c84a9edcd418cd055becad6a22439e7c5e3bf8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_i2c_remove':
>> .tmp_gl_ite-it6505.o:(.text+0x4cc): undefined reference to `drm_dp_aux_unregister'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_bridge_attach':
>> .tmp_gl_ite-it6505.o:(.text+0x994): undefined reference to `drm_dp_aux_register'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `step_train_lane_voltage_para_set':
>> .tmp_gl_ite-it6505.o:(.text+0x1308): undefined reference to `drm_dp_dpcd_write'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x1334): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_irq_scdt':
   .tmp_gl_ite-it6505.o:(.text+0x2068): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_video_reset':
   .tmp_gl_ite-it6505.o:(.text+0x247c): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_setup_sha1_input':
>> .tmp_gl_ite-it6505.o:(.text+0x31a0): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x32dc): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_step_cr_train':
   .tmp_gl_ite-it6505.o:(.text+0x4040): undefined reference to `drm_dp_dpcd_write'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x406c): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x40dc): undefined reference to `drm_dp_dpcd_write'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x4174): undefined reference to `drm_dp_link_train_clock_recovery_delay'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x4184): undefined reference to `drm_dp_dpcd_read_link_status'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x4194): undefined reference to `drm_dp_clock_recovery_ok'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x4240): undefined reference to `drm_dp_get_adjust_request_voltage'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x4254): undefined reference to `drm_dp_get_adjust_request_pre_emphasis'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_link_training_setup':
   .tmp_gl_ite-it6505.o:(.text+0x4738): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x4808): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_parse_link_capabilities':
>> .tmp_gl_ite-it6505.o:(.text+0x652c): undefined reference to `drm_dp_link_rate_to_bw_code'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x671c): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x6964): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_detect':
   .tmp_gl_ite-it6505.o:(.text+0x6ab4): undefined reference to `drm_dp_dpcd_read'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x6acc): undefined reference to `drm_dp_bw_code_to_link_rate'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x6b2c): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x6d10): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x6d40): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x6d80): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_irq_hpd':
   .tmp_gl_ite-it6505.o:(.text+0x719c): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_hdcp_wait_ksv_list':
   .tmp_gl_ite-it6505.o:(.text+0x74c0): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x75d4): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_process_hpd_irq':
   .tmp_gl_ite-it6505.o:(.text+0x784c): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x78bc): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7940): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7974): undefined reference to `drm_dp_dpcd_read_link_status'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x79b0): undefined reference to `drm_dp_channel_eq_ok'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_step_eq_train':
   .tmp_gl_ite-it6505.o:(.text+0x7d18): undefined reference to `drm_dp_dpcd_write'
>> microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7d70): undefined reference to `drm_dp_link_train_channel_eq_delay'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7d80): undefined reference to `drm_dp_dpcd_read_link_status'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7d90): undefined reference to `drm_dp_clock_recovery_ok'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7da8): undefined reference to `drm_dp_channel_eq_ok'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7de4): undefined reference to `drm_dp_get_adjust_request_voltage'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7df8): undefined reference to `drm_dp_get_adjust_request_pre_emphasis'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7e78): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x7eec): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_link_step_train_process':
   .tmp_gl_ite-it6505.o:(.text+0x808c): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x80fc): undefined reference to `drm_dp_dpcd_write'
   microblaze-linux-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_hdcp_work':
>> .tmp_gl_ite-it6505.o:(.text+0x9ba0): undefined reference to `drm_dp_dpcd_read_link_status'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x9bdc): undefined reference to `drm_dp_channel_eq_ok'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x9c90): undefined reference to `drm_dp_dpcd_read'
   microblaze-linux-ld: .tmp_gl_ite-it6505.o:(.text+0x9dd4): undefined reference to `drm_dp_dpcd_read'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
