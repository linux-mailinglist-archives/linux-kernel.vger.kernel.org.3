Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558D57F28F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbiGXBfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbiGXBfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:35:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211EA440
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658626519; x=1690162519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gFG2+ggfMBZitB1FqGrTRgyNTKDHAZsdnD0n432qpCQ=;
  b=CiAjN9xXKL9/tzY8Eam3a1rkfhkjlB4wzCuPDf5Ge3YdYPaSOleSGPDA
   Y0tW8vlJWnyw1OwA6jWoBKLIMhoCE9yw9udukB20O3vgflVeb6eIyetHF
   7sJoV44nd2CA+4xQ9+HmrS39ZPg3IL5j8Es36BMEn2qcX5HYx2MoGVOcB
   9TRvBLrpFNSutUJnFaxdrdOr6J6PgVFOY/VURTUHzwo6g7TsZMUJX/m22
   kufSD9r3NczC8NiDGizInhAfEDGy+/jN1P3CXAKg2qhYnterLCTiYPxW/
   F85sj/ebAWLfpCWtiG65bQBAiN/I0JCpCM9njLh+yEhS8qnqDsRdfjn+g
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="313245570"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="313245570"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 18:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="627003458"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2022 18:35:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFQWb-0003MF-0A;
        Sun, 24 Jul 2022 01:35:17 +0000
Date:   Sun, 24 Jul 2022 09:34:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: drivers/i2c/busses/i2c-owl.c:477:34: warning: 'owl_i2c_of_match'
 defined but not used
Message-ID: <202207240951.fYqgIbOg-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: d211e62af46693f90f6386085817e22239e3fe79 i2c: Add Actions Semiconductor Owl family S900 I2C driver
date:   4 years ago
config: i386-buildonly-randconfig-r004-20220718 (https://download.01.org/0day-ci/archive/20220724/202207240951.fYqgIbOg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d211e62af46693f90f6386085817e22239e3fe79
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d211e62af46693f90f6386085817e22239e3fe79
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/i2c/busses/ drivers/mailbox/ drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-owl.c:477:34: warning: 'owl_i2c_of_match' defined but not used [-Wunused-const-variable=]
     477 | static const struct of_device_id owl_i2c_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~


vim +/owl_i2c_of_match +477 drivers/i2c/busses/i2c-owl.c

   476	
 > 477	static const struct of_device_id owl_i2c_of_match[] = {
   478		{ .compatible = "actions,s900-i2c" },
   479		{ /* sentinel */ }
   480	};
   481	MODULE_DEVICE_TABLE(of, owl_i2c_of_match);
   482	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
