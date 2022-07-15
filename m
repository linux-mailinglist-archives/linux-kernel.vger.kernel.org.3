Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9BA575957
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbiGOCAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 22:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbiGOB7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:59:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD34B71BC4;
        Thu, 14 Jul 2022 18:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=U1Pnkjl1TQvDGHeLMcLaMQ6UHR2dQ4Eet6DoluHtc8w=; b=oAbK8Hqr9z3GSd9gMw9LIaf4lT
        UnyUuHneSq9/6nknXPylHb3FkbIKxuTPpxPWVxbqhcdPPgox0PS3P68k3lfCWeEt/oa8v2yjMKFkm
        HWefJpLuM2umRgY4yJ41ONJ9/1I+LHF7O473r//LadRAGHvHBpXyQOBQHhRG+4D/fKZZX14uEADxJ
        rlkAGF1qA+XvekYAPVg3SfAF+2TvHpFZZusTtgDXc7+Fp3sZ8iqI5K07eMivlJeVuiWOygKc0aQqY
        Maa+XRpICvGU4xWBuzsjSO8lQwlcTqNW1s7CxiClWrRhc7dTNfs7AYYpTVmr6dOSznxrNMw+PFOKE
        t/hZeScg==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCAcS-009scA-F4; Fri, 15 Jul 2022 01:59:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org
Subject: [PATCH] leds: clevo-mail: fix Kconfig "its" grammar
Date:   Thu, 14 Jul 2022 18:59:48 -0700
Message-Id: <20220715015948.12643-1-rdunlap@infradead.org>
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
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-leds@vger.kernel.org
---
 drivers/leds/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -456,7 +456,7 @@ config LEDS_CLEVO_MAIL
 
 	  The driver supports two kinds of interface: using ledtrig-timer
 	  or through /sys/class/leds/clevo::mail/brightness. As this LED
-	  cannot change it's brightness it blinks instead. The brightness
+	  cannot change its brightness it blinks instead. The brightness
 	  value 0 means off, 1..127 means blink at 0.5Hz and 128..255 means
 	  blink at 1Hz.
 
