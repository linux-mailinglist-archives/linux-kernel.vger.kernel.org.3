Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3D57F203
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 01:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiGWXCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 19:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiGWXB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 19:01:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2391E1A064;
        Sat, 23 Jul 2022 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658617318; x=1690153318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uO14P5Z/HSC5LGiKTRp+TtPiWLCoSqv3tZewvl7+QkU=;
  b=a2vsvUh5jwgMxvrfYFWzD+ohCgiwyy4rYBhMxe64eC2YfiN5ZMYEGY02
   HiDuRd1Db68UPkqTOYZ1BnwjSpmC0pytstPZId2fJl3igAMa8AYcXlaKE
   FPzpCblCQ8QkwWiDPiPihmGzV7RLbhJjes3zetaDmKdIqZCG2uRxke/6Y
   WkLLnhrzvVavfTkRKM2OIxXz+AvTRA/Gtk05EqvoI7n6AaoMQ5Q99Qm/O
   mB1a8PYpsSFoktVjxL7p7iqn01AK6C6z9X303fvJslcOar4pEtqu4DFkh
   cR2AW6HO582DZQk4wZr/KrCVLtQFRIGQLfJOgmA4ALm24dbLK6USpAqXz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="286259030"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="286259030"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 16:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="775571802"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2022 16:01:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFO8B-0003CX-09;
        Sat, 23 Jul 2022 23:01:55 +0000
Date:   Sun, 24 Jul 2022 07:01:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/atmel/atmel-sama7g5-isc.c:610:34: warning:
 unused variable 'microchip_xisc_of_match'
Message-ID: <202207240637.I0U48Kcd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: c9aa973884a163ecb6d5d4d3be9137058adcaf8c media: atmel: atmel-isc: add microchip-xisc driver
date:   1 year, 1 month ago
config: hexagon-randconfig-r035-20220724 (https://download.01.org/0day-ci/archive/20220724/202207240637.I0U48Kcd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c9aa973884a163ecb6d5d4d3be9137058adcaf8c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c9aa973884a163ecb6d5d4d3be9137058adcaf8c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/atmel/

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
