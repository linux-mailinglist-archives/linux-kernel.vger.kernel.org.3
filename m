Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145564DAF73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355611AbiCPMPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348955AbiCPMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:15:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71CF33EA4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647432861; x=1678968861;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M614pRt+vU5+k8Ns8OpEYGFm85yp3Q+Rf7WLnoRl3ic=;
  b=CgKqNAeEaq7dio4Y33FKR5n2i/aFwqHvmJectcBRawVgEqppQtdwh2ZS
   zZxWG15N2gOvHW5z7pJOE9okFzpnQ+2kBEpiYA/dAFkAZ8wFUNV8pZGoE
   ZDpirclmMQaTV+9wDPBa64Jvp70B0+FpnZrE1F+ayHgtpuFUuVK5Tb2cN
   woNPZPWpTc8CK96YTU+wNqEy0RtFDS3LHh8P6e14PJr5LRxyjTbcmOQTY
   P/CTQLRqfD3cU1yXZj+MGZfW6mINvlw0nUwKf18W81/kiRteB6XJ4fQ59
   xj8bugqHhWoCnoKEOv2eACamTBvss8nLdjWg70pyDMZZnzN9ogYJkZKGi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255394112"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="255394112"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="516303782"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 05:14:19 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUSXj-000CNj-1z; Wed, 16 Mar 2022 12:14:19 +0000
Date:   Wed, 16 Mar 2022 20:14:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-rebased 128/129] arch/x86/kernel/head_64.o:
 warning: objtool: verify_cpu()+0x4d: unreachable instruction
Message-ID: <202203162009.MT0Cnaca-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-rebased
head:   6d6cab7288e23cfe0084bd1c214e3649146eb159
commit: fc9eb9756100201dbc23d220d3441115866085c8 [128/129] [REVERTME] x86/tdx: Add CONFIG option for KVM SDV workarounds
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220316/202203162009.MT0Cnaca-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/fc9eb9756100201dbc23d220d3441115866085c8
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-rebased
        git checkout fc9eb9756100201dbc23d220d3441115866085c8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/head_64.o: warning: objtool: verify_cpu()+0x4d: unreachable instruction

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
