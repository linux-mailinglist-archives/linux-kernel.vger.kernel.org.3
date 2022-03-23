Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFF84E5B98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbiCWW7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCWW7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:59:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBC2C13F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648076300; x=1679612300;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k7cTbB4gfD0aPBjyg9gQGdLe/k/tsH9UotE2j2KhLTI=;
  b=j7b4U1aVt0XfR7BCfDoRlLa/4345gzGLzrLrVz1uRHLNZiKDk8Sd3iiG
   pCGP285zjsHPJVrhXjG/po3d+HejdI2Q2OnHT0XneFvQTIg6gpBeomT4k
   nyXu7OSlWiMkFjCKZHu2AZehltsUVDKQwice99gcLCX7kVq1DG9nDB4KF
   53w6r13GNy+feZb+mwcPPawIm5PE3e6EacIVSonQffB9T5bVAobvqeXW1
   htBiioFZZcRZzFWVJn1pkj5O0Wfno+ebUpIMBEcQ9BWC8VlSpGlYBiTqx
   EQKRndwT/1lluv1I8QKCMphRh0+2Vi52rlixLB+93FW7XK5aA0Ve97ifs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258197373"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258197373"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 15:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="544396217"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2022 15:58:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX9vk-000KSo-9x; Wed, 23 Mar 2022 22:58:16 +0000
Date:   Thu, 24 Mar 2022 06:57:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     kbuild-all@lists.01.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [device-mapper-dm:dm-5.19 132/132] drivers/md/dm.c:1542:18: error:
 'result' undeclared
Message-ID: <202203240638.crXQjFY5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git dm-5.19
head:   7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
commit: 7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe [132/132] dm: push error handling down to __split_and_process_bio
config: s390-buildonly-randconfig-r005-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240638.crXQjFY5-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?id=7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
        git remote add device-mapper-dm https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
        git fetch --no-tags device-mapper-dm dm-5.19
        git checkout 7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/md/dm.c: In function '__process_abnormal_io':
>> drivers/md/dm.c:1542:18: error: 'result' undeclared (first use in this function)
    1542 |                 *result = BLK_STS_NOTSUPP;
         |                  ^~~~~~
   drivers/md/dm.c:1542:18: note: each undeclared identifier is reported only once for each function it appears in


vim +/result +1542 drivers/md/dm.c

  1508	
  1509	static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
  1510					  blk_status_t *status)
  1511	{
  1512		unsigned num_bios;
  1513	
  1514		if (!is_abnormal_io(ci->bio))
  1515			return false;
  1516	
  1517		num_bios = 0;
  1518		switch (bio_op(ci->bio)) {
  1519		case REQ_OP_DISCARD:
  1520			num_bios = ti->num_discard_bios;
  1521			break;
  1522		case REQ_OP_SECURE_ERASE:
  1523			num_bios = ti->num_secure_erase_bios;
  1524			break;
  1525		case REQ_OP_WRITE_SAME:
  1526			num_bios = ti->num_write_same_bios;
  1527			break;
  1528		case REQ_OP_WRITE_ZEROES:
  1529			num_bios = ti->num_write_zeroes_bios;
  1530			break;
  1531		default:
  1532			return false;
  1533		}
  1534	
  1535		/*
  1536		 * Even though the device advertised support for this type of
  1537		 * request, that does not mean every target supports it, and
  1538		 * reconfiguration might also have changed that since the
  1539		 * check was performed.
  1540		 */
  1541		if (!num_bios)
> 1542			*result = BLK_STS_NOTSUPP;
  1543		else {
  1544			__send_changing_extent_only(ci, ti, num_bios);
  1545			*result = BLK_STS_OK;
  1546		}
  1547		return true;
  1548	}
  1549	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
