Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012534BD73D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbiBUHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:34:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbiBUHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:33:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92DE13E10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:16 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a23so30796816eju.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBWIzB83ChA6R4uLvAqJmKdkFkztNJhor8Vdyj0pogA=;
        b=ZI+Kz0SbhCsPzeMhpPmG8qaA5tpUtDXsMJyAj9DbKH/Z9O7UuarhQco+1QBVYE/bTi
         7JvzN7tBILLy+YcUFpJQX+SL4RtRnqH124fq48x+Da5+WH6Xgc1IiZY2Jm/G3P8+EQrc
         e8/YgEkbIyWPs9yDHP4sHeql18vlkiRFuFKxAPAED1FNlSxNzuvFff109yY0w/k/o+vf
         wlDDG/Jqz8st07SDeaz3We4gyO9y8pyGw4+2htiYh/1ySsEmhWvhjLnmxE6DY15udxTN
         6w/rNOUQbXQMdy4qmCXy7E0PGHuOm06lbr5DyA58kCTJvDuWmvNSu9M3JbocmoMSWPiF
         WhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBWIzB83ChA6R4uLvAqJmKdkFkztNJhor8Vdyj0pogA=;
        b=C1345QMKmnPPjs0ju+nfdMnneu3jVYhH5tzBeX9ozZszLGtx811SFN0WaiM+uGPIrq
         MuNA/XqMAh+XusPu0FzRxLlMNGz92lSQSeDSW5orlMRJJdWyRataUA5j3sK5il+e1qCN
         V29D7FLuuSSrWLZf3l4C752DA05SV4S/S9Qn/ZxR1vH+qNDHSV6VnFECPIgcxfB9bOHY
         KbL4PM0J+niT3BocqVbng+2CR5DrsTIGlbEa9jg/2Sa2+hOYCSrtfG7osy5YuHug4mMu
         thsDrQ5BFkhZUABhoTLGFTgbGmKxTqkgb6QAsNmRPtiXyYULUAIOaFKgfh36St5MvTYY
         O1+w==
X-Gm-Message-State: AOAM531AXm75Oq7q51nApyOvNzjmkTGsMML2KXQXw7Cc+CxN1ILsu8js
        hWwJn19XkxE1qBgPvqpphAw=
X-Google-Smtp-Source: ABdhPJzy2+WzOcUV/3YBjZdYT9fVpStRUIC1brwW2M3PmY7gn+FOk2CLectYcD3rflRnUaDX5m+sXA==
X-Received: by 2002:a17:906:714c:b0:6cf:4850:52cc with SMTP id z12-20020a170906714c00b006cf485052ccmr14907208ejj.319.1645428795434;
        Sun, 20 Feb 2022 23:33:15 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id c11sm8673128edx.42.2022.02.20.23.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:33:15 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/5] staging: r8188eu: odm cleanups
Date:   Mon, 21 Feb 2022 08:33:01 +0100
Message-Id: <20220221073306.16636-1-straube.linux@gmail.com>
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

This set removes two more functions from the unwanted hal/odm layer.
Tested on x86_64 with Inter-Tech DMG-02.

v2:
Fixed a typo in the commit message of patch 2/5.
unsed -> used

Michael Straube (5):
  staging: r8188eu: remove ODM_CmnInfoHook()
  staging: r8188eu: convert two u8 variables to bool
  staging: r8188eu: remove enum odm_bw
  staging: r8188eu: convert type of pBandWidth in odm_dm_struct
  staging: r8188eu: remove ODM_CmnInfoUpdate()

 drivers/staging/r8188eu/hal/odm.c             | 56 +------------------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 19 ++++---
 drivers/staging/r8188eu/include/odm.h         | 29 +---------
 drivers/staging/r8188eu/include/rtw_mlme.h    |  2 +-
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 +-
 5 files changed, 16 insertions(+), 92 deletions(-)

-- 
2.35.1

