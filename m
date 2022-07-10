Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA356CD35
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 07:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiGJFSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 01:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJFSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 01:18:50 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05632CE06
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 22:18:43 -0700 (PDT)
X-QQ-mid: bizesmtp63t1657430289tl1a6gi5
Received: from localhost.localdomain ( [182.148.15.109])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 10 Jul 2022 13:18:06 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000C00A0000000
X-QQ-FEAT: 4rCmCcmdMHfAO7oteR2yxeyd0t2dSvgO4NlmkJx3dDbce1mMrmgwJAdDu1eL5
        DXhnTfNFNOQbXqNOBd7SM/VibJ5Z1Jm0WeaLSh8k/eZG2TlvKFs/zn4zbEG67H02J5pIVTv
        ceOyi4x/AD6zVxnDTxBAvChavcXUg/2Ffa0jFDX+wa7ZZomGtK6wpKelhT+JUhbM4Gn5rl+
        rMGmfSaWFeE8em2Uz+zmIrgLS5sfYig2l00CbUcR70gnOCzt7/BBVRnai/J3t6kSHETQWKK
        LfLLx3MpZ5nvDfmewmvDYdwDWYas1ojMVQXav23JIgU5iLZNxYEJ7KKJdwXIH9RyMY5+hNj
        cG6rv6pibUGXlKW5xGNxuFIRHqQAHvPSP0juBRXuftIQMErLKl2PJTTXTDCzw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     lenb@kernel.org, rafael@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] acpi/apei: fix repeated words in comments
Date:   Sun, 10 Jul 2022 13:18:00 +0800
Message-Id: <20220710051800.7294-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/acpi/apei/apei-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 33b7fbbeda82..ae6d156e32b4 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -4,7 +4,7 @@
  * infrastructure
  *
  * APEI allows to report errors (for example from the chipset) to the
- * the operating system. This improves NMI handling especially. In
+ * operating system. This improves NMI handling especially. In
  * addition it supports error serialization and error injection.
  *
  * For more information about APEI, please refer to ACPI Specification
-- 
2.36.1

