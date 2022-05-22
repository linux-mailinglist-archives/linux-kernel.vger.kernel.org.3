Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27292530659
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbiEVVuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiEVVui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:50:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACBA37A11
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653256237; x=1684792237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=67m3haPpHPcMbRowtwu7rSs5RsSN2+Gxfq9a+RuOjng=;
  b=f3Kd21Zzr4yOog6nxANK6+ym6mZjg6cENa4bprLa4fmV0EVWIIR/MWQc
   3SvnJEthcN2Q+sqUnCbtYhdyrQvZ+ul0ZQ3ZCGF0azRWBuCJwjZh8Wzwo
   Hb1jq6m39Ws4oIcvEi3tuM0roqrwHJOQrWBnAL4S9fOIVOpyme3EHA7te
   8tIrTWvXeVnusKyM60Uru77oLWeFyRwpcO/2WhkCTBnGXCdRNlSQsb3mS
   bKGz5e4stykM25zIuTJ+s0Gz7jTkoBg7cKDi9cD+zIv2StNdJUX0ErI0F
   n9pJpJdCNbLgZlPITRPZjwSxLMplH+GDZ6F2Np8FNpUhdjsMdHE7h/ooO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="359444765"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="359444765"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 14:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="600310534"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 May 2022 14:50:36 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nstT9-0000dn-Nu;
        Sun, 22 May 2022 21:50:35 +0000
Date:   Mon, 23 May 2022 05:50:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [madvenka786:orc_v2 7/20] include/asm-generic/orc_lookup.h:69:25:
 error: array type has incomplete element type 'struct orc_entry'
Message-ID: <202205230515.qgof50pO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/madvenka786/linux orc_v2
head:   ed9a1d5c036130a53c639eb712485e3d13ab4372
commit: a4c6af5b74f86f69cebc1b18d8a31a3beff7cd8e [7/20] objtool: Reorganize ORC kernel code
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220523/202205230515.qgof50pO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/madvenka786/linux/commit/a4c6af5b74f86f69cebc1b18d8a31a3beff7cd8e
        git remote add madvenka786 https://github.com/madvenka786/linux
        git fetch --no-tags madvenka786 orc_v2
        git checkout a4c6af5b74f86f69cebc1b18d8a31a3beff7cd8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/../kernel/module.c:26:
>> include/asm-generic/orc_lookup.h:69:25: error: array type has incomplete element type 'struct orc_entry'
      69 | extern struct orc_entry __start_orc_unwind[];
         |                         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/orc_lookup.h:70:25: error: array type has incomplete element type 'struct orc_entry'
      70 | extern struct orc_entry __stop_orc_unwind[];
         |                         ^~~~~~~~~~~~~~~~~


vim +69 include/asm-generic/orc_lookup.h

    65	
    66	extern bool orc_init;
    67	extern int __start_orc_unwind_ip[];
    68	extern int __stop_orc_unwind_ip[];
  > 69	extern struct orc_entry __start_orc_unwind[];
    70	extern struct orc_entry __stop_orc_unwind[];
    71	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
