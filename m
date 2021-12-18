Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6F9479AA4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhLRMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhLRMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:04:39 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591C1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 04:04:39 -0800 (PST)
Received: from dslb-178-004-169-039.178.004.pools.vodafone-ip.de ([178.4.169.39] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1myYS1-0008I6-F3; Sat, 18 Dec 2021 13:04:33 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/9] staging: r8188: another round a cleanups
Date:   Sat, 18 Dec 2021 13:04:14 +0100
Message-Id: <20211218120423.29906-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another set with minor cleanups in several parts of the driver.

As usual, this was tested with an Edimax V2 on an arm32 embedded system.

Martin Kaiser (9):
  staging: r8188: make rx signal strength function static
  staging: r8188: remove the dummy ioctl handler
  staging: r8188: antAveRSSI is set but not used
  staging: r8188: antRSSIcnt is set but not used
  staging: r8188: antSumRSSI is set but not used
  staging: r8188: Bssid in struct fast_ant_train is set but not used
  staging: r8188: remove unused odm capabilities
  staging: r8188: ODM_BB_DIG is always set
  staging: r8188: ODM_BB_RA_MASK is always set

 drivers/staging/r8188eu/core/rtw_mlme_ext.c  |  5 ++---
 drivers/staging/r8188eu/hal/odm.c            |  5 +----
 drivers/staging/r8188eu/hal/odm_HWConfig.c   |  2 --
 drivers/staging/r8188eu/hal/odm_RTL8188E.c   |  8 +-------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c    |  6 +-----
 drivers/staging/r8188eu/include/odm.h        | 14 --------------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 17 -----------------
 7 files changed, 5 insertions(+), 52 deletions(-)

-- 
2.20.1

