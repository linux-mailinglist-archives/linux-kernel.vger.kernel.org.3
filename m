Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FEF51307B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiD1KBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiD1KAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:00:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C637B1A88
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651139299; x=1682675299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q1opffEEwo5IGbaNrl0/HQqnHRrkm2E0pxDjl+Uq1Xg=;
  b=aMcfgvamn2buJqKJ0xy4+eVCu5dVE2on7Q3aaUZFwdwnHz4afLM/BehG
   +0drWxf/UdIGxt0yv2kGZ7TRSIsslx4tVaIkzL7UgEvD6JuOBPcXNGflL
   +1PndDSXDtGDxdQiSURhdEYJEOy0IvdQFW551bedZ7ydW0deYh7frgcB2
   3UJtFBH5SXex1xq8cqyxobQu9uZDf+AQQgYEFxosWzWDmvuAYtclusGv3
   srAvKALKuQRjyxXTAn5pLJI+RpeKDMlLXQFlIJjo5zaTZRcqOSCjqelgR
   FCrB8NeK4lV4ZvW4bi4q+w+0PDey2SQf/lLO5V4HtICJZYfxDyYJ7ptRb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="248158260"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="248158260"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 02:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="682375902"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2022 02:48:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk0kz-0005Fr-7h;
        Thu, 28 Apr 2022 09:48:17 +0000
Date:   Thu, 28 Apr 2022 17:47:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 25/45] ERROR:
 modpost: "fscache_begin_cache_operation" [fs/afs/kafs.ko] undefined!
Message-ID: <202204281705.oW8Orm8h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   a20ca5707a9b524115f5ded439fed1f8e552dd6b
commit: 506cacdcdfd787336db327e5f38d5a378d5998fd [25/45] fscache: Add a function to begin an cache op from a netfslib request
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220428/202204281705.oW8Orm8h-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/506cacdcdfd787336db327e5f38d5a378d5998fd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout 506cacdcdfd787336db327e5f38d5a378d5998fd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "fscache_begin_cache_operation" [fs/afs/kafs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
