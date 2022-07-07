Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99D56AC32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbiGGTta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiGGTt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:49:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD88113D2C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:49:25 -0700 (PDT)
Received: from dslb-188-097-214-244.188.097.pools.vodafone-ip.de ([188.97.214.244] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o9XV3-0008AP-Ke; Thu, 07 Jul 2022 21:49:21 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] staging: r8188eu: remove sta2sta_data_frame prototype
Date:   Thu,  7 Jul 2022 21:49:13 +0200
Message-Id: <20220707194914.63794-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707194914.63794-1-martin@kaiser.cx>
References: <20220707194914.63794-1-martin@kaiser.cx>
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

Remove the prototype for sta2sta_data_frame. Make the function static, it
is used only inside rtw_recv.c.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 32cd452d1f3d..6a2a1b1664ac 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -556,13 +556,8 @@ static void count_rx_stats(struct adapter *padapter, struct recv_frame *prframe,
 	}
 }
 
-int sta2sta_data_frame(
-	struct adapter *adapter,
-	struct recv_frame *precv_frame,
-	struct sta_info **psta
-);
-
-int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame, struct sta_info **psta)
+static int sta2sta_data_frame(struct adapter *adapter,
+			      struct recv_frame *precv_frame, struct sta_info **psta)
 {
 	u8 *ptr = precv_frame->rx_data;
 	int ret = _SUCCESS;
-- 
2.30.2

