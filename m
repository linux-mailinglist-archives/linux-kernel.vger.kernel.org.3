Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88F0471C66
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhLLS6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhLLS6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:58:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC90C061751
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:58:48 -0800 (PST)
Received: from dslb-188-104-058-180.188.104.pools.vodafone-ip.de ([188.104.58.180] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mwU3W-0001zY-KP; Sun, 12 Dec 2021 19:58:42 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/3] staging: r8188eu: remove hal sreset
Date:   Sun, 12 Dec 2021 19:58:30 +0100
Message-Id: <20211212185833.22000-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set moves two simple functions out of the hal layer into
the place where they are used. Since we support only a single chipset
in this driver, there's no need to go through the hal layer for such
simple functions.

Martin Kaiser (3):
  staging: r8188eu: move xmit status check from hal to rtw_cmd
  staging: r8188eu: move linked status check from hal to rtw_mlme_ext
  staging: r8188eu: clean up rtl8188e_sreset_linked_status_check

 drivers/staging/r8188eu/Makefile              |  1 -
 drivers/staging/r8188eu/core/rtw_cmd.c        | 13 ++++++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 18 ++++++++-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c | 37 -------------------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  1 -
 .../staging/r8188eu/include/rtl8188e_sreset.h | 13 -------
 6 files changed, 29 insertions(+), 54 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_sreset.c
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_sreset.h

-- 
2.20.1

