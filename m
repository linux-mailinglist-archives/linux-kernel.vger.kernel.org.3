Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879EF58093D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 04:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiGZCD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 22:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiGZCD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 22:03:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DD02529E;
        Mon, 25 Jul 2022 19:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658801006; x=1690337006;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nGXce4BEiuO3MY3YTJ0jEz9ehzkLTWYcY9aS9F+R5ec=;
  b=YO3jem2z7TU34aPIeZSr1IiLlHdDYgj23rbfy76sCEj7fZyRwl0fJDFI
   EGN/2TfJIGL1jQoijdT6Jnk4zKmsxgFuqHndzA6qlNi4wzgdXcAJZxfJM
   mdEzZug0jv1ej1M8rLL75IqiV3lmKmw8ZP4RMEvjqA3OplvN/LMlWnpG/
   gbCo+NZQxiwGndR8+fFIXCpNsc7UN7l0riBPdBuKk4ebcrY2kbKXxfSqM
   2hkmlcAnoPS+qEkA0GJ2DTFE26g7zYzFLWsEfxrmgqc4owKyyKmbBJkcS
   miksatyIn1KvkghX04HG+nPmJ4prIHt/zRN+mXSTDi6gm2E4khai0YZvo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="374139248"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="374139248"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 19:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="627698116"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2022 19:03:25 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oG9uu-0005qC-1G;
        Tue, 26 Jul 2022 02:03:24 +0000
Date:   Tue, 26 Jul 2022 10:02:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     SeongJae Park <sjpark@amazon.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [sj:damon/next 22/25] htmldocs: Documentation/PCI/index.rst:
 WARNING: document isn't included in any toctree
Message-ID: <202207261047.AMrNATOY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
head:   7b095128a1a8d7cd001d16012bd33216b7c89b6c
commit: 5e8617bff7f858577368516ec457f51d18ea940f [22/25] Docs: Modify for DAMON only
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
