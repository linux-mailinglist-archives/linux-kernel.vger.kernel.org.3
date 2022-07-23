Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6657957EC15
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 06:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiGWE1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 00:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGWE1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 00:27:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D712AF6;
        Fri, 22 Jul 2022 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658550425; x=1690086425;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p32WojUus5yQvIGYicEbXPwQzncOSK5v30pgKhW98Ss=;
  b=Z0KdV5ej56RhTv7dgjmQJAps9Zq/qW9V94ZpqDF+FUWS1iHj1OgXZeF7
   sfVHID2E7h+z9Mcy1kKICW9vyUO8T//F2dqAED0wL4mhkyvqvMls6Ayz8
   QcylFNKCxWNdYOXujZ5YoBow35U0J1d3T9kWnidnrWLOWw4hBT4xZK1wK
   XZJDYTi636JJIFaYIjoJKBuBm2CEHyWM0xVYw7Emcxg3l4Ab0KN2dqLvy
   wTtJ/kdX4omfb+PozLSfnD1urHWSa3ev3KDZY0Yk/gFRGep4wX+vX+nQV
   2oVxkCwtwNY6Z1CLqB/NWoOEkUDyjSz7Xd86VYZBAEiPv/Q0zMNcRbyx4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="313179590"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="313179590"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 21:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="574399997"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2022 21:27:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oF6jG-0002GD-0j;
        Sat, 23 Jul 2022 04:27:02 +0000
Date:   Sat, 23 Jul 2022 12:26:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/media/platform/renesas/rcar_drif.c:1470:34: warning: unused
 variable 'rcar_drif_of_table'
Message-ID: <202207231223.j1VC50Wj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   70664fc10c0d722ec79d746d8ac1db8546c94114
commit: ee4a77a32b39064fdab0aa2b36bbd35ebf57e077 media: platform: place Renesas drivers on a separate dir
date:   4 months ago
config: hexagon-randconfig-r034-20220721 (https://download.01.org/0day-ci/archive/20220723/202207231223.j1VC50Wj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0c1b32717bcffcf8edf95294e98933bd4c1e76ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee4a77a32b39064fdab0aa2b36bbd35ebf57e077
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ee4a77a32b39064fdab0aa2b36bbd35ebf57e077
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/renesas/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/renesas/rcar_drif.c:1470:34: warning: unused variable 'rcar_drif_of_table' [-Wunused-const-variable]
   static const struct of_device_id rcar_drif_of_table[] = {
                                    ^
   1 warning generated.


vim +/rcar_drif_of_table +1470 drivers/media/platform/renesas/rcar_drif.c

7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1466  
7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1467  static SIMPLE_DEV_PM_OPS(rcar_drif_pm_ops, rcar_drif_suspend,
7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1468  			 rcar_drif_resume);
7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1469  
7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12 @1470  static const struct of_device_id rcar_drif_of_table[] = {
7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1471  	{ .compatible = "renesas,rcar-gen3-drif" },
7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1472  	{ }
7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1473  };
7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1474  MODULE_DEVICE_TABLE(of, rcar_drif_of_table);
7625ee981af166d drivers/media/platform/rcar_drif.c Ramesh Shanmugasundaram 2017-06-12  1475  

:::::: The code at line 1470 was first introduced by commit
:::::: 7625ee981af166ddb569e2e6c0006e2af471326f [media] media: platform: rcar_drif: Add DRIF support

:::::: TO: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
