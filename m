Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9A34D44F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbiCJKs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241381AbiCJKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:48:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E8637A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646909273; x=1678445273;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MzMAdsv55pFk0fS6LjtMyulpOtE7bHXFh95B1tLmkgA=;
  b=lSh/K97oNhx8bDGK9eAzNKAux1UhY9NK30ds3sEEG80h2ARZO7FyNwR/
   WdIXOJ1pER8NHeBRZVnimARLqkjeTpmtICPbjC74mtIV7vu+Nes3FnHoi
   bMRT7ZXN1VlTQfIexoExJSTnzuVIK8ypydDyedl8l68P8GQ9tKaDG2aFS
   fndoPFA4rYKdtH6xKMVlu3F1cRbGX4HiykB3KcQ7vVAba87te5ySaQio7
   fvCUpbu2wfZ9z/EC01Fz4c9764F2CKkUL4laqOIZyZnU2OmZWMP2QvAf0
   LYXTX1ZwNxG1uZ/QnzypFbgmdjtFmbhf4l9MH8MMO28JNWP+4g8SmUyUL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="254048756"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="254048756"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 02:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="578754323"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2022 02:47:52 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSGKl-0004of-DE; Thu, 10 Mar 2022 10:47:51 +0000
Date:   Thu, 10 Mar 2022 18:47:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alessio Balsini <balsini@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 1034/9999] usr/include/linux/fuse.h:888: found __[us]{8,16,32,64} type
 without #include <linux/types.h>
Message-ID: <202203101849.Vpu9XtZ0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   2d490f129561c7cb45482b0aa866e7b973489e8f
commit: 5e424f85962b0353631642f4da402f2003c218ba [1034/9999] ANDROID: fuse/passthrough: API V2 with __u32 open argument
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220310/202203101849.Vpu9XtZ0-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/5e424f85962b0353631642f4da402f2003c218ba
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 5e424f85962b0353631642f4da402f2003c218ba
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> usr/include/linux/fuse.h:888: found __[us]{8,16,32,64} type without #include <linux/types.h>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
