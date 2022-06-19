Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB7550CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiFSTnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbiFSTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:43:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686076350
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:43:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s185so2738733pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QG1QV5jcE/qCLfJfakMMrZfmCDBIgHiC1TqIeZ6eiw=;
        b=Bg5wNP2vtH4T5PvHSN81HgF4Uq+0i1xgkp7/rVE1jy1X7tSe1mgVoMRU34u5KY6iMP
         XMYUI5pRSUiHRzHyYcXZyP+5PmaKwWlA/owFceB9cXDNkWntzekvzSDCpbvFqaJcNyhp
         zzvYj/jDCf9PbS7McbEgvyEgSf7afOhu+tZXwFWQIPocHx720KDHhGMpDvcwRvfosY7s
         uWNdPZtMOGsKtT1bqJZdSqwBaPi5IMvm/6flXaE8T7hPaSRf5hHMVZg570GWmcXmWQD7
         H1yLXbefH6NIGPYxYyr959h/+CJjY8H0EfikLjQLkCqUd2VCgm15pCkrLSglyi0Y38vg
         Qs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QG1QV5jcE/qCLfJfakMMrZfmCDBIgHiC1TqIeZ6eiw=;
        b=InLt9nsLbGKyPPBeJAb0T+PsPNTeXqvSOeHsCVUz1vdgUo3QzCK+/A36DXyQNBspNg
         IP0IjzsyJSb1/UVLntNOzC86AkEt5g04Di5qFCkhLTd5MCFNpjsFtCLjMvtaXVZiJVkC
         1wQSHNiTyIbr5GoqSc006AP5hNgIEvmTT4M3GV2KsvI3/DA4uw/CVvLFlyNeiM09GUPK
         vmQzsBRZFIpbQs5fN60LrksvctqqepLl+4Pr4objtZdR7SwmBlYjqBVnY+nOayOkD5LN
         UI0fk9VBEmTC1qCQcQaj4K8+qPCfG6gV3Sli2P7fggQxVzdmGbQUZMdnBhMCk4017ZgJ
         V7qg==
X-Gm-Message-State: AJIora+fyGWyUyTOzJOHD+3d8PqdWz2ZBRfK29dzkC7fkL+g5tGs53ZZ
        //r7Dqq+sCrGSeDAPEnBKeE=
X-Google-Smtp-Source: AGRyM1vZOBA2oL/DgQZnkKqx/28nVDqd8GC8NhYH4bNg9UxNtjFJlAKA+akFEVtuVNGCjb7xRWETHw==
X-Received: by 2002:a63:7d44:0:b0:40c:8cb1:eeaa with SMTP id m4-20020a637d44000000b0040c8cb1eeaamr6450551pgn.597.1655667779852;
        Sun, 19 Jun 2022 12:42:59 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id i185-20020a626dc2000000b0051bf9159d2dsm7406414pfc.208.2022.06.19.12.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 12:42:59 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v2 5/5] Staging: r8188eu: core: rtw_xmit: Fixed a coding style issue
Date:   Sun, 19 Jun 2022 12:42:31 -0700
Message-Id: <e938a8ac0ff3a9d777754a081c7a08026aaae253.1655666628.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655666628.git.marcus.yu.56@gmail.com>
References: <cover.1655666628.git.marcus.yu.56@gmail.com>
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

Moved the constant ETH_P_IP to the right hand side of the comparison as
per checkpatch.pl

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 6797335f7855..943422141c8b 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -443,7 +443,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	pattrib->pktlen = pktfile.pkt_len;
 
-	if (ETH_P_IP == pattrib->ether_type) {
+	if (pattrib->ether_type == ETH_P_IP) {
 		/*  The following is for DHCP and ARP packet, we use cck1M to tx these packets and let LPS awake some time */
 		/*  to prevent DHCP protocol fail */
 		u8 tmp[24];
-- 
2.36.1

