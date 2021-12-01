Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FCA464D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349139AbhLAMFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:05:13 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223]:6644 "EHLO
        esa9.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349175AbhLAME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:04:59 -0500
IronPort-SDR: KwWKXZUYiKS+ofKpzz9Ia3+ewJ5b4EI6/vJNTdx0YF0WDMsZq9pXmfuwVdZEqwchlRlNV+bUNB
 dX4TEv5iMDTptKh8jWdE6fXjDmLZQ9kksnKzcmTxVb86nnGH8Rfk2dY5mmx/gWWbWEP5JvpQ+2
 KJsAVED3fq0zKKuqNRpAnsEkbRd1zp02VVhyLSxcBEU/61y2ruoAtBzA4n+KQ2KY9Xl0JqGfrx
 dFcIqi6md1XqJsUMW2e06HAIeq2dxlcTJfZ59gRGA92cehQBe4n5WGT5NQIQufzvFFswpnCMPO
 wPe/4DjgEgK2LyqmHeGlx3d9
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="42610609"
X-IronPort-AV: E=Sophos;i="5.87,278,1631545200"; 
   d="scan'208";a="42610609"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Dec 2021 21:01:19 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D2767E9E44
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 21:01:18 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 06D33D9973
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 21:01:18 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id D30164008A13E;
        Wed,  1 Dec 2021 21:01:17 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     linux-kernel@vger.kernel.org, mchehab+huawei@kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        ionela.voinescu@arm.com, pcc@google.com, bilbao@vt.edu,
        matorola@gmail.com, rafael@kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 2/2] docs: document the sysfs ABI for "isolated"
Date:   Wed,  1 Dec 2021 20:59:57 +0900
Message-Id: <20211201115957.254224-3-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211201115957.254224-1-tarumizu.kohei@fujitsu.com>
References: <20211201115957.254224-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documentation of sysfs ABI for "isolated". It was added by
commit 59f30abe94bf("show isolated cpus in sysfs"). However, there is
no documentation for these interface.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index f84c32f0bdf6..61f5676a7429 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -673,3 +673,11 @@ Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
 		(RO) the list of CPUs that are in nohz_full mode.
 		These CPUs are set by boot parameter "nohz_full=".
+
+What:		/sys/devices/system/cpu/isolated
+Date:		Apr 2015
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) the list of CPUs that are isolated and don't
+		participate in load balancing. These CPUs are set by
+		boot parameter "isolcpus=".
-- 
2.27.0

