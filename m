Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7834BCDAA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbiBTKDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:03:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbiBTKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:02:58 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A63A732
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bq11so2122245edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u3lC5A2Ox2Mr0XkcLY5xCuAMwekJnyBOdtA3+n9Nrs=;
        b=CLcJpQBwvjWPPUvYDqUmCeXK/yN8NCRHwbt4hHPSm2K0LrM9x+Xda8zRnnft5jBZYx
         yLOK2mBBI+UOMc7bYe/S5vtztVS+5JUkJnKMH5uHqXz3z7djcraQJGtfN7C6yAEta7Bg
         8P/M7qLF0/xeeHBYSmMw2G5CwVRw0HLNxILBNrsEs2ZtXuXGyj9Uw19vE9Xtk2xT07pU
         bwjFUovB+0MMqvzVq3POXwEbqi1n0EG0b+BEa3kM4zV2VCSuanBWHEpBraLO0O5F40i3
         HVuaqJtTZZ15RFt2bYG+7KvBROFC5Ay09pwcRVCLM4K2wxleA1mPSrVC1A34BPzmUKwa
         YDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u3lC5A2Ox2Mr0XkcLY5xCuAMwekJnyBOdtA3+n9Nrs=;
        b=dap8X9yPppFeiBD0fA1PXiQ+OqXEMnKMdaTo0UbL9eAeLEsSDKafek0c45bl49Q339
         ZGAKMrvrBsEGgvu4wgbKs+XK60xpzWHIzcrAcZ5SnRwSPBV1Mz7T54Tz1pFCVPVUctWO
         Vs1hifao7po3YtEaBTmyEhF/b4nV3NiSLAnqhhIOzoIjj0+wCxFm2lRzE0SVGadTN944
         E3B2fpQEOdkekvnX/d0vPac0fN9adts+X7ap2j0pBgfQesNeyni+CTTQrprRoJgHDTvB
         BjDhhQYo3Jyk7531Dq2xtewos7+/pjNUU2voWX5cIpIalwo1NNc5lWzCXi4fflbY7gTx
         OvsQ==
X-Gm-Message-State: AOAM530rw8RBBs7W03qAtXPF43Al5chPJXxv8O3az2D2dGBZf8HLgt8E
        3xJNB+ZpqFXDZ2oRxEclgA0=
X-Google-Smtp-Source: ABdhPJzlyMoULzYQRR9uz3KXhH8EN18wzCpoahZ0LuyUKES2HSE5aA6HlpEVMNLye/dJQAp4CTWcgQ==
X-Received: by 2002:a50:9d89:0:b0:410:ff04:5a98 with SMTP id w9-20020a509d89000000b00410ff045a98mr16559884ede.404.1645351338920;
        Sun, 20 Feb 2022 02:02:18 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id dx7sm3265223ejb.23.2022.02.20.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 02:02:18 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: odm cleanups
Date:   Sun, 20 Feb 2022 11:02:07 +0100
Message-Id: <20220220100212.7466-1-straube.linux@gmail.com>
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

