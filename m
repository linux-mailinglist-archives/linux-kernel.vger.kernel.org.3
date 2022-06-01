Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303F953B0B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 02:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiFAX5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 19:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiFAX47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 19:56:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A8124E1ED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654127816; x=1685663816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YCpSo2LjWpnUaC0ljVavOADFNQHGCUn7ASovaagsnNo=;
  b=SGPWAJGkx/iKdWRCQ2xWqCFqz4PSSfPJozNVJ21XtVZ5336BEh45QxXt
   f4NKIouEVYnNnrnqmchIMagLE01hJPZLrmPHrdUuirMNyz6CUfs1XJkx/
   SJuI4gXBebsawl952rCFsW2CUTCZxHT7GRqBEglRcF1eNUomg5jKCsAkc
   8GcH225QGCb79b8fOn/3sWrqMnVZ3iwvtt3OOe07wdR5KnHl4VDUreUmR
   D54EyoD+B2xo9CN8sKFCXmaYps3xZF2CFUY4S/pIRw0ZlkxAiBVI6YbpJ
   17TW0ZTIfbZAkGVX6BToQGotLu2PtKsYdWoENNhdAAn2etnX3+JeW4fLR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="255637067"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="255637067"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 16:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="563036712"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2022 16:56:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwYCs-0004YG-Bj;
        Wed, 01 Jun 2022 23:56:54 +0000
Date:   Thu, 2 Jun 2022 07:56:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 36/59] ERROR:
 modpost: "fscache_begin_cache_operation" [fs/ceph/ceph.ko] undefined!
Message-ID: <202206020747.ZdNsGuNi-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   22ecc2fcdab4616e624408911ec1d54644e82030
commit: e761d039ea17aeaa3a5642e428b713473606798b [36/59] fscache: Add a function to begin an cache op from a netfslib request
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220602/202206020747.ZdNsGuNi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/e761d039ea17aeaa3a5642e428b713473606798b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout e761d039ea17aeaa3a5642e428b713473606798b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "fscache_begin_cache_operation" [fs/ceph/ceph.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
