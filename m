Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0666B46FF90
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhLJLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:15:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:54474 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237577AbhLJLPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:15:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301711579"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="301711579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:12:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="516720832"
Received: from ccrisan-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.210.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:12:01 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [PATCHv4 5/5] HID: debug: Add USI usages
Date:   Fri, 10 Dec 2021 13:11:38 +0200
Message-Id: <20211210111138.1248187-6-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
References: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Add USI defined usages to the HID debug code.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/hid/hid-debug.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 7a92e2a04a09..26c31d759914 100644
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
-- 
2.25.1

