Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2814052ECE2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349703AbiETNKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343831AbiETNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:10:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4151632AC;
        Fri, 20 May 2022 06:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653052200; x=1684588200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JYvA0BL6yB7SFLBfiv6pDy7n04oHm5chtGpJPdO8AMI=;
  b=ApywRSmx+SNEVgwzZJTJvdufX0Fx+jReJ+nN1DD9WgdwKGRAfBlA+dIy
   xzReUFSN3Bswl+jdA6o/o6hAhf+ZRi1qiNkKsPOefoN9v7HG6YGApg84k
   Bgbidf1CXN6BsqX8q2+yoaRvM0aBcuWKnpq6H1a8sI4dTyy1ZikMHU6+q
   DtbN4QM/7VCuKGYNoCG5aPq0LQDSVLUlzccgoOYBlIjSc5fQlehMdsJBL
   JmduFXah1cEF4AEhPh4u2mmWlVsBbyTBVE1do0mzAnoUbZwesGLEfLQ6v
   /DGcIe9hqfeJ3yNjFcJaQloy3Q0k/yJeI5cuPcZ0re69Sbh9yuAod8bSR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297909104"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="297909104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="715526492"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 May 2022 06:09:45 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ns2O0-0004ii-Lb;
        Fri, 20 May 2022 13:09:44 +0000
Date:   Fri, 20 May 2022 21:08:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, djwong@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] xfs: Remove the redundant assignment
Message-ID: <202205202134.P3H4KQ7S-lkp@intel.com>
References: <20220520040518.73957-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520040518.73957-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xfs-linux/for-next]
[also build test WARNING on v5.18-rc7 next-20220519]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiapeng-Chong/xfs-Remove-the-redundant-assignment/20220520-120736
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220520/202205202134.P3H4KQ7S-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/890587fbe3e3934d20fcd39effdcefedd65e6b7f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jiapeng-Chong/xfs-Remove-the-redundant-assignment/20220520-120736
        git checkout 890587fbe3e3934d20fcd39effdcefedd65e6b7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/xfs_log_recover.c:3542:20: warning: unused variable 'agfp' [-Wunused-variable]
                           struct xfs_agf  *agfp = agfbp->b_addr;
                                            ^
>> fs/xfs/xfs_log_recover.c:3551:20: warning: unused variable 'agi' [-Wunused-variable]
                           struct xfs_agi  *agi = agibp->b_addr;
                                            ^
   2 warnings generated.


vim +/agfp +3542 fs/xfs/xfs_log_recover.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  3519  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3520  #if defined(DEBUG)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3521  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  3522   * Read all of the agf and agi counters and check that they
^1da177e4c3f41 Linus Torvalds    2005-04-16  3523   * are consistent with the superblock counters.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3524   */
e89fbb5ee1893f Christoph Hellwig 2017-11-06  3525  STATIC void
^1da177e4c3f41 Linus Torvalds    2005-04-16  3526  xlog_recover_check_summary(
9a8d2fdbb47aaa Mark Tinguely     2012-06-14  3527  	struct xlog		*log)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3528  {
934933c3eec9e4 Dave Chinner      2021-06-02  3529  	struct xfs_mount	*mp = log->l_mp;
934933c3eec9e4 Dave Chinner      2021-06-02  3530  	struct xfs_perag	*pag;
e82226138b20d4 Dave Chinner      2020-12-16  3531  	struct xfs_buf		*agfbp;
e82226138b20d4 Dave Chinner      2020-12-16  3532  	struct xfs_buf		*agibp;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3533  	xfs_agnumber_t		agno;
5e1be0fb1a3950 Christoph Hellwig 2008-11-28  3534  	int			error;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3535  
934933c3eec9e4 Dave Chinner      2021-06-02  3536  	for_each_perag(mp, agno, pag) {
934933c3eec9e4 Dave Chinner      2021-06-02  3537  		error = xfs_read_agf(mp, NULL, pag->pag_agno, 0, &agfbp);
4805621a37d9b2 Christoph Hellwig 2008-11-28  3538  		if (error) {
a0fa2b679ecd15 Dave Chinner      2011-03-07  3539  			xfs_alert(mp, "%s agf read failed agno %d error %d",
934933c3eec9e4 Dave Chinner      2021-06-02  3540  						__func__, pag->pag_agno, error);
4805621a37d9b2 Christoph Hellwig 2008-11-28  3541  		} else {
9798f615ad2be4 Christoph Hellwig 2020-03-10 @3542  			struct xfs_agf	*agfp = agfbp->b_addr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3543  			xfs_buf_relse(agfbp);
4805621a37d9b2 Christoph Hellwig 2008-11-28  3544  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3545  
934933c3eec9e4 Dave Chinner      2021-06-02  3546  		error = xfs_read_agi(mp, NULL, pag->pag_agno, &agibp);
a0fa2b679ecd15 Dave Chinner      2011-03-07  3547  		if (error) {
a0fa2b679ecd15 Dave Chinner      2011-03-07  3548  			xfs_alert(mp, "%s agi read failed agno %d error %d",
934933c3eec9e4 Dave Chinner      2021-06-02  3549  						__func__, pag->pag_agno, error);
a0fa2b679ecd15 Dave Chinner      2011-03-07  3550  		} else {
370c782b98436b Christoph Hellwig 2020-03-10 @3551  			struct xfs_agi	*agi = agibp->b_addr;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
