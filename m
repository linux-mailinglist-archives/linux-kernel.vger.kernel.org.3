Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36A47EDA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352172AbhLXJPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:15:07 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:22905 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352165AbhLXJPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:15:06 -0500
X-UUID: 046f702daed34fef9d1d893f7cbc4d58-20211224
X-CPASD-INFO: 34b417fd38014c059e2a55d60f022626@fIScVF5plJRfWHJ9g6Z7b1mWYpFlYYS
        FcqBQYmBmXlaVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3gnacVGFllg==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 34b417fd38014c059e2a55d60f022626
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:173.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:83.0,IP:-2.0,MAL:0.0,ATTNUM:0.
        0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4488.0,FROMTO:0,AD:0,FFOB:0.0,CFO
        B:0.0,SPC:0.0,SIG:-5,AUF:101,DUF:27928,ACD:143,DCD:245,SL:0,AG:0,CFC:0.893,CF
        SR:0.042,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: 046f702daed34fef9d1d893f7cbc4d58-20211224
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: 046f702daed34fef9d1d893f7cbc4d58-20211224
X-User: yinxiujiang@kylinos.cn
Received: from localhost.localdomain [(118.26.139.139)] by nksmu.kylinos.cn
        (envelope-from <yinxiujiang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1032329646; Fri, 24 Dec 2021 17:27:40 +0800
From:   Yin Xiujiang <yinxiujiang@kylinos.cn>
To:     rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: Remove initialization of static variables to 0
Date:   Fri, 24 Dec 2021 17:14:58 +0800
Message-Id: <20211224091458.693093-1-yinxiujiang@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the initialization of three static variables to 0 which is
pointless

Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
---
 drivers/acpi/acpica/dbhistry.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index fd813c5d3952..60b77b11c0f2 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -24,9 +24,9 @@ typedef struct history_info {
 } HISTORY_INFO;
 
 static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZE];
-static u16 acpi_gbl_lo_history = 0;
-static u16 acpi_gbl_num_history = 0;
-static u16 acpi_gbl_next_history_index = 0;
+static u16 acpi_gbl_lo_history;
+static u16 acpi_gbl_num_history;
+static u16 acpi_gbl_next_history_index;
 
 /*******************************************************************************
  *
-- 
2.30.0

