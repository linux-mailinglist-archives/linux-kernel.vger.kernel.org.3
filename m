Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0595A0291
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbiHXUOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbiHXUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:14:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C3F7C53E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u9so6663945ejy.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=2cyaS4gO5h/F5vHUL0nItZes1zeuwWKpTfH3a+yaz5w=;
        b=iEsi0k5fwHIYGRSUKl4X3Zk1ANLBJHZVjPKOnl+IkpmbLv+LgJB1Ym2vjjT9R8vLtE
         KfC9XMQVKntWiOpDhMgGlZIBKgER4E2Qpu38n5p6y5Y72iFyZf3w8qFGcHeobIQTInUd
         8OIsOSVFasfIeeuoEvY2gCeIXODTpSxaDmfVk9vpUytUKDuU7kALfD7HKXw06q6XrBMK
         rQmFWNo+Z/iOnrH91VOVrEJmgjRwMqGGh/BIew4IUJMGOQzQIzoHF+McCeBoLyIgnLLP
         PCbJzZFNUv/Ipzjhf6CHphLtBZ65RUZXrM2/RBF3dtONmfJeeOaa5vTtt1YI1bAxXGpi
         AmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=2cyaS4gO5h/F5vHUL0nItZes1zeuwWKpTfH3a+yaz5w=;
        b=2mqMMr1zbCSvKDTuIZqZYY99qZWF/LOHEQsuDYrq38POwFrlbsl7081Nghn6RZKlra
         UXUHnT8UWqtDQ2fJqcaplUNIuouX9zZmePL55KXII1E0wNgY25+oL6Vyup+s0lH8wvyR
         4E9B/GJbfGDlxr7xmkD6onpYH+6HJbMeEVKATNnPZgD4QulFeOl4Bg9y+qNpCG+AZUmn
         RO12AfliC4EERPB241hHc4y3O1Q5D8tBi6eLWqHf69w6J25zICxZpVWP8nRauR/qnEXx
         l43gsG/y36gCGz1/R0hsxtbK+ApP6OWezY2R/xw+F+f8q4WJWLDyJszWr80TVBjZNNEU
         1nQg==
X-Gm-Message-State: ACgBeo3dbN8gth+/DFlazSdIejCWJg6i167IJ+7kvKvEYfsEDndMl0Jm
        CJQzdM/8HyWLDQ786GGZhI8=
X-Google-Smtp-Source: AA6agR67xjcbz9YssVZFaI8NDUZdIsFHzxvsfzy5U3bGg476A1aMTgqPfJIx9JS4SnwCJtxOJvAxRw==
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id nb10-20020a1709071c8a00b006e92a0dd7b7mr349449ejc.572.1661372076524;
        Wed, 24 Aug 2022 13:14:36 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id k23-20020a17090632d700b00722e50dab2csm1559660ejk.109.2022.08.24.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:14:36 -0700 (PDT)
Date:   Wed, 24 Aug 2022 22:14:34 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: rtl8192e: Remove blank lines in rtl_core.c
Message-ID: <32e831619a91f00cc37e04a2da1a9aeda2ad90a0.1661370978.git.philipp.g.hortmann@gmail.com>
References: <cover.1661370978.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661370978.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove blank lines as requested by checkpatch. Reasons are "multiple
blank lines", "Blank lines aren't necessary after an open brace" and
"Blank lines aren't necessary before a close brace".

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 24 --------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index b9ce71848023..5b3b215448bc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -25,7 +25,6 @@
 int hwwep = 1;
 static char *ifname = "wlan%d";
 
-
 static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
 	.get_eeprom_size		= rtl92e_get_eeprom_size,
@@ -189,7 +188,6 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 			priv->rtllib->RfOffReason = 0;
 			bActionAllowed = true;
 
-
 			if (rtState == eRfOff &&
 			    ChangeSource >= RF_CHANGE_BY_HW)
 				bConnectBySSID = true;
@@ -236,7 +234,6 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 			 __func__, StateToSet, priv->rtllib->RfOffReason);
 		PHY_SetRFPowerState(dev, StateToSet);
 		if (StateToSet == eRfOn) {
-
 			if (bConnectBySSID && priv->blinked_ingpio) {
 				schedule_delayed_work(
 					 &ieee->associate_procedure_wq, 0);
@@ -395,7 +392,6 @@ static void _rtl92e_qos_activate(void *data)
 	for (i = 0; i <  QOS_QUEUE_NUM; i++)
 		priv->rtllib->SetHwRegHandler(dev, HW_VAR_AC_PARAM, (u8 *)(&i));
 
-
 success:
 	mutex_unlock(&priv->mutex);
 }
@@ -455,7 +451,6 @@ static int _rtl92e_handle_beacon(struct net_device *dev,
 
 	schedule_delayed_work(&priv->update_beacon_wq, 0);
 	return 0;
-
 }
 
 static int _rtl92e_qos_assoc_resp(struct r8192_priv *priv,
@@ -883,7 +878,6 @@ static void _rtl92e_init_priv_constant(struct net_device *dev)
 	pPSC->RegMaxLPSAwakeIntvl = 5;
 }
 
-
 static void _rtl92e_init_priv_variable(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -1201,7 +1195,6 @@ static enum reset_type _rtl92e_if_check_reset(struct net_device *dev)
 	} else {
 		return RESET_TYPE_NORESET;
 	}
-
 }
 
 static void _rtl92e_if_silent_reset(struct net_device *dev)
@@ -1407,7 +1400,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		ieee->LinkDetectInfo.NumTxOkInPeriod > 100)
 			bBusyTraffic = true;
 
-
 		if (ieee->LinkDetectInfo.NumRxOkInPeriod > 4000 ||
 		    ieee->LinkDetectInfo.NumTxOkInPeriod > 4000) {
 			bHigherBusyTraffic = true;
@@ -1456,7 +1448,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		else
 			priv->check_roaming_cnt = 0;
 
-
 		if (priv->check_roaming_cnt > 0) {
 			if (ieee->eRFPowerState == eRfOff)
 				netdev_info(dev, "%s(): RF is off\n", __func__);
@@ -1487,7 +1478,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		}
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 0;
 		ieee->LinkDetectInfo.NumRecvDataInPeriod = 0;
-
 	}
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
@@ -1541,7 +1531,6 @@ void rtl92e_tx_enable(struct net_device *dev)
 	rtllib_reset_queue(priv->rtllib);
 }
 
-
 static void _rtl92e_free_rx_ring(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -1936,13 +1925,11 @@ long rtl92e_translate_to_dbm(struct r8192_priv *priv, u8 signal_strength_index)
 	return signal_power;
 }
 
-
 void rtl92e_update_rx_statistics(struct r8192_priv *priv,
 				 struct rtllib_rx_stats *pprevious_stats)
 {
 	int weighting = 0;
 
-
 	if (priv->stats.recv_signal_power == 0)
 		priv->stats.recv_signal_power =
 					 pprevious_stats->RecvSignalPower;
@@ -1985,8 +1972,6 @@ void rtl92e_copy_mpdu_stats(struct rtllib_rx_stats *psrc_stats,
 	ptarget_stats->bFirstMPDU = psrc_stats->bFirstMPDU;
 }
 
-
-
 static void _rtl92e_rx_normal(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -2086,7 +2071,6 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		priv->rx_idx[rx_queue_idx] = (priv->rx_idx[rx_queue_idx] + 1) %
 					      priv->rxringcount;
 	}
-
 }
 
 static void _rtl92e_tx_resume(struct net_device *dev)
@@ -2151,7 +2135,6 @@ static int _rtl92e_open(struct net_device *dev)
 	ret = _rtl92e_try_up(dev);
 	mutex_unlock(&priv->wx_mutex);
 	return ret;
-
 }
 
 static int _rtl92e_try_up(struct net_device *dev)
@@ -2163,7 +2146,6 @@ static int _rtl92e_try_up(struct net_device *dev)
 	return _rtl92e_up(dev, false);
 }
 
-
 static int _rtl92e_close(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -2181,7 +2163,6 @@ static int _rtl92e_close(struct net_device *dev)
 	mutex_unlock(&priv->wx_mutex);
 
 	return ret;
-
 }
 
 static int _rtl92e_down(struct net_device *dev, bool shutdownrf)
@@ -2224,10 +2205,8 @@ static void _rtl92e_set_multicast(struct net_device *dev)
 
 	promisc = (dev->flags & IFF_PROMISC) ? 1 : 0;
 	priv->promisc = promisc;
-
 }
 
-
 static int _rtl92e_set_mac_adr(struct net_device *dev, void *mac)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -2376,8 +2355,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 	return IRQ_HANDLED;
 }
 
-
-
 /****************************************************************************
  * ---------------------------- PCI_STUFF---------------------------
  ****************************************************************************/
@@ -2452,7 +2429,6 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 		goto err_rel_rtllib;
 	}
 
-
 	ioaddr = (unsigned long)ioremap(pmem_start, pmem_len);
 	if (ioaddr == (unsigned long)NULL) {
 		netdev_err(dev, "ioremap failed!");
-- 
2.37.2

