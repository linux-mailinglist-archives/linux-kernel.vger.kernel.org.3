Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7F488399
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiAHMuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiAHMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:18 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F5C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:17 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAg-0005EJ-JJ; Sat, 08 Jan 2022 13:50:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/12] staging: r8188eu: another round of cleanups
Date:   Sat,  8 Jan 2022 13:49:47 +0100
Message-Id: <20220108124959.313215-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another set with simple cleanups in several places.

Tested with Edimax V2 on an arm32 embedded system, using staging-testing
plus the recent patchsets by Michael and Phil.

Martin Kaiser (12):
  staging: r8188eu: ODM_MAC_EDCA_TURBO is always set
  staging: r8188eu: ODM_BB_FA_CNT is always set
  staging: r8188eu: ODM_BB_CCK_PD is always set
  staging: r8188eu: remove unused chip type settings
  staging: r8188eu: remove obsolete defines and comments
  staging: r8188eu: CurrentBW4024GTxPwrIdx is set but not used
  staging: r8188eu: CurrentBW2024GTxPwrIdx is set but not used
  staging: r8188eu: CurrentOfdm24GTxPwrIdx is set but not used
  staging: r8188eu: CurrentCckTxPwrIdx is set but not used
  staging: r8188eu: HW_VAR_MEDIA_STATUS1 is never set
  staging: r8188eu: remove HAL_*_ENABLE defines
  staging: r8188eu: we always enqueue in rtw_set_chplan_cmd

 drivers/staging/r8188eu/core/rtw_cmd.c        | 26 ++++++---------
 drivers/staging/r8188eu/hal/odm.c             | 11 -------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  5 +--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 32 -------------------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 19 -----------
 drivers/staging/r8188eu/include/HalVerDef.h   |  5 ---
 drivers/staging/r8188eu/include/hal_intf.h    |  1 -
 drivers/staging/r8188eu/include/odm.h         |  5 ---
 .../staging/r8188eu/include/rtl8188e_hal.h    |  6 ----
 drivers/staging/r8188eu/include/rtw_cmd.h     |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  2 +-
 11 files changed, 12 insertions(+), 102 deletions(-)

-- 
2.30.2

