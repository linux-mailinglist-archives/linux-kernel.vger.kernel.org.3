Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87115465329
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351628AbhLAQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:48:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:26296 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351610AbhLAQrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:47:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216512506"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="216512506"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="512783969"
Received: from razaahme-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.36.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:14 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [RFCv3 2/7] HID: hid-input: Add suffix also for HID_DG_PEN
Date:   Wed,  1 Dec 2021 18:42:56 +0200
Message-Id: <20211201164301.44653-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201164301.44653-1-tero.kristo@linux.intel.com>
References: <20211201164301.44653-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

This and HID_DG_STYLUS are pretty much the same thing so add suffix for
HID_DG_PEN too. This makes the input device name look better.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 39ebedb2323b..73c2edda742e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1737,6 +1737,7 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 		case HID_GD_MOUSE:
 			suffix = "Mouse";
 			break;
+		case HID_DG_PEN:
 		case HID_DG_STYLUS:
 			suffix = "Pen";
 			break;
-- 
2.25.1

