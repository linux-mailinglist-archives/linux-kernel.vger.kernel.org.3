Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96977494985
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiATIc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:32:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:45528 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234116AbiATIcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642667575; x=1674203575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YEP8OBUJ2Yl4udmcU0gumYgcLsHyyl58EBUQwZ6C8cE=;
  b=Ya0+tPYlWdoH8E+ENZtKfBOe6iqMkwveDq8z3XG/il9khsr50LH0+KBr
   k3W5IOrlkO/I05BqmQOHMrFXeIgG9pSMFlvBUNfy3rTSaHgDxXwkIQPAI
   07bfXKdFbaWbAZTCHTKOSbo4MEnXnz2Oz9VFFPP+VsqzPsnlWuWLFJM91
   Qsn1m65YTt5nAXrjMsZRGKhGPpkmIHsO5e1zrGPelwpCxzY9t3j/Z6ys8
   Hg8JNbTjY6h5qdukEb4xMtNByDRc9oo2vrfm/S8Kki6j2soGPX6cMNJhF
   gaDsVPq4HIqAPEAq8hlKdrz2Hq1vEGwOL3RvWBsahHi59ggDWBcO2nxl3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="308637668"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="308637668"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 00:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="616006213"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2022 00:32:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nASsH-000E8s-Hy; Thu, 20 Jan 2022 08:32:53 +0000
Date:   Thu, 20 Jan 2022 16:32:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-upstream 15/35] ld: Unexpected run-time relocations
 (.rel) detected!
Message-ID: <202201201627.jQaRSiQq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-upstream
head:   b893f6d89d7f317a3059ce66d362d18b6036ae2c
commit: d8bd4e38f74301c8e7c103e11fa302acbb97518c [15/35] x86/boot: Allow to hook up alternative port I/O helpers
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220120/202201201627.jQaRSiQq-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/d8bd4e38f74301c8e7c103e11fa302acbb97518c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout d8bd4e38f74301c8e7c103e11fa302acbb97518c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld: Unexpected run-time relocations (.rel) detected!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
