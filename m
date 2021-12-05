Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE1468B48
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhLEOC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhLEOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:02:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17758C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:59:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so31611337edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAHMngfO41TnEdh6H008A3VfjsmKRpjhz8V7MtD1hQ8=;
        b=bmsi3P7462SlnAHylMaESJzb7zLJVX83KxuxipSeZj6VQyFdJSI3V63GqLz332W9os
         p4HeAd/fAXIHxZsUe5CktO5C29aalM+k+j1tCJ/GshNXBMw5Falgf1lsJNruoHEO0lSS
         mvm/LmBTI023y9rLuj5gpX1J+/xcKxOPVAat91ICNn2+Hv9f2ywDa9RINicUY6ZuQJsP
         HHjP1s+mwkfe0I6c8wFXgA6otEnvo6yti8h+DNRZUo75U/y+lHglzRQzYRGXwCRZCvnh
         b+LYLlqD5ejjk2bkFOHNJ4rKZomzOCjHKKIKe0iwGBhpv3BmlHyY1rk7EJie33Jo27d7
         JHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAHMngfO41TnEdh6H008A3VfjsmKRpjhz8V7MtD1hQ8=;
        b=B9X2U63OJ3Y2YNPAife7Nqf9upanW8foGYyQ5s8uNpIc+bCPzHBZ6Ar/bDwnDtAgRQ
         iN7Rn6bB56ERyjEtYCOFisIh5cpOMVLCnFZVQR66rnuYWCXI/6pW1PNLP/s06e6IRjlo
         t3CAgDccU5be1xT9kvukH4mETvvQCMB5dDT53p05ZuR0xch+8JLmvvJiT4bdma5oxN2v
         OvqJi5aMVddNCaSbajSfcbmoKsbRKJe/V+mMb1JIqQV3qgOz0x3sKf3fvuyku29Lby/O
         2QJe1YDieGEc2oixzJ/Rdgo+HbrtEeL3o6dqe4/0T0j4xBt2Oga5ZyO5nlTND7sGxbKD
         Y9Vw==
X-Gm-Message-State: AOAM5324VngmOkSVGzUV3/Idy62fd34LyF8C4ZMPur65xYOyGHaZBNHQ
        Cu7X7VeP1frMjW7CtQDPmzc=
X-Google-Smtp-Source: ABdhPJxSDiq5U6GkKkIC5y7VUtBdm5jtRDmLC93mCp0Jj6N9oy1v99DgL/Nz8+xKGpZEuW0NaTrGWQ==
X-Received: by 2002:a05:6402:27c7:: with SMTP id c7mr45856390ede.0.1638712767750;
        Sun, 05 Dec 2021 05:59:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id yd20sm5146451ejb.47.2021.12.05.05.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:59:27 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/12] staging: r8188eu: misc cleanups
Date:   Sun,  5 Dec 2021 14:59:07 +0100
Message-Id: <20211205135919.30460-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series consists of various cleanups.

Tested on x86_64 with InterTech DMG-02.

Michael Straube (12):
  staging: r8188eu: remove RF_PATH_{C,D}
  staging: r8188eu: struct odm_mac_status_info is not used
  staging: r8188eu: remove macro PHY_SetRFReg
  staging: r8188eu: remove macro PHY_QueryRFReg
  staging: r8188eu: remove macro PHY_SetBBReg
  staging: r8188eu: remove macro PHY_QueryBBReg
  staging: r8188eu: remove duplicate defines
  staging: r8188eu: bWIFI_Direct is set but never used
  staging: r8188eu: bWIFI_Display is set but never used
  staging: r8188eu: remove unused macro IS_FW_81xxC
  staging: r8188eu: remove macro GET_HAL_DATA
  staging: r8188eu: hal_data_sz is set but never used

 drivers/staging/r8188eu/core/rtw_p2p.c        |  3 -
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 30 +++----
 drivers/staging/r8188eu/hal/odm.c             | 14 +--
 drivers/staging/r8188eu/hal/odm_interface.c   | 12 +--
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    | 12 +--
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 14 +--
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 26 ++----
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 86 +++++++------------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 38 ++++----
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  4 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 63 +++++++-------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  4 +-
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  | 16 ----
 drivers/staging/r8188eu/include/drv_types.h   |  3 +-
 drivers/staging/r8188eu/include/hal_intf.h    |  2 -
 drivers/staging/r8188eu/include/odm.h         |  8 --
 drivers/staging/r8188eu/include/rtl8188e_dm.h |  7 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |  5 +-
 20 files changed, 136 insertions(+), 215 deletions(-)

-- 
2.34.1

