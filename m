Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BA559CFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiHWELc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiHWELa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:11:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504458537
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661227889; x=1692763889;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kIniq2gMsd4t/dzZOBa0ZSAI/IfeA9ECNffGoHZEh+U=;
  b=FoSq0LgJvkmmsCA1QdJvjc1ltR96mVvWVZJK71lmpnN/al6hDSk6zPWH
   f5JuSDbOUG5lu/epD1iy2nudETnZjH2qbYreFYG3ZGEzwyXkd24HgWgFT
   W0dys1YWhwOX2fi42Uc2BjhLMKpu9gEmS8Q/elgP2JSRbYLKUPHB6suaM
   23k+xc/LT9eHvFnR9+VUqfBC9ofqj50JZLmSX3qBzxZGB+pA36Fh6CEa+
   TwByz2+VDhkWzEAYS2tgPf9FJp+GHzP31Yd5UAWBj8XzP4b8o9vU4tk49
   RFGDptxN08QFVBUfkDPfp4qtal/0lR+CgZdbC4rOtUuh24kkRNjVEcFVZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="292327538"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="292327538"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="638488195"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2022 21:11:28 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQLGB-00019r-1B;
        Tue, 23 Aug 2022 04:11:27 +0000
Date:   Tue, 23 Aug 2022 12:10:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:pr/46 28/34] sound/soc/codecs/tas2764.c:647:34: warning:
 array 'tas2764_of_match' assumed to have one element
Message-ID: <202208231248.bx78rX6E-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux pr/46
head:   5952de58993c87e5e5797ac37ef4f7364ac5ef37
commit: a29452b8c6f8d669e74cb8ae15d77d1a9a4bb261 [28/34] ASoC: tas2764: Extend driver to SN012776
config: ia64-randconfig-r016-20220821 (https://download.01.org/0day-ci/archive/20220823/202208231248.bx78rX6E-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/a29452b8c6f8d669e74cb8ae15d77d1a9a4bb261
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/46
        git checkout a29452b8c6f8d669e74cb8ae15d77d1a9a4bb261
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tas2764.c:647:34: warning: array 'tas2764_of_match' assumed to have one element
     647 | static const struct of_device_id tas2764_of_match[];
         |                                  ^~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
   Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
   Selected by [y]:
   - QCOM_RPMPD [=y] && PM [=y] && QCOM_SMD_RPM [=y]


vim +/tas2764_of_match +647 sound/soc/codecs/tas2764.c

   646	
 > 647	static const struct of_device_id tas2764_of_match[];
   648	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
