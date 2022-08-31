Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B465A76D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiHaGmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiHaGmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:42:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B188EBE4F9;
        Tue, 30 Aug 2022 23:42:03 -0700 (PDT)
X-QQ-mid: bizesmtp80t1661928119tglclo0g
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:41:58 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: hoArX50alxF+DlkLpK/znGIRlCGJAm5yW5Wu9It0PjkeJdDzPx4f/OSE+9DEh
        rAxdP9B2znhloLLiMI6VFCGcf/jPHLjKzmg2yUUZnQoX5oAfEPLgo7u+UdrlPV45aKrawxF
        VfRK7k/avmHGqPywszbzi2kYfemyUm1hjJwRmuHSaRBQHg1YWNW6BVqh56dl7S99T2xd++G
        cRdlvl+qtvLafgxh/Vu62x7Feia77RpQoULA36ddg5hOJJ5KZk0MsiWObohTCatrmqGRBPa
        Z+QWTAQ1WilbHDn8HZByjeMjVa8EgdcANyygxu/raMp0/EkIzFg6H6P2juLF0IZAzuj9RKn
        w0JTNfJWGPnVnLff7XBKd00S0Fg/B0QiLVOxc0Ru/Qy1hjoGzKg1b1VOnDYlQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mips: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:41:51 +0800
Message-Id: <20220831064151.22233-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'of'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/mips/sgi-ip22/ip22-gio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index 8686e8c1c4e5..b8e944b81a92 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -41,7 +41,7 @@ static struct device gio_bus = {
 /**
  * gio_match_device - Tell if an of_device structure has a matching
  * gio_match structure
- * @ids: array of of device match structures to search in
+ * @ids: array of device match structures to search in
  * @dev: the of device structure to match against
  *
  * Used by a driver to check whether an of_device present in the
-- 
2.36.1

