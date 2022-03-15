Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB04D9411
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbiCOFoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245552AbiCOFoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:44:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12515F68
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647322974; x=1678858974;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vKLqgdrX1D20OabK5vs+RVD+2WZZSvXBVFAyEtLfaKw=;
  b=b29XfvGsy03LMYJrM4G8BvIAXI7M1CKhOfvZ2/ep35HTngn5Piiw3yMU
   iLzG1NEPfsjJ1EW6LNfZE0XUofkg2725mSwv/EZ8CsLYySKHfKRxvvE+Z
   MXFHbjUdhjmtszfkQT8WyGU5zKT62lPX89j6tNDfGheaf77JTjA460ZYt
   cBkdwhr8g0eDKQOEcfQeOFSlfia32P7nJ6r9V/99Pv+ym5Tiadm7Rno4d
   tcBnYjXOC7Duy0bW9Pat//ikyPG21g1aKsHxvLW68WjXoNYwdv/IGLtHE
   rh/LfPgzACdfs1eMFYP4dnnEtlb1Dcpdn05fMJPhlxKdpgWPTMFRsM1n+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253778780"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="253778780"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:42:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="515730299"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 22:42:52 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTzxL-000Abh-IO; Tue, 15 Mar 2022 05:42:51 +0000
Date:   Tue, 15 Mar 2022 13:41:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: [toke:xdp-queueing-03 7/9] filter.c:undefined reference to `bpf_log'
Message-ID: <202203151336.iJ9Hu2Wo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-03
head:   a043a41b1a69e5d034c8bdc1cdcce2f3df28a833
commit: 581e3988251592601ab763f144f827b71296beb9 [7/9] bpf: Enable direct packet access for dequeue packets
config: arm-randconfig-r004-20220313 (https://download.01.org/0day-ci/archive/20220315/202203151336.iJ9Hu2Wo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=581e3988251592601ab763f144f827b71296beb9
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-03
        git checkout 581e3988251592601ab763f144f827b71296beb9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: net/core/filter.o: in function `dequeue_btf_struct_access':
>> filter.c:(.text+0xc994): undefined reference to `bpf_log'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
