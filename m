Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CA64A3851
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355665AbiA3TDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiA3TDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:03:38 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C90DC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:35 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id s13so36157310ejy.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sY7P/t1AUJsEIOGpEH9jaDzmKFiJT+OmhoPSXZS+aIU=;
        b=KVgyFQYvaCRMG8doNu5bpdNayOmMOVW9c5lDnOPnN+8l5VCOJ5iGipAdwjLMmkrjcc
         JowLuzdEuCzMedpD58bdrhcczDKcZqi2FKpjxaXjjQ+gpFifMvxRof39272dM63rRDpC
         Sep+T/f57kqrf9n00LULD6w6Pafd4U7OlJxSDXDCd2JSWjnUTF2lpHe80eOKt1sbiELQ
         G2GifrF/8LpNYkgUccs2tVwR3AkxRxdbHXSn5wW99y8jMhLlotWplzHpZIMrldH5hJcW
         YWjHeUvfcFGFhSvFs29+/3YUydmS8bv9gNPeReSb6IC9QcbiqiJnt0hv2Tyj7Y5tmBy8
         yaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sY7P/t1AUJsEIOGpEH9jaDzmKFiJT+OmhoPSXZS+aIU=;
        b=AaTHTgqv7m97DuOnbBUnkTv3hudxXn2H7y8TcLuJskOW2jSTEb1U3YndAs1hzY8Vd4
         lXXo7B1QkeQjc/IsuHaYDFoK+L6oW3q0Ii8y2tvsXQi1oyRFIS3B9+KfWKyDVYHLTi7I
         Tql1uraCNHvj5gzez5dvYbL8Q2Lsp1nNWFo1KIMKt1YX5NvW5h4AL07G8jRMZrhHFa8m
         48oRht80eTCjdFw/Acvo3EX0E0EAFb4ZQe3yZHdIMOA0D2s9T6/GfFomt5kNedwxx/EK
         hYHS5x8vPaJEswW/mBvrzv5t9TbMBIIYmKPxUrEvHRJPdOLu9rcFUBQeai0cFjYVFMT6
         pV/w==
X-Gm-Message-State: AOAM532xiM2UgSxhRNz5fgjO8OjvfnDFihJrgv814gwa32YzuXCk71++
        veQkjtkV2k/X8fRtX+u/aNtEHeHL4/M=
X-Google-Smtp-Source: ABdhPJy80yJCavGANxQUw1B/AB5X3t8dzuJoZKNdwdH6uhYKbCE/WBKO1flQ8Fn3z3MgtvB16bgPRQ==
X-Received: by 2002:a17:907:7d8e:: with SMTP id oz14mr6463555ejc.764.1643569414130;
        Sun, 30 Jan 2022 11:03:34 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id n3sm921124ejr.6.2022.01.30.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 11:03:33 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/12] staging: r8188eu: remove some HW variables
Date:   Sun, 30 Jan 2022 20:03:09 +0100
Message-Id: <20220130190321.7172-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some cases from SetHwReg8188EU() and replaces
the usages with calling the according code directly. In most cases
calls to rtw_write/rtw_read.

Tested on x86_64 with Inter-Tech DMG-02.

Please apply this series on top of the series
"staging: r8188eu: remove two wrappers"

Thanks,
Michael

Michael Straube (12):
  staging: r8188eu: remove HW_VAR_BEACON_INTERVAL
  staging: r8188eu: remove HW_VAR_SEC_CFG
  staging: r8188eu: remove HW_VAR_CAM_INVALID_ALL
  staging: r8188eu: remove HW_VAR_AC_PARAM_VO
  staging: r8188eu: remove HW_VAR_AC_PARAM_VI
  staging: r8188eu: remove HW_VAR_AC_PARAM_BK
  staging: r8188eu: remove HW_VAR_MEDIA_STATUS
  staging: r8188eu: merge Set_NETYPE0_MSR() and Set_MSR()
  staging: r8188eu: remove HW_VAR_CAM_WRITE
  staging: r8188eu: remove HW_VAR_BCN_FUNC
  staging: r8188eu: remove HW_VAR_CHECK_BSSID
  staging: r8188eu: remove HW_VAR_CAM_EMPTY_ENTRY

 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 15 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 24 +++---
 drivers/staging/r8188eu/hal/usb_halinit.c    | 88 --------------------
 drivers/staging/r8188eu/include/hal_intf.h   | 11 ---
 4 files changed, 18 insertions(+), 120 deletions(-)

-- 
2.34.1

