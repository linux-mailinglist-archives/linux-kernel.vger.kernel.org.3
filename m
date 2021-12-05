Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A70B468BA8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhLEPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhLEPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:16:46 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8669C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:13:19 -0800 (PST)
Received: from dslb-188-097-212-203.188.097.pools.vodafone-ip.de ([188.97.212.203] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mttCU-0007gF-Ci; Sun, 05 Dec 2021 16:13:14 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/10] staging: r8188eu: remove unused define
Date:   Sun,  5 Dec 2021 16:12:50 +0100
Message-Id: <20211205151251.6861-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211205151251.6861-1-martin@kaiser.cx>
References: <20211205151251.6861-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the _IOCTL_LINUX_C_ define, which is not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 56adfe4087a8..77728ba78d76 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2012 Realtek Corporation. */
 
-#define _IOCTL_LINUX_C_
-
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/wlan_bssdef.h"
-- 
2.20.1

