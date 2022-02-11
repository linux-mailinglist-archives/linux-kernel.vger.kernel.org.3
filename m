Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C664B1EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346494AbiBKG4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:56:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiBKG4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:56:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D735E90
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644562594; x=1676098594;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iB/lM/znErfMvbjv71Zr8IwM0QF4HnkvtbKONtDkg4o=;
  b=DNolEssU5TiebZ8gWlK6csZIFtDMwKkeyG7AlIb7m5xdEY/o8rH5Pql/
   EEC925N6r1c19QMy46gctN33Gd9pECk/ukn1tW6ULuzExbJgql0i09QT4
   2XrE+8JZdpFAwmjkE2ijCxx7aZlPgQ3K7iMbC26vCmEoJ2YiSDSL3xC5Q
   4SKgXQMMdidIjLU4jWFLpF029WmlQakRfchYJJO2/oeCWe458Ei4R56Ul
   ffFTb5wvAV398jMkt5onNezClwL9LvOE1dHQLnfK4FY5gtXN0BKbpVmkl
   3OCIVSTEWF+xwNg8k2Dnr0xlNa8ts7+RpQIro9IrrDwe4uW38G6Fz7ZK/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274230762"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="274230762"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701997783"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 22:56:33 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIPr6-0004Fw-JS; Fri, 11 Feb 2022 06:56:32 +0000
Date:   Fri, 11 Feb 2022 14:55:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt 57/57] net/ceph/messenger_v2.c:1783:37:
 warning: 'struct cepn_connection' declared inside parameter list will not be
 visible outside of this definition or declaration
Message-ID: <202202111451.CXV1VUqM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt
head:   adf69efebc954db1aa7af7b93febbc2a1b51dc6c
commit: adf69efebc954db1aa7af7b93febbc2a1b51dc6c [57/57] libceph: define a structure to track SPARSE_READ reply processing
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220211/202202111451.CXV1VUqM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=adf69efebc954db1aa7af7b93febbc2a1b51dc6c
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt
        git checkout adf69efebc954db1aa7af7b93febbc2a1b51dc6c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ceph/messenger_v2.c:1783:37: warning: 'struct cepn_connection' declared inside parameter list will not be visible outside of this definition or declaration
    1783 | static int prepare_read_data(struct cepn_connection *con)
         |                                     ^~~~~~~~~~~~~~~
   net/ceph/messenger_v2.c: In function 'prepare_read_data':
   net/ceph/messenger_v2.c:1787:5: error: dereferencing pointer to incomplete type 'struct cepn_connection'
    1787 |  con->in_data_crc = -1;
         |     ^~
   net/ceph/messenger_v2.c:1788:30: error: passing argument 1 of 'prepare_read_data_len' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1788 |  ret = prepare_read_data_len(con, data_len(con->in_msg));
         |                              ^~~
         |                              |
         |                              struct cepn_connection *
   net/ceph/messenger_v2.c:1759:58: note: expected 'struct ceph_connection *' but argument is of type 'struct cepn_connection *'
    1759 | static int prepare_read_data_len(struct ceph_connection *con, int len)
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~^~~
   net/ceph/messenger_v2.c: In function 'prepare_sparse_read_data_cont':
   net/ceph/messenger_v2.c:1842:24: error: 'iter' undeclared (first use in this function)
    1842 |  if (!iov_iter_is_bvec(iter))
         |                        ^~~~
   net/ceph/messenger_v2.c:1842:24: note: each undeclared identifier is reported only once for each function it appears in
   net/ceph/messenger_v2.c:1881:10: error: implicit declaration of function 'handle_epilogue'; did you mean 'decode_epilogue'? [-Werror=implicit-function-declaration]
    1881 |   return handle_epilogue(con);
         |          ^~~~~~~~~~~~~~~
         |          decode_epilogue
   net/ceph/messenger_v2.c:1839:19: warning: unused variable 'in_iter' [-Wunused-variable]
    1839 |  struct iov_iter *in_iter = &con->v2.in_iter;
         |                   ^~~~~~~
   net/ceph/messenger_v2.c: In function 'prepare_sparse_read_header':
   net/ceph/messenger_v2.c:1898:24: error: 'iter' undeclared (first use in this function)
    1898 |  if (!iov_iter_is_kvec(iter))
         |                        ^~~~
   net/ceph/messenger_v2.c:1895:19: warning: unused variable 'in_iter' [-Wunused-variable]
    1895 |  struct iov_iter *in_iter = &con->v2.in_iter;
         |                   ^~~~~~~
   net/ceph/messenger_v2.c:1893:17: warning: unused variable 'bv' [-Wunused-variable]
    1893 |  struct bio_vec bv;
         |                 ^~
   net/ceph/messenger_v2.c: In function 'prepare_read_tail_plain':
   net/ceph/messenger_v2.c:1951:28: error: passing argument 1 of 'prepare_read_data' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1951 |   return prepare_read_data(con);
         |                            ^~~
         |                            |
         |                            struct ceph_connection *
   net/ceph/messenger_v2.c:1783:54: note: expected 'struct cepn_connection *' but argument is of type 'struct ceph_connection *'
    1783 | static int prepare_read_data(struct cepn_connection *con)
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~^~~
   net/ceph/messenger_v2.c: At top level:
   net/ceph/messenger_v2.c:2938:12: error: static declaration of 'handle_epilogue' follows non-static declaration
    2938 | static int handle_epilogue(struct ceph_connection *con)
         |            ^~~~~~~~~~~~~~~
   net/ceph/messenger_v2.c:1881:10: note: previous implicit declaration of 'handle_epilogue' was here
    1881 |   return handle_epilogue(con);
         |          ^~~~~~~~~~~~~~~
   net/ceph/messenger_v2.c: In function 'populate_in_iter':
   net/ceph/messenger_v2.c:3012:28: error: passing argument 1 of 'prepare_read_data' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3012 |    ret = prepare_read_data(con);
         |                            ^~~
         |                            |
         |                            struct ceph_connection *
   net/ceph/messenger_v2.c:1783:54: note: expected 'struct cepn_connection *' but argument is of type 'struct ceph_connection *'
    1783 | static int prepare_read_data(struct cepn_connection *con)
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~^~~
   net/ceph/messenger_v2.c:3014:8: error: 'IN_S_PREPARE_READ_SPARSE_DATA' undeclared (first use in this function); did you mean 'IN_S_PREPARE_SPARSE_DATA'?
    3014 |   case IN_S_PREPARE_READ_SPARSE_DATA:
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |        IN_S_PREPARE_SPARSE_DATA
   At top level:
   net/ceph/messenger_v2.c:1834:12: warning: 'prepare_sparse_read_data_cont' defined but not used [-Wunused-function]
    1834 | static int prepare_sparse_read_data_cont(struct ceph_connection *con)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
