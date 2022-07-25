Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2130580761
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiGYWaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGYWaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:30:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB6B26
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658788214; x=1690324214;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rEibPX4A+3q/UO4dudDLBb6xgStJG1WiFr0ZClH+s98=;
  b=OWjwRG5+J3iTwTwOuNWaDWoo40ZZlzfMVYosjYZ1JLh/ZpZ87ZJB3JyL
   h0H1+K9ihJ8LlDs7eLTU46PObIIJzzUzci1SztykHCbw6vyPr1etg66rR
   88Q+87WyFGeIYFoQ3nxKLYOJv5mhJ2SwnXekODhIR/K9+kCVXg6Uuqdh6
   9Bi9eBJJy/gIIHiWNIcXDjeKxm0S6qo90z1+xxqwD+IE9bjH9RCKH8q1q
   mML6QLagqxg7nY6s36Lnu8Z2mEWg+qHUNXCz4mk4XVb94XqW8pJWLQp3l
   09ZQcR4HHsp/MxEDjHlR01WABeYi30ptvhV3UlcXXuedrqy6GG3WnZ26p
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="267579093"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="267579093"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 15:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="667653405"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2022 15:30:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oG6aa-0005cW-0u;
        Mon, 25 Jul 2022 22:30:12 +0000
Date:   Tue, 26 Jul 2022 06:29:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/wm_adsp.c:1490:32: warning: taking address of
 packed member 'name' of class or structure 'wm_adsp_host_buf_coeff_v1' may
 result in an unaligned pointer value
Message-ID: <202207260648.ERQjXCRB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: 353bb6a5f2ac495f289b7c7a528c7d134c9a8ec4 ASoC: wm_adsp: Compressed stream DSP memory structs should be __packed
date:   5 months ago
config: arm-randconfig-r013-20220724 (https://download.01.org/0day-ci/archive/20220726/202207260648.ERQjXCRB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9e88cbcc403bdf82f29259ad60ff60a8fc4434a1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=353bb6a5f2ac495f289b7c7a528c7d134c9a8ec4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 353bb6a5f2ac495f289b7c7a528c7d134c9a8ec4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/wm_adsp.c:1490:32: warning: taking address of packed member 'name' of class or structure 'wm_adsp_host_buf_coeff_v1' may result in an unaligned pointer value [-Waddress-of-packed-member]
           cs_dsp_remove_padding((u32 *)&coeff_v1.name, ARRAY_SIZE(coeff_v1.name));
                                         ^~~~~~~~~~~~~
   1 warning generated.


vim +1490 sound/soc/codecs/wm_adsp.c

d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1434  
0700bc2fb94c28 Simon Trimmer      2021-09-13  1435  static int wm_adsp_buffer_parse_coeff(struct cs_dsp_coeff_ctl *cs_ctl)
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1436  {
4f2d4eabf57718 Stuart Henderson   2019-02-22  1437  	struct wm_adsp_host_buf_coeff_v1 coeff_v1;
a792af69b08fd7 Charles Keepax     2019-02-22  1438  	struct wm_adsp_compr_buf *buf;
e146820215910d Simon Trimmer      2021-09-13  1439  	struct wm_adsp *dsp = container_of(cs_ctl->dsp, struct wm_adsp, cs_dsp);
04ae08596737c4 Charles Keepax     2021-09-13  1440  	unsigned int version;
a792af69b08fd7 Charles Keepax     2019-02-22  1441  	int ret, i;
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1442  
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1443  	for (i = 0; i < 5; ++i) {
a887f9c7a4d37a Charles Keepax     2022-02-10  1444  		ret = cs_dsp_coeff_read_ctrl(cs_ctl, 0, &coeff_v1,
a887f9c7a4d37a Charles Keepax     2022-02-10  1445  					     min(cs_ctl->len, sizeof(coeff_v1)));
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1446  		if (ret < 0)
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1447  			return ret;
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1448  
04ae08596737c4 Charles Keepax     2021-09-13  1449  		if (coeff_v1.host_buf_ptr)
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1450  			break;
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1451  
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1452  		usleep_range(1000, 2000);
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1453  	}
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1454  
04ae08596737c4 Charles Keepax     2021-09-13  1455  	if (!coeff_v1.host_buf_ptr) {
0700bc2fb94c28 Simon Trimmer      2021-09-13  1456  		adsp_err(dsp, "Failed to acquire host buffer\n");
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1457  		return -EIO;
a792af69b08fd7 Charles Keepax     2019-02-22  1458  	}
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1459  
0700bc2fb94c28 Simon Trimmer      2021-09-13  1460  	buf = wm_adsp_buffer_alloc(dsp);
a792af69b08fd7 Charles Keepax     2019-02-22  1461  	if (!buf)
a792af69b08fd7 Charles Keepax     2019-02-22  1462  		return -ENOMEM;
a792af69b08fd7 Charles Keepax     2019-02-22  1463  
0700bc2fb94c28 Simon Trimmer      2021-09-13  1464  	buf->host_buf_mem_type = cs_ctl->alg_region.type;
04ae08596737c4 Charles Keepax     2021-09-13  1465  	buf->host_buf_ptr = be32_to_cpu(coeff_v1.host_buf_ptr);
a792af69b08fd7 Charles Keepax     2019-02-22  1466  
a792af69b08fd7 Charles Keepax     2019-02-22  1467  	ret = wm_adsp_buffer_populate(buf);
a792af69b08fd7 Charles Keepax     2019-02-22  1468  	if (ret < 0)
a792af69b08fd7 Charles Keepax     2019-02-22  1469  		return ret;
a792af69b08fd7 Charles Keepax     2019-02-22  1470  
4f2d4eabf57718 Stuart Henderson   2019-02-22  1471  	/*
4f2d4eabf57718 Stuart Henderson   2019-02-22  1472  	 * v0 host_buffer coefficients didn't have versioning, so if the
4f2d4eabf57718 Stuart Henderson   2019-02-22  1473  	 * control is one word, assume version 0.
4f2d4eabf57718 Stuart Henderson   2019-02-22  1474  	 */
0700bc2fb94c28 Simon Trimmer      2021-09-13  1475  	if (cs_ctl->len == 4) {
0d3fba3e7a5669 Charles Keepax     2019-02-22  1476  		compr_dbg(buf, "host_buf_ptr=%x\n", buf->host_buf_ptr);
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1477  		return 0;
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1478  	}
d52ed4b0bc73c1 Richard Fitzgerald 2018-07-19  1479  
a0b653e89a3afd Richard Fitzgerald 2020-12-30  1480  	version = be32_to_cpu(coeff_v1.versions) & HOST_BUF_COEFF_COMPAT_VER_MASK;
a0b653e89a3afd Richard Fitzgerald 2020-12-30  1481  	version >>= HOST_BUF_COEFF_COMPAT_VER_SHIFT;
4f2d4eabf57718 Stuart Henderson   2019-02-22  1482  
a0b653e89a3afd Richard Fitzgerald 2020-12-30  1483  	if (version > HOST_BUF_COEFF_SUPPORTED_COMPAT_VER) {
0700bc2fb94c28 Simon Trimmer      2021-09-13  1484  		adsp_err(dsp,
4f2d4eabf57718 Stuart Henderson   2019-02-22  1485  			 "Host buffer coeff ver %u > supported version %u\n",
a0b653e89a3afd Richard Fitzgerald 2020-12-30  1486  			 version, HOST_BUF_COEFF_SUPPORTED_COMPAT_VER);
4f2d4eabf57718 Stuart Henderson   2019-02-22  1487  		return -EINVAL;
4f2d4eabf57718 Stuart Henderson   2019-02-22  1488  	}
4f2d4eabf57718 Stuart Henderson   2019-02-22  1489  
5beb8eeade2c03 Simon Trimmer      2021-09-13 @1490  	cs_dsp_remove_padding((u32 *)&coeff_v1.name, ARRAY_SIZE(coeff_v1.name));
4f2d4eabf57718 Stuart Henderson   2019-02-22  1491  
0700bc2fb94c28 Simon Trimmer      2021-09-13  1492  	buf->name = kasprintf(GFP_KERNEL, "%s-dsp-%s", dsp->part,
4f2d4eabf57718 Stuart Henderson   2019-02-22  1493  			      (char *)&coeff_v1.name);
4f2d4eabf57718 Stuart Henderson   2019-02-22  1494  
0d3fba3e7a5669 Charles Keepax     2019-02-22  1495  	compr_dbg(buf, "host_buf_ptr=%x coeff version %u\n",
a0b653e89a3afd Richard Fitzgerald 2020-12-30  1496  		  buf->host_buf_ptr, version);
4f2d4eabf57718 Stuart Henderson   2019-02-22  1497  
a0b653e89a3afd Richard Fitzgerald 2020-12-30  1498  	return version;
4f2d4eabf57718 Stuart Henderson   2019-02-22  1499  }
4f2d4eabf57718 Stuart Henderson   2019-02-22  1500  

:::::: The code at line 1490 was first introduced by commit
:::::: 5beb8eeade2c03b55ae729c05bb9fa245633fe74 ASoC: wm_adsp: Rename generic DSP support

:::::: TO: Simon Trimmer <simont@opensource.cirrus.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
