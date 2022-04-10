Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C384FB0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 01:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiDJX1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 19:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243437AbiDJX0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:26:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A23520192
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649633083; x=1681169083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vs+iY8oK0qHZfUcC9MHwcZsvx/hIx+dS5NECv9WowVw=;
  b=kpCE7fE5lNrfXASXqGFQ1y4AqFSS+1BBv2NkhJyrn2sd94DAikYx2zFj
   gGKCrVQY539AxaSO3rGV4v7SEp5mhUuOA3DrPCQT/GTyf99zn/RlvfS6x
   x6FfBExHiquzE1FLoq+PmAz9VeNMY6utx1WIXo4OkjZh3ZDwo1748m2Fa
   CJDAX5KB/33qZ5btPS4ejIeiK/H+rWeYUOrAeBhMI2FIXe0WDAEDhwEQ6
   7x7mW9MqSZXjfdiHQCHYO6n+PIIbPk+McTpwQEfO56MdAwEQdJ1USaDeG
   23qaLBeDO+c8zva6AA4yzd3EETp2H92eJa3dn7gOb/OjEYCnTGMd07UcF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242591179"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="242591179"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 16:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="506886682"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2022 16:24:41 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndgvA-0001Bf-KI;
        Sun, 10 Apr 2022 23:24:40 +0000
Date:   Mon, 11 Apr 2022 07:24:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: or1k-linux-ld: drivers/net/dsa/realtek/realtek-smi.o:undefined
 reference to `rtl8366rb_variant'
Message-ID: <202204110757.XIafvVnj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4ea3c6425269d33da53c79d539ce9554117cf4d4
commit: 765c39a4fafe6f7ea0d370aa5f30c811579cf8eb net: dsa: realtek: convert subdrivers into modules
date:   2 months ago
config: openrisc-buildonly-randconfig-r003-20220411 (https://download.01.org/0day-ci/archive/20220411/202204110757.XIafvVnj-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=765c39a4fafe6f7ea0d370aa5f30c811579cf8eb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 765c39a4fafe6f7ea0d370aa5f30c811579cf8eb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> or1k-linux-ld: drivers/net/dsa/realtek/realtek-smi.o:(.rodata+0x16c): undefined reference to `rtl8366rb_variant'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
