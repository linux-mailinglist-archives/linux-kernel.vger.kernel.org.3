Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809E6585F1F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 15:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiGaN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGaN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:29:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA9DF5A0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659274171; x=1690810171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1D11l667QaXwyTK6Jw5IVB0+2keysgTKvrvzCh3jwz8=;
  b=jc2CiTZfPOYgLQh5E/VhUe+vV66GMJ7y2xfSBl+1zw75JGOKqc6RepYY
   x6fekDL4Eski057amh+DskSMtzPpH4L4EJlsixla4OdAlz9XEx//YZjlX
   ERI9o3HIcJU1ef3/3uKb7TiYAgvWLt5pvRsV69NMYK2nKOvhkBvBLjwvS
   7Gi9N6ctPwLwJVJhmLkPoK2XFRg0HaFMngP7VhZ/vfHG4Oel5C7UVdoEF
   DaneXc3TTZNhz587ywuPDfZc8p/9gu65lxrz/yQpnCXoGHOoWK9gPGSTK
   Ix5T+ZqBN9kURXmSIrCVBIKR8j5AAUviPYytfrVSRdfsSZKXsqxazBghW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="375299455"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375299455"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="629929944"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2022 06:29:30 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI90b-000EB5-21;
        Sun, 31 Jul 2022 13:29:29 +0000
Date:   Sun, 31 Jul 2022 21:28:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ambarus:at-hdmac-virt-dma-2nd-iteration 9/11]
 drivers/dma/at_hdmac.c:469: warning: expecting prototype for set_desc_eol().
 Prototype was for set_lli_eol() instead
Message-ID: <202207312153.ze7Hqt3a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ambarus/linux-0day at-hdmac-virt-dma-2nd-iteration
head:   ae6fc9abe0bb2ef6193d3353b41ebcd49f7f95a0
commit: e4caf9eb097113115c4ae345da16ce06c9365842 [9/11] dmaengine: at-hdmac: Update driver to use virt-dma
config: arm-at91_dt_defconfig (https://download.01.org/0day-ci/archive/20220731/202207312153.ze7Hqt3a-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ambarus/linux-0day/commit/e4caf9eb097113115c4ae345da16ce06c9365842
        git remote add ambarus https://github.com/ambarus/linux-0day
        git fetch --no-tags ambarus at-hdmac-virt-dma-2nd-iteration
        git checkout e4caf9eb097113115c4ae345da16ce06c9365842
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'vd' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'atchan' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'sglen' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'active_xfer' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'boundary' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'dst_hole' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'src_hole' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'memset_buffer' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'memset_paddr' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'memset_vaddr' not described in 'at_desc'
   drivers/dma/at_hdmac.c:251: warning: Function parameter or member 'sg' not described in 'at_desc'
   drivers/dma/at_hdmac.c:259: warning: cannot understand function prototype: 'enum atc_status '
   drivers/dma/at_hdmac.c:292: warning: Function parameter or member 'vc' not described in 'at_dma_chan'
   drivers/dma/at_hdmac.c:292: warning: Function parameter or member 'atdma' not described in 'at_dma_chan'
   drivers/dma/at_hdmac.c:292: warning: Function parameter or member 'sgidx' not described in 'at_dma_chan'
   drivers/dma/at_hdmac.c:292: warning: Function parameter or member 'cyclic' not described in 'at_dma_chan'
   drivers/dma/at_hdmac.c:292: warning: Function parameter or member 'desc' not described in 'at_dma_chan'
   drivers/dma/at_hdmac.c:365: warning: Function parameter or member 'regs' not described in 'at_dma'
   drivers/dma/at_hdmac.c:469: warning: Function parameter or member 'i' not described in 'set_lli_eol'
>> drivers/dma/at_hdmac.c:469: warning: expecting prototype for set_desc_eol(). Prototype was for set_lli_eol() instead
   drivers/dma/at_hdmac.c:708: warning: Function parameter or member 'i' not described in 'atc_handle_error'


vim +469 drivers/dma/at_hdmac.c

807dd140a1f96b Tudor Ambarus 2022-07-04  463  
807dd140a1f96b Tudor Ambarus 2022-07-04  464  /**
807dd140a1f96b Tudor Ambarus 2022-07-04  465   * set_desc_eol - set end-of-link to descriptor so it will end transfer
807dd140a1f96b Tudor Ambarus 2022-07-04  466   * @desc: descriptor, signle or at the end of a chain, to end chain on
807dd140a1f96b Tudor Ambarus 2022-07-04  467   */
e4caf9eb097113 Tudor Ambarus 2022-07-11  468  static void set_lli_eol(struct at_desc *desc, unsigned int i)
807dd140a1f96b Tudor Ambarus 2022-07-04 @469  {
e4caf9eb097113 Tudor Ambarus 2022-07-11  470  	u32 ctrlb = desc->sg[i].lli->ctrlb;
807dd140a1f96b Tudor Ambarus 2022-07-04  471  
807dd140a1f96b Tudor Ambarus 2022-07-04  472  	ctrlb &= ~ATC_IEN;
807dd140a1f96b Tudor Ambarus 2022-07-04  473  	ctrlb |= ATC_SRC_DSCR_DIS | ATC_DST_DSCR_DIS;
807dd140a1f96b Tudor Ambarus 2022-07-04  474  
e4caf9eb097113 Tudor Ambarus 2022-07-11  475  	desc->sg[i].lli->ctrlb = ctrlb;
e4caf9eb097113 Tudor Ambarus 2022-07-11  476  	desc->sg[i].lli->dscr = 0;
807dd140a1f96b Tudor Ambarus 2022-07-04  477  }
807dd140a1f96b Tudor Ambarus 2022-07-04  478  

:::::: The code at line 469 was first introduced by commit
:::::: 807dd140a1f96b66a04811cb693fcc3685110501 dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c

:::::: TO: Tudor Ambarus <tudor.ambarus@microchip.com>
:::::: CC: Tudor Ambarus <tudor.ambarus@microchip.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
