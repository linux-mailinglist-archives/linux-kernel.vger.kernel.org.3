Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859134DB99E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbiCPUnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiCPUnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:43:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A864BC9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6Ex2pLdz5gD/Bu9SEokKuJDOiJb5N2ZhO58Lzad4N40=; b=XXAdcciDiJ2TmVJF/7I13wIpg6
        GVKvutTdqFEBWZbu4DumIWPla52Gz1mK+/5hRfxjl9GMsGGOJR+Jz+rWecAXhF8nfPxAbgGs4Fdpy
        oA3uPFToAKCoU3PMO0CVaiXs+ZRNOALRGt5x4G70+MxC564/so6di5ohQFa+fwv8a3tYPvhKi1jsn
        J3qFDlgPuYzqFaCueYpq9tfJfUJla2ctRTQaNmicix8cEKp0ZiMZrY5qeZQoPVdZYZmczLyHDe7mT
        Fqa5wZwR4G0McGkYlTOrLoxRqPdRqYyAyJXA4XQk0+n53uVJ6IgT+37Q1oxRQTHiE4Fb+Dv81XjxB
        NObHhdlg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUaSp-00EHHf-BG; Wed, 16 Mar 2022 20:41:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Subject: [PATCH -next] sched/headers: ARM needs asm/paravirt_api_clock.h
Date:   Wed, 16 Mar 2022 13:41:46 -0700
Message-Id: <20220316204146.14000-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
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

Add <asm/paravirt_api_clock.h> for arch/arm/.

Fixes this build error:

In file included from ../kernel/sched/core.c:81:
../kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
   87 | # include <asm/paravirt_api_clock.h>

Fixes: 4ff8f2ca6ccd ("sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: linux-next-20220316

 arch/arm/include/asm/paravirt_api_clock.h |    1 +
 1 file changed, 1 insertion(+)

--- /dev/null
+++ linux-next-20220316/arch/arm/include/asm/paravirt_api_clock.h
@@ -0,0 +1 @@
+#include <asm/paravirt.h>
