Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6F59786D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbiHQUzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbiHQUzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:55:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1FEA7212
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660769737; x=1692305737;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L89mLhgUIBYKBC1C8V4dOSMBNvOwl9CiFw2E/+ybi1E=;
  b=acOJgh922vmB/p5SOhr5aE7Q59qvEhDgSuOaQ2AIjeDd5EybjKdDe59z
   ZNxdJUHIH/PEd749IUVJ9PCs9FctdmGldaWJEpfLVXI9BU1hBUAsdCy9f
   0xprKdx4wA6GBK6GNDPEl6YfEypX6MJ+Jx9uNahgVQugE2fGisdydR+z7
   Zv1Tu/jx/AbmW7+SKXHBXBQVOAX9J3Erl2j6n2qqRh3zqIpzl19tQdZEA
   lLgoE4GZblLBhZ71c/OXoJtkb4go7jSnb9MmelXlLo3p3zMy20WRg29cE
   E3yNW0kXBKUW30U8SIQOUQZBZ6ODqPB9uI7IhmmWWjhxuBtS/9mc2XxP/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="354341767"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="354341767"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 13:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="640609508"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2022 13:55:35 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOQ4d-0001L6-0Y;
        Wed, 17 Aug 2022 20:55:35 +0000
Date:   Thu, 18 Aug 2022 04:54:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [srini-nvmem:for-next 2/4] drivers/nvmem/u-boot-env.c:141:17:
 sparse: sparse: cast to restricted __le32
Message-ID: <202208180411.tn0DH3Se-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git for-next
head:   74220cdb1b54f4f904311da69a37836b63289bed
commit: f955dc14450695564926711cf9fa8e1d5d854302 [2/4] nvmem: add driver handling U-Boot environment variables
config: openrisc-randconfig-s031-20220818 (https://download.01.org/0day-ci/archive/20220818/202208180411.tn0DH3Se-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/commit/?id=f955dc14450695564926711cf9fa8e1d5d854302
        git remote add srini-nvmem https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git
        git fetch --no-tags srini-nvmem for-next
        git checkout f955dc14450695564926711cf9fa8e1d5d854302
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/nvmem/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/nvmem/u-boot-env.c:141:17: sparse: sparse: cast to restricted __le32
>> drivers/nvmem/u-boot-env.c:141:17: sparse: sparse: cast to restricted __le32
>> drivers/nvmem/u-boot-env.c:141:17: sparse: sparse: cast to restricted __le32
>> drivers/nvmem/u-boot-env.c:141:17: sparse: sparse: cast to restricted __le32
>> drivers/nvmem/u-boot-env.c:141:17: sparse: sparse: cast to restricted __le32
>> drivers/nvmem/u-boot-env.c:141:17: sparse: sparse: cast to restricted __le32

vim +141 drivers/nvmem/u-boot-env.c

   102	
   103	static int u_boot_env_parse(struct u_boot_env *priv)
   104	{
   105		struct device *dev = priv->dev;
   106		size_t crc32_data_offset;
   107		size_t crc32_data_len;
   108		size_t crc32_offset;
   109		size_t data_offset;
   110		size_t data_len;
   111		uint32_t crc32;
   112		uint32_t calc;
   113		size_t bytes;
   114		uint8_t *buf;
   115		int err;
   116	
   117		buf = kcalloc(1, priv->mtd->size, GFP_KERNEL);
   118		if (!buf) {
   119			err = -ENOMEM;
   120			goto err_out;
   121		}
   122	
   123		err = mtd_read(priv->mtd, 0, priv->mtd->size, &bytes, buf);
   124		if ((err && !mtd_is_bitflip(err)) || bytes != priv->mtd->size) {
   125			dev_err(dev, "Failed to read from mtd: %d\n", err);
   126			goto err_kfree;
   127		}
   128	
   129		switch (priv->format) {
   130		case U_BOOT_FORMAT_SINGLE:
   131			crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
   132			crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
   133			data_offset = offsetof(struct u_boot_env_image_single, data);
   134			break;
   135		case U_BOOT_FORMAT_REDUNDANT:
   136			crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
   137			crc32_data_offset = offsetof(struct u_boot_env_image_redundant, mark);
   138			data_offset = offsetof(struct u_boot_env_image_redundant, data);
   139			break;
   140		}
 > 141		crc32 = le32_to_cpu(*(uint32_t *)(buf + crc32_offset));
   142		crc32_data_len = priv->mtd->size - crc32_data_offset;
   143		data_len = priv->mtd->size - data_offset;
   144	
   145		calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
   146		if (calc != crc32) {
   147			dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
   148			err = -EINVAL;
   149			goto err_kfree;
   150		}
   151	
   152		buf[priv->mtd->size - 1] = '\0';
   153		err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
   154		if (err)
   155			dev_err(dev, "Failed to add cells: %d\n", err);
   156	
   157	err_kfree:
   158		kfree(buf);
   159	err_out:
   160		return err;
   161	}
   162	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
