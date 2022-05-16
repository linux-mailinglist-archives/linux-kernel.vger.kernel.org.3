Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45425528857
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbiEPPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbiEPPRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:17:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2453BBDD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652714256; x=1684250256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RixpoNBRwwdCs881xnhBxAUyps5SSUh3RGfadtr7pQ8=;
  b=ip8OMHhi7W5Gcqj864cz7S+vyunUqeE7ullpjAWhq7IqbvcTw8/cltnU
   pPmjzRCEEdYqiNMZTJ/O1rwZx+bvRP26HoyQ1/QRl51tXNIcbfQdTPYMI
   BFPquzGfxQlmlw+5o+UEih8UU3F0XFzHk6C6y8YGvvWKVqE6NW7kcf7WR
   Jh4+kEUC0CYuGT8TrChzz8lCxjAtIciHQ+hpXB6ca/JAKuLEPfmp1h7Ex
   HVKsQixDa46fT8EKBhvLYj3U7UFt8Fw4DKbSrrr9r1L2izsDTabkuGXCc
   DyWHLrFfRd7t1oWG0T84CZq9Z/iQ/+a/XFIgKV7/BjZbjqc/gWKpJQHyA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270810644"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270810644"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 08:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="574059803"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 May 2022 08:17:34 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqcTV-00008A-Fw;
        Mon, 16 May 2022 15:17:33 +0000
Date:   Mon, 16 May 2022 23:16:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 6458/6473]
 drivers/hwmon/corsair-psu.o: warning: objtool:
 corsairpsu_hwmon_ops_is_visible()+0x17: unreachable instruction
Message-ID: <202205162350.HH1e1YC1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   ae766496dbd448eea2af4b3be8e2b2172ce38a79
commit: 370d33da35e31c1544eb77bcf2539f09b1064b9c [6458/6473] x86: Add straight-line-speculation mitigation
config: x86_64-randconfig-r011-20220516 (https://download.01.org/0day-ci/archive/20220516/202205162350.HH1e1YC1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=370d33da35e31c1544eb77bcf2539f09b1064b9c
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 370d33da35e31c1544eb77bcf2539f09b1064b9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/corsair-psu.o: warning: objtool: corsairpsu_hwmon_ops_is_visible()+0x17: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
