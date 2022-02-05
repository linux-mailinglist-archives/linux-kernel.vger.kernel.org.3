Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9324AA62B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 04:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379151AbiBEDUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 22:20:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:61519 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238357AbiBEDUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644031210; x=1675567210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yM5X09rRZwT5cEQ9imFXrwu+8OaDAuvFupGBrgF+5Zo=;
  b=KRH6ztpenLw/mfw2lJWVxXdmU/+pwfzSr8ZLv1A86l8P2Ym4SSQGLJO0
   A6CF6FD5CCKCt7SsQHSLyujDz+y9CmnGVh1cztYVT3r/Leys3mWDAgbnw
   bt4ZhLbAr/nwSPT8/cGOPzzgI/qeJgzpVt//SWpAu9yzWOYGsFNCB6p4o
   zCCIsreCLXwdByyTsviptZskh/nocGJzniaLQnO5+fD9UY/UOgN3nXkCt
   qJcIhA28CnfMG3xz0E22eAQhpBALO2la1IeMJWgAaTOrWIILXg+zuyUzp
   VbIoaBZh839bMT2nGbE5RjX0kB9pH7VXaxKjfDotVyc0FY/SWeDboFvS6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="232050680"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="232050680"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 19:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="584320627"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2022 19:20:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGBcM-000YUa-Nx; Sat, 05 Feb 2022 03:20:06 +0000
Date:   Sat, 5 Feb 2022 11:19:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Boyd <swboyd@chromium.org>, benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Sean O'Brien <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: [PATCH 3/5] HID: Extract vivaldi hid feature mapping for use in
 hid-hammer
Message-ID: <202202051134.yIxi48BD-lkp@intel.com>
References: <20220204202021.895426-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204202021.895426-4-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I love your patch! Yet something to improve:

[auto build test ERROR on 26291c54e111ff6ba87a164d85d4a4e134b7315c]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/Input-HID-Consolidate-ChromeOS-Vivaldi-keyboard-logic/20220205-042211
base:   26291c54e111ff6ba87a164d85d4a4e134b7315c
config: s390-randconfig-r014-20220130 (https://download.01.org/0day-ci/archive/20220205/202202051134.yIxi48BD-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/83759eb892fd16fd0bb7ff4bb0c4baa4e7a0283e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stephen-Boyd/Input-HID-Consolidate-ChromeOS-Vivaldi-keyboard-logic/20220205-042211
        git checkout 83759eb892fd16fd0bb7ff4bb0c4baa4e7a0283e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x1336): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/input/vivaldi-keymap.o: in function `vivaldi_hid_feature_mapping':
>> (.text+0x13e): undefined reference to `hid_alloc_report_buf'
>> s390-linux-ld: (.text+0x18c): undefined reference to `hid_hw_raw_request'
>> s390-linux-ld: (.text+0x1e8): undefined reference to `hid_report_raw_event'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
