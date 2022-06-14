Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2854A807
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347051AbiFNEZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348312AbiFNEZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:25:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A92C119
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655180730; x=1686716730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ug2jpAvXFyr74lnjw0JDGHjJqcMclMDigeR9JbbzPdY=;
  b=BKA4xWK4ZZj30QeBPQ6OnAL6IE3j0u1gbfRqL0UMD5R7F5VCqtMWSsaa
   OLcpxlb189csRfDyK7UtpCpI0UT7fywxrPlciMud9roowvRsdxeQnPgat
   UZcDE8WIuUy2FCwb9XJYoohOtdVB3bfL77BF9jGpPtfI5fbQyzk+OfkW9
   7zFcfxW6JiJYznKSQyPv1LDsuZQEmyo69Xel0Sj9X9zRBsj1I70Lj67IY
   VxFOTN983i2dQKe4BlT7esWifdIms6mQyhbBSk/2K61nyA7j8gR8P/hNQ
   7CshsrY59hu0RN5lUUW7B+7TljgnLWBsigjX4eCy2v1kZsKK7U8dCr3oy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303902752"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="303902752"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="726613018"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2022 21:25:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0y77-000LTD-1T;
        Tue, 14 Jun 2022 04:25:13 +0000
Date:   Tue, 14 Jun 2022 12:24:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.17.y 2841/3797] sound/soc/codecs/tscs454.o:
 warning: objtool: tscs454_set_dai_fmt()+0x88: unreachable instruction
Message-ID: <202206141206.gk4OdiYj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   a554a1e2ef7fa48cebd9cc2349804974247c0958
commit: 6350ee3fb5fa8a6012de917491a8f8fa478b82ca [2841/3797] ASoC: tscs454: Add endianness flag in snd_soc_component_driver
config: x86_64-randconfig-c002-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141206.gk4OdiYj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=6350ee3fb5fa8a6012de917491a8f8fa478b82ca
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.17.y
        git checkout 6350ee3fb5fa8a6012de917491a8f8fa478b82ca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tscs454.o: warning: objtool: tscs454_set_dai_fmt()+0x88: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
