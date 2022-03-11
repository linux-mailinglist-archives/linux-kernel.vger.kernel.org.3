Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500694D611B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348448AbiCKMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbiCKMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:01:05 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19B51A94A7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647000002; x=1678536002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EVwqrpAEaupKtqKFWaRq0A2+hB9cR3uuFUPXgD0tHEk=;
  b=BpymFC0wH60CKv/sPJSR1f3zwH7Ef1yiT8zWt8IVordqwByx8DDdg0vJ
   ehBTQOnailP1rsSuQWuoAVpAsl/gdP41Wx1vy+pKr4UaJYB3x5WIJeWrC
   7R3rh1NNevjL6kwwBpiJYWJYne7eoc/EeinGA/aw9NdeweFnuFqdUjjYa
   umjCs16qy8E8jTw4DoHiresbGtVRyQJapBnYRXOQWjNwoGV10SDB8LqRA
   jVWTkriKCS3Ty/3j9W4Mf3bEoivhrCz8ZCL7H14KWLmZy2P7zcAMlvPr0
   Gx1P8LK73DiEeIlcZoHH8leQWER90Pf7HzlXNNn4xfdDUrR4ouLDtFMud
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316281093"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="316281093"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 04:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="689044540"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2022 04:00:01 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSdw8-0006M7-MG; Fri, 11 Mar 2022 12:00:00 +0000
Date:   Fri, 11 Mar 2022 19:59:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-03 3/9] net/bpf/test_run.c:1372:15: warning: cast
 to pointer from integer of different size
Message-ID: <202203111957.Pexg2qR6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-03
head:   91c92d46077f70b03fd162128dd3373663d529d4
commit: eb1f31b3643b9fb49f4785deab32e3461eca777f [3/9] xdp: add dequeue program type for getting packets from a PIFO
config: xtensa-buildonly-randconfig-r004-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111957.Pexg2qR6-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=eb1f31b3643b9fb49f4785deab32e3461eca777f
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-03
        git checkout eb1f31b3643b9fb49f4785deab32e3461eca777f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash net/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/bpf/test_run.c: In function 'bpf_prog_test_run_dequeue':
>> net/bpf/test_run.c:1372:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1372 |         pkt = (void *)retval;
         |               ^


vim +1372 net/bpf/test_run.c

  1347	
  1348	int bpf_prog_test_run_dequeue(struct bpf_prog *prog, const union bpf_attr *kattr,
  1349				      union bpf_attr __user *uattr)
  1350	{
  1351		struct xdp_txq_info txq = { .dev = current->nsproxy->net_ns->loopback_dev };
  1352		u32 repeat = kattr->test.repeat, duration, size;
  1353		struct dequeue_data ctx = { .txq = &txq };
  1354		struct xdp_buff xdp = {};
  1355		struct xdp_frame *pkt;
  1356		int ret = -EINVAL;
  1357		u64 retval;
  1358	
  1359		if (prog->expected_attach_type)
  1360			return -EINVAL;
  1361	
  1362		if (kattr->test.data_in || kattr->test.data_size_in ||
  1363		    kattr->test.ctx_in || kattr->test.ctx_out || repeat > 1)
  1364			return -EINVAL;
  1365	
  1366		ret = bpf_test_run(prog, &ctx, repeat, &retval, &duration, false);
  1367		if (ret)
  1368			return ret;
  1369		if (!retval)
  1370			return bpf_test_finish(kattr, uattr, NULL, NULL, 0, retval, duration);
  1371	
> 1372		pkt = (void *)retval;
  1373		xdp_convert_frame_to_buff(pkt, &xdp);
  1374		size = xdp.data_end - xdp.data_meta;
  1375		/* We set retval == 1 if pkt != NULL, otherwise 0 */
  1376		ret = bpf_test_finish(kattr, uattr, xdp.data_meta, NULL, size, !!retval, duration);
  1377		xdp_return_frame(pkt);
  1378		return ret;
  1379	}
  1380	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
