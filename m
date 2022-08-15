Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD8592852
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiHOD5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiHOD5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:57:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064FCBCB3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660535852; x=1692071852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YG16vjBnfqBbNTU/hzk6wALQfbQIM1s78gGFIPQZuXg=;
  b=Dyjvd4moVVAhSnUZV7rYfJAh7b/MWPUyBxEHKXl+A5bzJO97O3k2TiB2
   u589boK/N/JnWEZjhEKtJiu7J2wztc+FA6UDj7hxTUawl51c6HDB2mPRt
   xcQXucxVssXCTDUBoSvAkfzyyXmGBBgQgiY+G1KR20ighquHk5AdWnqBd
   KZehQkRSxNX2T/c38pgF6YqR8IHKrGtO5zwdBeThqa4Q/Uq2SvIgjRNO4
   LmlqlqJr/asDbOUt8FquVZAjEqOyBIHSbAaWqn7b1pfiFNpaHJKa592w0
   D9AnpybpzKIohazlOY7h7Rl2CskfLDv2ZDV0vZC4e8nvjHKiYvcBIVh/s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="289454108"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="289454108"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 20:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="674714191"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2022 20:57:29 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNREE-0000kI-10;
        Mon, 15 Aug 2022 03:57:26 +0000
Date:   Mon, 15 Aug 2022 11:56:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tristram Ha <Tristram.Ha@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        George McCollister <george.mccollister@gmail.com>
Subject: drivers/net/dsa/microchip/ksz9477_i2c.c:77:34: warning:
 'ksz9477_dt_ids' defined but not used
Message-ID: <202208151149.g01fvM7O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: 20e03777d70923fe7eae0d7f043ef9488393ab95 net: dsa: microchip: add KSZ9477 I2C driver
date:   2 years, 11 months ago
config: x86_64-buildonly-randconfig-r002-20220815 (https://download.01.org/0day-ci/archive/20220815/202208151149.g01fvM7O-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=20e03777d70923fe7eae0d7f043ef9488393ab95
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 20e03777d70923fe7eae0d7f043ef9488393ab95
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/platform/ drivers/net/dsa/microchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/microchip/ksz9477_i2c.c:77:34: warning: 'ksz9477_dt_ids' defined but not used [-Wunused-const-variable=]
      77 | static const struct of_device_id ksz9477_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~


vim +/ksz9477_dt_ids +77 drivers/net/dsa/microchip/ksz9477_i2c.c

    76	
  > 77	static const struct of_device_id ksz9477_dt_ids[] = {
    78		{ .compatible = "microchip,ksz9477" },
    79		{ .compatible = "microchip,ksz9897" },
    80		{},
    81	};
    82	MODULE_DEVICE_TABLE(of, ksz9477_dt_ids);
    83	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
