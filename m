Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E8557407
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiFWHeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiFWHek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:34:40 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0B6846662
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:34:38 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 39BD21E80C85;
        Thu, 23 Jun 2022 15:34:20 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QmuzbNwUwYMz; Thu, 23 Jun 2022 15:34:17 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.33])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C35141E80C7D;
        Thu, 23 Jun 2022 15:34:16 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] mfd: Fix spelling mistake
Date:   Thu, 23 Jun 2022 15:33:33 +0800
Message-Id: <20220623073333.5675-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'receieved' to 'received'.
Change 'recieve' to 'receive'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 include/linux/mfd/ipaq-micro.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/ipaq-micro.h b/include/linux/mfd/ipaq-micro.h
index ee48a4321c57..d5caa4c86ecc 100644
--- a/include/linux/mfd/ipaq-micro.h
+++ b/include/linux/mfd/ipaq-micro.h
@@ -75,8 +75,8 @@ struct ipaq_micro_rxdev {
  * @id: 4-bit ID of the message
  * @tx_len: length of TX data
  * @tx_data: TX data to send
- * @rx_len: length of receieved RX data
- * @rx_data: RX data to recieve
+ * @rx_len: length of received RX data
+ * @rx_data: RX data to receive
  * @ack: a completion that will be completed when RX is complete
  * @node: list node if message gets queued
  */
-- 
2.25.1

