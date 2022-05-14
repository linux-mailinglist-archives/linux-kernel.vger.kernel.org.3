Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB652731C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiENQsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiENQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:47:53 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A6032060
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:47:52 -0700 (PDT)
Received: from dslb-188-097-047-153.188.097.pools.vodafone-ip.de ([188.97.47.153] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1npuvh-0003kw-Qd; Sat, 14 May 2022 18:47:45 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/7] staging: r8188eu: more cleanups in OnAction_back
Date:   Sat, 14 May 2022 18:47:33 +0200
Message-Id: <20220514164740.282552-1-martin@kaiser.cx>
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

Simplify some more places where fields are extracted from an incoming
block ack frame.

This series should be applied after the "start cleaning up OnAction_back"
series.

Martin Kaiser (7):
  staging: r8188eu: get addba resp status from ieee80211_mgmt
  staging: r8188eu: read addba resp tid from ieee80211_mgmt
  staging: r8188eu: merge process_addba_req into OnAction_back
  staging: r8188eu: replace if with ternary operator
  staging: r8188eu: use BIT(tid) instead of manual shift
  staging: r8188eu: check for initiator vs recipient
  staging: r8188eu: use the tid in delba processing

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 36 ++++++++++---------
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 22 ------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 --
 3 files changed, 20 insertions(+), 40 deletions(-)

-- 
2.30.2

