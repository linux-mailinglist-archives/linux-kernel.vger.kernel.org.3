Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40256871C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiGFLpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiGFLpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:45:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509D228E1B;
        Wed,  6 Jul 2022 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657107903; x=1688643903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9O/uk8hzidHlOKBk1K4kxy0EkY6O5XjVCbjq4/nqvi0=;
  b=SotLaba0xgoe2w2WERUplCst6b3O4b5oDOyp2N+LyPnAjH3ggO/HJ/la
   FG+fow73VghIh5hANlsMfEJ96bXQ6SxrnfKM6o7LCDtUnXTYJhWlbc6S3
   vW82uVp/90k54fAtg0HOVnCfvUmKLXxZB4KP9ksaWWi/wcyjSdA/diiyt
   OLiniPJSVts+xKisr6pxdL45UhuuSR4NSR0ZLvdj3ORXwMftXJMlnwBm9
   DXPaSSihquyA0xYo0Y4faaZ5yfbRBRhSHSeytPmNGjkoCN+KjhY1KjnUA
   MP3vcbVuSDz25Em48rh++CMi9WxAoZw8axVTwu/w8bkNx4lkVHdj2blek
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="264141399"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="264141399"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 04:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="682890850"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2022 04:45:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o93Sm-000KXF-CP;
        Wed, 06 Jul 2022 11:45:00 +0000
Date:   Wed, 6 Jul 2022 19:44:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     kbuild-all@lists.01.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] Input: mtk-pmic-keys - Add support for MT6331
 PMIC keys
Message-ID: <202207061915.tYTQKEhu-lkp@intel.com>
References: <20220706101122.201007-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706101122.201007-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on linus/master v5.19-rc5 next-20220705]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/Input-mtk-pmic-keys-Add-support-for-MT6331-PMIC-keys/20220706-181323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: arc-randconfig-r043-20220703 (https://download.01.org/0day-ci/archive/20220706/202207061915.tYTQKEhu-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5e286347fa7c13c4674f97ed475e4f42a49ce5b4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review AngeloGioacchino-Del-Regno/Input-mtk-pmic-keys-Add-support-for-MT6331-PMIC-keys/20220706-181323
        git checkout 5e286347fa7c13c4674f97ed475e4f42a49ce5b4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/input/keyboard/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/input/keyboard/mtk-pmic-keys.c:12:10: fatal error: linux/mfd/mt6331/registers.h: No such file or directory
      12 | #include <linux/mfd/mt6331/registers.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +12 drivers/input/keyboard/mtk-pmic-keys.c

  > 12	#include <linux/mfd/mt6331/registers.h>
    13	#include <linux/mfd/mt6358/registers.h>
    14	#include <linux/mfd/mt6397/core.h>
    15	#include <linux/mfd/mt6397/registers.h>
    16	#include <linux/module.h>
    17	#include <linux/of_device.h>
    18	#include <linux/of.h>
    19	#include <linux/platform_device.h>
    20	#include <linux/regmap.h>
    21	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
