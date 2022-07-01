Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7444562E88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiGAIkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiGAIkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:40:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48670E44
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656664835; x=1688200835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yNbLeOU8ZncDWv6Jreaj3wNMxmSS4ObZi6ZL7+WXThM=;
  b=k7LvG96yPLDKA92qxDIkLDvQMVYDn3taB12R/LhVr31BSIET4iJ5wzMK
   ijerpH2eu+E9x5dkki4SYMe8vIzqyQRuPu1BpNIK0QSsZSTUgwyicwrsZ
   VWLUVhmkXPStDBWEcx9xQ0/4wySx7Oc9VFwrQO7zYyETw3xaw4su8zLRp
   gM7MLKoKFmz99YqPkWC4lsG6c331tpzDZ5q0pwBTkgQApfkbVj/fa68+m
   EhOWn0xCN0bhLiRcR90H7yfz2zhP0rIUG6+KCQPB9G9+RsLrlq0bz4QeT
   y2CiC/IzsLLkpDNiTCg/srvYsgog22kTa+iUKm//rKfJnIwU5rA1KUDuP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="308106124"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="308106124"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="694429019"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2022 01:40:34 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7CCX-000Dkk-Q1;
        Fri, 01 Jul 2022 08:40:33 +0000
Date:   Fri, 1 Jul 2022 16:39:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/050-nvme 8/10] drivers/soc/apple/rtkit.c:665:9:
 error: call to undeclared function 'mbox_client_poll_data'; ISO C99 and
 later do not support implicit function declarations
Message-ID: <202207011600.x6cjbQ0z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

FYI, the error/warning still remains.

tree:   https://github.com/AsahiLinux/linux bits/050-nvme
head:   5b3910635863df45900af347c932d5468e7541fc
commit: ecb1172a9cbf4c3ad18fa5c259380a116c2f00e6 [8/10] soc: apple: rtkit: Add apple_rtkit_poll
config: arm64-randconfig-r001-20220629 (https://download.01.org/0day-ci/archive/20220701/202207011600.x6cjbQ0z-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/ecb1172a9cbf4c3ad18fa5c259380a116c2f00e6
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/050-nvme
        git checkout ecb1172a9cbf4c3ad18fa5c259380a116c2f00e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/apple/rtkit.c:665:9: error: call to undeclared function 'mbox_client_poll_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return mbox_client_poll_data(rtk->mbox_chan);
                  ^
   drivers/soc/apple/rtkit.c:665:9: note: did you mean 'mbox_client_peek_data'?
   include/linux/mailbox_client.h:46:6: note: 'mbox_client_peek_data' declared here
   bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
        ^
   1 error generated.


vim +/mbox_client_poll_data +665 drivers/soc/apple/rtkit.c

   662	
   663	int apple_rtkit_poll(struct apple_rtkit *rtk)
   664	{
 > 665		return mbox_client_poll_data(rtk->mbox_chan);
   666	}
   667	EXPORT_SYMBOL_GPL(apple_rtkit_poll);
   668	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
