Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1212E4B6242
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiBOEyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:54:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiBOEyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:54:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAE4C55AA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 20:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644900875; x=1676436875;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YU6kcuUoeqMB68UCW/H5aAcGjz47jaCjs+uiY9fjG74=;
  b=LR4SqRqzm7UfQTiSlc/tRdnl4NsHYv8AqbS1Ec5Kf2yDsV5k4R2b1gJh
   R1uf23gAr2fafv8cgCrOnO89RZAZhNMZP2BpYnHjHIEZmpwfD0lw8jbXY
   LOzkVeHZwJe7dttz9luGXvZCMffVxWoWTfwcn618C/KIIRIaNGmmIYt1f
   7DncQ+vNfTgpLEWhaQEbVb/44rKrkwpTBlT1WKPaCZmwXK1t2HwBXc28M
   WTrYv+EAIZ8AJ0VmD0+LHqFpF0NKhIpQ52mKiGYLaqvbYXoAKf/RIMkgG
   ONxpD2SWqmTJ18PON2Af7Gd1IOJ0DdvELLle3OuHOHHEMlBSPqH21YveB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230212308"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="230212308"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 20:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="703432558"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2022 20:54:33 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJprF-0009Ho-0R; Tue, 15 Feb 2022 04:54:33 +0000
Date:   Tue, 15 Feb 2022 12:54:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 13/39] ERROR:
 modpost: "netfs_releasepage" [fs/cifs/cifs.ko] undefined!
Message-ID: <202202151241.1W1hxLPK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   b995bc7182f60aa2b4d8930a7446f10dfbcebcc2
commit: d36d22552364a62e281dea83ff2ba46d471a21c0 [13/39] netfs: Provide invalidatepage and releasepage calls
config: i386-randconfig-a004-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151241.1W1hxLPK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/d36d22552364a62e281dea83ff2ba46d471a21c0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout d36d22552364a62e281dea83ff2ba46d471a21c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "netfs_releasepage" [fs/cifs/cifs.ko] undefined!
>> ERROR: modpost: "netfs_invalidatepage" [fs/cifs/cifs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
