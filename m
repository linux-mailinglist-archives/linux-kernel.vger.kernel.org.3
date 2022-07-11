Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5534D570AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiGKTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiGKTwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:52:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C3F5720D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657569161; x=1689105161;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nKybO9tUqV03SxQ/6tRzuuqCi0DJgi6UGQRUw0ZICrw=;
  b=i/iafMzFIaLIsRGXPats/R2zAHWtuevoYvFyOwBri29qStFrNC2/6JfY
   fSxf+co9qWhLDlcXLyBfRRP8kr+HdXUhbkhHX0KtwlT/3Z/dD0iXZg0mB
   x/HXNjHdrmhJMhh/ALe78akQLjciFCBhDVOmSIkIjqFZdAmSfnf14PQ+p
   1Q+JkpKlctNchkxM8WDHVIQZiDiLrZZac34TU+jfZOCVEDTyQ8PjzM12G
   ln8k8a1UBjE51EaC+s4Ee64SJHKjzHf61SKxZr85+Y7Tnoz54p8UB4Z55
   B/HFefaaW33IVlQzQzJWRNnv+PSzzvZf5ruLbZAhqiiVrYIKEGqVakOAf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="371063783"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="371063783"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="622214183"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2022 12:52:40 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAzSR-0001Ah-OG;
        Mon, 11 Jul 2022 19:52:39 +0000
Date:   Tue, 12 Jul 2022 03:52:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 8b979924b9f9e945a095a2f622b39b9fd9f65acb
Message-ID: <62cc7f7e.jaIxoQ58GWsnQOBY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 8b979924b9f9e945a095a2f622b39b9fd9f65acb  x86/build: Remove unused OBJECT_FILES_NON_STANDARD_test_nx.o

elapsed time: 765m

configs tested: 3
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
