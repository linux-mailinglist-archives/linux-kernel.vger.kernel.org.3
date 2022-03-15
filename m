Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F764DA57C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352288AbiCOWly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352284AbiCOWlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:41:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AEA5D191;
        Tue, 15 Mar 2022 15:40:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so418305wmp.5;
        Tue, 15 Mar 2022 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eF7Ju9bnYULQUD4TwuczuGatyNZQSDGQVXAZ0n/JqVM=;
        b=JzvlDbj0rGw2ex9OZz3+XQ9aH3k/b0BEu3N9rMMDnaT0HhAo1N1AdPu3yyufQX1dvU
         o5Q00Dh3e6lanAiOLLA3lX5CELdRGeJkjL6jGi8RjWnaVzugda0WFu49sR+D6t7Je/2e
         2cMt2c/in3BrNJ21ftvLJy70SXbii8cHUsjBCKniu1m1yZ18mTVSNLlOO84jiwgsA+jD
         pzz+fcoTk2tJH8k4sWHysC1QW+pL3LnhK2Ag0j/jpiFLyNlzHCHdfu64qPuZMk4Ejme4
         TrCq/reqlXcPq2IcCh8RcbjRh+uO3jtf7ksrlZbvzukZGWAeKpJGdSS56+Dpa2aGgubN
         inyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eF7Ju9bnYULQUD4TwuczuGatyNZQSDGQVXAZ0n/JqVM=;
        b=PZqOotiOSQWOswvKFagVJyxe9QgUdyuy21Un68ls8RuWw9TyHElGHu/6VPmAzIqOXc
         vscXP96ITxHFvLUQ1JTrYaPe9T9SOv5BWeYSbwFQer8RHBUH7TfYOT9kpEJrK+Na9S0M
         dj4YO4nxw5zLsjPJaG7xlh2upZ0ZWV03Al1SfFS0x5zCR29Qj+gh4w63Q8osI11Ni2ay
         4eoXkXFL6QRwANpv0HsnNTUDXncau2CtbnrcJzsUlZ8IMKTrV4KVLB3aupP54ZsjLwns
         U4ETg9WQ3BSOEVsWHbTGpaWfyiSRaTLjEBC92tlsYek3X5NPY3hAznq4vNPdG3hFQab+
         j9Wg==
X-Gm-Message-State: AOAM531I8dlNfRS4GB2kS5amTu93iA23Q2kHT44xX7ElbwnhtVSEMM+3
        IvjK0kWZzXdytk/7XLwIYbg=
X-Google-Smtp-Source: ABdhPJw2MXRwi/73MA6L129wuYZTRDb820LGgWutg815SGiu09p+4S6TbWm6HQDHIY1UlND+YA6fQA==
X-Received: by 2002:a05:600c:4408:b0:388:a042:344f with SMTP id u8-20020a05600c440800b00388a042344fmr5099652wmn.52.1647384038341;
        Tue, 15 Mar 2022 15:40:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm102234wmb.22.2022.03.15.15.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:40:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix spelling mistake "RESQUEST" -> "REQUEST"
Date:   Tue, 15 Mar 2022 22:40:37 +0000
Message-Id: <20220315224037.2962063-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a netdev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index e3d0a361d370..eb904b42f9c6 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2732,7 +2732,7 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 			      (struct rtllib_probe_response *)header, stats);
 		break;
 	case RTLLIB_STYPE_PROBE_REQ:
-		netdev_dbg(ieee->dev, "received PROBE RESQUEST (%d)\n",
+		netdev_dbg(ieee->dev, "received PROBE REQUEST (%d)\n",
 			   WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)));
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
 		    ((ieee->iw_mode == IW_MODE_ADHOC ||
-- 
2.35.1

