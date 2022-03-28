Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE174E9003
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbiC1IWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbiC1IWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:22:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD6153A5D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648455643; x=1679991643;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X/ujBVMAf8bxk2V6GI32GPU9XNz0mDme+92j35t6tB4=;
  b=DpQTLhXdPbp7ICihLu3eCOqtAfgOMk4QmiT7BuNP2dWRQhWok0S0zxSV
   yhzPZumIdfH4HazYktm8W9t+dpng5k+AYifl3xtW79F1zXpn2Tb4M4yXy
   aStrgXFxxiG2PgyHgRdylVTsie0WuGzaf8oxcIAF9xhOBJtV0pQ4UbV1C
   3vb11kfjq684WgGG0Z3fzfDIEUeqIB4uhTwHu7Cq5wzPfLplyS5brk6re
   SSEhXIH5o6sMMXgLwfLka8cZSXLtp1RFMaWO02jG29WTws30p+MxzvMpn
   qQD6KLWYYR+clJwPD/YushhXTe62x+/oQLs4m0sOpaSYGdGzvM+GAjf6j
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="259129827"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="259129827"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 01:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="563435784"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 28 Mar 2022 01:20:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYkcC-0001sL-HP; Mon, 28 Mar 2022 08:20:40 +0000
Date:   Mon, 28 Mar 2022 16:20:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-amd.c:296:21: warning: cast to smaller integer type
 'enum amd_spi_versions' from 'const void *'
Message-ID: <202203281638.pWQ7vWbp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi André,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: 209043554915d7c51ac112a668ad1a255e1bea61 spi: amd: Add support for version AMDI0062
date:   6 weeks ago
config: x86_64-randconfig-a011-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281638.pWQ7vWbp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=209043554915d7c51ac112a668ad1a255e1bea61
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 209043554915d7c51ac112a668ad1a255e1bea61
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-amd.c:296:21: warning: cast to smaller integer type 'enum amd_spi_versions' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           amd_spi->version = (enum amd_spi_versions) device_get_match_data(dev);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +296 drivers/spi/spi-amd.c

   272	
   273	static int amd_spi_probe(struct platform_device *pdev)
   274	{
   275		struct device *dev = &pdev->dev;
   276		struct spi_master *master;
   277		struct amd_spi *amd_spi;
   278		int err = 0;
   279	
   280		/* Allocate storage for spi_master and driver private data */
   281		master = spi_alloc_master(dev, sizeof(struct amd_spi));
   282		if (!master) {
   283			dev_err(dev, "Error allocating SPI master\n");
   284			return -ENOMEM;
   285		}
   286	
   287		amd_spi = spi_master_get_devdata(master);
   288		amd_spi->io_remap_addr = devm_platform_ioremap_resource(pdev, 0);
   289		if (IS_ERR(amd_spi->io_remap_addr)) {
   290			err = PTR_ERR(amd_spi->io_remap_addr);
   291			dev_err(dev, "error %d ioremap of SPI registers failed\n", err);
   292			goto err_free_master;
   293		}
   294		dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
   295	
 > 296		amd_spi->version = (enum amd_spi_versions) device_get_match_data(dev);
   297	
   298		/* Initialize the spi_master fields */
   299		master->bus_num = 0;
   300		master->num_chipselect = 4;
   301		master->mode_bits = 0;
   302		master->flags = SPI_MASTER_HALF_DUPLEX;
   303		master->setup = amd_spi_master_setup;
   304		master->transfer_one_message = amd_spi_master_transfer;
   305	
   306		/* Register the controller with SPI framework */
   307		err = devm_spi_register_master(dev, master);
   308		if (err) {
   309			dev_err(dev, "error %d registering SPI controller\n", err);
   310			goto err_free_master;
   311		}
   312	
   313		return 0;
   314	
   315	err_free_master:
   316		spi_master_put(master);
   317	
   318		return err;
   319	}
   320	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
