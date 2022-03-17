Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F404DBBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350471AbiCQAtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbiCQAtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:49:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED2DF21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647478089; x=1679014089;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aX3lS9WD4i7xviK5tdAATvYtmd8BwxLejkajHwREatw=;
  b=FWy33aHoofX6X1QkcxXsJBMfEMsDZAxWjjaP5LlVf68cJonSBVD1+4Rk
   2u+fOs4PRH3nEx/OK/5pfpiEeNcdcaAbz6j1okcuCDhLkY3FR7uIuGqqk
   85SSr0fQcFXZybWYPHyIaxEEfJ7XybQA8lw2p11nFiHIYpGvAhtaTFRQH
   GqB9CMgQLe1VAOe8s/xjEpAOcNuW/WtjCMvgaWlCVU6bkfExPsHVWdptY
   V++q2SYWjOJqCDDs1F6t/mr5/+eV7YVIRDZSEZSxTDagugUIr7yBOG3wO
   0b5lAhzTEJD/sPDWOTUTfWHzeXVjzNhXav8tMb+8+4wmlks8gsSPvRR+b
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244202235"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="244202235"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="513240696"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2022 17:48:07 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUeJD-000D85-2Y; Thu, 17 Mar 2022 00:48:07 +0000
Date:   Thu, 17 Mar 2022 08:47:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1563/2335] ./usr/include/linux/if_link.h:5:10:
 fatal error: uapi/linux/netlink.h: No such file or directory
Message-ID: <202203170832.caWKLJnr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: f9feb19bd4ff82d90e72d9471ed90de86b38aeb5 [1563/2335] headers/deps: net: Optimize <uapi/linux/if_link.h>
config: i386-randconfig-a006-20220314 (https://download.01.org/0day-ci/archive/20220317/202203170832.caWKLJnr-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f9feb19bd4ff82d90e72d9471ed90de86b38aeb5
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout f9feb19bd4ff82d90e72d9471ed90de86b38aeb5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/if_link.h:5:10: fatal error: uapi/linux/netlink.h: No such file or directory
       5 | #include <uapi/linux/netlink.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
