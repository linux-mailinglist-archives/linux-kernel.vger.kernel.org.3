Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FB14EDA32
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiCaNHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiCaNHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:07:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025E49252
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so47974516ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pvflieYkGvqxxIFeLwTIeMj7AbGD4LMFP+RQU2pR/xU=;
        b=ek1+IghIBT0bcGojmg71M4YYdT+5iyd9S2DmEDNImFQZkSO8m2dv2hmeWO0CSdjNf7
         AAtdpjkrPRIoVJawVniS/hzEFLf1RR9/gvz8jzGOMnEOL61BlOcBG7QAwTXY9kvmfNwk
         T74Xix2kVrSh5uUUPYfvY43IIFIe8GImiy1Kcm+fdQ4VbQ6qq4MAsQeWdex+M6gYsUfy
         VMRKXW1MvOQLJazzbAyuT5yvkM7rtbmPxGk8QoiB7NIjgtCTXmssYHRd7U6VLEuFzKBC
         8Xn7Sy1R5Ysvtlt7cHqT1zNSa+b/CwhXsTtATHGvFbOFuC8jp4P6z4C1fz5LkzW5wt/J
         fV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pvflieYkGvqxxIFeLwTIeMj7AbGD4LMFP+RQU2pR/xU=;
        b=IHLSBBIckULWzkZ43KJN8yWolDXMO+dnxdn6YAeDCVDDLFAZHA3Fz3sMAv4b8KCD0f
         A0juuh3wczAC1CMYhkF+DBke2SUmyIa28yuZ2uRrrG7o2tx+DH8IIuerjQgPepVrHpz1
         QgV8s0xCbsaKwcs/nTPzOw++MRID8Ne2wBBpsbGEnMsOhOImMHWh1Xp7KgUQkfs7ybzc
         1Kg+PdFfIwlSlCRgqvOBq1oJmAIWbdYdLoNwCf2Gvvj0QpLVTUp2Pkj5RtU3uL2DvwoL
         ESj8UL5I+X2YDkBytPnUmaBJYu3mb7ZBjenEZjvvlZIfCVQbFXqDDtS+1jFRSaRAcYpT
         aNbQ==
X-Gm-Message-State: AOAM531+aXfkgf1kscjmAWOO9IdxZsk/We1QI1g19GKv/HT/cePMnujX
        sOR/KW2gjXW7b3w9f8uqi8s=
X-Google-Smtp-Source: ABdhPJwE/mM0q2UOa5P6FLgSZ+W9DWY0CAbNM725eRXiAEEY1B/GzM02PAPJHEONKlNBLKpUGF0RXw==
X-Received: by 2002:a17:906:6a11:b0:6e4:976b:e94 with SMTP id qw17-20020a1709066a1100b006e4976b0e94mr4986900ejc.142.1648731928910;
        Thu, 31 Mar 2022 06:05:28 -0700 (PDT)
Received: from localhost.localdomain ([95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm9333358ejc.197.2022.03.31.06.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 06:05:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: remove GetHwReg8188EU()
Date:   Thu, 31 Mar 2022 15:05:17 +0200
Message-Id: <20220331130522.6648-1-straube.linux@gmail.com>
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

This series remove the function GetHwReg8188EU(). This is part of the
ongoing effort to get rid of the unwanted hal layer.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: rename clear_bacon_valid_bit()
  staging: r8188eu: remove HW_VAR_BCN_VALID from GetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_CHK_HI_QUEUE_EMPTY from
    GetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_FWLPS_RF_ON from GetHwReg8188EU()
  staging: r8188eu: remove GetHwReg8188EU()

 drivers/staging/r8188eu/core/rtw_cmd.c        | 14 +++----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 14 +++++--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 19 +++++++--
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  6 +--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 40 -------------------
 drivers/staging/r8188eu/include/hal_intf.h    |  4 --
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  3 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  4 +-
 8 files changed, 39 insertions(+), 65 deletions(-)

-- 
2.35.1

