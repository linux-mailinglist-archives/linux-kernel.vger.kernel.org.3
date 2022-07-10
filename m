Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE3856CC86
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 05:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiGJDpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 23:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJDpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 23:45:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C3011814;
        Sat,  9 Jul 2022 20:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657424752; x=1688960752;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EstlRZ+njSWlv76Nln8G2irxpf1Uxid3bbJ992h6v8U=;
  b=WSkAg1XlDIgp6jnGG1+jvS1y7x2RpwFc7ZF9WJEyOuJXmlals3OyQJJQ
   vLVedUAIwc50hVMW9qxBPICegkrYzLZZR9ZjUFm7zyaUZJH7Wkfw6EOw4
   NhKWDEH2KFppyKM5hZfwRISpEYn33WWaeUUoUWJlK9GCkwVLq7NMKbwAQ
   GKLMB4aGJK66vwH4yWPdfp7T7apr8c1lUe4SYGrwquRjtcXAHVEtRa43K
   7qUfmlSxDBk5x92GnZY8DoXSi9Op5nme1WNVECqjh35w4jSphD70ywF47
   vvLIvLtIbpYK44jpX+tFvA5uH86AW8vMlKqcnZtUjglc/LwvJeDsBLTIq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="283232015"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="283232015"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 20:45:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="569377038"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Jul 2022 20:45:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oANtG-000PRM-By;
        Sun, 10 Jul 2022 03:45:50 +0000
Date:   Sun, 10 Jul 2022 11:44:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 16/368] htmldocs:
 Documentation/filesystems/xfs-online-fsck-design.rst:3691: WARNING:
 Duplicate explicit target name: "kernel".
Message-ID: <202207101126.VEXGZ19c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   569bd1ce4bb5c53a1b892fbe6d99693bf637063b
commit: a7934b8211da00f08827e4aeb97e477d20e91c23 [16/368] xfs: document future directions of online fsck
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/filesystems/xfs-online-fsck-design.rst:3691: WARNING: Duplicate explicit target name: "kernel".

vim +/kernel +3691 Documentation/filesystems/xfs-online-fsck-design.rst

  3689	
  3690	Future Work
> 3691	===========
  3692	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
