Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2211050A9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392188AbiDUUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387130AbiDUUI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:08:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8FE4C795
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650571538; x=1682107538;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w2ybIKuJWhV4JC31zdCZy12Bc7kl5NsB8RnG0A9ORzY=;
  b=i7gw8aORf/bliHbTzHHGJVh7ji/fohcTWZ0tArYnNkjPasLvSVDpij9x
   gulKIbclFY7ZI4l9CxyCxYkT+8gZa8ulgftOoHDGBongtHYW6guQW4kdU
   CWqtt00nI89ISKOBR1ehOpyU7d0AU6CMS1SUh1KoT9ZF3qMddNaf7npL5
   usKptw1MkC+FQhzhab5Wiyb1UppFUBKXJL9DwvF9OdzrAec95NkKRuf0v
   jlrrNRnqdeGx0rAOcfF0M7JDWY72n0l9Z2nwLt20Hxw+1pR0AvO1Z7BgZ
   HqdK7Rh1tqCgxf+J1EVFIaUqr7vB/dXgwvhI+EMgoccpbMKSYpH37xiX4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244390199"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="244390199"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 13:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="530469195"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Apr 2022 13:05:37 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhd3Y-0008jv-D3;
        Thu, 21 Apr 2022 20:05:36 +0000
Date:   Fri, 22 Apr 2022 04:05:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-rebased 77/83] arch/x86/kernel/head_64.o: warning:
 objtool: verify_cpu()+0x4d: unreachable instruction
Message-ID: <202204220440.BCSQowTi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-rebased
head:   4c095660b91dbdd18042456e395af0deeef93485
commit: 557120ad3fe964723adac78b3cbf4193c4327d78 [77/83] [REVERTME] x86/tdx: Add CONFIG option for KVM SDV workarounds
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220422/202204220440.BCSQowTi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/557120ad3fe964723adac78b3cbf4193c4327d78
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-rebased
        git checkout 557120ad3fe964723adac78b3cbf4193c4327d78
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/head_64.o: warning: objtool: verify_cpu()+0x4d: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
