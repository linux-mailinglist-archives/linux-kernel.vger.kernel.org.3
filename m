Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D24583D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiG1LhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiG1LhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:37:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34594D4D2;
        Thu, 28 Jul 2022 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659008229; x=1690544229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W7bquB12dgy6FoNN+53PkeFsrr0wQHWEANblt77YEHg=;
  b=QehDlhrhlQdC9JRE42I/s1J4lJApPKfnUuEJVtdLC2fPKDSgkZRX0OzL
   g0/EK++lK9rCxhGYxIzijlxLtfMA8XYoDPuMPBbU/SBE0Zxhy6gwCcGWj
   UnlKKKNU9bkf2+k590eVjG6VlBTIQq43ow+aUjV/A9m5TtqsXZlWuBIxg
   HXPRt1u2JS8XuFGJlxquJ5icYKYPbrHo87AERAysV1nlMunKDPJPLegit
   iyBx5C4QUAmFBofWmW6JgP0YF2MGMFuwRqyoZARAWN6SjrweC3oAdXAhH
   M7KkE75SD8vMTK04A7XrLPSrMdLWB67ghnc3x7/9DNQK0DT0GhbIyRUwn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="287243498"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="287243498"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 04:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="576431623"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2022 04:37:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH1pD-0009w9-0M;
        Thu, 28 Jul 2022 11:37:07 +0000
Date:   Thu, 28 Jul 2022 19:36:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-doc@vger.kernel.org
Subject: [mic:tmp-net 7/18] htmldocs:
 Documentation/userspace-api/landlock:321: include/uapi/linux/landlock.h:37:
 WARNING: Unknown target name: "network flags".
Message-ID: <202207281934.kZwWkH1t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tmp-net
head:   8f4104b3dc59e7f110c9b83cdf034d010a2d006f
commit: d2f5198c7820f4bc80d2ea402ca29eb7504f3d92 [7/18] landlock: user space API network support
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/userspace-api/landlock:321: include/uapi/linux/landlock.h:37: WARNING: Unknown target name: "network flags".

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
