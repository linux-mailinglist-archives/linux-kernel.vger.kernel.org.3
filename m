Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96B54A882
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbiFNE4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241504AbiFNE4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:56:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAEB38197
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655182575; x=1686718575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1xbQFLsN1yyCoJIXPd9A/YJMlmAue8J/iynH1aqw9V8=;
  b=esQE2LrkmmweWKH7FuxViGq8SlMHg52PvSDmXzQiwCD5u7uuHD6KqYF7
   +nP5X6NDrkqH8257LbvJxqyZNznvJFiEWNW04HyIcoRugrIGS1go/+ama
   +EWhBRtL6IL5qYsdqsvdQdIPdjAAZovzeoF0uOwzTWl3pqSFkj5xW1+3I
   sYdVG/NpCN8j8x5vcS2kTf6ZE8mEH63godLdJocfmS0cRg4k9RoUD2jkS
   03imJYe0Su/8y9bL0EJy/TbYuGpbDBRtSv9laF5hwsSSivpFKHyoSmf6Y
   wyrzthmGkgsMUgluxM6VF5RW8vtsm56qeERO4Z2YImmCTPQVGnEXz57KQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303909532"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="303909532"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:56:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640137759"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jun 2022 21:56:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0yb7-000LUt-Sn;
        Tue, 14 Jun 2022 04:56:13 +0000
Date:   Tue, 14 Jun 2022 12:55:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/keys-fixes 1/2]
 system_keyring.c:undefined reference to `x509_load_certificate_list'
Message-ID: <202206141240.n4fGpU0E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/keys-fixes
head:   8dea6c86f1eed1f423e8be0c8f4877e22325e5e2
commit: 7538d043fdb18966abae4e888d9de2e0be3942ff [1/2] certs: Move load_certificate_list() to be with the asymmetric keys code
config: s390-buildonly-randconfig-r002-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141240.n4fGpU0E-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7538d043fdb18966abae4e888d9de2e0be3942ff
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/keys-fixes
        git checkout 7538d043fdb18966abae4e888d9de2e0be3942ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: certs/system_keyring.o: in function `load_system_certificate_list':
>> system_keyring.c:(.init.text+0x70): undefined reference to `x509_load_certificate_list'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
