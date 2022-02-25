Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACEA4C4459
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbiBYMJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiBYMJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:09:34 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18161D6CBA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:09:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gb39so10486693ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X01b0npE0g+H3NBwvWgXa+/pm4dhDaG2cD6CkeGqTNw=;
        b=CjMH3Qps1rz/CRFPosO3PcU5VcJkFJwriblFFxrCqQ0zxWnUJasp0FbjqTeSEOGs1B
         qeAziIRyG7NOaFRhstdQPnpexaWuYfZJFxdV0PfjznTnE59dmtkmUvZcYlil/OewrOwk
         ocT8S7bpAGGD3sBekuUpDI+66tuUcIF3G7AKwk37hiUlZyYQDa6LCYf8qdtYZIfSKqJ2
         iy5+YTlmb09fMk6bMzCvcMx8fVuS+MEPYqRNoV6NBnDFLJN4RenaaDQcy3/BRLicIT5/
         6hVTSgbUh9hhQ+n/kaD82m1yKEto+Nx9wuyt5uQK4Z2Qnc4LmyGySmsssMZfW3Q5nAMO
         cIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X01b0npE0g+H3NBwvWgXa+/pm4dhDaG2cD6CkeGqTNw=;
        b=6tCpdcWocxDjlAMvq0eZoHv92d7LCyhxbs+KWHpz1cxD/iSDkD0UyVpKwfEcUz4USq
         zJ2SSoVuO0WW8cat+K0YxbtpE5minGb/U31OlTB8tccoYCLVqC898qXQVsDr2KpDmerZ
         rkdoNnduY5lTyJMMVKBGXzp4cK4VVS7uxF2/7LEjWfe4AKUa9sBA+VXcqN8B4/sJE7cr
         8S7ma10QH4z6fvp9xmR1TQjnPKxMfT4RPTuLf+/VUadzJJRVktCY2aZiE/1z4KHJlsD6
         dSYGFAG4+zQ9Fp6BHaASgcMNqtpBVd8P5NjqPoBvxsGkX4wjWD6Xpacq4Ku/FTYnxP5Y
         DuLQ==
X-Gm-Message-State: AOAM530+sPuMEWXsDiaZMB95MQPdeMLSnthP7dOe3st8IWbjBH1lg8Zm
        0Wg5Gcjf4XpAcyaJTxzBu/s=
X-Google-Smtp-Source: ABdhPJyrS+9uMgAuqc88GQ/Pbftfx5agFbjvTEh1+94I4w9oz959xik5bPykI9Grzh1Os8+Tw2OFoQ==
X-Received: by 2002:a17:906:b348:b0:6cf:5b66:2f80 with SMTP id cd8-20020a170906b34800b006cf5b662f80mr5712628ejb.638.1645790941517;
        Fri, 25 Feb 2022 04:09:01 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8d.dynamic.kabel-deutschland.de. [95.90.187.141])
        by smtp.gmail.com with ESMTPSA id y14-20020a50eb8e000000b00410a2e7798dsm1229418edr.38.2022.02.25.04.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:09:01 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: some simple cleanups
Date:   Fri, 25 Feb 2022 13:08:39 +0100
Message-Id: <20220225120843.10674-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This series contains some simple cleanups in different areas of the
driver.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: EepromAddressSize is set but not used
  staging: r8188eu: remove unused function prototype
  staging: r8188eu: remove update_bcn_p2p_ie()
  staging: r8188eu: remove ETH_ALEN from ieee80211.h

 drivers/staging/r8188eu/core/rtw_ap.c           |  6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 15 ---------------
 drivers/staging/r8188eu/hal/usb_halinit.c       |  3 ---
 drivers/staging/r8188eu/include/drv_types.h     |  1 -
 drivers/staging/r8188eu/include/ieee80211.h     |  1 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h  |  1 -
 drivers/staging/r8188eu/include/rtl8188e_recv.h |  1 -
 7 files changed, 28 deletions(-)

-- 
2.35.1

