Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDE467CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382409AbhLCRs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:48:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56604 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353385AbhLCRsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:48:25 -0500
Date:   Fri, 03 Dec 2021 17:44:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638553500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoACRO/DB5qjDEz/XpyclBOEktpzo44c+wSmwT4PCTU=;
        b=NZClIZeH4iYvYK8jBVrTLzOt7nEzAcFLhNYY3XlG0oowxaGFjBd2fvP8bMHNBePQWp1xTV
        CLmgzr5M1on80/l3i3hZiWSRs3ntTz3pbHlZ1oHdLDHJufk8P0qYmVPkSWj2Cy2Hs5A1E3
        H2ZbdWqrxyTfWYrgb9ihSRVbNY+iNgL2p/BcQenPdaEcjTXXOmxqw1A1e0V90rpSaEkTqq
        aSM+OobsQuj+Z2UPGFgIwrzVrDrA7B6wFLuDeWK6bLIw5j4lPOFVzJKNLx7xPL1DWG+Rln
        pFoCDsn4VMzIp8/Uo6m0xT9Rsg71MyA1zt6GIkHwChJcF7OydiAmIzkBQKpIzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638553500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoACRO/DB5qjDEz/XpyclBOEktpzo44c+wSmwT4PCTU=;
        b=cGagb5o7UOoXrJGzlY+Op/OPD1Y1LkAxXAYcSp2RGFHVMBRlyr1R5k/DhZS08gYoRzpXi4
        y8+32WE/AxhUnjDA==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/ce4100: Replace "ti,pcf8575" by "nxp,pcf8575"
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C0c00cec971f5c405e47d04e493d854de0efc2e49=2E16385?=
 =?utf-8?q?39629=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C0c00cec971f5c405e47d04e493d854de0efc2e49=2E163853?=
 =?utf-8?q?9629=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <163855349926.11128.14527362647058338597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     9e4d52a00a0217857fa40dc998971a375f861a61
Gitweb:        https://git.kernel.org/tip/9e4d52a00a0217857fa40dc998971a375f861a61
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Fri, 03 Dec 2021 14:55:23 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 03 Dec 2021 18:23:57 +01:00

x86/ce4100: Replace "ti,pcf8575" by "nxp,pcf8575"

The TI part is equivalent to the NXP part, and its compatible value is
not documented in the DT bindings.

Note that while the Linux driver DT match table does not contain the
compatible value of the TI part, it could still match to this part, as
i2c_device_id-based matching ignores the vendor part of the compatible
value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lkml.kernel.org/r/0c00cec971f5c405e47d04e493d854de0efc2e49.1638539629.git.geert+renesas@glider.be
---
 arch/x86/platform/ce4100/falconfalls.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/ce4100/falconfalls.dts b/arch/x86/platform/ce4100/falconfalls.dts
index 0ac3d43..65fa3d8 100644
--- a/arch/x86/platform/ce4100/falconfalls.dts
+++ b/arch/x86/platform/ce4100/falconfalls.dts
@@ -249,7 +249,7 @@
 
 						gpio@26 {
 							#gpio-cells = <2>;
-							compatible = "ti,pcf8575";
+							compatible = "nxp,pcf8575";
 							reg = <0x26>;
 							gpio-controller;
 						};
@@ -263,7 +263,7 @@
 
 						gpio@26 {
 							#gpio-cells = <2>;
-							compatible = "ti,pcf8575";
+							compatible = "nxp,pcf8575";
 							reg = <0x26>;
 							gpio-controller;
 						};
