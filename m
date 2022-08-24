Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71D65A0290
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiHXUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbiHXUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:14:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA07C526
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w20so7732138edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=O2auyW/wyuCTRZgooWa2O9OlE4D4l/s1oCdHs9nl/AM=;
        b=RkCHIIr13O8y6XDImqeVhXCvTCViIgq/I2Q9U83Sp0NchD+XeBv2fybJXTkGfGkJlf
         LxlTt3dqw8JKKkNTzmyAjX4aWDkQFDQNDc4E/2Wkwr4HL3bk6RV1NhrbHCvPcRZZ0t0m
         yFdBK75Yo2yHfwHs1aB0+DYF20JLsbIkbR6b1K2BddFl4jXyJN4P0jIEKKZDQ7Yn1iL5
         pSOyD0v+rao59R7MStWhXYQRT9fryjqbn62BaF1dZ9PCaau2iTgAlOwBlfDG6UMkVHl9
         X6J0Sxag1N3Ci8eeyKEZwT7taN5pyzBGCf7kXURgHZH485MibCy8FSorTkaRik0PuAQ0
         jBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=O2auyW/wyuCTRZgooWa2O9OlE4D4l/s1oCdHs9nl/AM=;
        b=NVGYhDs9CUm0z4CZ/PCd9vKAyTGA8K3e3JwgGezP9yl+cV5vCprwd5ZpImpMqT2lL7
         2ULzLgEFrpI4O1JHwz7VZeZwYC4Ppx0gr2oL2HLRTP6xwIN8dtFPM53Yzli2qRcTIH7+
         g7SzqlZxw0eUD4OG8ikTky0LwqxB0p/Y6eCOQdAALIpcrBk/WVrOLikJAGq8jmVXJ4SI
         G8NdJhKtl0EpaFM84cKcqceOnUPjxPXNhH1kPkF6rgAVCwTCOI6oWNXk6WgXqEJM+96F
         u/aMEhnx3zBJK0My9Chme7ZO36XciUedV6uGH0nBU0V9cbU/4h3986WN8A/jzZNQRle8
         3FMg==
X-Gm-Message-State: ACgBeo3Ik6cAuESWrlzZNAuFcLox0tmot1EEBGpFUtDbDDGJrbvYqFQ0
        7SSUhSgDP/gkmAqcbmdgMVF5I9R4DG4=
X-Google-Smtp-Source: AA6agR4yvrNf2nypLiV3+GroLzz/CEDa+5vK7a01KJMJogU8vyj0ZhI/1cLv6KwFgeFEqkd9NAWPXg==
X-Received: by 2002:a05:6402:328c:b0:446:bcc8:bf49 with SMTP id f12-20020a056402328c00b00446bcc8bf49mr522360eda.309.1661372081382;
        Wed, 24 Aug 2022 13:14:41 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id d26-20020a50cd5a000000b0044758c9b951sm2220907edj.79.2022.08.24.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:14:41 -0700 (PDT)
Date:   Wed, 24 Aug 2022 22:14:39 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8192e: Rename Tx... and RxCheckStuckHandler
Message-ID: <3041cec77df10cdff18d5466beb3b0616370b112.1661370978.git.philipp.g.hortmann@gmail.com>
References: <cover.1661370978.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661370978.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable name TxCheckStuckHandler and RxCheckStuckHandler is changed to
avoid CamelCase which is not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 5b3b215448bc..ff73b8cff5e8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -43,8 +43,8 @@ static const struct rtl819x_ops rtl819xp_ops = {
 	.rx_enable			= rtl92e_enable_rx,
 	.tx_enable			= rtl92e_enable_tx,
 	.interrupt_recognized		= rtl92e_ack_irq,
-	.TxCheckStuckHandler		= rtl92e_is_tx_stuck,
-	.RxCheckStuckHandler		= rtl92e_is_rx_stuck,
+	.tx_check_stuck_handler	= rtl92e_is_tx_stuck,
+	.rx_check_stuck_handler	= rtl92e_is_rx_stuck,
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
@@ -1143,7 +1143,7 @@ static enum reset_type _rtl92e_tx_check_stuck(struct net_device *dev)
 	spin_unlock_irqrestore(&priv->irq_th_lock, flags);
 
 	if (bCheckFwTxCnt) {
-		if (priv->ops->TxCheckStuckHandler(dev)) {
+		if (priv->ops->tx_check_stuck_handler(dev)) {
 			RT_TRACE(COMP_RESET,
 				 "TxCheckStuck(): Fw indicates no Tx condition!\n");
 			return RESET_TYPE_SILENT;
@@ -1157,7 +1157,7 @@ static enum reset_type _rtl92e_rx_check_stuck(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->ops->RxCheckStuckHandler(dev)) {
+	if (priv->ops->rx_check_stuck_handler(dev)) {
 		RT_TRACE(COMP_RESET, "RxStuck Condition\n");
 		return RESET_TYPE_SILENT;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 698552a92100..8f254c34d5d3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -299,8 +299,8 @@ struct rtl819x_ops {
 	void (*tx_enable)(struct net_device *dev);
 	void (*interrupt_recognized)(struct net_device *dev,
 				     u32 *p_inta, u32 *p_intb);
-	bool (*TxCheckStuckHandler)(struct net_device *dev);
-	bool (*RxCheckStuckHandler)(struct net_device *dev);
+	bool (*tx_check_stuck_handler)(struct net_device *dev);
+	bool (*rx_check_stuck_handler)(struct net_device *dev);
 };
 
 struct r8192_priv {
-- 
2.37.2

