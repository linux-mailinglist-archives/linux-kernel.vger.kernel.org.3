Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFE52788B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbiEOPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiEOPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:54:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB6612D18
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:54:13 -0700 (PDT)
Received: from dslb-188-096-141-066.188.096.pools.vodafone-ip.de ([188.96.141.66] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nqGZJ-0006NT-9L; Sun, 15 May 2022 17:54:05 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/5] staging: r8188eu: another set of small fixes
Date:   Sun, 15 May 2022 17:53:56 +0200
Message-Id: <20220515155401.352742-1-martin@kaiser.cx>
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

A couple of simple fixes in several places.

Martin Kaiser (5):
  staging: r8188eu: use ieee80211 helper to check for beacon
  staging: r8188eu: remove obsolete comments
  staging: r8188eu: simplify error handling in recv_func_prehandle
  staging: r8188eu: last_rx_mgnt_pkts is set but not used
  staging: r8188eu: assoc_rsp and assoc_rsp_len are not used

 drivers/staging/r8188eu/core/rtw_mlme.c       |  1 -
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  6 -----
 drivers/staging/r8188eu/core/rtw_recv.c       |  5 +----
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    | 22 -------------------
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  4 +---
 drivers/staging/r8188eu/include/rtw_mlme.h    |  2 --
 drivers/staging/r8188eu/include/sta_info.h    |  2 --
 7 files changed, 2 insertions(+), 40 deletions(-)

-- 
2.30.2

