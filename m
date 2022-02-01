Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E104A57C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiBAHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:32:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:44284 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233720AbiBAHc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643700749; x=1675236749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t9miSX30TX840SAzvdn/XzITUl8Uc4ypVaKt+AK1gyk=;
  b=iDPT3xETb1XR0uCRI40l2Sk4AUXI88N78NU2+ENPXARYjdOcN+5V/4DW
   r/NkszWsEzKn6jciv0WG7BdGHqM91MoOSTskusvoY7/yYVItvxM/2LuAw
   PbnO666U5nAToqd7PiapVI7jm8b+3wDXsuC6YhYferUShtGcg9jA/VGRJ
   JPXauTZDeYCs6czI+t+QriKRjbl37MjLsL7JFy5m5u0Zisjs8YiZzMssQ
   /OMJjZXDMOzCoqhp41W9EgX9YiEYd/ZT9Qbp8H9RAxg4AU0sIvD9wFMRU
   n5fqXXeyh+GpoU3XynsgC89I3HmcnMvr6xofi9Bdh8+Zfyr9i7ve52a3a
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="245227685"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="245227685"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:32:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="565510555"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2022 23:32:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEneL-000SyR-R5; Tue, 01 Feb 2022 07:32:25 +0000
Date:   Tue, 1 Feb 2022 15:32:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: dtbs_check: arch/arm/boot/dts/socfpga_arria5_socdk.dt.yaml: /:
 '3-3-v-regulator' does not match any of the regexes: '.*-names$',
 '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\-._]{0,63}$',
 '^[a-zA-Z][a-zA-Z0-9,+\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\-._]{0,...
Message-ID: <202202011507.GgCeHsB7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8c7e4ede46fe63ff10000669652648aab09d112
commit: 4483397b03536506535d611b0cb28a81a69e8edf ARM: socfpga: drop ARCH_SOCFPGA
date:   11 months ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
