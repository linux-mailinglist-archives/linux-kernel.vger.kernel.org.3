Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56604898D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbiAJMqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiAJMqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:46:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62EEC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:46:50 -0800 (PST)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6u4T-0007Td-PB; Mon, 10 Jan 2022 13:46:45 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/9] staging: r8188eu: clean up odm phy functions
Date:   Mon, 10 Jan 2022 13:46:29 +0100
Message-Id: <20220110124638.6909-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set cleans up the error handling for some of the odm phy functions
and merges small functions. While at it, it also removes a couple of
unused defines.

Martin Kaiser (9):
  staging: r8188eu: fix phy_RF6052_Config_ParaFile error handling
  staging: r8188eu: remove a constant variable
  staging: r8188eu: remove unused function parameter
  staging: r8188eu: remove constant function parameter
  staging: r8188eu: replace the READ_AND_CONFIG
  staging: r8188eu: relay errors from ODM_ReadAndConfig_...
  staging: r8188eu: merge ODM_ConfigMACWithHeaderFile into
    PHY_MACConfig8188E
  staging: r8188eu: remove unused cck, ofdm and mcs rate defines
  staging: r8188eu: merge ODM_ConfigBBWithHeaderFile with its callers

 drivers/staging/r8188eu/hal/odm_HWConfig.c    | 34 +---------------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 10 ++---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 11 +-----
 .../staging/r8188eu/include/odm_HWConfig.h    | 39 +------------------
 4 files changed, 9 insertions(+), 85 deletions(-)

-- 
2.30.2

