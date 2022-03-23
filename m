Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1787A4E5B50
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbiCWWjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244521AbiCWWjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:39:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E3C5F8B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648075094; x=1679611094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4jF+Df17MVvV0AjR2LNj1V6JQVFfLQcHMH5bdq2C90U=;
  b=cwyR1l5QX1fX2qOknS6opgVIO2L5/wBif1IusguoIVusJNuOkgWxuBd6
   emx/uU6NnmTRJS0Whn3+nU0wEl/S+/bbjmSyGDsnJoD0wg3UPsTKuo3pP
   FEY9st0gzZCWiQ2l/o3CGs0qS0WD9faMxg4bg2ve+o6TyMwnOJ911QTp6
   UHFy+BXPELZ6XXKKmiw6OR9vPMSi/rFYNsk/9epkOrnC/kuFKLaNue29F
   CmLP5iets/+/8aXelBOHLKbSUKbeGGSwWOeM1rrPrT7KQroPc+Y3Kq05z
   ePEDHBj+Dv+71UcXmJHVf5cdbq+a1Dhib6zBExTMdT6qGQqLWNOWNZZrL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258429597"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258429597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 15:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="501175344"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2022 15:38:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX9cI-000KRJ-Lw; Wed, 23 Mar 2022 22:38:10 +0000
Date:   Thu, 24 Mar 2022 06:37:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [device-mapper-dm:dm-5.19 132/132] drivers/md/dm.c:1542:4: error:
 use of undeclared identifier 'result'
Message-ID: <202203240618.diX27ri2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220324/202203240618.diX27ri2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?id=7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
        git remote add device-mapper-dm https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
        git fetch --no-tags device-mapper-dm dm-5.19
        git checkout 7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/md/dm.c:1542:4: error: use of undeclared identifier 'result'
                   *result = BLK_STS_NOTSUPP;
                    ^
   drivers/md/dm.c:1545:4: error: use of undeclared identifier 'result'
                   *result = BLK_STS_OK;
                    ^
   2 errors generated.


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
