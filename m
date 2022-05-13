Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE38526011
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379324AbiEMKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379055AbiEMKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:16:47 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC73E21265;
        Fri, 13 May 2022 03:16:45 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AQNL8NaA205LTVBVW/8Lhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fUwHt1j131D0GnDFNWGiPPveKamr3e4xwat+1/EkP7JGAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9GgjOGj5Zz2f1DqJ6xV?=
 =?us-ascii?q?Rw0eKbLnYzxVjEBSX0kZPYfp+SvzX+X9Jb7I1f9W2fjx+VGCEAwIJEC/eB2ESd?=
 =?us-ascii?q?C+JQwLT8XaQuYr+a3xq+rDOhqmsknasLsOes3sGlI1izCALAqTPjrR6TM+M8d0?=
 =?us-ascii?q?DA7rt5BEOyYZMcDbzdrKhPabHVnPlYRFYJ7n+qygHT7WyNXpUjTpqct5WXXigt?=
 =?us-ascii?q?r39DQ3HD9EjCRbZwN2B/G+SSdpCKkaiz2/ee3kVKtmk9ATMeW9c8jZL8vKQ=3D?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A52oAfqGdTyWl+cNApLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124213173"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 May 2022 18:16:44 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0A2454D1716F;
        Fri, 13 May 2022 18:16:39 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 13 May 2022 18:16:39 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 13 May 2022 18:16:38 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <mgross@linux.intel.com>, <bp@suse.de>, <tglx@linutronix.de>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] x86/speculation: Add missing srbds=off in the document of 'mitigations='
Date:   Fri, 13 May 2022 18:16:37 +0800
Message-ID: <20220513101637.216487-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0A2454D1716F.A79BC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..93e9b15f1cf4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3103,6 +3103,7 @@
 					       mds=off [X86]
 					       tsx_async_abort=off [X86]
 					       kvm.nx_huge_pages=off [X86]
+					       srbds=off [X86,INTEL]
 					       no_entry_flush [PPC]
 					       no_uaccess_flush [PPC]
 
-- 
2.21.0



