Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0904A4FA984
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbiDIQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241416AbiDIQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:34:29 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FB23EC77
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:32:20 -0700 (PDT)
Received: from ipservice-092-217-091-111.092.217.pools.vodafone-ip.de ([92.217.91.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ndE0W-0006Rg-G6; Sat, 09 Apr 2022 18:32:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/10] staging: r8188eu: use standard timer functions
Date:   Sat,  9 Apr 2022 18:32:02 +0200
Message-Id: <20220409163212.241122-1-martin@kaiser.cx>
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

Make the driver-specific rtw_get_passing_time_ms function obsolete. Use
the stardard kernel functions for timeout handling.

Martin Kaiser (10):
  staging: r8188eu: no need for an else after return
  staging: r8188eu: remove unnecessary rtw_get_passing_time_ms call
  staging: r8188eu: summarize two if statements
  staging: r8188eu: improve timeout handling in
    rtl8188e_firmware_download
  staging: r8188eu: improve timeout handling in rtw_check_join_candidate
  staging: r8188eu: make LPS_RF_ON_check static
  staging: r8188eu: improve timeout handling in LPS_RF_ON_check
  staging: r8188eu: improve timeout handling in iol_execute
  staging: r8188eu: improve timeout handling in
    efuse_read_phymap_from_txpktbuf
  staging: r8188eu: remove unused timer functions

 drivers/staging/r8188eu/core/rtw_fw.c           |  6 +++---
 drivers/staging/r8188eu/core/rtw_mlme.c         |  4 +++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c     | 11 ++---------
 drivers/staging/r8188eu/core/rtw_pwrctrl.c      |  7 +++----
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 14 ++++++--------
 drivers/staging/r8188eu/include/osdep_service.h |  3 ---
 drivers/staging/r8188eu/include/rtw_pwrctrl.h   |  1 -
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 11 -----------
 8 files changed, 17 insertions(+), 40 deletions(-)

-- 
2.30.2

