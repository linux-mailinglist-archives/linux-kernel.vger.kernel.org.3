Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E775ACF95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbiIEKH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiIEKHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:07:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEF193EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662372431; x=1693908431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HPt3jPuMljFnT1HwUVeRYiZPN24kNujUVy3j7fR1Br8=;
  b=bAau8P5WudKic+KddS/YXMDGBHGIKhoAWKkAuXM/hfQiCb3AI/YoAw50
   cATWfTsfAgXyvzN+BqaYvVDn/hGcGzw/B4kJipBBEHJKPoXi+GwDkLH8k
   AiMqVJZqu8ZDEQZT5L/etNM1frCZz4DYiICionHBtrN1fs4/mTO2o2fum
   nf6p6tcflNzIBJ3xHqIyDarUi9QUTCHfVJiy0SKjYSHfJmqZEr7oNvB7U
   hnyJipHlUBiWFe0knapauxQbn1P3K11d/xFmnm0PkgaNC2GjivGEvjP8R
   pJi8mQDPU5DJTrubP69ca28iqM3XzbJpYKWDm+FfpA49ba8cwGXoCl0Nq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="382654392"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="382654392"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 03:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="682010011"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2022 03:07:10 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV90X-000425-10;
        Mon, 05 Sep 2022 10:07:09 +0000
Date:   Mon, 5 Sep 2022 18:06:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tiwai/sound/master 42/45]
 sound/pci/hda/patch_sigmatel.c:4450:24: warning: unused variable 'spec'
Message-ID: <202209051729.qu4hSOAb-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block tiwai/sound/master
head:   a6c91e26b44722382fb45d782d25d9ed77bbb184
commit: 414d38ba871092aeac4ed097ac4ced89486646f7 [42/45] ALSA: hda/sigmatel: Keep power up while beep is enabled
config: x86_64-randconfig-a014-20220905 (https://download.01.org/0day-ci/archive/20220905/202209051729.qu4hSOAb-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/414d38ba871092aeac4ed097ac4ced89486646f7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tiwai/sound/master
        git checkout 414d38ba871092aeac4ed097ac4ced89486646f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/pci/hda/patch_sigmatel.c:4450:24: warning: unused variable 'spec' [-Wunused-variable]
           struct sigmatel_spec *spec = codec->spec;
                                 ^
   1 warning generated.


vim +/spec +4450 sound/pci/hda/patch_sigmatel.c

  4447	
  4448	static int stac_check_power_status(struct hda_codec *codec, hda_nid_t nid)
  4449	{
> 4450		struct sigmatel_spec *spec = codec->spec;
  4451		int ret = snd_hda_gen_check_power_status(codec, nid);
  4452	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
