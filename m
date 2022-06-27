Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0B55CF21
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbiF0VJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiF0VJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:09:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFA0637A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656364193; x=1687900193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0fE4uqkmbAo0XocW6zntSFynh6Ikk+Ql8U35pWSqPe0=;
  b=UYjfAO6fZVAAdG063+y6P5V61NBCn1TgThZtwt+eXm0kcqJilStKyadT
   lwO8iNAmwOYYlz38IZs8Df7A65Cr9MLeOExgmkHUmKiJS2VRss5brmcpK
   ebAyk6JrtIxG3WqMsQ8JJRiQrsugYLQqzmHqjTqGnKqOvwEDM3rbQBnJN
   /5UDE+V7C2UXXY6npNh+he5X8FVSSngMS+OvoJ0pht9tXbs+LIO7KOUbx
   mx/mGpbf/4djAqdiB8btBQipVTliRemBH3nM/upL9ElEZ7a4gdnTzDF4A
   n7QaTzz3RlYZu4abStz37lywIsRXf8NYVkfGtzmXJvaZclb9SFh3NUwy7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="261975315"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="261975315"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692792064"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2022 14:09:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5vzT-00092Z-2c;
        Mon, 27 Jun 2022 21:09:51 +0000
Date:   Tue, 28 Jun 2022 05:08:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [jirislaby:lto 7/48] kernel/static_call_inline.c:504:22: warning: no
 previous prototype for 'sc_func_a'
Message-ID: <202206280510.uGOwzwNF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   b5ee1c28376713353cb5355716949d9c6d9b416b
commit: 7968aa68d8a410363407df9a678f4027874affcb [7/48] static_call: Make static call functions visible
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220628/202206280510.uGOwzwNF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=7968aa68d8a410363407df9a678f4027874affcb
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout 7968aa68d8a410363407df9a678f4027874affcb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/static_call_inline.c:504:22: warning: no previous prototype for 'sc_func_a' [-Wmissing-prototypes]
     504 | __visible_on_lto int sc_func_a(int x)
         |                      ^~~~~~~~~


vim +/sc_func_a +504 kernel/static_call_inline.c

   503	
 > 504	__visible_on_lto int sc_func_a(int x)
   505	{
   506		return x+1;
   507	}
   508	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
