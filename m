Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE854C5680
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 15:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiBZOtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 09:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiBZOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 09:49:37 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F04A186225
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 06:49:03 -0800 (PST)
Received: from ipservice-092-217-092-093.092.217.pools.vodafone-ip.de ([92.217.92.93] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nNyNY-0007Wh-2Y; Sat, 26 Feb 2022 15:49:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/6] staging: r8188eu: remove unused define
Date:   Sat, 26 Feb 2022 15:48:43 +0100
Message-Id: <20220226144843.1118951-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220226144843.1118951-1-martin@kaiser.cx>
References: <20220226144843.1118951-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the rtw_dequeue_recvframe define, which is not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_recv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index d2c1efbe62f0..6a6f6373467b 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -264,7 +264,6 @@ struct recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
 struct recv_frame *rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
 int  rtw_free_recvframe(struct recv_frame *precvframe,
 			struct __queue *pfree_recv_queue);
-#define rtw_dequeue_recvframe(queue) rtw_alloc_recvframe(queue)
 int _rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue);
 int rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue);
 void rtw_free_recvframe_queue(struct __queue *pframequeue,
-- 
2.30.2

