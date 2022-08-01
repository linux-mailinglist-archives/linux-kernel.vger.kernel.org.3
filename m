Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27764586E85
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiHAQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiHAQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:26:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E92A71C;
        Mon,  1 Aug 2022 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659371200; x=1690907200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VMXo5DjiwiqtT6m271eeEopcmaYvEvxFlvUT6ghUWRk=;
  b=Fs+RgYbMQNQOpg8TfA/66pruilouOFfwPIaeRRYWd5bm2g/t0QAkyoyn
   N3LL/A55GZ2JSCoMyd2mrYPvib1Meb7ezbBb1b5c/jzH4Nl998Pf27faD
   gzI4UEUkm0Bz4CA2vDmkUNdPgWxB2hr3ipQvcKV5k7/h7+Kh+Lqa4tLPe
   MWmR5O1mcmwM5lnAP0aED78wVR4ZH5hBhxdMDYbAR4KQ8SkD8r5liJgUx
   4soU2qM2I77liGtsTVcRm+XbLdGp6PKUZ7oAtVtQBcxYOTy4WHC5Ow+PI
   UrnmCC7QUEg02ORjQ9gpdmtKRKpKIpALyEM5O8+CfDEG+VJBhivjl9JUb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290400537"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="290400537"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="929618108"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2022 09:26:37 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIYFZ-000F9b-0N;
        Mon, 01 Aug 2022 16:26:37 +0000
Date:   Tue, 2 Aug 2022 00:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/atmel/atmel-sama7g5-isc.c:610:34: warning:
 unused variable 'microchip_xisc_of_match'
Message-ID: <202208020021.8hfala2O-lkp@intel.com>
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

Hi Eugen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d7cb6b04c3f3115719235cc6866b10326de34cd
commit: c9aa973884a163ecb6d5d4d3be9137058adcaf8c media: atmel: atmel-isc: add microchip-xisc driver
date:   1 year, 2 months ago
config: mips-randconfig-r024-20220731 (https://download.01.org/0day-ci/archive/20220802/202208020021.8hfala2O-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c9aa973884a163ecb6d5d4d3be9137058adcaf8c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c9aa973884a163ecb6d5d4d3be9137058adcaf8c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/platform/atmel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/atmel/atmel-sama7g5-isc.c:610:34: warning: unused variable 'microchip_xisc_of_match' [-Wunused-const-variable]
   static const struct of_device_id microchip_xisc_of_match[] = {
                                    ^
   1 warning generated.


vim +/microchip_xisc_of_match +610 drivers/media/platform/atmel/atmel-sama7g5-isc.c

   609	
 > 610	static const struct of_device_id microchip_xisc_of_match[] = {
   611		{ .compatible = "microchip,sama7g5-isc" },
   612		{ }
   613	};
   614	MODULE_DEVICE_TABLE(of, microchip_xisc_of_match);
   615	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
