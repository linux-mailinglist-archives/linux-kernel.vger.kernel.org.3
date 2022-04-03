Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA74F08C6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 12:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbiDCKjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 06:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiDCKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 06:39:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688012AE3C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 03:37:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u28so1480245eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6tvqdTFA299G8+SEfu7H95L5YODhmmKREl6BdiE8C0=;
        b=NBK9/HAFdazkxZGmYF6Fn6jseabDHnPMzOakAWAPjIKaNZd3XXLfQrZFIX3lPPSSAK
         eSvM2MiyarScp6nDjelzMcVd4wRkilZBvjtYOQE/J3SQ9l0zAoOsiZ6kgHKODBxmihee
         Vv5K1BxjUARzwmmcXpjWnjTHi6/DOg9cAJy1QecKts/fbKchwaELnFkjmHR31D20ra5z
         CXxvrEi/L2sBfoAOeZA7E3J1OX0/bzMqGtLB1IaKcclc0YbQpwjpmG4hNpd+Pm7dEe+W
         j/mvuf5luIGaU7y27OSJQ60CzaqSwthG8GiniphFZgPxaUOdgBiQvTp7Ac8ctaUSJDC8
         b2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6tvqdTFA299G8+SEfu7H95L5YODhmmKREl6BdiE8C0=;
        b=1J4LDJ+w6++4u6XlmAMrqZHwsN/81Phfqk6tsREJ5NaMYkktG2iDyKdoQKWn5TWQID
         tVIGqIfHeQXa1mNTEYgdr12DnawTfPI58+zEV3y6aliajavjmdU4PW2BzQNRuF2e9Pvu
         bWCxiZpQZa4DzZymnG14JTP17oyw9aWLPX6GX026D5ASYmqLUnBGjvubIShOYhjAZdmn
         KgLpAdoQH1SZ+HMdleRqBYTL6XRCQod1xkONzDGp90dXdecI2VJSKSeQbCywIxnpEVqC
         uEqc+Y0BZLZa+7TH6m2nrT5O4Jm09oklfXYrNykbv1rwSBvlH9ouYg8lS0jxeRZHE22T
         3o1A==
X-Gm-Message-State: AOAM533IOqXxUkxAFzSHlpwIHxbZZ71h+4M/Cb71qcAzucZAanEUoNGx
        x9T63vb5ZkhYOuZCU+GrZIE=
X-Google-Smtp-Source: ABdhPJwaTtSI8eNsOGZM/dGErV1jUOJ1c1ciYhAcjWV9qLeFQx6qSztziaGdrs531JRjPB2O2YVKtg==
X-Received: by 2002:a05:6402:6c2:b0:419:1a14:8fb2 with SMTP id n2-20020a05640206c200b004191a148fb2mr29041775edy.415.1648982243942;
        Sun, 03 Apr 2022 03:37:23 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b006e1382b8192sm3130751ejc.147.2022.04.03.03.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:37:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: remove unused parameter from _rtw_pwr_wakeup()
Date:   Sun,  3 Apr 2022 12:37:10 +0200
Message-Id: <20220403103713.12883-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403103713.12883-1-straube.linux@gmail.com>
References: <20220403103713.12883-1-straube.linux@gmail.com>
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

The parameter 'caller' of _rtw_pwr_wakeup() is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 7beabf82eb92..08e8a5efba5e 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -353,7 +353,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 * Return _SUCCESS or _FAIL
 */
 
-int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *caller)
+int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 7c3cb895c3cd..0a0f7a4c4052 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -121,10 +121,9 @@ s32 LPS_RF_ON_check(struct adapter *adapter, u32 delay_ms);
 void LPS_Enter(struct adapter *adapter);
 void LPS_Leave(struct adapter *adapter);
 
-int _rtw_pwr_wakeup(struct adapter *adapter, u32 ips_defer_ms,
-		    const char *caller);
+int _rtw_pwr_wakeup(struct adapter *adapter, u32 ips_defer_ms);
 #define rtw_pwr_wakeup(adapter)						\
-	 _rtw_pwr_wakeup(adapter, RTW_PWR_STATE_CHK_INTERVAL, __func__)
+	 _rtw_pwr_wakeup(adapter, RTW_PWR_STATE_CHK_INTERVAL)
 int rtw_pm_set_ips(struct adapter *adapter, u8 mode);
 int rtw_pm_set_lps(struct adapter *adapter, u8 mode);
 
-- 
2.35.1

