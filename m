Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD77C4E4D92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiCWHuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbiCWHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:50:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614A70050
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:49:12 -0700 (PDT)
Received: from dslb-178-004-173-157.178.004.pools.vodafone-ip.de ([178.4.173.157] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWvjv-0003JV-6K; Wed, 23 Mar 2022 08:49:07 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/7] staging: r8188eu: use ieee80211 helpers for parsing
Date:   Wed, 23 Mar 2022 08:48:52 +0100
Message-Id: <20220323074859.177425-1-martin@kaiser.cx>
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

Update some of the code for parsing incoming messages to use
the ieee80211 helpers.

Martin Kaiser (7):
  staging: r8188eu: use ieee80211 define for version check
  staging: r8188eu: use ieee80211 helper to read the pwr bit
  staging: r8188eu: use standard mechanisms for control frames
  staging: r8188eu: use standard mechanisms for data frames
  staging: r8188eu: use standard mechanisms for qos data frames
  staging: r8188eu: remove unused data frame subtypes
  staging: r8188eu: remove unused control frame subtypes

 drivers/staging/r8188eu/core/rtw_recv.c       | 18 +++++-----
 drivers/staging/r8188eu/core/rtw_xmit.c       |  6 ++--
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  3 +-
 drivers/staging/r8188eu/include/wifi.h        | 36 ++++---------------
 4 files changed, 21 insertions(+), 42 deletions(-)

-- 
2.30.2

