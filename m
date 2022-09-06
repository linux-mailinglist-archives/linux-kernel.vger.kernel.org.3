Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2CB5AF63E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiIFUju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIFUjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:39:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8493A186DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662496786; x=1694032786;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rExLlN3V5QG+V48IGEwb2e3lGFTG2oeVWSO5sqImoY4=;
  b=VOOtgMmb7FVBPj4VRiQikpDOlXO6gtqiFLpvxCMCRig3O4ShH6rQ6hyR
   pQ0fICwYH4DfWSYJk5ss/Wdbjc8Kqag+aIoOrKSW0IZYf8jn8T7Sptp+M
   bMXrKjT05KhjFu65szpJ0/3JUg6PQn7nRnGkozmDJk4cM9FfhEma9m/7m
   SahngyXus0Sht+a5nlWxMIdLUaYl0cRRPVh+xoSVRtb3cXzWp+V6LszC1
   buGC3mtCDK33aJPvvIaFlfY8Q2tEgvsZy9hFuA6GbBqkfSbCnCpaTZpWc
   ketYGm5IZKx8PLwdssxNbTJ8JK8rNwZWDZ+3/Ph5C3EknCz2ctHJRwZcB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297485246"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="297485246"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:39:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="591412602"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2022 13:39:44 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVfMF-0005b3-2z;
        Tue, 06 Sep 2022 20:39:43 +0000
Date:   Wed, 7 Sep 2022 04:38:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/reset/reset-ti-sci.c:229: undefined reference to
 `devm_ti_sci_get_handle'
Message-ID: <202209070451.QaOZq6Qu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53e99dcff61e1523ec1c3628b2d564ba15d32eb7
commit: a6af504184c981efd253f986e6fc54db57b1d39f reset: ti-sci: Allow building under COMPILE_TEST
date:   5 months ago
config: arm-randconfig-c042-20220906 (https://download.01.org/0day-ci/archive/20220907/202209070451.QaOZq6Qu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a6af504184c981efd253f986e6fc54db57b1d39f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a6af504184c981efd253f986e6fc54db57b1d39f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/reset/reset-ti-sci.o: in function `ti_sci_reset_probe':
>> drivers/reset/reset-ti-sci.c:229: undefined reference to `devm_ti_sci_get_handle'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +229 drivers/reset/reset-ti-sci.c

28df169b9afa12 Andrew F. Davis 2017-05-24  217  
28df169b9afa12 Andrew F. Davis 2017-05-24  218  static int ti_sci_reset_probe(struct platform_device *pdev)
28df169b9afa12 Andrew F. Davis 2017-05-24  219  {
28df169b9afa12 Andrew F. Davis 2017-05-24  220  	struct ti_sci_reset_data *data;
28df169b9afa12 Andrew F. Davis 2017-05-24  221  
28df169b9afa12 Andrew F. Davis 2017-05-24  222  	if (!pdev->dev.of_node)
28df169b9afa12 Andrew F. Davis 2017-05-24  223  		return -ENODEV;
28df169b9afa12 Andrew F. Davis 2017-05-24  224  
28df169b9afa12 Andrew F. Davis 2017-05-24  225  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
28df169b9afa12 Andrew F. Davis 2017-05-24  226  	if (!data)
28df169b9afa12 Andrew F. Davis 2017-05-24  227  		return -ENOMEM;
28df169b9afa12 Andrew F. Davis 2017-05-24  228  
28df169b9afa12 Andrew F. Davis 2017-05-24 @229  	data->sci = devm_ti_sci_get_handle(&pdev->dev);
28df169b9afa12 Andrew F. Davis 2017-05-24  230  	if (IS_ERR(data->sci))
28df169b9afa12 Andrew F. Davis 2017-05-24  231  		return PTR_ERR(data->sci);
28df169b9afa12 Andrew F. Davis 2017-05-24  232  
28df169b9afa12 Andrew F. Davis 2017-05-24  233  	data->rcdev.ops = &ti_sci_reset_ops;
28df169b9afa12 Andrew F. Davis 2017-05-24  234  	data->rcdev.owner = THIS_MODULE;
28df169b9afa12 Andrew F. Davis 2017-05-24  235  	data->rcdev.of_node = pdev->dev.of_node;
28df169b9afa12 Andrew F. Davis 2017-05-24  236  	data->rcdev.of_reset_n_cells = 2;
28df169b9afa12 Andrew F. Davis 2017-05-24  237  	data->rcdev.of_xlate = ti_sci_reset_of_xlate;
28df169b9afa12 Andrew F. Davis 2017-05-24  238  	data->dev = &pdev->dev;
28df169b9afa12 Andrew F. Davis 2017-05-24  239  	idr_init(&data->idr);
28df169b9afa12 Andrew F. Davis 2017-05-24  240  
28df169b9afa12 Andrew F. Davis 2017-05-24  241  	platform_set_drvdata(pdev, data);
28df169b9afa12 Andrew F. Davis 2017-05-24  242  
28df169b9afa12 Andrew F. Davis 2017-05-24  243  	return reset_controller_register(&data->rcdev);
28df169b9afa12 Andrew F. Davis 2017-05-24  244  }
28df169b9afa12 Andrew F. Davis 2017-05-24  245  

:::::: The code at line 229 was first introduced by commit
:::::: 28df169b9afa121153ef2a3ef4ceae72512cde6d reset: Add the TI SCI reset driver

:::::: TO: Andrew F. Davis <afd@ti.com>
:::::: CC: Philipp Zabel <p.zabel@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
