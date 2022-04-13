Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D64FFFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiDMUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiDMUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:14:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD546B532
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:43 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z19so2212792qtw.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLu5+mnBdkV5bNcuBYn/9StkIMnThnOJRjEm3/I6LL8=;
        b=JQbNGODPh/X7mDysGHKbjM3WkcSoi89SOSZVLGbV/UPdE8SMyTqBI+Ww/JkrZsN/jl
         eGfxZ4SsA01wvrXmEAuZ8RpUR/NP/ZBD0sWfs/LDAi0du18C0koHi2PRBwqzYIHPjHae
         JIutwzN0GAlHwYC36bFqzraSYhZveSn3t2rpdz+kGkk8P82MjbwFebgp5RWp4Rq+/7Ey
         raJ+EaY2p4fVoP3nmnF/lcQutv6QzTq42bHAzMJntNc28ktHwOz3lh0cGJ5K4gpxwp++
         UEzu/ewT08eqVX4BGP01B6HkRNRGLrD5nAVsW1CMM2cdEKApnqkm+AzjJx08VAwa6XWf
         y0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLu5+mnBdkV5bNcuBYn/9StkIMnThnOJRjEm3/I6LL8=;
        b=c6khRWQiMl58HO2N34j1yENVc/V31FRKXVTutLiyMUyUE/30lt1fIM2JwBNtWdLvwC
         VuRQqDUF6eFTFaku3l2GKARmBDRXsnrFH/Tc2Sxfq8b47xh6DD87UIRBFANhgCp2oMnB
         ngRtDg94/AkgLpbYZHWyqPwrbRUaUaaHnbCaIgUIsFCEAaQ600NdsLSC8oA10dNj6sdy
         AvD0R39x7i+mK2F6v7tZPa/6woimTSinI0D+Org7/yn2QJmNbixEndL2pFl3ZiJy5NoB
         TIACfQXh/8xfrFxlq6pEp09pZc4nvsxmB5WMThD7Q/3Qq+432gkjRtkrbFT0z65PWktk
         9aKw==
X-Gm-Message-State: AOAM530LYkfOfHsFVnpU/tpVL5ICGBjzTZ4+R645ZTprjTPO+jfBq7cD
        refX5jU1XBuDgo5AApuKnQI=
X-Google-Smtp-Source: ABdhPJyiBkXmOz1EjxJX3Vdcd/isDYM9UtENeLlEXyamjBzbo2SNLPdgpC3jKZ/KiHIc7WtxB7LlrA==
X-Received: by 2002:a05:622a:1cc5:b0:2ed:cba0:3f0e with SMTP id bc5-20020a05622a1cc500b002edcba03f0emr8505261qtb.365.1649880702197;
        Wed, 13 Apr 2022 13:11:42 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id 7-20020a370907000000b0069c5598584esm1469827qkj.105.2022.04.13.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:11:41 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH 0/6] staging: r8188eu: fix warnings reported by checkpatch
Date:   Wed, 13 Apr 2022 16:11:28 -0400
Message-Id: <cover.1649880454.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches address style issues found by checkpatch in the
core/rtw_mlme.c file. 

Jaehee Park (6):
  staging: r8188eu: remove unnecessary braces in single statement block
  staging: r8188eu: remove spaces before tabs
  staging: r8188eu: remove 'added by' author comments
  staging: r8188eu: place constants on the right side of tests
  staging: r8188eu: replace spaces with tabs
  staging: r8188eu: correct typo in comments

 drivers/staging/r8188eu/core/rtw_mlme.c | 42 +++++++++++--------------
 1 file changed, 19 insertions(+), 23 deletions(-)

-- 
2.25.1

