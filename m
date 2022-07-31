Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384FB585FC5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiGaQW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiGaQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:22:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50580DEEF
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659284545; x=1690820545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m1mZiG8G2YBxeVkT/EYeTO7dWs34ZdOSH2Huuhy/TkY=;
  b=ei/gzRmsHiCxUF7xQ1+9WUUKmBQWt5acrjUEp3o5vBVAwIcjjHwGRpDN
   AlCTbSldS/Ov82iltVPsY/6khrN3T7kZw4sBX3HeuNxmF0ROdDmEkkaKx
   9kBXg9tNgmRyzUlbGqr3Xe9coWFoeBR1STmJAx9WWlZaQOdQiJ+oFXqWI
   b/3farEgMqgibaZ3WBvoNNPWURGMKlC87XMBCNxWhn9INAfRgY7kYKLeL
   Dyk4UUU04sPwwtmqeMcu0N9/z9d5UF7gsZAOz2hIzCS7Xgzg89xaO8bg+
   TeNPFKXwJVb0MqGzBAt7SbGr59wQbd3quYuShIHv/19fbRXYZE5aOnh36
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="353014283"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="353014283"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 09:22:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="669798559"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2022 09:22:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIBhu-000EHt-2i;
        Sun, 31 Jul 2022 16:22:22 +0000
Date:   Mon, 1 Aug 2022 00:22:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 11/15] sound/soc/apple/macaudio.c:290:3:
 sparse: sparse: symbol 'macaudio_fixed_kctls' was not declared. Should it be
 static?
Message-ID: <202208010056.ESwV1wcB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   f284fb1969531d5bcbc85cdaba483d954aafbb1f
commit: 45d56de6798e69a32c1e7b529e7849fc74ed3e66 [11/15] ASoC: Add macaudio machine driver
config: arm64-randconfig-s043-20220721 (https://download.01.org/0day-ci/archive/20220801/202208010056.ESwV1wcB-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/45d56de6798e69a32c1e7b529e7849fc74ed3e66
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 45d56de6798e69a32c1e7b529e7849fc74ed3e66
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash sound/soc/apple/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> sound/soc/apple/macaudio.c:290:3: sparse: sparse: symbol 'macaudio_fixed_kctls' was not declared. Should it be static?

vim +/macaudio_fixed_kctls +290 sound/soc/apple/macaudio.c

   286	
   287	struct fixed_kctl {
   288		char *name;
   289		char *value;	
 > 290	} macaudio_fixed_kctls[] = {
   291		{"ASI1 Sel", "Left"},
   292		{"Left ASI1 Sel", "Left"},
   293		{"Right ASI1 Sel", "Left"},
   294		{"Left Front ASI1 Sel", "Left"},
   295		{"Left Rear ASI1 Sel", "Left"},
   296		{"Right Front ASI1 Sel", "Left"},
   297		{"Right Rear ASI1 Sel", "Left"},
   298		{"Left Tweeter ASI1 Sel", "Left"},
   299		{"Left Woofer 1 ASI1 Sel", "Left"},
   300		{"Left Woofer 2 ASI1 Sel", "Left"},
   301		{"Right Tweeter ASI1 Sel", "Left"},
   302		{"Right Woofer 1 ASI1 Sel", "Left"},
   303		{"Right Woofer 2 ASI1 Sel", "Left"},
   304		{"Left ISENSE Switch", "Off"},
   305		{"Left VSENSE Switch", "Off"},
   306		{"Right ISENSE Switch", "Off"},
   307		{"Right VSENSE Switch", "Off"},
   308		{"Jack Mixer Volume", "63"},
   309		{ }
   310	};
   311	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
