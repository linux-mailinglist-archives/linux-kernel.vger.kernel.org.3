Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB184A9207
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356523AbiBDBbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:31:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:7592 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232338AbiBDBbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643938308; x=1675474308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VyGTKXxJ1IpuEpcC70siMf4YSeH5sUi26MWsLvw6lNw=;
  b=CXbmtClXZR9aFqVmq3h3zdzCubBSVRkaE/nPNwkppin+yaajiVdkm4sj
   zlqi7xFoIyS3DvVaacNaOCK49JZbLCbacxw6osnP3drEKyMKdVMbVEBMr
   JeVMaUh47R49XwSQYFrsYM+5dzUUL52DlmX+lps/cch9LKoiNz8ZJeIgl
   4XtKoZ7vz7ETe0hKWNY3v+buH2Fqg7AzikKP4aQ3QSpLh9dKq8BT4ujAT
   2dBYaj03OzzkcvMii6qCabD07MgIPMos9QFysiDAzEq6ZD2pJRD9mDTmi
   NgpN9f4k+TPYod1jcrImUxIpoIbhO33ulzepYs4PN8g0oN6yq07h357FV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="311595678"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="311595678"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="699529798"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2022 17:31:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFnRx-000WwN-71; Fri, 04 Feb 2022 01:31:45 +0000
Date:   Fri, 4 Feb 2022 09:30:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:extron 101/107]
 ./usr/include/linux/cec.h:150:19: error: unknown type name 'bool'
Message-ID: <202202040843.rcfO1kyB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

FYI, the error/warning still remains.

tree:   git://linuxtv.org/hverkuil/media_tree.git extron
head:   8cab2c3a2a07f1afb74b96f198b9d816afb28ffd
commit: d679f6adf24b7fef91e8a3b3584b48587e9cf0a2 [101/107] cec.h: add cec_msg_recv_is_tx_result() helper
config: x86_64-randconfig-a005-20220131 (https://download.01.org/0day-ci/archive/20220204/202202040843.rcfO1kyB-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree extron
        git checkout d679f6adf24b7fef91e8a3b3584b48587e9cf0a2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/linux/cec-funcs.h:11,
                    from <command-line>:32:
>> ./usr/include/linux/cec.h:150:19: error: unknown type name 'bool'
     150 | static __inline__ bool cec_msg_recv_is_tx_result(const struct cec_msg *msg)
         |                   ^~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
