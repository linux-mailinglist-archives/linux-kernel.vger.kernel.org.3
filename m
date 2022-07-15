Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F857594C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiGOB7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiGOB7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:59:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA62B639
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Yst2yccGqVsHHqDRowt/OQDTK10KawgyD2WvW7jbQUM=; b=UaAp8IxGBlD9H4eVA9Ft/ypU2D
        cP4+Ouaakuhu9jH5mY8QKwXSNYBJPbkC+Cb1GhkN63oyGBKHLCZrAergphBC7g3k3sBEoe+MMl9Rc
        F1QERcGtYQHlNE7YQ2ACv4McRJk0Dt2wtkVulEGpuuja8aKWMsbEZKcL82gUTmn9O6+ulpVnX0oKN
        uwql9JrcdiVbIXb3Fl9h7KV9g7JvJLdYzBpXDJXdbIBONgjpLWg+pPJUow7RAZy05x2e7Kmg9J+ne
        r+Cpc0aMKFfArXZqinWtpakxdmT+87GhYcxfcCtugdq+emr/OUECxTk8DBpOk/kVmf1qdbLRfIUOe
        ssCt8Qiw==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCAba-009sW1-9c; Fri, 15 Jul 2022 01:58:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clocksource: arm_global_timer: fix Kconfig "its" grammar
Date:   Thu, 14 Jul 2022 18:58:52 -0700
Message-Id: <20220715015852.12523-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the possessive "its" instead of the contraction "it's"
where appropriate.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/clocksource/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -373,7 +373,7 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	depends on ARM_GLOBAL_TIMER
 	help
 	  When the ARM global timer initializes, its current rate is declared
-	  to the kernel and maintained forever. Should it's parent clock
+	  to the kernel and maintained forever. Should its parent clock
 	  change, the driver tries to fix the timer's internal prescaler.
 	  On some machs (i.e. Zynq) the initial prescaler value thus poses
 	  bounds about how much the parent clock is allowed to decrease or
