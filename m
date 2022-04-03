Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6349E4F0B59
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358349AbiDCQy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiDCQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:54:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5133915D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:53:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so8296997ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGWC9z9Vble15uohjVceMy9pmNPvA8ixj7T4/I7j2vg=;
        b=eysorBVn3uf8H6RmlcB4Y5q6Uiqu9VJI6vguIsiW8ijsMcWha2M5Ru92qDdfkK6V8b
         m0G4kxUXDhxG6GKopOg+qvJ2uiA5n99+BgXGelAtrejCQqxzFpn1W0DYhRp4GCPIKDGo
         peGizf/+uC6QCAf6xooViaBPcBd1YMVj/T4cb506C5+X9RfR7LaXaN3wivuqCRG1yIWb
         I98umR3e+WW3aeinfhfyP87cEizGuQFvEOR0dnfBLPVQf8F1Xi/Si4k7IsKMpnz2f6Wp
         ABItaMzMaExtIQg0PtS3ue/0PIyQv6okQ2MEkrGJ9tocmknXtPS3yPh57jlH5018rUy4
         8cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGWC9z9Vble15uohjVceMy9pmNPvA8ixj7T4/I7j2vg=;
        b=3IxGbrqoOMEWv7G5NeLMKmi4Lfq4YM1kviVCz6EnzQwO5x+lXFISDl1ebXSrltW3wX
         +fQjEm10q8Lzz3lYQJS9FFaqz8tlh2z9EaLX9zojqrr1p4XtAPaNPGXXwgb9+iLAtrN/
         VIFKeOYeLwmvG24nBBTeNfA3Lyutd31HOcWryiAsGhYq0Uwjwxw+F09dSWTn011YJyLn
         WoPkGWnX65igRZ7CWXsPQxphZRWZu0EUb4w6RF/ZgqZLJr96hYA+xloKxrsv9+GTaBk1
         2t1Afx/ZsxQ6lWyMM11EjT3PdJpT11yJsZuJ+0D/DCXWzWl3JOJtdMMotvMZGp9xYT0I
         3Mpw==
X-Gm-Message-State: AOAM532eZ7aiDl9bVlBYYzRrezxQ0rpDJ4kid6/YPHL7TyzuS/sJpeg7
        8NvO/GNhm36PB9iLi7JCqtc=
X-Google-Smtp-Source: ABdhPJwGAoEhkgr7k86IejYdeWPiUf8Ssp0RP2typ0RgA6GgyE6WRpNu7wrCgyFnm/sAyvBNhuk02A==
X-Received: by 2002:a17:907:62a1:b0:6da:7952:d4d2 with SMTP id nd33-20020a17090762a100b006da7952d4d2mr7550856ejc.260.1649004782072;
        Sun, 03 Apr 2022 09:53:02 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm4018138edu.11.2022.04.03.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:53:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: remove GetHalDefVar8188EUsb()
Date:   Sun,  3 Apr 2022 18:52:50 +0200
Message-Id: <20220403165255.6900-1-straube.linux@gmail.com>
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

This series removes the function GetHalDefVar8188EUsb(). This is part
of the ongoing effort to get rid of the unwanted hal layer.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: remove HAL_DEF_IS_SUPPORT_ANT_DIV
  staging: r8188eu: use support_ant_div()
  staging: r8188eu: remove dead code
  staging: r8188eu: remove HAL_DEF_CURRENT_ANTENNA
  staging: r8188eu: remove GetHalDefVar8188EUsb()

 drivers/staging/r8188eu/core/rtw_cmd.c       |  4 +--
 drivers/staging/r8188eu/core/rtw_mlme.c      | 11 ++----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c    |  8 ++---
 drivers/staging/r8188eu/hal/usb_halinit.c    | 36 ++++++++------------
 drivers/staging/r8188eu/include/hal_intf.h   |  6 ++--
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  8 +----
 7 files changed, 26 insertions(+), 49 deletions(-)

-- 
2.35.1

