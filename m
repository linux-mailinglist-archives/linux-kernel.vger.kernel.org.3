Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F32489914
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiAJNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42810 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiAJM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:59:59 -0500
Date:   Mon, 10 Jan 2022 12:59:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBFxIJM41Sb9w8JcbLtCIYY4vHvFqp1D/k8qj+NTmHQ=;
        b=13kqqn3hAbunSUcyPU2sKogDUlSVZWKi1ODlySX72WBlMP5gl4HTSsbbpIETK8egRRXnOW
        Fky8MN1B/B9YXkiEClUDg8+TWZnsB37WSd0rE3+JyxWiGHg+TD7bAgO65kQ90wKb/N8OQz
        aKrYloAUFgzyme0RomSKZgBI4sOrnPHmwjfQcuKEhpsjAYdFGpEqfdZ1GPYn+yeMwlhHe3
        ne8QJVQ7I0/tObr4V6pHTjd9HkftxFLSSZeE53xHvrfVarQyMigpXry8EIoLYlN/BZlSH4
        WCR5ITN7qNRS+4FnRFZWwR/UIudp92sZBIJAJ8sqfYqdZkiemvJketXeBTQxIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBFxIJM41Sb9w8JcbLtCIYY4vHvFqp1D/k8qj+NTmHQ=;
        b=9S5BS/l3f41dUVLhFk0lE7Pi9K+sq2Wemcqxu6XxHIpO9Stk/8SsiueD6nm9Nfq3nakGTD
        KYx8T1wKu1qa9UDw==
From:   "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/renesas,ostm: Make
 RENESAS_OSTM symbol visible
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112184413.4391-5-biju.das.jz@bp.renesas.com>
References: <20211112184413.4391-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <164181959581.16921.2907921100695481721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a2807f657976b943bf0eb81d026398d28aa89863
Gitweb:        https://git.kernel.org/tip/a2807f657976b943bf0eb81d026398d28aa89863
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Fri, 12 Nov 2021 18:44:13 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 09 Dec 2021 14:05:20 +01:00

clocksource/drivers/renesas,ostm: Make RENESAS_OSTM symbol visible

As RZ/G2L uses the ARM Architected Timer as system timer, enabling
the OSTM is not mandatory.

Make RENESAS_OSTM symbol visible, so that user can enable it
when needed.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211112184413.4391-5-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f65e31b..821ea4a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -510,7 +510,8 @@ config SH_TIMER_MTU2
 	  This hardware comes with 16-bit timer registers.
 
 config RENESAS_OSTM
-	bool "Renesas OSTM timer driver" if COMPILE_TEST
+	bool "Renesas OSTM timer driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
 	select CLKSRC_MMIO
 	select TIMER_OF
 	help
