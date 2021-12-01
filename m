Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF29465333
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351589AbhLAQsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:48:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:26296 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351612AbhLAQrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:47:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216512562"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="216512562"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="512784014"
Received: from razaahme-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.36.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:23 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [RFCv3 5/7] HID: debug: Add USI usages
Date:   Wed,  1 Dec 2021 18:42:59 +0200
Message-Id: <20211201164301.44653-6-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201164301.44653-1-tero.kristo@linux.intel.com>
References: <20211201164301.44653-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Add USI defined usages to the HID debug code.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
[tero.kristo: squashed in EV_MSC definitions]
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/hid/hid-debug.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 7a92e2a04a09..cec0470e5485 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -141,8 +141,10 @@ static const struct hid_usage_entry hid_usage_table[] = {
     {0, 0x33, "Touch"},
     {0, 0x34, "UnTouch"},
     {0, 0x35, "Tap"},
+    {0, 0x38, "Transducer Index"},
     {0, 0x39, "TabletFunctionKey"},
     {0, 0x3a, "ProgramChangeKey"},
+    {0, 0x3B, "Battery Strength"},
     {0, 0x3c, "Invert"},
     {0, 0x42, "TipSwitch"},
     {0, 0x43, "SecondaryTipSwitch"},
@@ -160,7 +162,40 @@ static const struct hid_usage_entry hid_usage_table[] = {
     {0, 0x59, "ButtonType"},
     {0, 0x5A, "SecondaryBarrelSwitch"},
     {0, 0x5B, "TransducerSerialNumber"},
+    {0, 0x5C, "Preferred Color"},
+    {0, 0x5D, "Preferred Color is Locked"},
+    {0, 0x5E, "Preferred Line Width"},
+    {0, 0x5F, "Preferred Line Width is Locked"},
     {0, 0x6e, "TransducerSerialNumber2"},
+    {0, 0x70, "Preferred Line Style"},
+      {0, 0x71, "Preferred Line Style is Locked"},
+      {0, 0x72, "Ink"},
+      {0, 0x73, "Pencil"},
+      {0, 0x74, "Highlighter"},
+      {0, 0x75, "Chisel Marker"},
+      {0, 0x76, "Brush"},
+      {0, 0x77, "No Preference"},
+    {0, 0x80, "Digitizer Diagnostic"},
+    {0, 0x81, "Digitizer Error"},
+      {0, 0x82, "Err Normal Status"},
+      {0, 0x83, "Err Transducers Exceeded"},
+      {0, 0x84, "Err Full Trans Features Unavailable"},
+      {0, 0x85, "Err Charge Low"},
+    {0, 0x90, "Transducer Software Info"},
+      {0, 0x91, "Transducer Vendor Id"},
+      {0, 0x92, "Transducer Product Id"},
+    {0, 0x93, "Device Supported Protocols"},
+    {0, 0x94, "Transducer Supported Protocols"},
+      {0, 0x95, "No Protocol"},
+      {0, 0x96, "Wacom AES Protocol"},
+      {0, 0x97, "USI Protocol"},
+      {0, 0x98, "Microsoft Pen Protocol"},
+    {0, 0xA0, "Supported Report Rates"},
+      {0, 0xA1, "Report Rate"},
+      {0, 0xA2, "Transducer Connected"},
+      {0, 0xA3, "Switch Disabled"},
+      {0, 0xA4, "Switch Unimplemented"},
+      {0, 0xA5, "Transducer Switches"},
   { 15, 0, "PhysicalInterfaceDevice" },
     {0, 0x00, "Undefined"},
     {0, 0x01, "Physical_Interface_Device"},
@@ -990,7 +1025,10 @@ static const char *absolutes[ABS_CNT] = {
 
 static const char *misc[MSC_MAX + 1] = {
 	[MSC_SERIAL] = "Serial",	[MSC_PULSELED] = "Pulseled",
-	[MSC_GESTURE] = "Gesture",	[MSC_RAW] = "RawData"
+	[MSC_GESTURE] = "Gesture",	[MSC_RAW] = "RawData",
+	[MSC_PEN_ID] = "PenID",		[MSC_PEN_COLOR] "PenColor",
+	[MSC_PEN_LINE_WIDTH] = "PenLineWidth",
+	[MSC_PEN_LINE_STYLE] = "PenLineStyle",
 };
 
 static const char *leds[LED_MAX + 1] = {
-- 
2.25.1

