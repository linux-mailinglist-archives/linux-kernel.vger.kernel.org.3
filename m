Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86FC573FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiGMWp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiGMWpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:45:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0514F186
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657752324; x=1689288324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t0fkYSwkITJ8tGBSMmcGaiIjSVk8ACFm/OG23j4g2zQ=;
  b=R4rtpBMdl0t7dCYug2Wmf8F/hb7wQxkwPUKkVbmCov/KlPnuobsl6a43
   /ehNQYH9cd/NHklp9b6APIOBhA+92Y7ftGZPSVUadZD4Ug3JlpuFiQFRD
   rgdWBkcN8qP9zJLO9NY3B5XMbvJxalAKy+1Uvm+SrRVxoDlFyIDdvGc8y
   DYt6zDQ0n3HljsLYOrY7CsiTWMsYbcjEXSwqKsXrCUcf8BctUAiLAPmhv
   o/yEzHuMSrS+0Q4z5SCOUR4rSu0kvJahRZUEjpdqYZHwRx1krqoxArx9A
   cqbp5Gyuhw8DcLYf48i3T1N/pyjmbxFAQIIfKxicywfNEymnyJGW3IGaM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285386826"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="285386826"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 15:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="570818101"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2022 15:45:22 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBl6f-0003qx-MV;
        Wed, 13 Jul 2022 22:45:21 +0000
Date:   Thu, 14 Jul 2022 06:44:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-06 12/17] filter.c:undefined reference to
 `dev_schedule_xdp_dequeue'
Message-ID: <202207140626.zPqDam4s-lkp@intel.com>
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
commit: a32ddb0c8337335ecce0a6a4f2f86297906ea5e5 [12/17] bpf: Add helper to schedule an interface for TX dequeue
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220714/202207140626.zPqDam4s-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=a32ddb0c8337335ecce0a6a4f2f86297906ea5e5
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-06
        git checkout a32ddb0c8337335ecce0a6a4f2f86297906ea5e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/core/dev.o: in function `net_tx_action':
   dev.c:(.text+0x11955): undefined reference to `dev_run_xdp_dequeue'
   ld: net/core/filter.o: in function `bpf_schedule_iface_dequeue.constprop.0':
>> filter.c:(.text+0x1235c): undefined reference to `dev_schedule_xdp_dequeue'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
