Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E6575B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiGOG3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOG3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:29:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F013F86
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:29:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id os14so7281610ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHgYQ57up5w2WHv1hYXHN8IBevAz2rN/LxpGnpqYmU4=;
        b=JI4Kgbgo0bQEvLMje6miGiraUoMac1F9ZoiQJ+JuxaDGse+xEfEKQC5DwcveHzTwnT
         oGcnGu9eUy687ISvDbxv5cB67LpDgH2Qg3LtelVfDEFIWMbkpfg40nVgPP+EjSHiqRpF
         fJH29ek18VNzPmjs2332lWP+IPY3UDd2C9DUpp0s02cy8rNhpVj59Gi7rg1T/l0Wmtl9
         hxb43UTFeSsOa+11pTOkzZ3VphowX6UvUEpKCJ+YvY07Df5Mvl2UpNUmH/DaeMFzJpAE
         GTE5pP7+FZAcIfTn/CYqOCuSr729sf9Evt9jHxdIy6D8DoSD8FI/IraOO7xKatADNHx9
         WDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHgYQ57up5w2WHv1hYXHN8IBevAz2rN/LxpGnpqYmU4=;
        b=braYZwmSMnaaRxfYw96gInNJVmAqM6Ps5iBLuLZI2x4tgIR/6RvYC1Yz5GXmuVSJgj
         OZZpQbRZPxEfThmDXbCgZ6Blr+zEpTjOnUCdZGl7QfPMfjffMLlQ8IxiMVWer55fKC0A
         hR6UcGJWrt/tclHiOQdXmq7flMMvDZdez22VXmHR/OEojCuaxvbZBmSByvHCOHH3XA3y
         rj27kD5JVObPNpTV6c0ko9j2z1HtWYfXZ/P/MK7RS512XNB9wqizJ7XOW6lt+ojvomb6
         tOclpO4S1g7TQO8/yexIMkFSv9XmnSrXHVlvaUld/peel6swLH6Cly+LlQPHCjPN0Ytk
         Et+w==
X-Gm-Message-State: AJIora/TBk7KzLS7xx3qRApohsR3vwKaCYeylcK6i9wk5uE2MDM1fGzZ
        QVRvExk7k9MvjoO45Z51N2A=
X-Google-Smtp-Source: AGRyM1uVsVPDS5mdTshIbzATliAzNcoW6hnqrk/t1m2yBgyfDc8D7QsW90IY2yCwRuxcJbnwwSDqrQ==
X-Received: by 2002:a17:907:9810:b0:722:f204:b409 with SMTP id ji16-20020a170907981000b00722f204b409mr12069875ejc.457.1657866555422;
        Thu, 14 Jul 2022 23:29:15 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb91.dynamic.kabel-deutschland.de. [95.90.187.145])
        by smtp.gmail.com with ESMTPSA id ku5-20020a170907788500b007262a5e2204sm1614515ejc.153.2022.07.14.23.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 23:29:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: remove SetHwReg8188EU()
Date:   Fri, 15 Jul 2022 08:29:03 +0200
Message-Id: <20220715062908.8547-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.0
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

This series finally removes SetHwReg8188EU().

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: remove HW_VAR_SET_OPMODE from SetHwReg8188EU()
  staging: r8188eu: remove unused parameter from correct_TSF()
  staging: r8188eu: remove unused parameter from update_TSF()
  staging: r8188eu: make update_TSF() and correct_TSF() static
  staging: r8188eu: remove SetHwReg8188EU()

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 163 +++++++++++++++++-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  20 ---
 drivers/staging/r8188eu/hal/usb_halinit.c     | 152 +---------------
 drivers/staging/r8188eu/include/hal_intf.h    |   7 -
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   5 +-
 5 files changed, 161 insertions(+), 186 deletions(-)

-- 
2.37.0

