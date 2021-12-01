Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF84464D6B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349136AbhLAMFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:05:10 -0500
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252]:52086 "EHLO
        esa7.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349169AbhLAMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:04:47 -0500
IronPort-SDR: pGfgp/2oKcMmTL52Yed7dYUXke+4FT+3ea4WhRH8kSjW0MEI60bKSX41hQqgtX53Bm9pbyJiw9
 FqCClh9yA2ZTgcC360cL1+jZjRxaeMVLZfVHb4NDnw7Uw/FK1E5hERoC/qKmQbMN0XRL2B1M6P
 YNlC9ujdX4vUHa7K/k9fvtHdfFGS29sPtP89ZyGkxJoTDVgTMEMN52nkkQtMH0l2Bc0j9Hbkr4
 rJNehU1eHFfyiC2iLSlWC4H6SiN1fCGwNXvxexdBvFyfbCQRIn5GLB35D3DuZ2/7dyo8xxBRhk
 ddDXVaeMOqdaofAtT4O+7FYl
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="33420900"
X-IronPort-AV: E=Sophos;i="5.87,278,1631545200"; 
   d="scan'208";a="33420900"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Dec 2021 21:01:15 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 55E53E9E43
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 21:01:14 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C6A3C9262
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 21:01:13 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 548A24008A297;
        Wed,  1 Dec 2021 21:01:13 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     linux-kernel@vger.kernel.org, mchehab+huawei@kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        ionela.voinescu@arm.com, pcc@google.com, bilbao@vt.edu,
        matorola@gmail.com, rafael@kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 1/2] docs: document the sysfs ABI for "nohz_full"
Date:   Wed,  1 Dec 2021 20:59:56 +0900
Message-Id: <20211201115957.254224-2-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211201115957.254224-1-tarumizu.kohei@fujitsu.com>
References: <20211201115957.254224-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documentation of sysfs ABI for "nohz_full". It was added
by commit 6570a9a1ce3a("show nohz_full cpus in sysfs"). However,
there is no documentation for these interface.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 69c65da16dff..f84c32f0bdf6 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -666,3 +666,10 @@ Description:	Preferred MTE tag checking mode
 		================  ==============================================
 
 		See also: Documentation/arm64/memory-tagging-extension.rst
+
+What:		/sys/devices/system/cpu/nohz_full
+Date:		Apr 2015
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) the list of CPUs that are in nohz_full mode.
+		These CPUs are set by boot parameter "nohz_full=".
-- 
2.27.0

