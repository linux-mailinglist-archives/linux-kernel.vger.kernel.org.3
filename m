Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9759846FF8C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhLJLPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:15:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:54466 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237428AbhLJLPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:15:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301711571"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="301711571"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:11:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="516720817"
Received: from ccrisan-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.210.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:11:56 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [PATCHv4 3/5] HID: Add hid usages for USI style pens
Date:   Fri, 10 Dec 2021 13:11:36 +0200
Message-Id: <20211210111138.1248187-4-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
References: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usage codes for USI style pens, based on the USB-HID usage table:
    https://usb.org/document-library/hid-usage-tables-122

See chapter 16, Digitizers Page (0x0D)

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 include/linux/hid.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index cc797d608951..b8634d17d11e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -241,6 +241,7 @@ struct hid_item {
 #define HID_DG_TOUCH		0x000d0033
 #define HID_DG_UNTOUCH		0x000d0034
 #define HID_DG_TAP		0x000d0035
+#define HID_DG_TRANSDUCER_INDEX	0x000d0038
 #define HID_DG_TABLETFUNCTIONKEY	0x000d0039
 #define HID_DG_PROGRAMCHANGEKEY	0x000d003a
 #define HID_DG_BATTERYSTRENGTH	0x000d003b
@@ -253,6 +254,15 @@ struct hid_item {
 #define HID_DG_BARRELSWITCH	0x000d0044
 #define HID_DG_ERASER		0x000d0045
 #define HID_DG_TABLETPICK	0x000d0046
+#define HID_DG_PEN_COLOR			0x000d005c
+#define HID_DG_PEN_LINE_WIDTH			0x000d005e
+#define HID_DG_PEN_LINE_STYLE			0x000d0070
+#define HID_DG_PEN_LINE_STYLE_INK		0x000d0072
+#define HID_DG_PEN_LINE_STYLE_PENCIL		0x000d0073
+#define HID_DG_PEN_LINE_STYLE_HIGHLIGHTER	0x000d0074
+#define HID_DG_PEN_LINE_STYLE_CHISEL_MARKER	0x000d0075
+#define HID_DG_PEN_LINE_STYLE_BRUSH		0x000d0076
+#define HID_DG_PEN_LINE_STYLE_NO_PREFERENCE	0x000d0077
 
 #define HID_CP_CONSUMERCONTROL	0x000c0001
 #define HID_CP_NUMERICKEYPAD	0x000c0002
-- 
2.25.1

