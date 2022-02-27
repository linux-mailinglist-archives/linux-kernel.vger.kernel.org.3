Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692464C5D88
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiB0Qmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiB0Qmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:42:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2640E7B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 08:42:11 -0800 (PST)
Received: from ipservice-092-217-088-081.092.217.pools.vodafone-ip.de ([92.217.88.81] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nOMcY-0005Z9-4F; Sun, 27 Feb 2022 17:42:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/8] staging: r8188eu: use ieee80211 defines and helpers
Date:   Sun, 27 Feb 2022 17:41:39 +0100
Message-Id: <20220227164147.1168847-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218135038.908307-1-martin@kaiser.cx>
References: <20220218135038.908307-1-martin@kaiser.cx>
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

Start using some defines and helper functions from
include/linux/ieee80211.h for parsing frame data.

v2:
 - resend the previous set, it seems that it slipped through the cracks
 - add some more patches to replace driver-specific macros with
   ieee80211 macros

Martin Kaiser (8):
  staging: r8188eu: use ieee80211 define for management frame type
  staging: r8188eu: use ieee80211 helpers to check the frame type
  staging: r8188eu: refactor validate_recv_frame's error handling
  staging: r8188eu: use ieee80211 helper for qos bit
  staging: r8188eu: use ieee80211 helper to check for more fragments
  staging: r8188eu: use ieee80211 helper to read "more data"
  staging: r8188eu: use ieee80211 helper to read the protected bit
  staging: r8188eu: use ieee80211 helper to read the "order" bit

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  3 +-
 drivers/staging/r8188eu/core/rtw_recv.c       | 48 +++++++------------
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  2 +-
 drivers/staging/r8188eu/include/rtw_recv.h    |  2 +-
 drivers/staging/r8188eu/include/wifi.h        | 32 +++++--------
 5 files changed, 33 insertions(+), 54 deletions(-)

-- 
2.30.2

