Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1F58D9EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbiHINv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbiHINvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:51:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6AB63F7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660053110; x=1691589110;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aKtPlszLj91DnSLWI6v2grczwttYIvtYJeZsjfBmvyU=;
  b=D6l1OOveMZEXH83KNP4Y7+yiwsxR3rWFJmu7pYhc3tRwtgaHw4cG3P91
   1f3UbKm4yJA/vIoFWv1SanCTTmPvx3uw7ik3iqhmt6c4Hb9Z/tbGFtymx
   7uHuftFQjnr5QtYK2W5CzRyXMxdxNu8KUWXo/9xG456u/QQoj8OEhIg/J
   CQWQzp0mGAygDkDUmVZbAzmfztyugo3U/ac/5cosuCJqlptfEfM+EAfPx
   iH6y2xeXQEymIgYFOC3qrm9HTP4aD6kghI81xaPiEzWM2k9TncfJ2SmS1
   H/0jgHpjxhTpp4TF17NN+uWn5xrtULu8WV8x7agFqHzDes3CxjjoUtu2w
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270611443"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="270611443"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 06:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="747044259"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2022 06:51:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLPe7-000My1-3D;
        Tue, 09 Aug 2022 13:51:48 +0000
Date:   Tue, 9 Aug 2022 21:51:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tal Cohen <talcohen@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 24/27]
 drivers/misc/habanalabs/gaudi2/gaudi2.c:3837:5: sparse: sparse: symbol
 'gaudi2_set_engine_cores' was not declared. Should it be static?
Message-ID: <202208092119.nTjk3pCL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   f34913141b3cb6da65860212be46960e97f4d44b
commit: 464bb4bbd5a316a10895bba40021b84a0cd6258b [24/27] habanalabs/gaudi2: new API to control engine cores running mode
config: i386-randconfig-s001-20220808 (https://download.01.org/0day-ci/archive/20220809/202208092119.nTjk3pCL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=464bb4bbd5a316a10895bba40021b84a0cd6258b
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 464bb4bbd5a316a10895bba40021b84a0cd6258b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:3837:5: sparse: sparse: symbol 'gaudi2_set_engine_cores' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
