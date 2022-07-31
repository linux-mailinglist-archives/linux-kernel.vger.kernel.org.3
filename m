Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5347E586059
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbiGaS2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiGaS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:28:07 -0400
Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F33BE2E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=924; q=dns/txt; s=iport;
  t=1659292086; x=1660501686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bv5QcmA0O1op7WObE6dUB/Vc4aYBLMmlkaMH2oviEho=;
  b=Yv6k0pEAaEpR9Om8uoILDunHm9iFhCgkVOKifsJp8Sk9ARLkIRR0zb1G
   L9biAWsr6S6t8taE1qQLFticbQJrnBhwmlEHHXa01oDrKyddT91SjK8YD
   u3G15R8KW+wD6Ia2J6FdzD7BaFz5OKM1MihvoCHPwG21oBF7aiE8ANLRw
   E=;
X-IPAS-Result: =?us-ascii?q?A0C2AAAgyOZilxbLJq1aHgEBCxIMggQLg3ssEkWNTIgQn?=
 =?us-ascii?q?HmBfAsBAQEPQgQBAYUGAoR1JjQJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEHBBQBAQEBAQEBAQkbBgwFEDWFOwgyhkMDAzIBRhAgMVcZgn2DGwOmb4Irg?=
 =?us-ascii?q?QGKAYE9iXmFJz0GgUlEhH2FEYVuBJgFAwkEBwVKRAMLLA8WBQgJFxIQEAIEE?=
 =?us-ascii?q?RoLBgMWPwkCBA4DQAgNAxEEAw8YCRIIEAQGAzEMJQsDFAwBBgMGBQMBAxsDF?=
 =?us-ascii?q?AMFJAcDHA8jDQ0EHx0DAwUlAwICGwcCAgMCBhUGAgI2GDkIBAgEKyMPBQIHL?=
 =?us-ascii?q?wUELwIeBAUGEQgCFgIGBAQEBBYCEAgCCCcXBxMzGQEFWRAJIRwOGhAFBhMDI?=
 =?us-ascii?q?G8FBz4PKDM1PCsfGwqBEiorFQMEBAMCBhgDAyICEC4xAxUGKRMSLQkqdQkCA?=
 =?us-ascii?q?yJtAwMEKi4DCSEfBwkwHZhQWjQIxDiDW59+GjGoZ5Z8oipahFCBYYIVTSMVg?=
 =?us-ascii?q?yNRGQ+BTIxgDQmOMEIxOwIGCwEBAwmPBgEB?=
IronPort-Data: A9a23:XJ6qtq4XVSF82gqo4zFrNgxRtDfHchMFZxGqfqrLsTDasY5as4F+v
 jMfCGmGa/qNYDP8Kosib9y/8ElX7ZbSxoJjHQE6+C0wZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyOa/lH3WlTYhSEUOZugHtIQM8aZfHEqLeNYYH1500g7xLVg2tcAbeWRWmthh
 /uj+6UzB3f9s9JEGjp8B3Wr8U4HUFza4Vv0j3RmDRx5lAa2e0o9UPrzEZqMw07QGeG4KAIVq
 9Hrl9lV9kuBl/sk50jMfrzTKiXmSZaKVeSCZ+Y/t6WK2nB/SiIOPqkTH9czUkN4qm6ylY5bk
 tUTja2Qc0AIMfiZ8Agde0Ew/yBWNKBcvbTAO3X66IqYzlbNdD3nxPAG4EMeZNJDvL0nRzsWr
 rpCcljhbTjb7w6y6LK2RfVyi8g/BMLqJ4gY/HpnyFk1CN54HMiTH/WiCdlwxBEytOB2Qdjlf
 s8wOShVVD7NbjJdNQJCYH45tL742iagG9FCk3qXpq0s4m7a5Bdsy7WrO8i9UsKLX8hOngCbu
 2fP5Uz9AxcTLtvZziCKmlqjnOLAniPTXIMUCa228eNsjFSPx2sVThoMWjOTpfi/l177WN9FL
 UEQ0jQhoLJ090GxSNT5GRqirxa5UgU0UtdKVuwi7xuRj6zd/0CSB3MPSXhKb9lOWNIKqSIC/
 XKmpNfGJGdUuuO/E3LDzoa0l3STNn1ARYMdXhMsQQwA6tjlhYg8iBPTU9pueJKIYs3J9SLYm
 G/V8XBv71kHpYtaiPXhpAGvbyeE/8CRFmYIChPrsnVJBz6VhbJJhaT1sDA3Dt4Zcu51q2VtW
 1BewaCjABgmV83lqcB0aLxl8EuVz/iEKibAplVkAoMs8T+gk1b6I90BumkjdBsxa5hfEdMMX
 KM1kV0JjHO0FCb6BZKbn6rqYyjX5fG6TI+8Bqy8giRmO8AuLmdrAx2ClWbJjzyyzyDAYIk0O
 IyQdo63HG0GBKF8pAdatM9DuYLHMhsWnDuJLbiilkzP+ePHNBa9FOdUWHPTP7tRxP7V/23oH
 yN3apLiJ+N3C7alPEE6MOc7cDg3EJTMLcqu9ZcMJrLaflsO9aNII6a5/I7NsrdNx8x9/tokN
 FnkMqOE4DITXUH6FDg=
IronPort-HdrOrdr: A9a23:z+xbDa35p22qkeCnONqGyAqjBLckLtp133Aq2lEZdPWaSKClfq
 eV7ZAmPHDP5gr5NEtLpTnEAtjifZq+z+8R3WBuB9aftWDd0QPCEGgh1/qB/9SKIULDH4BmuJ
 uIC5IfNDU1ZmIK6/oTJ2KDYrEd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,206,1654560000"; 
   d="scan'208";a="650848"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 31 Jul 2022 18:26:59 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 26VIQpXx008219;
        Sun, 31 Jul 2022 18:26:58 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [v4.9 PATCH 3/6] init/main: properly align the multi-line comment
Date:   Sun, 31 Jul 2022 20:26:33 +0200
Message-Id: <20220731182635.1910069-4-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220731182635.1910069-1-hegtvedt@cisco.com>
References: <20220731182635.1910069-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Add a tab before it to follow standard practices. Also add the missing
full stop '.'.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
(cherry picked from commit 1b3b3b49b9961401331a1b496db5bec5c7b41ae6)
---
 init/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index a6ecdd492ed..8b803078d7b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -498,10 +498,10 @@ asmlinkage __visible void __init start_kernel(void)
 	local_irq_disable();
 	early_boot_irqs_disabled = true;
 
-/*
- * Interrupts are still disabled. Do necessary setups, then
- * enable them
- */
+	/*
+	 * Interrupts are still disabled. Do necessary setups, then
+	 * enable them.
+	 */
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
-- 
2.34.1

