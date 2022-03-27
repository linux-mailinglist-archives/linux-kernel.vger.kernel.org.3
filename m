Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F004E8948
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiC0SLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiC0SLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:11:46 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D571134BB2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:10:01 -0700 (PDT)
Received: from dslb-178-004-173-219.178.004.pools.vodafone-ip.de ([178.4.173.219] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nYXKt-00019B-AW; Sun, 27 Mar 2022 20:09:55 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/9] staging: r8188eu: use ieee80211 helpers for parsing
Date:   Sun, 27 Mar 2022 20:09:35 +0200
Message-Id: <20220327180944.712545-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220323074859.177425-1-martin@kaiser.cx>
References: <20220323074859.177425-1-martin@kaiser.cx>
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

Update some of the code for parsing incoming messages to use
the ieee80211 helpers.

v2:
 - fix an endianness issue in the version check patch
 - add two more patches for validate_recv_frame, use a struct ieee80211_hdr
   instead of a frame control variable in this function

Martin Kaiser (9):
  staging: r8188eu: use ieee80211 define for version check
  staging: r8188eu: use ieee80211 helper to read the pwr bit
  staging: r8188eu: use standard mechanisms for control frames
  staging: r8188eu: use standard mechanisms for data frames
  staging: r8188eu: use standard mechanisms for qos data frames
  staging: r8188eu: remove unused data frame subtypes
  staging: r8188eu: remove unused control frame subtypes
  staging: r8188eu: use ieee80211 macro for sequence number
  staging: r8188eu: use ieee80211 define for fragment number

 drivers/staging/r8188eu/core/rtw_recv.c       | 40 +++++++++---------
 drivers/staging/r8188eu/core/rtw_xmit.c       |  6 +--
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  3 +-
 drivers/staging/r8188eu/include/wifi.h        | 42 ++++---------------
 4 files changed, 32 insertions(+), 59 deletions(-)

-- 
2.30.2

