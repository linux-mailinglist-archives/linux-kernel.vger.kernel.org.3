Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D744CE673
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 19:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiCESy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 13:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiCESyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 13:54:55 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EF81D451C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 10:54:05 -0800 (PST)
Received: from dslb-084-059-247-134.084.059.pools.vodafone-ip.de ([84.59.247.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nQZXV-00016k-Ir; Sat, 05 Mar 2022 19:54:01 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/6] staging: r8188eu: remove three unused receive defines
Date:   Sat,  5 Mar 2022 19:53:47 +0100
Message-Id: <20220305185351.1409232-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220305185351.1409232-1-martin@kaiser.cx>
References: <20220305185351.1409232-1-martin@kaiser.cx>
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

Remove three unused defines from rtl8188e_recv.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtl8188e_recv.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
index a2320af11216..09adffd756de 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -6,10 +6,6 @@
 
 #define TX_RPT1_PKT_LEN 8
 
-#define RECV_BLK_SZ 512
-#define RECV_BLK_CNT 16
-#define RECV_BLK_TH RECV_BLK_CNT
-
 #define NR_PREALLOC_RECV_SKB (8)
 
 #define NR_RECVBUFF (4)
-- 
2.30.2

