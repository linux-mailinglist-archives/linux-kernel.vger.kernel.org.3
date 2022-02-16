Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCD4B7FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiBPFBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:01:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiBPFBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:01:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE1A1A9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644987686; x=1676523686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i1jBEqV5rPtfWQlJDhdZ4S7M13/5/aSE4lRpY+/gb+I=;
  b=iC65xFSYDgwSqwHrP518YIe0inbOhA0yvhn+no/T/o5zQADgJEg347u3
   UGKm82GqMB0wG7UwAscKrDrs5RTW6qAzoyHJls07AK3ABupORxVzn+N28
   ChVo+2sNbScbUrrkdZHeBlNv+UyQryMqXC0cOAhxkkWMjqSaiTsuMdeSj
   OqPFFG93E/K6QWmfnZ92bzb0eLnOANigoMtD62h5uaSwxpQPPPWZNNm9F
   xkD8ylUJCQwRzk38cvcKP0i7wbhdzf1ciMdfK2amOLGml1BY2K8JsUWlA
   633+0Mx2v3CNUgaiPI3KIJnJjch1jRO5wPypkD0QEWDrHafHiKAHPMUOv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="231151187"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="231151187"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 21:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="636327738"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 21:01:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKCRQ-000AQi-8H; Wed, 16 Feb 2022 05:01:24 +0000
Date:   Wed, 16 Feb 2022 13:00:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [ammarfaizi2-block:axboe/linux-block/m1-test 314/382]
 kernel/reboot.o: warning: objtool: sys_off_handler_power_off() falls through
 to next function register_power_off_handler()
Message-ID: <202202161223.yfRXt35T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1-test
head:   5adfbb595194191bad98c47447ddbee7d3b60b8f
commit: d4c326600862cf161d7cd7dbc0bbf7f8cb01b500 [314/382] kernel: Add combined power-off+restart handler call chain API
config: x86_64-randconfig-m001-20220214 (https://download.01.org/0day-ci/archive/20220216/202202161223.yfRXt35T-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/d4c326600862cf161d7cd7dbc0bbf7f8cb01b500
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1-test
        git checkout d4c326600862cf161d7cd7dbc0bbf7f8cb01b500
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/reboot.o: warning: objtool: sys_off_handler_power_off() falls through to next function register_power_off_handler()

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
