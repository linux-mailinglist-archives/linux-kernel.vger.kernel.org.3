Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B785A105C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiHYMYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiHYMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:24:51 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF1C13F09
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:24:48 -0700 (PDT)
X-QQ-mid: bizesmtp67t1661430267tcyqppkd
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 20:24:26 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: iBxuBmNAXy06zdryGGJHuEeVxHvs3CqEDaPaA1fC8U8EcVcJHjOs0ualjkxAB
        8xVtmhWiI2fDfJSBHwyHWgsKqNdKjG4Nu0IYM9Id22RMylifHMgfLY41mOPMMzN2xUqoFNV
        y2PF4wFF1I4sX1tY0l2OJ0MirpFyNlivftj7q5B7pWQs+mulLnWfRCdbzgTwJWsauA8VKt+
        /4yA7YjtbqbntDq3J/RqUze7iZuqGRbMMF365fiJovBYVzTXRbyxLCq9VD7E5ozr8p9hn7A
        ref76jtkLP0RshPum5N0KaJZpCKdsuUbBfQgtjAq8KSGimW93oenf3hLnaVeN5sRlL+PfVj
        VA6mZGpu/uTXKhIJz46EWwJKW6cNNfBViIyECGm6Ej1UwFgxpoU4B8nLjcCOQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     Roy.Pledge@nxp.com, leoyang.li@nxp.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] fsl/dpio: fix repeated words in comments
Date:   Thu, 25 Aug 2022 20:24:18 +0800
Message-Id: <20220825122418.24508-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 1d2b27e3ea63..5315e01624c7 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -331,7 +331,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_register);
  * @dev: the device that requests to be deregistered
  *
  * This function should be called only after sending the MC command to
- * to detach the notification-producing device from the DPIO.
+ * detach the notification-producing device from the DPIO.
  */
 void dpaa2_io_service_deregister(struct dpaa2_io *service,
 				 struct dpaa2_io_notification_ctx *ctx,
-- 
2.36.1

