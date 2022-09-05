Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A7E5ACDD9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiIEIbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbiIEIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:31:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB68A6438
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:29:27 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MLhW00wsrz67xLp;
        Mon,  5 Sep 2022 16:28:44 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 10:29:24 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 09:29:22 +0100
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        <rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <yangyingliang@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 0/5] Misc hisi_lpc changes
Date:   Mon, 5 Sep 2022 16:23:01 +0800
Message-ID: <1662366186-233933-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xu Wei,

This is a series of small improvements to the driver from Andy
and myself.

Andy sent his patches originally in the following:
https://lore.kernel.org/lkml/20220708210859.6774-1-andriy.shevchenko@linux.intel.com/

Please consider sending through the arm-soc tree for v6.1 .

Based on v6.0-rc3.

Differences to v2:
- Fix handling of platform_device_register_full() error (Andy)
- Add Andy's RB tag (thanks!)

Differences to v1:
- remove blank lines in patch 5/5, as requested by Andy

Thanks,
John

Andy Shevchenko (4):
  bus: hisi_lpc: Don't dereference fwnode handle
  bus: hisi_lpc: Use devm_platform_ioremap_resource
  bus: hisi_lpc: Correct error code for timeout
  bus: hisi_lpc: Don't guard ACPI IDs with ACPI_PTR()

John Garry (1):
  bus: hisi_lpc: Use platform_device_register_full()

 drivers/bus/hisi_lpc.c | 96 +++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 52 deletions(-)

-- 
2.35.3

