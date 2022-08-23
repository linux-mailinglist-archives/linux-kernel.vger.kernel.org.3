Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926B859E8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbiHWRNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344110AbiHWRMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:12:16 -0400
X-Greylist: delayed 88 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 06:56:20 PDT
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE078F3260;
        Tue, 23 Aug 2022 06:56:20 -0700 (PDT)
X-QQ-mid: bizesmtp64t1661262936th5h1wr5
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 21:55:35 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: QityeSR92A0zxGAD6HzWS0l8NZauE8FK1yox1IMlCkjktcn3X4S52GscfSTE7
        QJSA/HNF39vcc9ks3/y3dhyDCS/xakVh4CU6NoZ1fY1f6jU0Ome4otAAk+TcGioFaejfbLa
        BSKG8YpLvLQaUrm7uCGojHKM5N4GugdKJY7itR+e7O/J7vXo7SjPgllweeoO2a2eef0RIW9
        Af7PQp9vaO7OfIw0Yhm/WiHxnj+d00rI7oWASXrluZaEEqTts5OQ+NJ0oel1KalR5T/vixV
        0bfsfvHu8bWl07JD5U3g4b6MibbBeOlMUf+SbQAJmMIZZW42SOcSlZiU0JUhYfyttPRLOw/
        TCWcT51kg9MKDahCugTMpJL/HbPYDAyirMoIEh3R9sO/93KtBndyuY+sSlBPA==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     gcherian@marvell.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] cavium/cpt: fix repeated words in comments
Date:   Tue, 23 Aug 2022 21:55:28 +0800
Message-Id: <20220823135528.64693-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/crypto/cavium/cpt/cpt_hw_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/cpt/cpt_hw_types.h b/drivers/crypto/cavium/cpt/cpt_hw_types.h
index 96bc963bb804..64c3dfd214bf 100644
--- a/drivers/crypto/cavium/cpt/cpt_hw_types.h
+++ b/drivers/crypto/cavium/cpt/cpt_hw_types.h
@@ -396,7 +396,7 @@ union cptx_vqx_misc_ena_w1s {
  * Word0
  *  reserved_20_63:44 [63:20] Reserved.
  *  dbell_cnt:20 [19:0](R/W/H) Number of instruction queue 64-bit words to add
- *	to the CPT instruction doorbell count. Readback value is the the
+ *	to the CPT instruction doorbell count. Readback value is the
  *	current number of pending doorbell requests. If counter overflows
  *	CPT()_VQ()_MISC_INT[DBELL_DOVF] is set. To reset the count back to
  *	zero, write one to clear CPT()_VQ()_MISC_INT_ENA_W1C[DBELL_DOVF],
-- 
2.36.1

