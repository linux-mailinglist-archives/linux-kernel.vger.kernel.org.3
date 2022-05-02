Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B35177B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387192AbiEBUK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355431AbiEBUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:10:46 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14DB63E6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:07:16 -0700 (PDT)
Received: from ipservice-092-217-077-109.092.217.pools.vodafone-ip.de ([92.217.77.109] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nlcK8-0007ch-T6; Mon, 02 May 2022 22:07:12 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/9] staging: r8188eu: remove unused action handler prototypes
Date:   Mon,  2 May 2022 22:06:46 +0200
Message-Id: <20220502200652.143665-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502200652.143665-1-martin@kaiser.cx>
References: <20220502200652.143665-1-martin@kaiser.cx>
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

For some action categories, we removed the handler function, but we forgot
the prototypes. Remove them as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index c68b3c77c378..136879a0a0f9 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -567,12 +567,6 @@ unsigned int OnDeAuth(struct adapter *padapter,
 unsigned int OnAction(struct adapter *padapter,
 		      struct recv_frame *precv_frame);
 
-unsigned int on_action_spct(struct adapter *padapter,
-			    struct recv_frame *precv_frame);
-unsigned int OnAction_qos(struct adapter *padapter,
-			  struct recv_frame *precv_frame);
-unsigned int OnAction_dls(struct adapter *padapter,
-			  struct recv_frame *precv_frame);
 unsigned int OnAction_back(struct adapter *padapter,
 			   struct recv_frame *precv_frame);
 unsigned int on_action_public(struct adapter *padapter,
-- 
2.30.2

