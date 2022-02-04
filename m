Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA194A939C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbiBDFav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:30:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:7489 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbiBDFat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643952649; x=1675488649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6/M48QsBwvy5StCBI/QZ/x2WdrnIQcL49s1jfc5DmLs=;
  b=Pv5L0GIOdZDriQJYTHjQvDNxJTd5PXHN5c/O8tRGocY/2ebmOEZCPrIV
   HvLnkdQ0ex4wht9HZarZ2QyounMxMZJY8l6qcAFWBe+/AbKhEOvE6sMYO
   qy6dlLojem25yq++vfVaRqx7cFwcTjg0AjCZ8eYcBPMh9svQeQNRIPThh
   tFdp+KgT6ZECSvRmWsfiE1XprZ4KRdW16XKqAg+RUWWAZENddhZqmU4ls
   lq6t7AMClcNs60sCL6iVNXtur5cz5HJ9rzr64AoTb+n4vFiLlo2fyt3jq
   LQZVjj1mqm/1eVZeMk4u6LX0q3gYsxY/US9UXwnYuNvNna2/eoNRiiA6V
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248262081"
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="248262081"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 21:30:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="483510272"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2022 21:30:49 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.180.188])
        by linux.intel.com (Postfix) with ESMTP id 2E11A58090D;
        Thu,  3 Feb 2022 21:30:49 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH V5 0/3] Intel Software Defined Silicon
Date:   Thu,  3 Feb 2022 21:30:43 -0800
Message-Id: <20220204053046.2475671-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Intel Software Defined Silicon. These
patches are the same as patches 4-6 from this series [1]. Patches 1-3 
of that series were pulled in during the 5.17 merge window.

[1] https://lore.kernel.org/lkml/20211216023146.2361174-1-david.e.box@linux.intel.com/T/

David E. Box (3):
  platform/x86: Add Intel Software Defined Silicon driver
  tools arch x86: Add Intel SDSi provisiong tool
  selftests: sdsi: test sysfs setup

 .../ABI/testing/sysfs-driver-intel_sdsi       |  77 +++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/intel/Kconfig            |  12 +
 drivers/platform/x86/intel/Makefile           |   2 +
 drivers/platform/x86/intel/sdsi.c             | 568 ++++++++++++++++++
 drivers/platform/x86/intel/vsec.c             |  12 +-
 tools/arch/x86/intel_sdsi/Makefile            |   9 +
 tools/arch/x86/intel_sdsi/sdsi.c              | 540 +++++++++++++++++
 tools/testing/selftests/drivers/sdsi/sdsi.sh  |  18 +
 .../selftests/drivers/sdsi/sdsi_test.py       | 226 +++++++
 10 files changed, 1470 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
 create mode 100644 drivers/platform/x86/intel/sdsi.c
 create mode 100644 tools/arch/x86/intel_sdsi/Makefile
 create mode 100644 tools/arch/x86/intel_sdsi/sdsi.c
 create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
 create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py

-- 
2.25.1

