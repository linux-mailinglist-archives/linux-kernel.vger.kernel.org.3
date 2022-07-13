Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06137573E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbiGMVDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiGMVDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:03:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C332BBB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657746191; x=1689282191;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uY73eBb1wOZQSGxxYzPE4kzPBm7bXyS0s4v2yaXvTlQ=;
  b=RkqpQo/a4J7/rGzl2Hg2YnaOj8Qj/P42dX9/VS8xeM96FWT0xQsR8Dp5
   McHLMRq0TX1lSJGwzTzTBLUg2PNgXlPSrDFuoZgEHJcpHTO6oDW+M9zZE
   yXX3rizZPNsrFsL3qo3kArShZyiNwE2JvdSjpkxvg+17xIhwXjh/cgGK8
   SXbf0jkQ0jter98BCgnvivOWelJiR8xqJR/RaYbAEKUnwGJqymPPlZcKA
   Uvq3ZbwgELUiJnyB/dA3ckxZqM+9AEEaCFwpa0vQIYkRVtw/IwvfpEa6i
   MLhPK3ZagGzPYvO9RSW+EiaUFzg5nFkL1bZ0AHf1SHNcG9Q3jl5VOdTNx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282898594"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="282898594"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 14:03:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="922797636"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2022 14:03:10 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBjVl-0003n9-Qo;
        Wed, 13 Jul 2022 21:03:09 +0000
Date:   Thu, 14 Jul 2022 05:02:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-06 11/17] dev.c:undefined reference to
 `dev_run_xdp_dequeue'
Message-ID: <202207140431.C7TYkTFB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-06
head:   eb15b48f1b85d5986f1c2dbaf68c3c27e93f0c0c
commit: 0fb9291256bd9a2e0b9a58ce6755891bcdf21938 [11/17] dev: Add XDP dequeue hook
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220714/202207140431.C7TYkTFB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=0fb9291256bd9a2e0b9a58ce6755891bcdf21938
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-06
        git checkout 0fb9291256bd9a2e0b9a58ce6755891bcdf21938
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/core/dev.o: in function `net_tx_action':
>> dev.c:(.text+0x7a20): undefined reference to `dev_run_xdp_dequeue'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
