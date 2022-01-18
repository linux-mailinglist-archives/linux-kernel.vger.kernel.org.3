Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB3492462
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbiARLNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:13:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:51656 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238030AbiARLNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642504412; x=1674040412;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1/OOUta8UyGm3KE2FDkDktaJwmazYsl1rfPj7CooCz8=;
  b=JlpaAVMa/2kkdm9J7wbnPvDmbiUMKZoMHh1QDYRyyLrSB056QhiEqYsE
   jyql19iXgZQSq6QZEvN+OiodkGuKn1PuyKMpDbkJ3Fvscw+z6rnRtQ6mp
   uCxzkgQBhG9FLt8Aqwmk4KdDR0QnO53s5OOyf00XSVABgTPhFy6KWDtIX
   keON+kBmYWSbgBronVBt9wPIfpgCdHU/EMk/sy+AifqZml0V/E1bV5Rm2
   +6MmYPr0bCnyQaYjC5hGccSq5O18VFjh9eHXYAVduZ1nyWfyClj/KTVbY
   DZ3xkl43dhMJ8R3zNg4vm/8o1AqxhCHC3jPv6y7alzdJBIJroi7uSzGLN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="308129616"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="308129616"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="517728584"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2022 03:13:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9mQb-000CUL-I4; Tue, 18 Jan 2022 11:13:29 +0000
Date:   Tue, 18 Jan 2022 19:12:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: dtbs_check: arch/arm/boot/dts/socfpga_arria5_socdk.dt.yaml: soc:
 'l3regs@0xff800000' does not match any of the regexes: '.*-names$',
 '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\-._]{0,63}$',
 '^[a-zA-Z0-9][a-zA-Z0-9,+\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\...
Message-ID: <202201181227.wiIEOItY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   35ce8ae9ae2e471f92759f9d6880eab42cc1c3b6
commit: 4483397b03536506535d611b0cb28a81a69e8edf ARM: socfpga: drop ARCH_SOCFPGA
date:   10 months ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
