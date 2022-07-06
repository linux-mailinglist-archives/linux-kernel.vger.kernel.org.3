Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6AF567E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiGFGJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGFGJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:09:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C9313D2B;
        Tue,  5 Jul 2022 23:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657087771; x=1688623771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2dHEkN5CyOk3xJvh1RujxNHJ3CrU75rcLP3MrSXk2uM=;
  b=I2pDNZBGR8Eq0//GI2Dfj+2xXBv3prxkhaOlRvWECRP4jIBry4/n53Yf
   yo6/RgwWQbqvbKvf8D1MvMTb9L/XE4BaE11hxpEUthQ/Z2iSugIVtp77p
   FphZfO/V5vO3GGtyEhfPD6m8uBYE4MtsxFUw0os1lJW5wZtqdqTi0diTP
   6ydchy9dPxoo9KQv7cQIEL0qANkf1x+2OX9jZouRbgTVlH3rfS6dYbRgX
   eu0cbetPsmMdxhCg3Zv4ubMn89qTyFBjSyP4VKX45p6IIZt/1sniTYn4z
   wUeLo0FlbMzuIO6OpQAF2zSmla5W+BsveWrNcIxlACxkHQDx7GgU/dV+N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266684273"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="266684273"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="839401904"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2022 23:09:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8yE4-000K8S-Ib;
        Wed, 06 Jul 2022 06:09:28 +0000
Date:   Wed, 6 Jul 2022 14:08:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-doc@vger.kernel.org
Subject: [jsarha:topic/cros-sof-v4.14-rebase 7725/9999] htmldocs:
 Documentation/process/clang-format.rst:: WARNING: document isn't included in
 any toctree
Message-ID: <202207061419.RnT2jUVt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: 59db4a35b31ee9ff086b7d55c2e6375851a6de97 [7725/9999] UPSTREAM: clang-format: add configuration file
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/process/clang-format.rst:: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
