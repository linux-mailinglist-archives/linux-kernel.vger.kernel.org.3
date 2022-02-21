Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B05C4BE9F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiBURpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:45:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiBURpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:45:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1657622B07;
        Mon, 21 Feb 2022 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645465479; x=1677001479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+thVCD7e5H0u/zoGVJJR51K03QVG5BFmzVuy+pL8UXs=;
  b=LEjuhxAUdk+0xEc+mzqONdElgLPRt1G4OTzTPCBID7pJkoOHbh02d/bG
   kpl8W4aFYOX5/yOgX3kOV/gNDqvqRXemqapWui1ogPl5YIL82uWQf4VMc
   cOzY1sDM9KTEUysIMuQ9n2dI6MNelkVrlIiuBRKQVqJk9r4B2z9SVQuqp
   jNWLvCF1BOWlU1FeYxQb1pLwPqveGA0J6esTPYMLlBmh8uNjIkyZ7hw5N
   USG0m+vr6dZxt4MVIVtPXvMnQUl3P8j9+HAA46pkDGCEwS/sqPxgSDA52
   H/g+gBiZ3QrWQzq0FrnO0M85yerXg6j6sOP7n/KLseOCwEI6aTc4lW/rG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276142135"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="276142135"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="573171307"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2022 09:44:36 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMCjj-0001pq-Io; Mon, 21 Feb 2022 17:44:35 +0000
Date:   Tue, 22 Feb 2022 01:43:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] remoteproc: Add AVM WASP driver
Message-ID: <202202220129.7LjlrUsi-lkp@intel.com>
References: <20220221135424.GA7385@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221135424.GA7385@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on robh/for-next v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daniel-Kestrel/Add-support-for-WASP-SoC-on-AVM-router-boards/20220221-215619
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202220129.7LjlrUsi-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/76e19a3c7ae383687205d7be3ac6224253d97704
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daniel-Kestrel/Add-support-for-WASP-SoC-on-AVM-router-boards/20220221-215619
        git checkout 76e19a3c7ae383687205d7be3ac6224253d97704
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/avm_wasp.c:150:5: warning: no previous prototype for 'avm_wasp_netboot_mdio_read' [-Wmissing-prototypes]
     150 | int avm_wasp_netboot_mdio_read(struct avm_wasp_rproc *avmwasp,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/remoteproc/avm_wasp.c:176:6: warning: no previous prototype for 'avm_wasp_netboot_mdio_write' [-Wmissing-prototypes]
     176 | void avm_wasp_netboot_mdio_write(struct avm_wasp_rproc *avmwasp,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/remoteproc/avm_wasp.c:197:6: warning: no previous prototype for 'avm_wasp_netboot_mdio_write_u32_split' [-Wmissing-prototypes]
     197 | void avm_wasp_netboot_mdio_write_u32_split(struct avm_wasp_rproc *avmwasp,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/remoteproc/avm_wasp.c:380:5: warning: no previous prototype for 'avm_wasp_netboot_load_firmware' [-Wmissing-prototypes]
     380 | int avm_wasp_netboot_load_firmware(struct avm_wasp_rproc *avmwasp)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/remoteproc/avm_wasp.c:569:5: warning: no previous prototype for 'avm_wasp_load_initramfs_image' [-Wmissing-prototypes]
     569 | int avm_wasp_load_initramfs_image(struct avm_wasp_rproc *avmwasp)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/avm_wasp_netboot_mdio_read +150 drivers/remoteproc/avm_wasp.c

   138	
   139	/**
   140	 * avm_wasp_netboot_mdio_read() - read with gswip mdio bus
   141	 * @avmwasp: pointer to drivers private avm_wasp_rproc structure
   142	 * @location: register number of the m_regs_wasp register array
   143	 *
   144	 * Reads a value from the specified register for the mdio address
   145	 * that is used for the connection to the WASP SoC
   146	 * Mutex on mdio_lock is required to serialize access on bus
   147	 *
   148	 * Return: Value that was read from the specified register
   149	 */
 > 150	int avm_wasp_netboot_mdio_read(struct avm_wasp_rproc *avmwasp,
   151				       int location)
   152	{
   153		int value;
   154	
   155		if (location > M_REGS_WASP_INDEX_MAX || location < 0)
   156			return 0;
   157		mutex_lock(&avmwasp->mdio_bus->mdio_lock);
   158		value = avmwasp->mdio_bus->read(avmwasp->mdio_bus,
   159				WASP_ADDR, m_regs_wasp[location]);
   160		mutex_unlock(&avmwasp->mdio_bus->mdio_lock);
   161		return value;
   162	}
   163	
   164	/**
   165	 * avm_wasp_netboot_mdio_write() - write with gswip mdio bus
   166	 * @avmwasp: pointer to drivers private avm_wasp_rproc structure
   167	 * @location: register number of the m_regs_wasp register array
   168	 * @value: value to be written to the register
   169	 *
   170	 * Writes a value to the specified register for the mdio address
   171	 * that is used for the connection to the WASP SoC
   172	 * Mutex on mdio_lock is required to serialize access on bus
   173	 * Makes sure not to write to invalid registers as this can have
   174	 * unpredictable results
   175	 */
 > 176	void avm_wasp_netboot_mdio_write(struct avm_wasp_rproc *avmwasp,
   177					 int location, int value)
   178	{
   179		if (location > M_REGS_WASP_INDEX_MAX || location < 0)
   180			return;
   181		mutex_lock(&avmwasp->mdio_bus->mdio_lock);
   182		avmwasp->mdio_bus->write(avmwasp->mdio_bus, WASP_ADDR,
   183				m_regs_wasp[location], value);
   184		mutex_unlock(&avmwasp->mdio_bus->mdio_lock);
   185	}
   186	
   187	/**
   188	 * avm_wasp_netboot_mdio_write_u32_split() - write 32bit value
   189	 * @avmwasp: pointer to drivers private avm_wasp_rproc structure
   190	 * @location: register number of the m_regs_wasp register array
   191	 * @value: value to be written to the register
   192	 *
   193	 * As the mdio registers are 16bit, this function writes a 32bit value
   194	 * to two subsequent registers starting with the specified register
   195	 * for the mdio address that is used for the connection to the WASP SoC
   196	 */
 > 197	void avm_wasp_netboot_mdio_write_u32_split(struct avm_wasp_rproc *avmwasp,
   198						   int location, const u32 value)
   199	{
   200		avm_wasp_netboot_mdio_write(avmwasp, location,
   201					    ((value & 0xffff0000) >> 16));
   202		avm_wasp_netboot_mdio_write(avmwasp, location + 1,
   203					    (value & 0x0000ffff));
   204	}
   205	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
