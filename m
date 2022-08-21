Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E446059B4D1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiHUPGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiHUPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:06:18 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A54E22520;
        Sun, 21 Aug 2022 08:06:15 -0700 (PDT)
X-QQ-mid: bizesmtp66t1661094372t953kfsl
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:06:10 +0800 (CST)
X-QQ-SSF: 0100000000200010B000B00A0000000
X-QQ-FEAT: rtp58PZ8kKibsJ2r1Mtoatw0Jl9p7QjFauFONfhGKZcUfOjFhOVMTyVaXyaM8
        dGuh+WyTNK//zM0KdGZvaQrDumoouUGhf01nYK9XXNo/5GzUhq/B5kvWIJCJOxGthkbhWTY
        08VFm4fYrcaPcaAq1sHyR1bULM+4+ZyffCS5vXOiD6ueVg7jpqG+4K2wZOvFbSXjIpb1bCq
        d+zZwqJ1B8KkVTW8MxR1PwY1+deNsGZzDQE25xmPonNLUimjpBBnWkfdsWchocjejEjrw3u
        UUYMm1GAppSGrHZv73GA7WQQ4HRe7q8yNPI1sMDd/aYLCB+CYzO3DA69j8wABPrh8QDv7fB
        RTzyuLEKLK5I3g4uGnS1JUyeqa5w96O8LNNcaJi
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] mips/sgi-ip22: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:06:04 +0800
Message-Id: <20220821150604.52687-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'of'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/parisc/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index 7df140545b22..78c354af2820 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -16,7 +16,7 @@
  *      fail to reach their PLT stub if we only create one big stub array for
  *      all sections at the beginning of the core or init section.
  *      Instead we now insert individual PLT stub entries directly in front of
- *      of the code sections where the stubs are actually called.
+ *      the code sections where the stubs are actually called.
  *      This reduces the distance between the PCREL location and the stub entry
  *      so that the relocations can be fulfilled.
  *      While calculating the final layout of the kernel module in memory, the
-- 
2.36.1

