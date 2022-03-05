Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283A84CE679
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiCESzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 13:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCESy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 13:54:56 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB81D451D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 10:54:06 -0800 (PST)
Received: from dslb-084-059-247-134.084.059.pools.vodafone-ip.de ([84.59.247.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nQZXT-00016k-Eq; Sat, 05 Mar 2022 19:53:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/6] staging: r8188eu: some rx cleanups
Date:   Sat,  5 Mar 2022 19:53:45 +0100
Message-Id: <20220305185351.1409232-1-martin@kaiser.cx>
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

Martin Kaiser (6):
  staging: r8188eu: remove unnecessary initializations
  staging: r8188eu: remove three unused receive defines
  staging: r8188eu: remove unused function prototype
  staging: r8188eu: make rtl8188e_process_phy_info static
  staging: r8188eu: remove some unused local ieee80211 macros
  staging: r8188eu: remove local BIT macro

 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  6 +---
 .../staging/r8188eu/include/rtl8188e_recv.h   |  6 ----
 drivers/staging/r8188eu/include/wifi.h        | 34 +------------------
 3 files changed, 2 insertions(+), 44 deletions(-)

-- 
2.30.2

