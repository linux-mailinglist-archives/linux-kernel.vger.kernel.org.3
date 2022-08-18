Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED763598CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbiHRT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiHRT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:58:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557CCBA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:58:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b16so3201435edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sH1DLTYjPqa55tvbt9/5ExhNIHtaK9eIVrGOQmIu/y4=;
        b=FMyqH1uIzY6AduUNPs3llT8CkaKF/z6l4jLS9/liT6xX/F8dtpyRgdFXBN5km2LMb7
         UM7xiR4v4Ro7Q9G1UhTK6b6yz+igVUAncSELg3YunpJZyMERdRt1yQT76KJ/z8KaYWZ+
         odz7IWidVb0OcHiRLfp69QSe/Cax2at+a75TK4tm6jzsD3CMWh5eO8BSj0DNZF5iZzo0
         lOx41ZrjzbzMu5Kxmi7o6Yt3Ij3PNUZ3tAQ9gew4m5nE1s8ZSM6xgfTl5kd0RDD5SUAu
         Yc1azj7h8euct/HZiNPJO7i76L+JTSuJbIg3cUV/iIIEfPGzWgW0xjzZ/yGhzKfEaUzy
         z22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sH1DLTYjPqa55tvbt9/5ExhNIHtaK9eIVrGOQmIu/y4=;
        b=RXMLUNX76PIHaDkLmCANLsuM18hGqnrxowQnJJUnbzynppXMm+ytNBoG/5gEVEW1hp
         2awAQZkahnAyml3xcoYT4jJFRi2rix2aL9tnhdwSbpd8sKpTIWQQ6Ho0XxF0ajhKZjWO
         oqtremwhcVx/ePkgTjbRv8HQZ6aTnQJQcvGz0XrDXupEOvIOZlI+R0AhYiNZhmHAbfdq
         1rZTr9VRj6oPSjrmBHsUNtBvihJtYG5MN9ZG5IHe6MqKzqfFeCYZbRC1uZ6aINiCWCgJ
         26rm5gkNF5Gw006Fy+UPMQ65plPkXVjJ2R8sIXVOnIYSrZ5yl0qPEjMS7iFzM6Yq1gMQ
         cfvg==
X-Gm-Message-State: ACgBeo175CziJQ/vmPgKfcW0f80aGkHYfmga37Ff4Rh8pkFe9zLB65Mx
        FW/B40lT69/a94afVjZZD2g=
X-Google-Smtp-Source: AA6agR6YRC4tvN8SdZPSIRwMjLtRjuVD2uItxkihhYWVxlcXlFULUgcmB/LDFdeDiFjXirCWxvLDVA==
X-Received: by 2002:a05:6402:ea1:b0:443:d90a:5d31 with SMTP id h33-20020a0564020ea100b00443d90a5d31mr3426263eda.121.1660852688735;
        Thu, 18 Aug 2022 12:58:08 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.89.132])
        by smtp.gmail.com with ESMTPSA id kx26-20020a170907775a00b0073cb0801104sm248235ejc.147.2022.08.18.12.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 12:58:08 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, phil@philpotter.co.uk,
        Larry.Finger@lwfinger.net, paskripkin@gmail.com
Subject: [PATCH] staging: r8188eu: remove ioctl_cfg80211.h
Date:   Thu, 18 Aug 2022 21:54:55 +0200
Message-Id: <20220818195454.11822-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove header file ioctl_cfg80211.h because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 .../staging/r8188eu/include/ioctl_cfg80211.h  | 89 -------------------
 1 file changed, 89 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/ioctl_cfg80211.h

diff --git a/drivers/staging/r8188eu/include/ioctl_cfg80211.h b/drivers/staging/r8188eu/include/ioctl_cfg80211.h
deleted file mode 100644
index 738f645f9bbc..000000000000
--- a/drivers/staging/r8188eu/include/ioctl_cfg80211.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. i*/
-
-#ifndef __IOCTL_CFG80211_H__
-#define __IOCTL_CFG80211_H__
-
-struct rtw_wdev_invit_info {
-	u8 token;
-	u8 flags;
-	u8 status;
-	u8 req_op_ch;
-	u8 rsp_op_ch;
-};
-
-#define rtw_wdev_invit_info_init(invit_info) \
-	do { \
-		(invit_info)->token = 0; \
-		(invit_info)->flags = 0x00; \
-		(invit_info)->status = 0xff; \
-		(invit_info)->req_op_ch = 0; \
-		(invit_info)->rsp_op_ch = 0; \
-	} while (0)
-
-struct rtw_wdev_priv {
-	struct wireless_dev *rtw_wdev;
-
-	struct adapter *padapter;
-
-	struct cfg80211_scan_request *scan_request;
-	spinlock_t scan_req_lock;
-
-	struct net_device *pmon_ndev;/* for monitor interface */
-	char ifname_mon[IFNAMSIZ + 1]; /* name of monitor interface */
-
-	u8 p2p_enabled;
-
-	u8 provdisc_req_issued;
-
-	struct rtw_wdev_invit_info invit_info;
-
-	u8 bandroid_scan;
-	bool block;
-	bool power_mgmt;
-};
-
-#define wdev_to_priv(w) ((struct rtw_wdev_priv *)(wdev_priv(w)))
-
-#define wiphy_to_wdev(x)				\
-((struct wireless_dev *)(((struct rtw_wdev_priv *)wiphy_priv(x))->rtw_wdev))
-
-int rtw_wdev_alloc(struct adapter *padapter, struct device *dev);
-void rtw_wdev_free(struct wireless_dev *wdev);
-void rtw_wdev_unregister(struct wireless_dev *wdev);
-
-void rtw_cfg80211_init_wiphy(struct adapter *padapter);
-
-void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter);
-
-void rtw_cfg80211_indicate_connect(struct adapter *padapter);
-void rtw_cfg80211_indicate_disconnect(struct adapter *padapter);
-void rtw_cfg80211_indicate_scan_done(struct rtw_wdev_priv *pwdev_priv,
-				     bool aborted);
-
-void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter,
-				     u8 *pmgmt_frame, uint frame_len);
-void rtw_cfg80211_indicate_sta_disassoc(struct adapter *padapter,
-					unsigned char *da,
-					unsigned short reason);
-
-void rtw_cfg80211_issue_p2p_provision_request(struct adapter *padapter,
-					      const u8 *buf, size_t len);
-void rtw_cfg80211_rx_p2p_action_public(struct adapter *padapter,
-				       u8 *pmgmt_frame, uint frame_len);
-void rtw_cfg80211_rx_action_p2p(struct adapter *padapter, u8 *pmgmt_frame,
-				uint frame_len);
-void rtw_cfg80211_rx_action(struct adapter *adapter, u8 *frame,
-			    uint frame_len, const char *msg);
-
-int rtw_cfg80211_set_mgnt_wpsp2pie(struct net_device *net,
-				   char *buf, int len, int type);
-
-bool rtw_cfg80211_pwr_mgmt(struct adapter *adapter);
-
-#define rtw_cfg80211_rx_mgmt(dev, freq, sig_dbm, buf, len, gfp)		\
-	cfg80211_rx_mgmt(dev, freq, sig_dbm, buf, len, gfp)
-#define rtw_cfg80211_send_rx_assoc(dev, bss, buf, len)			\
-	cfg80211_send_rx_assoc(dev, bss, buf, len)
-
-#endif /* __IOCTL_CFG80211_H__ */
-- 
2.25.1

