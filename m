Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC35A4ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiH2OIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiH2OIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:08:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3361F83F2A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661782122; x=1693318122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YL6LPmNpRLPRwpVKKeFWCKEvrSsVCE6CGzczMgVm3Es=;
  b=P4AFbNs0QwfvD084vZI9u6da++HAVTNWWMjDMMSaCqioye03hH1H/nCO
   uQkk4OX8lO8jGrM4ABaKJmgpCfBphG6SVGoG47PVTydW65Iu903iU3DhC
   NxhMFdAacyhT0qscwQiS7m3eSEWxmGzR5jz3gETXPb3Vmpyc1vmMTX/NW
   SQhX8oboyNFatXDbIaDkOWy0dYsWtyGdj0Vz2Fmii5LNysp2wg8LpRn+d
   lIcVMPYQwiVQ/ZuJ9U9MMk2ravuGHdzR6JXf8pZcK6xFS6O7ot6N3CTUr
   aV33vxX+SdUxkD9RMFCX/NOY18gEAirttwbMXztzi9Uy8C7ne1qM5j83H
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="275303378"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="275303378"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="714877613"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2022 07:05:39 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSfOU-00002l-2u;
        Mon, 29 Aug 2022 14:05:38 +0000
Date:   Mon, 29 Aug 2022 22:04:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vitaly Rodionov <vitaly.rodionov@cirrus.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: sound/pci/hda/cs35l41_hda.c:323:15: sparse: sparse: cast to
 restricted __be32
Message-ID: <202208292243.9xMDeXpd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b90cb1053190353cc30f0fef0ef1f378ccc063c5
commit: 2e81e1fffd53ba108481f2f14388b628884efe61 ALSA: hda: cs35l41: Add initial DSP support and firmware loading
date:   7 weeks ago
config: x86_64-randconfig-s022-20220829 (https://download.01.org/0day-ci/archive/20220829/202208292243.9xMDeXpd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2e81e1fffd53ba108481f2f14388b628884efe61
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2e81e1fffd53ba108481f2f14388b628884efe61
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> sound/pci/hda/cs35l41_hda.c:323:15: sparse: sparse: cast to restricted __be32
>> sound/pci/hda/cs35l41_hda.c:323:15: sparse: sparse: cast to restricted __be32

vim +323 sound/pci/hda/cs35l41_hda.c

   299	
   300	static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
   301	{
   302		int halo_sts;
   303		int ret;
   304	
   305		ret = cs35l41_init_dsp(cs35l41);
   306		if (ret) {
   307			dev_warn(cs35l41->dev, "Cannot Initialize Firmware. Error: %d\n", ret);
   308			goto clean_dsp;
   309		}
   310	
   311		ret = cs35l41_write_fs_errata(cs35l41->dev, cs35l41->regmap);
   312		if (ret) {
   313			dev_err(cs35l41->dev, "Cannot Write FS Errata: %d\n", ret);
   314			goto clean_dsp;
   315		}
   316	
   317		ret = cs_dsp_run(&cs35l41->cs_dsp);
   318		if (ret) {
   319			dev_err(cs35l41->dev, "Fail to start dsp: %d\n", ret);
   320			goto clean_dsp;
   321		}
   322	
 > 323		ret = read_poll_timeout(hda_cs_dsp_read_ctl, ret,
   324					be32_to_cpu(halo_sts) == HALO_STATE_CODE_RUN,
   325					1000, 15000, false, &cs35l41->cs_dsp, HALO_STATE_DSP_CTL_NAME,
   326					HALO_STATE_DSP_CTL_TYPE, HALO_STATE_DSP_CTL_ALG,
   327					&halo_sts, sizeof(halo_sts));
   328	
   329		if (ret) {
   330			dev_err(cs35l41->dev, "Timeout waiting for HALO Core to start. State: %d\n",
   331				 halo_sts);
   332			goto clean_dsp;
   333		}
   334	
   335		cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap, CSPL_MBOX_CMD_PAUSE);
   336		cs35l41->firmware_running = true;
   337	
   338		return 0;
   339	
   340	clean_dsp:
   341		cs35l41_shutdown_dsp(cs35l41);
   342		return ret;
   343	}
   344	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
