Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF134D7B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiCNHSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiCNHSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:18:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27443FDA8;
        Mon, 14 Mar 2022 00:17:06 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7GwIN2004173, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7GwIN2004173
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:16:58 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 14 Mar 2022 15:16:58 +0800
Received: from localhost.localdomain (172.21.132.198) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 15:16:57 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <karenhsu@realtek.com>, <kidman@realtek.com>,
        <max.chou@realtek.com>, <hsinyu_chang@realtek.com>
Subject: [PATCH] rtl_bt: Add firmware and config files for RTL8852B
Date:   Mon, 14 Mar 2022 15:16:53 +0800
Message-ID: <20220314071653.1656-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.198]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/14/2022 06:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTQgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

This firmware/config submitted is for RTL8852B BT USB I/F.

Version: 0xDFB7_91CB

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 WHENCE                      |   2 ++
 rtl_bt/rtl8852bu_config.bin | Bin 0 -> 6 bytes
 rtl_bt/rtl8852bu_fw.bin     | Bin 0 -> 55276 bytes
 3 files changed, 2 insertions(+)
 create mode 100644 rtl_bt/rtl8852bu_config.bin
 create mode 100644 rtl_bt/rtl8852bu_fw.bin

diff --git a/WHENCE b/WHENCE
index 16cc12f..8f37cc3 100644
--- a/WHENCE
+++ b/WHENCE
@@ -4033,6 +4033,8 @@ File: rtl_bt/rtl8822cs_fw.bin
 File: rtl_bt/rtl8822cs_config.bin
 File: rtl_bt/rtl8852au_fw.bin
 File: rtl_bt/rtl8852au_config.bin
+File: rtl_bt/rtl8852bu_fw.bin
+File: rtl_bt/rtl8852bu_config.bin
 
 Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
 
diff --git a/rtl_bt/rtl8852bu_config.bin b/rtl_bt/rtl8852bu_config.bin
new file mode 100644
index 0000000000000000000000000000000000000000..91d3f4402289e7b0efd395c7fcc8b4789465aba6
GIT binary patch
literal 6
NcmWGtt=!JQ000Mk0jmH2

literal 0
HcmV?d00001

diff --git a/rtl_bt/rtl8852bu_fw.bin b/rtl_bt/rtl8852bu_fw.bin
new file mode 100644
index 0000000000000000000000000000000000000000..1d446101e2128ca692152f41cdb286346c9fce8f
GIT binary patch
literal 55276
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

literal 0
HcmV?d00001

-- 
2.17.1

