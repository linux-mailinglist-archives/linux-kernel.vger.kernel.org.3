Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625F4F8816
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiDGTam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiDGTak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:30:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6204529A57A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:28:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg10so12976730ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iryodbly7hWSxF2KcHp9s3S3xjPavYjEFSYWyJwJex0=;
        b=KKcV/Buz4A73ob6dE9LrdOVhfmWRWjTzVhH1UcRUQ/DxhvWpgE8iDdVVFglekx+DJ3
         8ze6MXC/PlPWRLN51JXqgSwYcg0vHH3xKBrFcLgvk4CoN0kYN/Q5qTWf3JMZq6PuYOhZ
         VprNKGGt3OIdHTBykMUe/6vgGBoq2JC6BvQfn9s4I22tAOPHvrVFOZQrPyCOzZ4x7K+V
         iMUf6pkuP2I3z7309POjmkj4ZAxyffAxHeIEHXRH8mGgPoKbhGPjzYsYmYN9mTBCcFtu
         wMbuHqyX8ho+lpZdwQO5Vx6au7xe0fBELFZ/h2ngWo7MEHo1oZ1XdP/RJe2T4Muk4lci
         OUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iryodbly7hWSxF2KcHp9s3S3xjPavYjEFSYWyJwJex0=;
        b=oQrjSDsSJX4mApQvUeT+j10W3ustOQbfBSqBe4LWegpe+O03ElOBN2ZrDrRhrrJ+UF
         IfTLFIhcQzG7CvRXpVwJ88TBenKwbV+s4FW7WuxzDOtVRyZ1X/JeFkylZW/xHMeHeoMl
         k4WjwlNuO5dNMFaNK5G7IqreAMhzdCxiYbMaGizqOK1tImTJH4axHOnOaV15S73Ev61O
         2DURM6AkoNIOEOvfqsgYrbI99CUffIXuO1oW9RMMlEU0atphyaHxCE+aESkLroXZHB1S
         8zPCuZuikaPPYP1raAJ7/mFvypaaW6nEu3VX646SfNXe5lnYVxg8Zmo37Sc9d2xzHz5G
         +WCA==
X-Gm-Message-State: AOAM530sXKrmhMAofYTHQWnee1XZ5fXX2CQ9muMRZBFVDiGEPb2FWn7+
        CXBF0p3DDJrifZaQth5gkx8=
X-Google-Smtp-Source: ABdhPJyHaNrp1jjFDEs1meOdh9ln+yMcVNcVUC+B3c9ThrEOAVW+Mf4cnMYxjO+irnJhXPZN5+3a7A==
X-Received: by 2002:a17:907:8693:b0:6e7:f5f4:c4d5 with SMTP id qa19-20020a170907869300b006e7f5f4c4d5mr14423085ejc.640.1649359703188;
        Thu, 07 Apr 2022 12:28:23 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm9652798edl.22.2022.04.07.12.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:28:22 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/8] staging: r8188eu: some simple cleanups
Date:   Thu,  7 Apr 2022 21:28:11 +0200
Message-Id: <20220407192819.10661-1-straube.linux@gmail.com>
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

Some simple cleanups. Most of them are removing unused macros,
structures, etc. from header files.

Michael Straube (8):
  staging: r8188eu: remove unused macros from basic_types.h
  staging: r8188eu: move struct rt_firmware to rtw_fw.h
  staging: r8188eu: ROMVer is always zero
  staging: r8188eu: remove unused fields from struct eeprom_priv
  staging: r8188eu: remove unused enums from odm.h
  staging: r8188eu: remove unused prototype usbvendorrequest()
  staging: r8188eu: remove header usb_vendor_req.h
  staging: r8188eu: clean up rtw_ioctl.h

 drivers/staging/r8188eu/hal/hal_com.c         |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  1 -
 drivers/staging/r8188eu/include/HalVerDef.h   |  1 -
 drivers/staging/r8188eu/include/basic_types.h | 73 +----------------
 drivers/staging/r8188eu/include/drv_types.h   |  6 +-
 drivers/staging/r8188eu/include/odm.h         | 29 -------
 drivers/staging/r8188eu/include/rtw_eeprom.h  |  3 -
 drivers/staging/r8188eu/include/rtw_fw.h      |  5 ++
 drivers/staging/r8188eu/include/rtw_ioctl.h   | 79 -------------------
 drivers/staging/r8188eu/include/usb_osintf.h  |  4 -
 .../staging/r8188eu/include/usb_vendor_req.h  | 35 --------
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  1 -
 12 files changed, 8 insertions(+), 231 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/usb_vendor_req.h

-- 
2.35.1

