Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA7C4BBA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiBRNvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:51:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiBRNvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:51:10 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD242557B6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:50:53 -0800 (PST)
Received: from dslb-178-004-174-047.178.004.pools.vodafone-ip.de ([178.4.174.47] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nL3eq-0007eo-UG; Fri, 18 Feb 2022 14:50:48 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] staging: r8188eu: use ieee80211 defines and helpers
Date:   Fri, 18 Feb 2022 14:50:34 +0100
Message-Id: <20220218135038.908307-1-martin@kaiser.cx>
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

Start using some defines and helper functions from
include/linux/ieee80211.h for parsing frame data.

Yet again, this is testing the water. I'd appreciate feedback if this
approach makes sense. If so, there's lots of other places that can be
converted.

Martin Kaiser (4):
  staging: r8188eu: use ieee80211 define for management frame type
  staging: r8188eu: use ieee80211 helpers to check the frame type
  staging: r8188eu: refactor validate_recv_frame's error handling
  staging: r8188eu: use ieee80211 helper for qos bit

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  3 +-
 drivers/staging/r8188eu/core/rtw_recv.c       | 40 ++++++-------------
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  2 +-
 drivers/staging/r8188eu/include/rtw_recv.h    |  2 +-
 drivers/staging/r8188eu/include/wifi.h        | 25 ++++++------
 5 files changed, 29 insertions(+), 43 deletions(-)

-- 
2.30.2

