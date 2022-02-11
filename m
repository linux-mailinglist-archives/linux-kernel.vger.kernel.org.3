Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EB14B1E12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbiBKGDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:03:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiBKGDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:03:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAAD26C2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644559413; x=1676095413;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G/H7POQMleY+VGb9NB3pk0JTuU0i6RTqgAMemTvi9qA=;
  b=VGp9LRjQ12oOL/6lnNM3yyzdqjvk7wh6axnGXRb/IDbLZU5OiPCTLRNb
   y7+ALWzyzwwid4DlmG0h13u6/g43hB/ubUrNMuyHw/DmNmsQhIZc8+3lt
   ldUAUwN69WA5zmwOkk/xGYiIQpTRYnHC+dTW1JvPP0dGCPxAYGBtE1seq
   wy2KvrRx7re6WslfjcOhYawU8AKFHDPUu8TlrJmlDeAkXwC4XMcNOz34g
   Yz5G/pM5e2VtHh6dDMxHRAiKn0uhj/3H9T0nq79v/aAR1+K5v98V1Bzdr
   aEECkQV9QHWvs4t5y1tmuxU2uBt+uFYqQXm8DaA6lCY9ghTm4DG06y4Ce
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230310732"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="230310732"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="774143815"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2022 22:03:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIP1n-0004CG-52; Fri, 11 Feb 2022 06:03:31 +0000
Date:   Fri, 11 Feb 2022 14:02:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt 57/57] net/ceph/messenger_v2.c:1783:37:
 warning: declaration of 'struct cepn_connection' will not be visible outside
 of this function
Message-ID: <202202111326.dzplRoUb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt
head:   adf69efebc954db1aa7af7b93febbc2a1b51dc6c
commit: adf69efebc954db1aa7af7b93febbc2a1b51dc6c [57/57] libceph: define a structure to track SPARSE_READ reply processing
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220211/202202111326.dzplRoUb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=adf69efebc954db1aa7af7b93febbc2a1b51dc6c
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt
        git checkout adf69efebc954db1aa7af7b93febbc2a1b51dc6c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ceph/messenger_v2.c:1783:37: warning: declaration of 'struct cepn_connection' will not be visible outside of this function [-Wvisibility]
   static int prepare_read_data(struct cepn_connection *con)
                                       ^
   net/ceph/messenger_v2.c:1787:5: error: incomplete definition of type 'struct cepn_connection'
           con->in_data_crc = -1;
           ~~~^
   net/ceph/messenger_v2.c:1783:37: note: forward declaration of 'struct cepn_connection'
   static int prepare_read_data(struct cepn_connection *con)
                                       ^
   net/ceph/messenger_v2.c:1788:47: error: incomplete definition of type 'struct cepn_connection'
           ret = prepare_read_data_len(con, data_len(con->in_msg));
                                                     ~~~^
   net/ceph/messenger_v2.c:1783:37: note: forward declaration of 'struct cepn_connection'
   static int prepare_read_data(struct cepn_connection *con)
                                       ^
   net/ceph/messenger_v2.c:1790:6: error: incomplete definition of type 'struct cepn_connection'
                   con->v2.in_state = IN_S_PREPARE_READ_DATA_CONT;
                   ~~~^
   net/ceph/messenger_v2.c:1783:37: note: forward declaration of 'struct cepn_connection'
   static int prepare_read_data(struct cepn_connection *con)
                                       ^
   net/ceph/messenger_v2.c:1842:24: error: use of undeclared identifier 'iter'
           if (!iov_iter_is_bvec(iter))
                                 ^
   net/ceph/messenger_v2.c:1881:10: error: implicit declaration of function 'handle_epilogue' [-Werror,-Wimplicit-function-declaration]
                   return handle_epilogue(con);
                          ^
   net/ceph/messenger_v2.c:1881:10: note: did you mean 'decode_epilogue'?
   net/ceph/messenger_v2.c:573:12: note: 'decode_epilogue' declared here
   static int decode_epilogue(void *p, u32 *front_crc, u32 *middle_crc,
              ^
   net/ceph/messenger_v2.c:1898:24: error: use of undeclared identifier 'iter'
           if (!iov_iter_is_kvec(iter))
                                 ^
   net/ceph/messenger_v2.c:1951:28: error: incompatible pointer types passing 'struct ceph_connection *' to parameter of type 'struct cepn_connection *' [-Werror,-Wincompatible-pointer-types]
                   return prepare_read_data(con);
                                            ^~~
   net/ceph/messenger_v2.c:1783:54: note: passing argument to parameter 'con' here
   static int prepare_read_data(struct cepn_connection *con)
                                                        ^
   net/ceph/messenger_v2.c:2938:12: error: static declaration of 'handle_epilogue' follows non-static declaration
   static int handle_epilogue(struct ceph_connection *con)
              ^
   net/ceph/messenger_v2.c:1881:10: note: previous implicit declaration is here
                   return handle_epilogue(con);
                          ^
   net/ceph/messenger_v2.c:3012:28: error: incompatible pointer types passing 'struct ceph_connection *' to parameter of type 'struct cepn_connection *' [-Werror,-Wincompatible-pointer-types]
                           ret = prepare_read_data(con);
                                                   ^~~
   net/ceph/messenger_v2.c:1783:54: note: passing argument to parameter 'con' here
   static int prepare_read_data(struct cepn_connection *con)
                                                        ^
   net/ceph/messenger_v2.c:3014:8: error: use of undeclared identifier 'IN_S_PREPARE_READ_SPARSE_DATA'
                   case IN_S_PREPARE_READ_SPARSE_DATA:
                        ^
   1 warning and 10 errors generated.


vim +1783 net/ceph/messenger_v2.c

  1782	
> 1783	static int prepare_read_data(struct cepn_connection *con)
  1784	{
  1785		int ret;
  1786	
  1787		con->in_data_crc = -1;
  1788		ret = prepare_read_data_len(con, data_len(con->in_msg));
  1789		if (ret == 0)
  1790			con->v2.in_state = IN_S_PREPARE_READ_DATA_CONT;
  1791		return ret;
  1792	}
  1793	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
