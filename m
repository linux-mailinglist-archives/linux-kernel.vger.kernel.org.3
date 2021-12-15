Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43C47648A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhLOV1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:27:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:2161 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhLOV1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639603640; x=1671139640;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xHU1ObsGFqyr+FLsTdmHeJ9K4lpChzxMzhe+2U9EKbQ=;
  b=cHhab/RKayojLrXd9/eWEdNAQt7kwYD9zdY8AsFDpJedB/644zKxrVaz
   TfD4DnryvusMA90HwY/6D6UvQfeYqE7Ymzd70AA7+YU/NPzt7kqzkHqc1
   xmhD99VkwhFTXzCWXUcBOcYq1eQ/BZo974ssFWC5YnywO/IzdQUDN7nfd
   O289T7KlRFll2/POG/UEhv3fmI2CukY7RbudSbv9GlP3vz91nLMjFXZK2
   MnuoSQY+fLAgUxbLqvr8pJMh93CprUbiZ+LXWvoKwDptE8XroClHkoA+a
   CDCcd8lK/3V7+OFEKwtd5N43uHWJQK9U2HcDa3OC8P5C5uImLx3MDTIxJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="302712378"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="302712378"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 13:27:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="614876080"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2021 13:27:19 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxbny-0002MD-BK; Wed, 15 Dec 2021 21:27:18 +0000
Date:   Thu, 16 Dec 2021 05:26:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [t-kristo-pm:usi-5.16-v5-bpf 16/19]
 ./usr/include/linux/bpf_hid.h:13:10: fatal error: linux/workqueue.h: No such
 file or directory
Message-ID: <202112160506.yDE4Oasz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-v5-bpf
head:   82a2c7cbd9682f2664179cd7e01647e46272c316
commit: 8ffc42bfd37f05ffa2c284b71a6c3bb5021fac8f [16/19] HID: bpf: add support for new workqueue triggering BPF call
config: x86_64-randconfig-a014-20211215 (https://download.01.org/0day-ci/archive/20211216/202112160506.yDE4Oasz-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/t-kristo/linux-pm/commit/8ffc42bfd37f05ffa2c284b71a6c3bb5021fac8f
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-v5-bpf
        git checkout 8ffc42bfd37f05ffa2c284b71a6c3bb5021fac8f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/bpf_hid.h:13:10: fatal error: linux/workqueue.h: No such file or directory
      13 | #include <linux/workqueue.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
