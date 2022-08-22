Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCCE59BF8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiHVMeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiHVMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:34:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE8732BA0;
        Mon, 22 Aug 2022 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661171674; x=1692707674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PZmF6XvWZoLRPxFBET3Yl8dm1F+14XAi57OYAT2wPcg=;
  b=HwPdSkTSpRP2tKWK052NUxaOoYDUxBX2hRWu2tJ/0Cx2xIGX6hl4PSgp
   /f94fq61CYW2fl9OQrXHpVnBH0WpIfdgElBL401PVxEeabws0ZuQnGWyi
   wtgfzRMJbQIQ6iT/seFU5Mx1X6GF88ViQZ2nPS8Z/ItjcMGQnNNcUMkwo
   8XGqAdE4Vr12uSn+XAmfUuaS1h3bTjxKSU3bWohUNCSttR1mDuCcwtdFh
   zqoCvTuc8BhCU/i01u3nWXOvSSssboKarKmoUrZGGlOQpG2YCWFQGIZGY
   uiA7s8uyA2KPZSvndY46btm6qSlsK2vOhnn8IPkMM3LZQAMrAUibWYhBL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="280371160"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="280371160"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 05:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="559726950"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2022 05:34:30 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ6dS-00002t-0S;
        Mon, 22 Aug 2022 12:34:30 +0000
Date:   Mon, 22 Aug 2022 20:33:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v5] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <202208222014.gb1mZ0S1-lkp@intel.com>
References: <20220822073105.10509-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822073105.10509-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Szuying,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc2 next-20220822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220822-153229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1c23f9e627a7b412978b4e852793c5e3c3efc555
config: openrisc-randconfig-r001-20220821 (https://download.01.org/0day-ci/archive/20220822/202208222014.gb1mZ0S1-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/abf17cfc1bbabb9346b4ca1ab723628389b773c5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220822-153229
        git checkout abf17cfc1bbabb9346b4ca1ab723628389b773c5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/soc/qcom/ drivers/thunderbolt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/thunderbolt/nvm.c: In function 'intel_nvm_validate':
>> drivers/thunderbolt/nvm.c:140:68: error: expected expression before ',' token
     140 |                                 DMA_PORT_CSS_ADDRESS, buf + NVM_CSS,
         |                                                                    ^


vim +140 drivers/thunderbolt/nvm.c

    94	
    95	static int  intel_nvm_validate(struct tb_switch *sw)
    96	{
    97		unsigned int image_size, hdr_size;
    98		const u8 *buf = sw->nvm->buf;
    99		u16 ds_size;
   100		int ret;
   101	
   102		image_size = sw->nvm->buf_data_size;
   103		if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
   104			return -EINVAL;
   105	
   106		/*
   107		 * FARB pointer must point inside the image and must at least
   108		 * contain parts of the digital section we will be reading here.
   109		 */
   110		hdr_size = (*(u32 *)buf) & 0xffffff;
   111		if (hdr_size + NVM_DEVID + 2 >= image_size)
   112			return -EINVAL;
   113	
   114		/* Digital section start should be aligned to 4k page */
   115		if (!IS_ALIGNED(hdr_size, SZ_4K))
   116			return -EINVAL;
   117	
   118		/*
   119		 * Read digital section size and check that it also fits inside
   120		 * the image.
   121		 */
   122		ds_size = *(u16 *)(buf + hdr_size);
   123		if (ds_size >= image_size)
   124			return -EINVAL;
   125	
   126		if (!sw->safe_mode) {
   127			u16 device_id;
   128	
   129			/*
   130			 * Make sure the device ID in the image matches the one
   131			 * we read from the switch config space.
   132			 */
   133			device_id = *(u16 *)(buf + hdr_size + NVM_DEVID);
   134			if (device_id != sw->config.device_id)
   135				return -EINVAL;
   136	
   137			if (sw->generation < 3) {
   138				/* Write CSS headers first */
   139				ret = dma_port_flash_write(sw->dma_port,
 > 140					DMA_PORT_CSS_ADDRESS, buf + NVM_CSS,
   141					DMA_PORT_CSS_MAX_SIZE);
   142				if (ret)
   143					return ret;
   144			}
   145	
   146			/* Skip headers in the image */
   147			buf += hdr_size;
   148			image_size -= hdr_size;
   149		}
   150	
   151		return image_size;
   152	}
   153	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
