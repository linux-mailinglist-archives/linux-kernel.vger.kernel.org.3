Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD8E545A52
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiFJDGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJDGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:06:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D843D6808
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654830361; x=1686366361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z3yrDucY7h8X3nhyVMdwU4T0YsGseG9NZ3ZOmoOS/S0=;
  b=ABcBgAxFBKWiVRHaAzWa9KKl4doTyYNjhaacy5JnO5WZqD5xpCOYavq2
   jcSq33Wkij176wem282UzY5+SzlLEYyqRNoMnbaUD8BiVsBfEMfGid4W8
   fh0CDtSGjuCdNcFySpw5AnfwZb3hweBwRBkNcmGUnZiYliO6ysIr3ID7i
   WAp6nPpDjS9hkubRUiXIeMz/GiSVHNRUZBwF0R2bgc4KL1o4W/0uEDGjX
   OOYcphxKNCkRhbbBagNBvNbEttk8+EoZtm962vI2cHXy1yHBwVL95IKKx
   acirmxs38gjGPVxyfx3LTugcTtaIeMepnyt3REga+UeFCOcnpyo3RXl02
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341559505"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="341559505"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 20:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="684304675"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2022 20:05:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzUyE-000Ge1-Es;
        Fri, 10 Jun 2022 03:05:58 +0000
Date:   Fri, 10 Jun 2022 11:05:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-netfs-llist 4/4] fs/ceph/addr.c:433:37: warning:
 unused variable 'subreq'
Message-ID: <202206101021.BVwn2jkt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-netfs-llist
head:   949c104f62d7b02839584a8cce853d4164f861ac
commit: 949c104f62d7b02839584a8cce853d4164f861ac [4/4] ceph: convert to netfs write helpers
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220610/202206101021.BVwn2jkt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=949c104f62d7b02839584a8cce853d4164f861ac
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-netfs-llist
        git checkout 949c104f62d7b02839584a8cce853d4164f861ac
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ceph/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/ceph/addr.c: In function 'ceph_upload_to_server_worker':
>> fs/ceph/addr.c:433:37: warning: unused variable 'subreq' [-Wunused-variable]
     433 |         struct netfs_io_subrequest *subreq =
         |                                     ^~~~~~


vim +/subreq +433 fs/ceph/addr.c

   430	
   431	static void ceph_upload_to_server_worker(struct work_struct *work)
   432	{
 > 433		struct netfs_io_subrequest *subreq =
   434			container_of(work, struct netfs_io_subrequest, work);
   435	}
   436	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
