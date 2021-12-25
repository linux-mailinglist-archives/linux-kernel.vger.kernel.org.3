Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4878A47F49A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 23:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhLYWcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 17:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLYWcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 17:32:53 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B323C061401;
        Sat, 25 Dec 2021 14:32:52 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640471568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bQtXtryogCMjBVY3/k4gfUtoHHlEfbKEdPsvtG8nGX0=;
        b=NPqwKxmYJQbRt6rRKmYIxtG4GqDaCxsGgEHTjuX+TCJadaQk4JODOBBvtvTLFOGShQOxT0
        ESEe9QD9pHCCVruUWHtCakoaZfM2uOIABDQH9YqlDnBPlge4QCn4AxZZ/L6Klywp+BpClx
        Qajc3lgXE1JFJy0L/LzP5yz/oUcp0GI=
From:   andrey.konovalov@linux.dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: raw-gadget: upgrade license identifier
Date:   Sat, 25 Dec 2021 23:32:36 +0100
Message-Id: <f55721ade28b2715eaf54b28a1bbfaad7b5adc0d.1640471342.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

Most of the USB gadget modules are licensed as GPL-2.0+. There is no
reason not to allow using Raw Gadget code under a newer GPL version.

Change SPDX identifier from GPL-2.0 to GPL-2.0+.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

---

I don't know whether such license change is possible and what it
requires.

Initially, when creating raw_gadget.c, I just copied GPL-2.0 from
somewhere as it didn't seem to matter. Recently, I was looking into
adding a license to a project that reuses both dummy_hcd.c and
raw_gadget.c, and I noticed the difference in licensing rules.

Hence this patch.
---
 drivers/usb/gadget/legacy/raw_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index c5a2c734234a..79d2363cb2b4 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * USB Raw Gadget driver.
  * See Documentation/usb/raw-gadget.rst for more details.
-- 
2.25.1

