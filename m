Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6CC53C106
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbiFBWrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbiFBWq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:46:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0107B100D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 15:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654210016; x=1685746016;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wkFKYh6+GBYmBdn4qaLmrZ1H0OBEJHJbuMMiS5EkQf0=;
  b=DxVlLKvmhq3b9eg68SJd4pAfeClngwA788hgialy76uXZC/nxb/JcgvN
   LxCn5UOfXHb7lNbA/3+Mct40lksiLNfsPI+HTMM/hidYlKJkgAebirnqz
   K6k8vNggLXnJ0kUbctzJIU38fApnVALgrRnQlAGT269gOPQQbN1N5tT9d
   /xTM/JWS6E7XecsugLaO2pwtWDEtVydjQarJsiaHPkKPry1trDbzFIRqB
   8h2uGSw2QKgc7HkPtbWBlinLexkLpYKIWfElCjxdpfBzUc7C9kpxlioIA
   VA01nqtg2HRZUybqzVnbpv0marQdcrya0Rxe5R88fLAdy4EXv1zDToqEn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="276117505"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="276117505"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 15:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="563531152"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2022 15:46:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwtaf-0005V1-0F;
        Thu, 02 Jun 2022 22:46:53 +0000
Date:   Fri, 3 Jun 2022 06:46:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: {standard input}:79: Error: unrecognized opcode: `tlbsx'
Message-ID: <202206030632.5VjvEzEw-lkp@intel.com>
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

Hi Michael,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d1dc87763f406d4e67caf16dbe438a5647692395
commit: 1a76e520ee1831a81dabf8a9a58c6453f700026e powerpc/64e: Tie PPC_BOOK3E_64 to PPC_FSL_BOOK3E
date:   3 months ago
config: powerpc64-randconfig-r025-20220531 (https://download.01.org/0day-ci/archive/20220603/202206030632.5VjvEzEw-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a76e520ee1831a81dabf8a9a58c6453f700026e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1a76e520ee1831a81dabf8a9a58c6453f700026e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
   {standard input}:62: Error: unrecognized opcode: `lbarx'
   {standard input}:62: Error: unrecognized opcode: `stbcx.'
>> {standard input}:79: Error: unrecognized opcode: `tlbsx'
   {standard input}:145: Error: unrecognized opcode: `tlbwe'
>> {standard input}:185: Error: unrecognized opcode: `tlbsx.'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
