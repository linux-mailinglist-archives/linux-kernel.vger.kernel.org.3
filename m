Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717BA4AB09D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbiBFQS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiBFQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:18:24 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCDC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:18:21 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGkEy-0001bS-E4; Sun, 06 Feb 2022 17:18:16 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/14] staging: r8188eu: another set of simple cleanups
Date:   Sun,  6 Feb 2022 17:17:55 +0100
Message-Id: <20220206161809.423031-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another set of simple cleanups in several parts of the driver.

Please apply this on top of my previous series (staging: r8188eu: more
rf cleanups).

Tested with EdimaxV2 on an arm32 embedded system.

Martin Kaiser (14):
  staging: r8188eu: only OFDM_index_old[0] is used
  staging: r8188eu: only OFDM_index[0] is used
  staging: r8188eu: replace local OFDM_index with single variable
  staging: r8188eu: remove debug code to bypass LC calibration
  staging: r8188eu: remove debug code to bypass IQ calibration
  staging: r8188eu: move local definitions into rtw_fw.h
  staging: r8188eu: remove unused enum _IFACE_TYPE
  staging: r8188eu: remove unused enum _ADAPTER_TYPE
  staging: r8188eu: remove the global DriverState
  staging: r8188eu: remove unused struct adapter components
  staging: r8188eu: in_cta_test is always 0
  staging: r8188eu: irq_alloc is not used
  staging: r8188eu: not_indic_disco is unused
  staging: r8188eu: remove unused struct hostapd_priv

 drivers/staging/r8188eu/core/rtw_fw.c        | 45 ++++++++++++++++++++
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 30 +++++--------
 drivers/staging/r8188eu/hal/usb_halinit.c    | 16 +------
 drivers/staging/r8188eu/include/drv_types.h  | 36 ----------------
 drivers/staging/r8188eu/include/odm.h        |  2 +-
 drivers/staging/r8188eu/include/rtw_fw.h     | 45 --------------------
 drivers/staging/r8188eu/include/rtw_mlme.h   |  5 ---
 drivers/staging/r8188eu/os_dep/usb_intf.c    |  8 ++--
 8 files changed, 61 insertions(+), 126 deletions(-)

-- 
2.30.2

