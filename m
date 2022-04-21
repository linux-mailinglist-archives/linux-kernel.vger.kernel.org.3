Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4537F509CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387804AbiDUJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387794AbiDUJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:46:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954225E8D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650534234; x=1682070234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WH3xISqKnw04BXD66oYQGexIAP7wV/SMEV2dOxRcBQQ=;
  b=RVGGpI9DGPm3T6esUuiF0PcRCxwMFFxUVN2oJZ2XoU0BF3MgTIEOAH+j
   GAGVPzgJtxwOnxU11vdFSd7lkjuX/osH8vPOepvu+WNAXLk/RiDXdim9W
   QC0oe8AxsyfXLXJ8sG7383U+fXDgNR/6kNzpZ52ii1lUvJEA7NYUZcK8I
   pYKLx65vXn9TigqHmduVG6TzFA/irtiae5NDZFF6H9PYzvPa/vCczbpY6
   3h8vPA42WPdj2JnVVnEbMqxmAqaxy1Fsb+Z5dxIRmEtl17dR3zC8roj1x
   d/Kkn7RbUps6rrT+VqkbwK8wHwCw/+bPQd7LPWpzF/WByHTlgY2yITO0Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264063437"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264063437"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 02:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="562505181"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2022 02:43:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhTLp-0008BB-Ls;
        Thu, 21 Apr 2022 09:43:49 +0000
Date:   Thu, 21 Apr 2022 17:42:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/acpi/arm64/agdi.c:88:13: warning: no previous prototype for
 function 'acpi_agdi_init'
Message-ID: <202204211729.xRuJP9jy-lkp@intel.com>
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

Hi Ilkka,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: a2a591fb76e6f5461dfd04715b69c317e50c43a5 ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device
date:   6 weeks ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220421/202204211729.xRuJP9jy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2a591fb76e6f5461dfd04715b69c317e50c43a5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a2a591fb76e6f5461dfd04715b69c317e50c43a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/arm64/agdi.c:88:13: warning: no previous prototype for function 'acpi_agdi_init' [-Wmissing-prototypes]
   void __init acpi_agdi_init(void)
               ^
   drivers/acpi/arm64/agdi.c:88:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init acpi_agdi_init(void)
   ^
   static 
   1 warning generated.


vim +/acpi_agdi_init +88 drivers/acpi/arm64/agdi.c

    87	
  > 88	void __init acpi_agdi_init(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
