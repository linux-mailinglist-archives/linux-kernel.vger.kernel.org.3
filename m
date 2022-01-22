Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EA4496D01
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 18:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiAVRGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 12:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiAVRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:06:02 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531D8C06173D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 09:06:02 -0800 (PST)
Received: from dslb-188-097-041-028.188.097.pools.vodafone-ip.de ([188.97.41.28] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nBJpr-0002IN-Bi; Sat, 22 Jan 2022 18:05:55 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] staging: r8188eu: some more odm cleanup
Date:   Sat, 22 Jan 2022 18:05:43 +0100
Message-Id: <20220122170547.68378-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some flags in the odm layer which are always set.
Remove an unused variable and merge two small functions.

Martin Kaiser (4):
  staging: r8188eu: EntryMaxUndecoratedSmoothedPWDB is set but not used
  staging: r8188eu: ODM_RF_TX_PWR_TRACK is always set
  staging: r8188eu: ODM_RF_CALIBRATION is always set
  staging: r8188eu: merge Init_ODM_ComInfo_88E and rtl8188e_init_dm_priv

 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  5 ---
 drivers/staging/r8188eu/hal/odm.c             |  8 -----
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 32 ++++---------------
 drivers/staging/r8188eu/include/odm.h         |  4 ---
 drivers/staging/r8188eu/include/rtl8188e_dm.h |  3 +-
 5 files changed, 8 insertions(+), 44 deletions(-)

-- 
2.30.2

