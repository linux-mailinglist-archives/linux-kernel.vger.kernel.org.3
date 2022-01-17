Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B81490C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbiAQQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiAQQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:13:33 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3595C061574;
        Mon, 17 Jan 2022 08:13:32 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4Jcxlt1PXKzQkjD;
        Mon, 17 Jan 2022 17:13:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642436008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5bVOXCL2pZNunkAFXt1lXg86764+54YuO1hqIIS1yLY=;
        b=1ivOzRS/ndOFvUhV3eT53xTajKVkINaGrlRRubrtttZXI58xzF5xJ1MjDpBD8tfPQtHMfr
        JRE/9oQJHDxKfiu5fM0dZDbZXlyVVPTtzPYo+UV3G1TJ2hKQU1OLvQn+R5G3Q744hUlxzl
        WKdYtXtb+ZhsxhIWY57guW+sr2xmJHtXlD21kes7O5PJ0pv8bFtl2BDk3o+yWsznOxTGPx
        Rikf+wMFWPOXW5zVidDu/mlx7feh88ot+MIL75mXjGN9kdivlaOeqr00c8TzZ/PgPWcdn9
        vO+elHfDT4E3aUEhp8qORQiqBZRwBtbgBdlr/qqm11UHvYNCx24QJP/lvD3z9A==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] pmbus: remove trailing whitespaces
Date:   Mon, 17 Jan 2022 17:12:49 +0100
Message-Id: <c984b88b136a1cde16ce52c5f818886653b0f84a.1642434222.git.sylv@sylv.io>
In-Reply-To: <cover.1642434222.git.sylv@sylv.io>
References: <cover.1642434222.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch issues by removing trailing whitespaces in Kconfig.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/hwmon/pmbus/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 41f6cbf96d3b..c96f7b7338bd 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -189,8 +189,8 @@ config SENSORS_LTC2978_REGULATOR
 	depends on SENSORS_LTC2978 && REGULATOR
 	help
 	  If you say yes here you get regulator support for Linear Technology
-	  LTC3880, LTC3883, LTC3884, LTC3886, LTC3887, LTC3889, LTC7880, 
-	  LTM4644, LTM4675, LTM4676, LTM4677, LTM4678, LTM4680, LTM4686, 
+	  LTC3880, LTC3883, LTC3884, LTC3886, LTC3887, LTC3889, LTC7880,
+	  LTM4644, LTM4675, LTM4676, LTM4677, LTM4678, LTM4680, LTM4686,
 	  and LTM4700.
 
 config SENSORS_LTC3815
-- 
2.33.1

