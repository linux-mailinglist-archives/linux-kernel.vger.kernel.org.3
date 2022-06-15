Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6098754C1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbiFOGPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiFOGPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:15:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0C3151C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655273705; x=1686809705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RKZm4iHlx2gJHuMGW3mB/2hwX5YsG49OK+zsblorQps=;
  b=CrV6fu9/GWHk1y/WNkYtoA8YkB6p4r6xD+h4uKXRpI/LS0zQjhe5jN6w
   JEMN4gyVEi/tY3++YWtOr+kGuMHXCePNDYkoTgRad1lJLENIsrOiftMYD
   C/J5RFqZQcOQV8uchTBQnf9QMurKnrJH5n1Y9LxzLmrXzRUCz7furO46u
   Dyl/maFy5veszCgZoJyziDDtK3UqmhET1L7/wu2nlYItsLzujspt+YIsB
   DEC+eiEaDR/12Gdxfg18PzIkotYq2dtqX2TOvVIrOwRrRIY5O33Ananyq
   RxC+iUBa7IvvgJsOs/bdgJgKVhz2r8GykYrFj3qMyk9sbG02nuate7+jy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="365199764"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="365199764"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 23:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="712805355"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2022 23:15:03 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1MIw-000McV-CH;
        Wed, 15 Jun 2022 06:15:02 +0000
Date:   Wed, 15 Jun 2022 14:14:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 7064/7855] fs/afs/write.o: warning:
 objtool: afs_write_back_from_locked_page()+0x23d: unreachable instruction
Message-ID: <202206151348.JwVjfqCd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   2e65f63d5e2c817d883c4c8df2010aa23bd07ea4
commit: dd07286924134bff9dcf85e59f02c63b197e5af1 [7064/7855] afs: Adjust ACK interpretation to try and cope with NAT
config: x86_64-randconfig-r026-20220613 (https://download.01.org/0day-ci/archive/20220615/202206151348.JwVjfqCd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=dd07286924134bff9dcf85e59f02c63b197e5af1
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout dd07286924134bff9dcf85e59f02c63b197e5af1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/afs/write.o: warning: objtool: afs_write_back_from_locked_page()+0x23d: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
