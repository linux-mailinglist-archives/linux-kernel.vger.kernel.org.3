Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A24A556A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiBADE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:04:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:8831 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbiBADE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643684667; x=1675220667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jB4yUS0VqdJA5c9c23rwVYy7/CxI3rWJGy9nTFkSgao=;
  b=ICt9i2s0PYaPfOG9QPHGB4IuokGugeMtwWDjqimL+bDBVXdR+1dGULOG
   PzS9RoKckgdNGwW6Megmpm/U/rr8i5ZWwdohdP220wOSpN54GH+UsdCh0
   8WxLu03KR2DYrmYmHY5AX0qUk+JCyqbeP3b53yHUBVhLKsOWP9w3z3v5s
   w+g8n1zaaBE6DXIq0kNivFL5Su46ua/NLs0wQioJqvnWPDZWxVrOr+rs1
   jf2Zyiht21lZRcSr9Qhj5R5jNGCZ5faOIMAFsIorPwmssovYiG2TLvM8T
   tHyaZkoHV/YLDKnqcfGGBw0aBIWed6DSrPPqnf992Rn0cCi8y/7iVXs79
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310918787"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="310918787"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 19:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="479450421"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 31 Jan 2022 19:04:27 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.192.236])
        by linux.intel.com (Postfix) with ESMTP id BB723580AD7;
        Mon, 31 Jan 2022 19:04:26 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/3] Intel Software Defined Silicon
Date:   Mon, 31 Jan 2022 19:04:21 -0800
Message-Id: <20220201030424.1068816-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Intel Software Defined Silicon. These
patches are the same as patches 4-6 from this series [1]. Patches 1-3 
of that series were pulled in during the 5.17 merge window.

David E. Box (3):
  platform/x86: Add Intel Software Defined Silicon driver
  tools arch x86: Add Intel SDSi provisioning tool
  selftests: sdsi: test sysfs setup

[1] https://lore.kernel.org/lkml/20211216023146.2361174-1-david.e.box@linux.intel.com/T/

 .../ABI/testing/sysfs-driver-intel_sdsi       |  77 +++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/intel/Kconfig            |  12 +
 drivers/platform/x86/intel/Makefile           |   2 +
 drivers/platform/x86/intel/sdsi.c             | 571 ++++++++++++++++++
 drivers/platform/x86/intel/vsec.c             |  12 +-
 tools/arch/x86/intel_sdsi/Makefile            |   9 +
 tools/arch/x86/intel_sdsi/sdsi.c              | 540 +++++++++++++++++
 tools/testing/selftests/drivers/sdsi/sdsi.sh  |  18 +
 .../selftests/drivers/sdsi/sdsi_test.py       | 226 +++++++
 10 files changed, 1473 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
 create mode 100644 drivers/platform/x86/intel/sdsi.c
 create mode 100644 tools/arch/x86/intel_sdsi/Makefile
 create mode 100644 tools/arch/x86/intel_sdsi/sdsi.c
 create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
 create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py

-- 
2.25.1

