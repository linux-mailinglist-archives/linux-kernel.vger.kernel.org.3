Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9992C4821E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 04:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242640AbhLaDjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 22:39:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:50282 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242613AbhLaDjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 22:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640921978; x=1672457978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3hVjEB5myWI5zDD304NaTBdrPrLbRGaDQpePtjKONU4=;
  b=NphmL74pgtbHWnSlEobEtovLdbFByHwP/1yFp8CmfrtcEnl2k+SPbpVQ
   AHvnaPFPjdup3jR+agl9w3jumGZzSjyGEmYk6QJQrovH0bDE/ytstXOe6
   ULyX9E5IOcio7CoxUq+qJ3u7qfh5XOkWTOTX2mucQZOng6yowAZ/Q0mdi
   mQN8946ZYGJQCVDZwAdGNezHrWd1kAYDyXNWL5aYl1UO8PDt9IuKnfaA4
   LvBZbezsepHJeyoKJuQ5BRIkONscprnwDMsUwY73gRTYLYXRRrAwSEW/b
   w3S00Fz+WJ7W9sG82nuuof5j3R2LOY+Y83WI2rIBRII7sd0E8FhT9jv2e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="328100645"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="328100645"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 19:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="666718307"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2021 19:39:37 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kay Sievers <kay.sievers@novell.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] Couple of cleanups in really_probe()
Date:   Fri, 31 Dec 2021 11:38:59 +0800
Message-Id: <20211231033901.2168664-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This series includes two cleanups in really_probe(). The purpose of
these cleanups are to make the sysfs add/remove and bus notification
events orderly when the driver can't bind to the device.

Best regards,
baolu

Change log:
v1: https://lore.kernel.org/all/20211229045159.1731943-1-baolu.lu@linux.intel.com/

v1->v2:
 - Split a single patch into two.
 - Remove the Fixes and Cc-stable tags as it doesn't fix any real
   bugs in practice. No need to back port. 

Lu Baolu (2):
  driver core: Move driver_sysfs_remove() after driver_sysfs_add()
  driver core: Make bus notifiers in right order in really_probe()

 drivers/base/dd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

