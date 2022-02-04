Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D9B4AA3F4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377853AbiBDXFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:05:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:46407 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376312AbiBDXE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644015898; x=1675551898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=861LxwAxTcjqLzCznC0PQu9lKsLTusKaC3uSWwNiJDk=;
  b=i2Z4fMSDNaMRPpt+mN2QnimW80NHZ+a0MsEIHht3X5pgbDdiS8WGBM+V
   aMu6ayC2gomljPBWU3+19cu1YaW8pamUBqqluZZz8uEbvY34eOY2KZSsM
   iGzyX1Oxt2y9BRSCA50hlTkHmEziyMdNlkxGw2Sl96hsdnznfcME032iB
   SSg94vkfIwJ645lLese518upXGRYoWnqrK6AHLtcMGe5yfY5HZNGcOFUA
   I9VOPaqoSC8mmvPU2BI2n5po3G+SvPOvdkFkk7E7rtmj7BPye6paDln7f
   fNxWe1OAbgKK3hNotnF79HRxN3tLxSrzs+qp0XvC0yBO07nPjBbcNAIB1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="232024503"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="232024503"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:04:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="631843346"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Feb 2022 15:04:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG7dP-000YHT-FE; Fri, 04 Feb 2022 23:04:55 +0000
Date:   Sat, 5 Feb 2022 07:04:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: Wrongly bound Elantech touchpad on Lenovo Yoga Slim 7
Message-ID: <202202050657.m9Z8VsGr-lkp@intel.com>
References: <s5hleyqwowl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hleyqwowl.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on hid/for-next linux/master linus/master v5.17-rc2 next-20220204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Takashi-Iwai/Wrongly-bound-Elantech-touchpad-on-Lenovo-Yoga-Slim-7/20220205-005753
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: x86_64-randconfig-a003-20220131 (https://download.01.org/0day-ci/archive/20220205/202202050657.m9Z8VsGr-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/9f3fbdd527662d97eb0bece1005d96a0a1b0fac2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Takashi-Iwai/Wrongly-bound-Elantech-touchpad-on-Lenovo-Yoga-Slim-7/20220205-005753
        git checkout 9f3fbdd527662d97eb0bece1005d96a0a1b0fac2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x87e136): Section mismatch in reference from the function elan_probe() to the variable .init.rodata:elan_i2c_denylist
The function elan_probe() references
the variable __initconst elan_i2c_denylist.
This is often because elan_probe lacks a __initconst
annotation or the annotation of elan_i2c_denylist is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
