Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B611C49D037
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbiAZRBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:01:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:63232 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243411AbiAZRAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643216437; x=1674752437;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dzazaE73zTV4hB458jhskjVKMSp/vV5S4qBm+l1Os0A=;
  b=B27SzUC0MEg6MYibHEdnfwEjBYsM/M5ORllO3WzlX9dlkHnuYkAW0dW6
   WVfPvS8sDE0QvfTwne1N8vVXI+ZnMMTPlut+8yyNTWWC9WVaPUuGKo0ta
   Xw5+RCj2MENZYxRVmXl1LtpyMgGRWoDdJOVACRW9ayd8E+TLLOShQ5GTF
   ZnjSh7aWscT5ZkRx6xlJvLb6H4Un8pDJoC6jI14FWupxTXaFvmUyf4C69
   Fa6jspBg5QVjS3XhmlCkgHxtY+eBhOcrWU626TgfgYbQ0PTFeO/bVblvk
   9EPo7jZNUDJFXe0CrxBxGkAbUfcaq8tmi5IYx3WvZ2SkhFJg37m6Ef7k7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246372662"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246372662"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 09:00:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="581161714"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2022 09:00:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCleM-000LPr-Hv; Wed, 26 Jan 2022 17:00:02 +0000
Date:   Thu, 27 Jan 2022 00:59:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:extron 101/103]
 ./usr/include/linux/cec.h:150:19: error: unknown type name 'bool'
Message-ID: <202201270048.Xzuv297t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git extron
head:   54377f21d8b2084a9f5993230bdab8e8cd55bb22
commit: d679f6adf24b7fef91e8a3b3584b48587e9cf0a2 [101/103] cec.h: add cec_msg_recv_is_tx_result() helper
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220127/202201270048.Xzuv297t-lkp@intel.com/config)
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
