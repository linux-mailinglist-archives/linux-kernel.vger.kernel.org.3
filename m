Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39435B1E14
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiIHNJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiIHNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:09:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E138A13DF7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:09:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u9so37966101ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UbzD73ANBmIAnFLQ4kLmnJvqIHDS1D6Ssvlro3k6SAc=;
        b=CCRU87sl0dDdVinCDDVfHoNWtWcAWNbY9lxV4uj/16ArW1D5qzxNp83v0CEgRg3vw0
         ppMN/Wrgqb0I1ZIDGu2qCdn/6yvNka5kIo++BJB6r/aIpViFVMWwbwsLpQPMO7J/ezr7
         s19OXW8UHZ19vQqBcRPSu+DVLFrmBWKr3DSMkl6oboKOxFYjWJoH6rHpj6z1p8k+qLyi
         qDkYw192zz9XREv6su1NYNCa1dTU7NGyCVyV1kvXKoFHjmzYdPl79O99/dhrqIsLOi5d
         GMFItasEEZRm5Xqpon9FdfsJZD0HOCf/G+evRPKXDZqeEhEBxHDn74AyhI+clCIz/BGQ
         kE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UbzD73ANBmIAnFLQ4kLmnJvqIHDS1D6Ssvlro3k6SAc=;
        b=zjN6j38Wb3+eTXJMQids1pQaKBuJEOJIxiUwRDcTiZ3ImmvpbveiwT41KrB35S0r/Z
         k7a19gsyTVBojuoRbYFmA4b/+x9Tz8ZuTUwhIeP99ZH2gPq+MnAG2GNEpQWfulVX6FIY
         O+OjE+JaPVDaBpuDFh/FzvtEmzI0PR7MyPMd7SdQ3r1KwRyM/hMmjkm4D2pjWrfPNB31
         s8epSnqXmoFBKQxHjPha2utDLENCO8GHP+Vod2GW4C30BjfIo0GGtvSh1GwXmcfbOHbN
         CzGvgbgUuf6gSXz7oejwJZjdJX4laLdqQaudV3dj0cXFH+n3YFDwVAlVR0jUhq+oIQq2
         wDnA==
X-Gm-Message-State: ACgBeo3zjGdTwJf5DrsIk2en+EGtNhttfj/SVI+Dtw5qA5ywk+jCJmG3
        yMoZxKzaP+E667VwtgtMbqNkE77/G50=
X-Google-Smtp-Source: AA6agR7u46nTrfb6Eb2z+eTVWECtts9/p08dYc2kxgLV8wGg+eN9CO6LeivOA6umOXzrd8Zv62WQ7A==
X-Received: by 2002:a17:906:a0d3:b0:73d:be5b:2b52 with SMTP id bh19-20020a170906a0d300b0073dbe5b2b52mr6117358ejb.727.1662642566641;
        Thu, 08 Sep 2022 06:09:26 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id cf6-20020a0564020b8600b0044edf0a2deasm4847978edb.69.2022.09.08.06.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:09:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: remove unused parameters from _BeaconFunctionEnable()
Date:   Thu,  8 Sep 2022 15:09:12 +0200
Message-Id: <20220908130915.8406-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908130915.8406-1-straube.linux@gmail.com>
References: <20220908130915.8406-1-straube.linux@gmail.com>
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

The parameters 'Enable' and 'Linked' of _BeaconFunctionEnable() are
unused. Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 63c5cec655d5..a478b83dcbf3 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -496,8 +496,7 @@ static int _InitBeaconParameters(struct adapter *Adapter)
 	return 0;
 }
 
-static void _BeaconFunctionEnable(struct adapter *Adapter,
-				  bool Enable, bool Linked)
+static void _BeaconFunctionEnable(struct adapter *Adapter)
 {
 	rtw_write8(Adapter, REG_BCN_CTRL, (BIT(4) | BIT(3) | BIT(1)));
 
@@ -1043,7 +1042,7 @@ void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 	rtw_write8(adapt,  REG_RXTSF_OFFSET_CCK, 0x50);
 	rtw_write8(adapt, REG_RXTSF_OFFSET_OFDM, 0x50);
 
-	_BeaconFunctionEnable(adapt, true, true);
+	_BeaconFunctionEnable(adapt);
 
 	rtw_resume_tx_beacon(adapt);
 
-- 
2.37.2

