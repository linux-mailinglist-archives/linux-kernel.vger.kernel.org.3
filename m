Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4474E31DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353380AbiCUUf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347272AbiCUUfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:35:24 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617323E0EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:33:58 -0700 (PDT)
Received: from dslb-094-219-034-255.094.219.pools.vodafone-ip.de ([94.219.34.255] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWOiv-0003ce-BX; Mon, 21 Mar 2022 21:33:53 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/6] staging: r8188eu: clean up odm dynamic functions
Date:   Mon, 21 Mar 2022 21:30:25 +0100
Message-Id: <20220321203031.143486-1-martin@kaiser.cx>
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

Simplify the code for odm dynamic functions. Remove unused capabilities
and intermediate steps.

This should be applied after the "remove local BIT macro" patch.

Martin Kaiser (6):
  staging: r8188eu: remove two limit defines
  staging: r8188eu: remove unused defines for dynamic functions
  staging: r8188eu: DYNAMIC_BB_DYNAMIC_TXPWR is not used
  staging: r8188eu: DYNAMIC_BB_ANT_DIV is not used
  staging: r8188eu: DYNAMIC_RF_CALIBRATION is not used
  staging: r8188eu: refactor dm func set and clear

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  6 ++---
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 12 ---------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 16 +++---------
 drivers/staging/r8188eu/include/hal_intf.h    |  2 +-
 .../staging/r8188eu/include/rtw_mlme_ext.h    | 25 -------------------
 5 files changed, 7 insertions(+), 54 deletions(-)

-- 
2.30.2

