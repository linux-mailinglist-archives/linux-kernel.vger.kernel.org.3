Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE555541E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356632AbiFVExh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356985AbiFVExQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:53:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A95C62C8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso15649264pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oisc3ypggyVnyacN2ACuhTwt037Hx2/ibOP/qwTmzmU=;
        b=PVrUG220AsrmlyFyxNgPrSWgswrgOZf8ZNb+VHT7wS+RW3rSrqHyF+DlzZyDveDd4Q
         SSI23m2ke1gsb3DASZa1iSCbcnJ9GFgDgX98JSmWHsEJ4ePFxVLHljwGvchcvH8zQ3it
         /R7kWJ4qmFb1QV7ceejbyMy3OuPXpQA7pZeu7zc2sGkLBVZY3kyQga2RLvGhG4G4spih
         tiuwlezt2jbeffgfiMtQ2TMvOFIm8RGZ5QD4q7SvAddNrdFj8xigbauGk7WaroEqyLNf
         w5NFce1bAzLgjtUrHqP0SwnsvEC8dt16DPPIHqwjRF4fDaS0bEGPKF0igtW6PFLKFzLk
         xGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oisc3ypggyVnyacN2ACuhTwt037Hx2/ibOP/qwTmzmU=;
        b=gBWq2yNJuTw6S9nHvOItI47ZbgEA5zA+wPkxsENAjp2xAH+Q88M9MqrAj1Ji7g8vxD
         tWIMOfLmNIhkdT3iw1w4yxxzieqi7agutPGlBVE23XKktj0PKC+at7mThuo3jNCQJZyg
         BaIlwACy+DZPKJmdMId4jCFFxZu33h/G9K9lXdbjDn9jXzOPp2qQhH/t3NkstM7YDh/Z
         6cmsyxYYVEB42NtFVtnGPhem9yTjuzJnQVbGSD/cpQtOsb1VBPqhSq/rrViyZJyhcWLQ
         bHUpodBnmOPqsALxJ8K69xbe7n7I9eCIcTDSDX9gjlvQGLy8wVaHb5S/89P7O8odXgeO
         uBWA==
X-Gm-Message-State: AJIora8Y6+F17x7xg89VBZDQ5Z7smhEIbA+zXOvsnXlrQLWYPr7Gelwp
        IWEKBOH3T4vf3UnRAH6Bo5XCX76suO4gDQ==
X-Google-Smtp-Source: AGRyM1tT/GLbMa+q3rLUJIL3USM5y4dOGHfH6GxOWQWV4OcuSThJ7MBwIuWxdOMNMuE693UmFNU6iQ==
X-Received: by 2002:a17:902:d504:b0:16a:4846:3f46 with SMTP id b4-20020a170902d50400b0016a48463f46mr1596164plg.159.1655873595633;
        Tue, 21 Jun 2022 21:53:15 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b0015e8d4eb24fsm11542908plr.153.2022.06.21.21.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:53:15 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: Fixed some blank line coding style issues
Date:   Tue, 21 Jun 2022 21:52:34 -0700
Message-Id: <cf4d4f7a58c9ba4510bed6748f78491c91e3e6f3.1655872968.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655872968.git.marcus.yu.56@gmail.com>
References: <cover.1655872968.git.marcus.yu.56@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added blank lines after variable declarations as per checkpatch.pl

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 14dd2344fa4b..cc91638a085d 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -237,6 +237,7 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 {
 	u32 cnt = 0;
 	struct recv_frame *pending_frame;
+
 	while ((pending_frame = rtw_alloc_recvframe(&adapter->recvpriv.uc_swdec_pending_queue))) {
 		rtw_free_recvframe(pending_frame, &adapter->recvpriv.free_recv_queue);
 		cnt++;
@@ -327,6 +328,7 @@ static struct recv_frame *decryptor(struct adapter *padapter, struct recv_frame
 
 	if (prxattrib->encrypt > 0) {
 		u8 *iv = precv_frame->rx_data + prxattrib->hdrlen;
+
 		prxattrib->key_index = (((iv[3]) >> 6) & 0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
@@ -777,6 +779,7 @@ static int sta2ap_data_frame(struct adapter *adapter,
 		}
 	} else {
 		u8 *myhwaddr = myid(&adapter->eeprompriv);
+
 		if (memcmp(pattrib->ra, myhwaddr, ETH_ALEN)) {
 			ret = RTW_RX_HANDLED;
 			goto exit;
@@ -1022,6 +1025,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
 		int ch_set_idx = rtw_ch_set_search_ch(pmlmeext->channel_set, rtw_get_oper_ch(adapter));
+
 		if (ch_set_idx >= 0)
 			pmlmeext->channel_set[ch_set_idx].rx_count++;
 	}
@@ -1049,6 +1053,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 		retval = validate_recv_data_frame(adapter, precv_frame);
 		if (retval == _FAIL) {
 			struct recv_priv *precvpriv = &adapter->recvpriv;
+
 			precvpriv->rx_drop++;
 		}
 	}
@@ -1312,9 +1317,11 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 	struct rx_pkt_attrib *pattrib;
 	unsigned char *data_ptr;
 	struct sk_buff *sub_skb, *subframes[MAX_SUBFRAME_COUNT];
+
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
 	int	ret = _SUCCESS;
+
 	nr_subframes = 0;
 
 	pattrib = &prframe->attrib;
-- 
2.36.1

