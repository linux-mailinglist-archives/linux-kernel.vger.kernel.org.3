Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65A657F60C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiGXQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiGXQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:49:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF1D10FD9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 09:49:49 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LrTYd0ZvQz67Kvx;
        Mon, 25 Jul 2022 00:45:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Jul 2022 18:49:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Jul 2022 17:49:44 +0100
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <soc@kernel.org>
CC:     <jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] arm64: defconfig: Enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
Date:   Mon, 25 Jul 2022 00:43:24 +0800
Message-ID: <1658681004-132191-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable
from a choice") faddr2line has stopped working by default as it relies
on CONFIG_DEBUG_INFO.

Enable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT to get it working again,
which seems the sensible config option to use.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index de662de0bb4d..43e3550afa45 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1311,6 +1311,7 @@ CONFIG_CRYPTO_DEV_HISI_TRNG=m
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
-- 
2.35.3

