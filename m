Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5003E49F25B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbiA1EUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:20:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:23907 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345967AbiA1ETz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643343595; x=1674879595;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YwUzDndx8KsWkO0pU7mV4VOgoPpD3+rTT7DTileunWY=;
  b=eXOddZJtmqB9zatiOe4b9Z0Y0QSGIy76JEvYAuTsoVUst5HnZCQP2jJZ
   NpXNLPiA5B47z0zL2l5CbWDXFdJZz3fOlZMMqMV5KjHrBm8UHPHTPOFq5
   u6m/W89yG0OkwM6B80NLMrzGVQi9asCSk2SVeo0hFvlIjFGoMMg4f7T08
   nfjaNET/MBuj/xcIgqfu4PY1OpEJXY4/7rliCh002X8eWDr2rAHWV7jZp
   k4ry79tpWtsjc5YAdVJ5YRnft5mo4bCVXsoQ/es68ts3Q/2C4PC5tZQzm
   Hp7YrbcBh3MG1U1fCRRmyN4R+luKVJVhY/pnhd5M3iPv96NlYjtfgMyDy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="245884866"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245884866"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 20:19:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480590569"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2022 20:19:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDIjp-000NSH-1b; Fri, 28 Jan 2022 04:19:53 +0000
Date:   Fri, 28 Jan 2022 12:19:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: dtbs_check: arch/arm/boot/dts/socfpga_arria5_socdk.dt.yaml: /:
 '3-3-v-regulator' does not match any of the regexes: '.*-names$',
 '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\-._]{0,63}$',
 '^[a-zA-Z][a-zA-Z0-9,+\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\-._]{0,...
Message-ID: <202201281238.OIJj04Zi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
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
