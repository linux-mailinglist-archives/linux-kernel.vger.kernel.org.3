Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6B53958A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346632AbiEaRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiEaRp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:45:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415132AC7C;
        Tue, 31 May 2022 10:45:25 -0700 (PDT)
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MVMqF-1oL5Br2wAZ-00SMuQ; Tue, 31
 May 2022 19:45:16 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] m68k: virt: Kconfig minor fixes
Date:   Tue, 31 May 2022 19:45:14 +0200
Message-Id: <20220531174514.1586248-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PnWVcVdYE0G9+ScLQlKSfM0HYC62jAW4m7Wb0mbdiWu1G2k1LH1
 +dcs64/0y9GVJfc1WnykHWHV2hpXvhBGnudWuGD8oQp4LGDtxS2OPmqRYo1Te/EL9lY10C8
 JrtSaObePtpwQzVL5UoD04UTjDDEdV4T+uC/p3YTw95SM88icfG4NDZccqOLnkxj+bTsRiC
 MUlH66vxFG0RwC9I5rp9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ys0Wbk22O+I=:N2lFnVjbpz4+1Ws8Akm2NE
 3X40bO1YwxG9sxTeYw96LttbRsKYUDYF4KrlUSnBZYrcUq5mPruycHarV+QCHBOvZAIqw9PvW
 jwbfCe3MXWpNIf/Fj0/z6FxQx0fh7Niro8q6b41Ulke7uaew0qw8O+gZ2Ox+UO1YVTzTq4yOS
 ggowdv6zzROHBESYblQLIjzH9J94nO3+au9DYi+Zq87OfvjZltggG4uXVuG6c7ciVUOswLPpD
 2vT8ryPhmEs/O2FTDspoUDKkbDCTLkQV0o5UPPlpSXwon7ww2xw0POK3SGyiB529h43RnbbYI
 yCuqCAw24vO3NQJhdtlqGKP9KucKk+ysBQ3kDnogmAaz1Ssh2SBtwivHava6NP4QbXEY6Wk8E
 60MN8uJ8/FROHMphfOm3fTTicufBLqYWZrvjQ0rPGYzZ7IbihU52hOhuRp+ur6kCFf/8rk2Ao
 ye5vaLMvkiTUSIjHzDkbWJKv/6RdATlrs17gMuzzJngJHkF4xF1HaYj/59ncal3K9t3lLwmlu
 ln783wxQoKn8v+taPIIfyyRtH8480qsaFQK+nuewcrwX0LGq44qY56R93VPsipzF14EqSrubo
 Qja+/RKq5HOEhI385PPlVa4kaReabJDdy7UZMjjsFRTaVBIqEDw7bW+olRNRYCrJC5tCeJZRI
 pOJ/AaRwCCaS6cm2s7krqSqTPrHN+ph9Rnldhzw2xHE/GIhIPKuYo533xDNfh92+z8W6rkql1
 bFg2uM/KiyUnmQSbluoWirZCTeN6PuRabhy0+g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select VIRTIO_MENU as it is needed by VIRTIO_MMIO.

Add an ending period at the end the virt machine help message.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 arch/m68k/Kconfig.machine | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index a1042568b9ad..4fbe57de1851 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -161,10 +161,11 @@ config VIRT
 	select RTC_CLASS
 	select RTC_DRV_GOLDFISH
 	select TTY
+	select VIRTIO_MENU
 	select VIRTIO_MMIO
 	help
 	  This options enable a pure virtual machine based on m68k,
-	  VIRTIO MMIO devices and GOLDFISH interfaces (TTY, RTC, PIC)
+	  VIRTIO MMIO devices and GOLDFISH interfaces (TTY, RTC, PIC).
 
 config PILOT
 	bool
-- 
2.36.1

