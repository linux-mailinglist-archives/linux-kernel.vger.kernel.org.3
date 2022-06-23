Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B047455710E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377856AbiFWCaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiFWCaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:30:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE93403CD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655951406; x=1687487406;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ygVJHjUr72DncGBeB6H6pJHG1C8V0aJ/deWt1FF1pUM=;
  b=GS8KfFWyM5fDZFcm99UBq/GYJNuaTCbuYi+vEnTw8hGGHAZE8NkAFZfO
   /ISIFYK13PyyQTcmNySZiVnC7UsjhJ/AZvwBeKBFptik6ISvg2EkrnVN3
   qt5ikkYHtVdKiYNfHzCGZwV9u9O+V8erYa/2Gw9ZwCRdmm+RGmQPV07Z7
   +GVUHNUe4tj9K6VE0HjGzDerk5yDzyyXpUwTduKHAWjiMeBbir2n9mgW7
   cte5CHiAhWafTOkmgBDzvWy1g4G37y5vx39vaSjb2jxH3z5pvDqllsblU
   RpfbqjBko1g1LDh2FJpw4u1BYdc1lkbw1JytHVowMYE+ivQbuRBgPt0Hy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342287687"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="342287687"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 19:30:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="715652599"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 19:30:04 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4Cbb-0000Ov-JV;
        Thu, 23 Jun 2022 02:30:03 +0000
Date:   Thu, 23 Jun 2022 10:29:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: [jirislaby:lto 15/45] /bin/bash: line 1: -r: command not found
Message-ID: <202206231016.Zg0JS11J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   8047611082d70c5263114fabce8c80a4c3d251fa
commit: 47baf8791751ff4df700249d753214d74c9d803f [15/45] Kbuild, lto: Add Link Time Optimization support
config: hexagon-randconfig-r041-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231016.Zg0JS11J-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=47baf8791751ff4df700249d753214d74c9d803f
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout 47baf8791751ff4df700249d753214d74c9d803f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> /bin/bash: line 1: -r: command not found

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
