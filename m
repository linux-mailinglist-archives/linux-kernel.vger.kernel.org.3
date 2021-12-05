Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2B468C56
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhLERSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbhLERSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:18:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66DEC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:14:34 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so33784040edd.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H93GgQCSgG0O/jTR8LDdgSffd2wakqUespS2pln07lo=;
        b=PO0fEiBiu/+InhmXUrzzB6P7kc3Vloy/04TzC+F+dEqz/um0F+HCIawLUGxbgJwg3J
         RWFIhpLjIrxxTNjtFkAezixe/cYfAoUn2k+MnZz6WsPw/QPa2CvcLTW8AMp1Lzaon2/l
         zXehGYjlTqwcbUcMGGrx0HFHOe01jofjT1EB4wvvl336JyyYi/MGqrqrp12NkLMUuvx4
         CzW6hIIxRkoOggnbrcbVWtTbS0T0D4ZoEXl1syWnmfvg9e1WoPGuXnA4sDxl9/creISU
         SekRC4tVXuR8kx49skuG6lsqZqp6k0JUPXFUJMkO8sJUeT9zcJ4IuzvOSm/5BYEeLZG5
         60aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H93GgQCSgG0O/jTR8LDdgSffd2wakqUespS2pln07lo=;
        b=Yad3xYxIjwHbCZ1PEHcuW84ECOzngCuuu2uE9e34xayOZuq4hUJHyBPDqgpyjozaa5
         3X+wOh4dwcSP/qIYsLAQBeNdsFdjLM++RwZwY78YLpTYBD+DzB90wUyub8H1ARUxHTlS
         4Ui6z0y2p/zl2O/+Sy3EzedHN6puUElWUit7i6aLZyT+ur+OB/3rEm/+BlbDDsDw4tYN
         +nBGpAypepbj9yMkHuFi69uX4S69LyRVQpVsFr584qUXdEEltYctIcshcIbQV+ypQn6y
         iUDhZ4EpypxcfOvaNWm0HLbY1E4qKbaPqx25FKwkCgBNn/fnnHf7c4YwXOwQZzh+fyD4
         kXow==
X-Gm-Message-State: AOAM5323Glg5e0IurhtWX5Q4zIMMC5eW9bNpWY8wS6W2QOQkscBOx6tf
        duF4mYtrhDrIzZfSM8LWz0Q=
X-Google-Smtp-Source: ABdhPJxnhCh7P5U+N28zF8E0CWbKe/NHE06FuYLFrTgVbLVXcg6EJlGf1fehK6RD/TKfzJpwp4MPVQ==
X-Received: by 2002:a05:6402:2210:: with SMTP id cq16mr46819762edb.32.1638724473283;
        Sun, 05 Dec 2021 09:14:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id ch28sm6071773edb.72.2021.12.05.09.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 09:14:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 00/10] staging: r8188eu: misc cleanups
Date:   Sun,  5 Dec 2021 18:13:32 +0100
Message-Id: <20211205171342.20551-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series consists of various cleanups.

Tested on x86_64 with InterTech DMG-02.

v2:
Removed patch 11 and 12.

As mentionied by Pavel the hal data allocation is never checked
for success. I'll work on that and send a separate series that
also removes the GET_HAL_DATA macro.

Michael Straube (10):
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

 drivers/staging/r8188eu/core/rtw_p2p.c        |  3 -
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  6 +-
 drivers/staging/r8188eu/hal/odm.c             |  8 +--
 drivers/staging/r8188eu/hal/odm_interface.c   | 12 ++--
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  8 ---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 60 ++++++-------------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 26 ++++----
 drivers/staging/r8188eu/hal/usb_halinit.c     | 12 ++--
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  | 16 -----
 drivers/staging/r8188eu/include/hal_intf.h    |  2 -
 drivers/staging/r8188eu/include/odm.h         |  8 ---
 drivers/staging/r8188eu/include/rtl8188e_dm.h |  7 +--
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 13 files changed, 49 insertions(+), 121 deletions(-)

-- 
2.34.1

