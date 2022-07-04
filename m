Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FA2565F75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 00:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiGDWnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 18:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGDWnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 18:43:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A8E0C2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656974588; x=1688510588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PQeVHjjTYOpF0eBv1GDmAvq3ad8ttVQS39GeWKMugbA=;
  b=kWRC7GhEzunwkEiH0w5oOzEarhMej8urCePFXEnFk19lLW/u5jGVnsfA
   MAcqzuabiWv3+Tml+wNfDWC9GsV/aEjzLJnqrEqTVrr/VY8H1Aq6lUCzr
   EZyjt01P3YFGlUgewGVQ8Lyqj3g4cQr2JzLhoUBr2QTTsNyXu3JMrXBks
   efL02QmZxgxwnfKnrvRyyQgofO4L2HiOiDEbpcPBPhUH3n6KY+MbZuF6Q
   fm3cwzFaqLrHig1LNuhh3JGYaSMcFnNQCiyqIt3QxzsSKkQJpB+RxTbJe
   7Fft2jWiqrKePzXgOnqs+/klBwUoe50m3CuGO9+EJN8twQF5DC0dJQSfk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="280759517"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="280759517"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 15:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="769436085"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Jul 2022 15:43:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8UmT-000IMm-Bc;
        Mon, 04 Jul 2022 22:43:01 +0000
Date:   Tue, 5 Jul 2022 06:42:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:habanalabs-next 52/74] gaudi2.c:undefined reference to
 `__udivdi3'
Message-ID: <202207050654.rbSbmU6k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   dd59146d7ce2b160b57e747e6ca70afbcb4b41a5
commit: c5c630faa00de0cc343fa0e5a236ed117ef454a3 [52/74] habanalabs: add gaudi2 asic-specific code
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220705/202207050654.rbSbmU6k-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=c5c630faa00de0cc343fa0e5a236ed117ef454a3
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout c5c630faa00de0cc343fa0e5a236ed117ef454a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/misc/habanalabs/gaudi2/gaudi2.o: in function `gaudi2_cpucp_info_get':
>> gaudi2.c:(.text+0x14787): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
