Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A5484012
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiADKpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:45:51 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:36320 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiADKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:45:49 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1n4hJo-00089g-BW; Tue, 04 Jan 2022 10:45:32 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1n4hJi-001BhW-DX; Tue, 04 Jan 2022 10:45:24 +0000
From:   anton.ivanov@cambridgegreys.com
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@axis.com, robh+dt@kernel.org, jdike@addtoit.com,
        johannes@sipsolutions.net, vincent.whitchurch@axis.com,
        richard@nod.at, linux-doc@vger.kernel.org,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: Document dtb command line option
Date:   Tue,  4 Jan 2022 10:44:57 +0000
Message-Id: <20220104104457.282828-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1118129237.194759.1640202076897.JavaMail.zimbra@nod.at>
References: <1118129237.194759.1640202076897.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Add documentation for the dtb command line option and the
ability to load/parse device trees.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 .../virt/uml/user_mode_linux_howto_v2.rst     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 2cafd3c3c6cb..81986fe014d4 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -1189,6 +1189,26 @@ E.g. ``os_close_file()`` is just a wrapper around ``close()``
 which ensures that the userspace function close does not clash
 with similarly named function(s) in the kernel part.
 
+Using UML as a Test Platform
+============================
+
+UML is an excellent test platform for device driver development. As
+with most things UML, "some user assembly may be required". It is
+up to the user to build their emulation environment. UML at present
+provides only the kernel infrastructure.
+
+Part of this infrastructure is the ability to load and parse fdt
+device tree blobs as used in Arm or Open Firmware platforms. These
+are supplied as an optional extra argument to the kernel command
+line::
+
+    dtb=filename
+
+The device tree is loaded and parsed at boottime and is accessible by
+drivers which query it. At this moment in time this facility is
+intended solely for development purposes. UML's own devices do not
+query the device tree.
+
 Security Considerations
 -----------------------
 
-- 
2.30.2

