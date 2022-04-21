Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8B550A7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391171AbiDUSQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378746AbiDUSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:16:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9804A4B1C0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650564813; x=1682100813;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2XbpHfj76wTOxRN5DgEq9y72XHmkJxs4XTPwn0whqI8=;
  b=CqT+rz/cb/rjT3TO1vS7SRNwYHA6RJJSdxR1TTfcljXLp/sI4BDxJ6gw
   5argfzH96HMubTNgCQQrOqsCwOFCxcFTb7fq2sMjkOo8NavmKK1u39o7R
   EPfSg8LZr/EJ/P+rX7JJWaz1GjfRpjWCaLEyIFiKKzhj8DwFYUNmmXFF/
   cwzdIqq9trRxeKxnZb8V7o21v4vOjLHOemxQi/Os1Xy6V2sjZNT+mm1AG
   57D9hJLGFDvocMvxEjbMjb9J3waLTPuyiH42Fcl83pcMYZzBzR+S25RDf
   aix/JtsgATe1fok5Z8OpX/QizfEujBL+GHUOgGKhP+LJRxCyR5GfCj+D9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246338435"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="246338435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 11:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="615027932"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 11:13:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhbJ5-0008eT-5P;
        Thu, 21 Apr 2022 18:13:31 +0000
Date:   Fri, 22 Apr 2022 02:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dhowells-fs:rxrpc-ringless 17/21] ERROR: modpost: "udpv6_sendmsg"
 [net/rxrpc/rxrpc.ko] undefined!
Message-ID: <202204220234.BwE2yOwW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git rxrpc-ringless
head:   c388a8388ad238ffbe0cd204c3eacaf200055751
commit: d24f75894c69b625aaa8f2b937072e750a5787df [17/21] rxrpc: Call udp_sendmsg() directly
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220422/202204220234.BwE2yOwW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=d24f75894c69b625aaa8f2b937072e750a5787df
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs rxrpc-ringless
        git checkout d24f75894c69b625aaa8f2b937072e750a5787df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "udpv6_sendmsg" [net/rxrpc/rxrpc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
