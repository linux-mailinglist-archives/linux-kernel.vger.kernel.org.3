Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C38564568
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 08:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiGCGhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 02:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGCGhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 02:37:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFA64C5;
        Sat,  2 Jul 2022 23:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656830257; x=1688366257;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fFNzadsWqSWjFsJYDW0a4mv1cISp54OOUOHAW8UOwKY=;
  b=eQ8F7d03zgfGj3nvGkfutY4QD0UBaxkMXkk48XgDBtyVxxEOmfAAOttV
   L1fU8xjU4hAMEdmZkV5DXpQSI0kuQWvDU3STZ8EDh4VqYp7PTIKHeAzZq
   9HGxjdwjFS6Eo84fx04JEiJaqRgfDzbg9DbtvKwdV562qMTS8CCZ2XvQ0
   St6PxkR5i7M1xiGUMSMIY7eeghGQAJjV22+UaSBcdcyVpqsX6oQhpih2g
   x3lTda6tEftmgPtmVDkCSePYACFTpKsBBY8CMP7sPUbQJMUNahMfR9DvA
   +Z52YsxCWDqUgdCvJu4LC3KQRCPxLsJmCHQ3DssonH/u17FapGDgBPf5Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="265938194"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="265938194"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 23:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="618868585"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jul 2022 23:37:35 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7tEc-000GB5-H0;
        Sun, 03 Jul 2022 06:37:34 +0000
Date:   Sun, 3 Jul 2022 14:36:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     SeongJae Park <sjpark@amazon.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [sj:damon/next 16/20] htmldocs: Documentation/PCI/index.rst:
 WARNING: document isn't included in any toctree
Message-ID: <202207031427.IAzQ551Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
head:   54aa71ecf6cac755c491a1992d83437cd2240311
commit: 81b3079ea3e5ea85af358bb8a7621bb4f2aec50f [16/20] Docs: Modify for DAMON only
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/PCI/index.rst: WARNING: document isn't included in any toctree
>> Documentation/accounting/index.rst: WARNING: document isn't included in any toctree
>> Documentation/admin-guide/index.rst: WARNING: document isn't included in any toctree
>> Documentation/arch.rst: WARNING: document isn't included in any toctree
>> Documentation/asm-annotations.rst: WARNING: document isn't included in any toctree
>> Documentation/block/index.rst: WARNING: document isn't included in any toctree
>> Documentation/bpf/index.rst: WARNING: document isn't included in any toctree
>> Documentation/cdrom/index.rst: WARNING: document isn't included in any toctree
>> Documentation/core-api/index.rst: WARNING: document isn't included in any toctree
>> Documentation/cpu-freq/index.rst: WARNING: document isn't included in any toctree
>> Documentation/crypto/index.rst: WARNING: document isn't included in any toctree
>> Documentation/dev-tools/index.rst: WARNING: document isn't included in any toctree
>> Documentation/devicetree/index.rst: WARNING: document isn't included in any toctree
>> Documentation/doc-guide/index.rst: WARNING: document isn't included in any toctree
>> Documentation/driver-api/index.rst: WARNING: document isn't included in any toctree
>> Documentation/fault-injection/index.rst: WARNING: document isn't included in any toctree
>> Documentation/fb/index.rst: WARNING: document isn't included in any toctree
>> Documentation/filesystems/index.rst: WARNING: document isn't included in any toctree
>> Documentation/firmware-guide/index.rst: WARNING: document isn't included in any toctree
>> Documentation/fpga/index.rst: WARNING: document isn't included in any toctree
>> Documentation/gpu/index.rst: WARNING: document isn't included in any toctree
>> Documentation/hid/index.rst: WARNING: document isn't included in any toctree
>> Documentation/hwmon/index.rst: WARNING: document isn't included in any toctree
>> Documentation/i2c/index.rst: WARNING: document isn't included in any toctree
>> Documentation/iio/index.rst: WARNING: document isn't included in any toctree
>> Documentation/infiniband/index.rst: WARNING: document isn't included in any toctree
>> Documentation/input/index.rst: WARNING: document isn't included in any toctree
>> Documentation/isdn/index.rst: WARNING: document isn't included in any toctree
>> Documentation/kbuild/index.rst: WARNING: document isn't included in any toctree
>> Documentation/kernel-hacking/index.rst: WARNING: document isn't included in any toctree
>> Documentation/leds/index.rst: WARNING: document isn't included in any toctree
>> Documentation/livepatch/index.rst: WARNING: document isn't included in any toctree
>> Documentation/locking/index.rst: WARNING: document isn't included in any toctree
>> Documentation/maintainer/index.rst: WARNING: document isn't included in any toctree
>> Documentation/mhi/index.rst: WARNING: document isn't included in any toctree
>> Documentation/misc-devices/index.rst: WARNING: document isn't included in any toctree
>> Documentation/mm/index.rst: WARNING: document isn't included in any toctree
>> Documentation/netlabel/index.rst: WARNING: document isn't included in any toctree
>> Documentation/networking/index.rst: WARNING: document isn't included in any toctree
>> Documentation/pcmcia/index.rst: WARNING: document isn't included in any toctree
>> Documentation/peci/index.rst: WARNING: document isn't included in any toctree
>> Documentation/power/index.rst: WARNING: document isn't included in any toctree
>> Documentation/process/index.rst: WARNING: document isn't included in any toctree
>> Documentation/scheduler/index.rst: WARNING: document isn't included in any toctree
>> Documentation/scsi/index.rst: WARNING: document isn't included in any toctree
>> Documentation/security/index.rst: WARNING: document isn't included in any toctree
>> Documentation/sound/index.rst: WARNING: document isn't included in any toctree
>> Documentation/spi/index.rst: WARNING: document isn't included in any toctree
>> Documentation/staging/index.rst: WARNING: document isn't included in any toctree
>> Documentation/target/index.rst: WARNING: document isn't included in any toctree
>> Documentation/timers/index.rst: WARNING: document isn't included in any toctree
>> Documentation/tools/index.rst: WARNING: document isn't included in any toctree
>> Documentation/trace/index.rst: WARNING: document isn't included in any toctree
>> Documentation/translations/index.rst: WARNING: document isn't included in any toctree
>> Documentation/usb/index.rst: WARNING: document isn't included in any toctree
>> Documentation/userspace-api/index.rst: WARNING: document isn't included in any toctree
>> Documentation/virt/index.rst: WARNING: document isn't included in any toctree
>> Documentation/w1/index.rst: WARNING: document isn't included in any toctree
>> Documentation/watchdog/index.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
