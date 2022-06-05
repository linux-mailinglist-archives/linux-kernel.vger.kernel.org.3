Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7600753DB2B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350992AbiFEJ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350975AbiFEJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:58:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D41412AE6;
        Sun,  5 Jun 2022 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654423124; x=1685959124;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CHtMVrgGKAU2RSmUy/mOnpfdRd709kBQ96y+3DfCz/o=;
  b=J+3R3JZPHRDT/W1udugebkjMFRzDRJt0j9oNslm5ceZER5QAbej1SwOF
   okog7slQ1qJBgMPymiXVSEPSZZLxpteYd4jO8uf0qBfXTB5E1Q4Ef7yQV
   sFjnt6+l9ss7jVj9lOvbI/bqhV+5QME7D9VZT3lGfXs7yQDsyxOVESM5E
   +kmvqmUsQ3GZK1sD68E0uhQkk4OyZHM3lIQ/+/hziVPgIZUIrl8ZQcC7c
   TCOgM0RtJJU6TAg9ZR39NLbzImsak00ZveoR9AHxrUsQHO7cZSS9yxOSb
   o4dcIedGOpxtQXGJio/2wbfgYqgUAYIwHPiRmQD/dNYct+lm3dosT89T2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="275344913"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="275344913"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 02:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="708634502"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2022 02:58:42 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxn1t-000BrZ-K1;
        Sun, 05 Jun 2022 09:58:41 +0000
Date:   Sun, 5 Jun 2022 17:57:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/atmel/atmel-sama7g5-isc.c:610:34: warning:
 unused variable 'microchip_xisc_of_match'
Message-ID: <202206051703.38nNx3IB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   952923ddc01120190dcf671e7b354364ce1d1362
commit: c9aa973884a163ecb6d5d4d3be9137058adcaf8c media: atmel: atmel-isc: add microchip-xisc driver
date:   12 months ago
config: hexagon-buildonly-randconfig-r002-20220605 (https://download.01.org/0day-ci/archive/20220605/202206051703.38nNx3IB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 416a5080d89066029f9889dc23f94de47c2fa895)
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
