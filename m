Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50AE57594E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiGOB7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbiGOB7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:59:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25D83FA25;
        Thu, 14 Jul 2022 18:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ubmeGXB/9zYuFBNOFFQ6o10JlxydVtHtuhwBQg2+mgE=; b=MzLW3g5ro67FR7HjejRLHwcQN2
        OITymdLB2eGRLv2ZlT0qejba47LlUXoWYLOy77nPSMbaQgzJ/pqd1DZ9UWR3vJC5vIClx1OWOqKzw
        JzWV8hVwjnGBqzu1l17yWsoBR++WgDiYWqtqNrV7kbx+kyTcomHO8JHPdvV7eJ6mc+adqglnUq6qi
        P8jlEbSOg1mD+RLWQzzV6pLWo1nfiZg2F6P4JNJU3BavO4XMIWBysGAfD3DlR+rDy9imuW73WzeCl
        2uMIGQQu2SEmvm7UdSVVvifDBjUgRy/ooisLur+fGKbHpGxzbKVO7h9SWc8Hhu+eHkcg3DSySZOrT
        e8tdtb2A==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCAbk-009sWs-7P; Fri, 15 Jul 2022 01:59:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH] cpufreq: loongson2: fix Kconfig "its" grammar
Date:   Thu, 14 Jul 2022 18:59:03 -0700
Message-Id: <20220715015903.12537-1-rdunlap@infradead.org>
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
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-mips@vger.kernel.org
---
 drivers/cpufreq/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -268,7 +268,7 @@ config LOONGSON2_CPUFREQ
 	  This option adds a CPUFreq driver for loongson processors which
 	  support software configurable cpu frequency.
 
-	  Loongson2F and it's successors support this feature.
+	  Loongson2F and its successors support this feature.
 
 	  If in doubt, say N.
 
