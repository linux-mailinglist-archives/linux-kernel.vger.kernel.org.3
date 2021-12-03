Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8A4678EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381192AbhLCN66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380508AbhLCN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:58:57 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C13C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:55:32 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:3191:9890:620a:6f4])
        by michel.telenet-ops.be with bizsmtp
        id RpvT2600E3eLghq06pvTJX; Fri, 03 Dec 2021 14:55:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt926-002Lev-S6; Fri, 03 Dec 2021 14:55:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt926-000lV8-AW; Fri, 03 Dec 2021 14:55:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 resend] x86: ce4100: Replace "ti,pcf8575" by "nxp,pcf8575"
Date:   Fri,  3 Dec 2021 14:55:23 +0100
Message-Id: <0c00cec971f5c405e47d04e493d854de0efc2e49.1638539629.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI part is equivalent to the NXP part, and its compatible value is
not documented in the DT bindings.

Note that while the Linux driver DT match table does not contain the
compatible value of the TI part, it could still match to this part, as
i2c_device_id-based matching ignores the vendor part of the compatible
value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v3:
  - Add Reviewed-by,

v2:
  - New.
---
 arch/x86/platform/ce4100/falconfalls.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/ce4100/falconfalls.dts b/arch/x86/platform/ce4100/falconfalls.dts
index 0ac3d43571361112..65fa3d866226ce97 100644
--- a/arch/x86/platform/ce4100/falconfalls.dts
+++ b/arch/x86/platform/ce4100/falconfalls.dts
@@ -249,7 +249,7 @@ i2c@1 {
 
 						gpio@26 {
 							#gpio-cells = <2>;
-							compatible = "ti,pcf8575";
+							compatible = "nxp,pcf8575";
 							reg = <0x26>;
 							gpio-controller;
 						};
@@ -263,7 +263,7 @@ i2c@2 {
 
 						gpio@26 {
 							#gpio-cells = <2>;
-							compatible = "ti,pcf8575";
+							compatible = "nxp,pcf8575";
 							reg = <0x26>;
 							gpio-controller;
 						};
-- 
2.25.1

