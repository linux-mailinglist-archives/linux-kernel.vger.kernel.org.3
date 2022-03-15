Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953A24DA43B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351818AbiCOUwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351795AbiCOUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:52:12 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC11054BE8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:50:59 -0700 (PDT)
Received: from ipservice-092-217-079-029.092.217.pools.vodafone-ip.de ([92.217.79.29] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nUE86-00084h-Hd; Tue, 15 Mar 2022 21:50:54 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/6] staging: r8188eu: some rx cleanups
Date:   Tue, 15 Mar 2022 21:50:35 +0100
Message-Id: <20220315205041.2714168-1-martin@kaiser.cx>
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

Here's another set with simple cleanups in the code for receiving frames.

v2 fixes a build error on 64-bit systems in the last patch.

Martin Kaiser (6):
  staging: r8188eu: remove unnecessary initializations
  staging: r8188eu: remove three unused receive defines
  staging: r8188eu: remove unused function prototype
  staging: r8188eu: make rtl8188e_process_phy_info static
  staging: r8188eu: remove some unused local ieee80211 macros
  staging: r8188eu: remove local BIT macro

 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  6 +---
 .../staging/r8188eu/include/rtl8188e_recv.h   |  6 ----
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 +-
 drivers/staging/r8188eu/include/wifi.h        | 34 +------------------
 4 files changed, 3 insertions(+), 45 deletions(-)

-- 
2.30.2

