Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E285167C0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 22:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354425AbiEAU3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiEAU3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 16:29:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FCB3A728
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 13:25:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n10so7111135ejk.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=otSZ1vNlbZZnefxXua2kl3gSYjKRO6kJyYuaC3ipspw=;
        b=JTO0wQlOqJpwRmwKi3r4/4pBPbTm0NQUtwE52bMaok+qwz6S+6KLrWp7lxu5BwzWid
         CUr6Vc24Lt0lypOrlaI1OsAENaJR9XLUXfi5M1bnuXAziTaLAM/I7bkdlvk2QBiroUlM
         JpMp4dok4VettjoBOsNIZKXFdw4+XLNvcOby38VO9atZ+lFSfO1kHCwjLHTBZBUK/Y6U
         k+vw1YBI3rsCP8ViybvKVskU2FB5K8CX92UNKn/3fwa4hfaSL1tqYUBrQe/XGDXNE+Iz
         zvA9TOBpeNDWaWPD+3kyOJVmsTdkahtFJhZdLNH1bsAaHrqHeVIlhHDui+J+K4aL6Rt6
         +XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=otSZ1vNlbZZnefxXua2kl3gSYjKRO6kJyYuaC3ipspw=;
        b=ODNXayI4zUSX1peFrgEdsj4p6d47DFK3bxliS6ErurnT9dsg04i+Q5YfpzdLQrUJ95
         GtCn3znpGSRPxN7Ll00eYYt6BrVAsOUgFMDvg4SvHvWfCisY7r5ZTDvqOewX+saFUiFx
         gwGAKVBunMhSs8Ll0F/rPT1fDuqBp1bxjepZxFqrq/OVSTj9xpNxWr4LnlL3kG2asHZ3
         s/I+SLhafAbjheWJoCIckRSZ0NrXDjU1qIsIaEjXCX+ygXLHDHskPackJwJXPnIGgl4/
         XDZvhMZptTwA+7lgJt6QQvLD8pL0xwbat+2sa6UChs14L/1nfu1E80pnNz5TYEaBpkp7
         NrZw==
X-Gm-Message-State: AOAM532KCNKZANkt6Jw/bbtjG2YNhWqz1yXokI/UAmQ29vLKexh1hT6y
        AhiOyKg00Eg8ASylK1aAtRw=
X-Google-Smtp-Source: ABdhPJyGIwncKgiS8FLl6mJ6K3tCH+7dtaGJ9w1yvlBORuHE3OQTwl4Zt62pJpGCol2+7Pu3e1DADg==
X-Received: by 2002:a17:907:968f:b0:6db:a3c5:ae3e with SMTP id hd15-20020a170907968f00b006dba3c5ae3emr8898304ejc.770.1651436738031;
        Sun, 01 May 2022 13:25:38 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id gz25-20020a170907a05900b006f3ef214e63sm2896059ejc.201.2022.05.01.13.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 13:25:37 -0700 (PDT)
Date:   Sun, 1 May 2022 22:25:35 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: vt6655: Rename function CARDbGetCurrentTSF
Message-ID: <2b92db8d67e8dd1fc85b45efe3b32d2199371190.1651435890.git.philipp.g.hortmann@gmail.com>
References: <cover.1651435890.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651435890.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the function uses CamelCase which
is not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> v2: Changed function name to include driver name
---
 drivers/staging/vt6655/card.c        | 10 +++++-----
 drivers/staging/vt6655/card.h        |  2 +-
 drivers/staging/vt6655/device_main.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 431890e6b8d2..c8372701bf43 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -11,7 +11,7 @@
  *      CARDbAddBasicRate - Add to BasicRateSet
  *      CARDbIsOFDMinBasicRate - Check if any OFDM rate is in BasicRateSet
  *      CARDqGetTSFOffset - Calculate TSFOffset
- *      CARDbGetCurrentTSF - Read Current NIC TSF counter
+ *      vt6655_get_current_tsf - Read Current NIC TSF counter
  *      CARDqGetNextTBTT - Calculate Next Beacon TSF counter
  *      CARDvSetFirstNextTBTT - Set NIC Beacon time
  *      CARDvUpdateNextTBTT - Sync. NIC Beacon time
@@ -288,7 +288,7 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 	u64 local_tsf;
 	u64 qwTSFOffset = 0;
 
-	CARDbGetCurrentTSF(priv, &local_tsf);
+	vt6655_get_current_tsf(priv, &local_tsf);
 
 	if (qwBSSTimestamp != local_tsf) {
 		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
@@ -322,7 +322,7 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 {
 	u64 qwNextTBTT = 0;
 
-	CARDbGetCurrentTSF(priv, &qwNextTBTT); /* Get Local TSF counter */
+	vt6655_get_current_tsf(priv, &qwNextTBTT); /* Get Local TSF counter */
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 
@@ -739,7 +739,7 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2)
  *
  * Return Value: true if success; otherwise false
  */
-bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
+bool vt6655_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF)
 {
 	void __iomem *iobase = priv->port_offset;
 	unsigned short ww;
@@ -807,7 +807,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 	void __iomem *iobase = priv->port_offset;
 	u64 qwNextTBTT = 0;
 
-	CARDbGetCurrentTSF(priv, &qwNextTBTT); /* Get Local TSF counter */
+	vt6655_get_current_tsf(priv, &qwNextTBTT); /* Get Local TSF counter */
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 	/* Set NextTBTT */
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 09e7f3f1cbed..340516b329e3 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -46,7 +46,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 			   unsigned short wBeaconInterval);
 void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short wBeaconInterval);
-bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF);
+bool vt6655_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF);
 u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval);
 u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2);
 unsigned char CARDbyGetPktType(struct vnt_private *priv);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 12fd825c23fe..bb8a30eefc74 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1603,7 +1603,7 @@ static u64 vnt_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct vnt_private *priv = hw->priv;
 	u64 tsf;
 
-	CARDbGetCurrentTSF(priv, &tsf);
+	vt6655_get_current_tsf(priv, &tsf);
 
 	return tsf;
 }
-- 
2.25.1

