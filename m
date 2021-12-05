Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8F468B9D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhLEPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhLEPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:16:37 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5569C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:13:09 -0800 (PST)
Received: from dslb-188-097-212-203.188.097.pools.vodafone-ip.de ([188.97.212.203] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mttCL-0007gF-4U; Sun, 05 Dec 2021 16:13:05 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/10] staging: r8188eu: some more cleanups
Date:   Sun,  5 Dec 2021 16:12:41 +0100
Message-Id: <20211205151251.6861-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another patch set with simple cleanups in different parts
of the driver.

Martin Kaiser (10):
  staging: r8188eu: bLedOpenDrain is always true for r8188eu
  staging: r8188eu: remove a bunch of unused led defines
  staging: r8188eu: remove two unused macros
  staging: r8188eu: bHWPowerdown is set but not used
  staging: r8188eu: remove unused macros from drv_types.h
  staging: r8188eu: hal data's interfaceIndex is never read
  staging: r8188eu: remove empty HAL_INIT_PROFILE_TAG macro
  staging: r8188eu: remove two write-only wifi direct variables
  staging: r8188eu: remove unused define
  staging: r8188eu: AntCombination is always 2

 drivers/staging/r8188eu/core/rtw_p2p.c        |  3 --
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    | 41 ++++---------------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 10 +----
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   | 16 +++-----
 drivers/staging/r8188eu/hal/usb_halinit.c     | 28 -------------
 drivers/staging/r8188eu/include/drv_types.h   |  6 ---
 .../staging/r8188eu/include/osdep_service.h   | 18 --------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  5 ---
 drivers/staging/r8188eu/include/rtw_led.h     | 32 ---------------
 drivers/staging/r8188eu/include/rtw_mlme.h    | 12 ------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  2 -
 12 files changed, 15 insertions(+), 159 deletions(-)

-- 
2.20.1

