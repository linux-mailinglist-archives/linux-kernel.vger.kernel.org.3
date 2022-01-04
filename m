Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE25484A13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiADVmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:42:39 -0500
Received: from aposti.net ([89.234.176.197]:52066 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234687AbiADVmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:42:37 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/8] PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS macro
Date:   Tue,  4 Jan 2022 21:42:08 +0000
Message-Id: <20220104214214.198843-3-paul@crapouillou.net>
In-Reply-To: <20220104214214.198843-1-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep this macro in line with the other ones. This makes it possible to
use them in the cases where the underlying dev_pm_ops structure is
exported.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/linux/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 31bbaafb06d2..389e600df233 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -362,7 +362,7 @@ struct dev_pm_ops {
  * to RAM and hibernation.
  */
 #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-static const struct dev_pm_ops name = { \
+const struct dev_pm_ops name = { \
 	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 }
 
-- 
2.34.1

