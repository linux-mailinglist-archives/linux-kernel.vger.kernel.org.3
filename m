Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F982539B95
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349335AbiFADWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349320AbiFADVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:21:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56AC1B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654053702; x=1685589702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fn+5mVYiizHLFtfzmUV+MDpl2bV/AkUddMs05vRTQGM=;
  b=Nssd2DBygaYZzeI4McERu/X86uQGrA+qOxSBEsRtLkJn8aUak9Xs7uIs
   kLa7wTQE/AYEPXxqZMyYYT1Jd6+cDZ9QAvXM+MrWoeifQxvvjzmrDohoF
   yxAKJum3nIkQm2q/OvFhZpbedG0I212+v2x4QnuDEnlnXYW/azrJSH4ei
   zgZq9c0qYYS4x3aVt98tbttesHyOFWt9NprpZUXKHDlWOZULdcJoBJtcX
   jAs4rq5ghk9FsCGzunXH6XV/09rmBsfv4xCkf90W80eoko7/awhjKp0og
   KxcOnaqvl0ciuiBQ3Gg2Jj+4+fbr+KupcWp9DEjXjXul4VuJ33V5PrZpm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275464642"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275464642"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 20:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="667219117"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2022 20:21:40 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwEvT-0003Rg-Tg;
        Wed, 01 Jun 2022 03:21:39 +0000
Date:   Wed, 1 Jun 2022 11:21:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.17.y 1295/2645] {standard input}:172: Error:
 unrecognized opcode: `tlbsx.'
Message-ID: <202206011158.6sdSAOlR-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.17.y
head:   39555c443b4f5c2406e81d4ad66224f963e43d23
commit: c1f16b96c5f684453943cc4f791c235cf1d11ac7 [1295/2645] powerpc/64e: Tie PPC_BOOK3E_64 to PPC_FSL_BOOK3E
config: powerpc64-randconfig-r031-20220530 (https://download.01.org/0day-ci/archive/20220601/202206011158.6sdSAOlR-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=c1f16b96c5f684453943cc4f791c235cf1d11ac7
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.17.y
        git checkout c1f16b96c5f684453943cc4f791c235cf1d11ac7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
   {standard input}:146: Error: unrecognized opcode: `lbarx'
   {standard input}:146: Error: unrecognized opcode: `stbcx.'
>> {standard input}:172: Error: unrecognized opcode: `tlbsx.'
>> {standard input}:186: Error: unrecognized opcode: `tlbsx'
>> {standard input}:345: Error: unrecognized opcode: `tlbwe'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
