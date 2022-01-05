Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCBF484F64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbiAEIem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiAEIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:34:42 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C763C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 00:34:41 -0800 (PST)
Received: from dslb-188-097-046-135.188.097.pools.vodafone-ip.de ([188.97.46.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n51kg-0005mc-T2; Wed, 05 Jan 2022 09:34:34 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/7] staging: r8188eu: clean up tx power arrays
Date:   Wed,  5 Jan 2022 09:34:19 +0100
Message-Id: <20220105083426.177128-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set removes unused tx power arrays and changes some other arrays from
multidimensional to one-dimensional.

Martin Kaiser (7):
  staging: r8188eu: rfPath is always 0
  staging: r8188eu: make Index24G_CCK_Base a 1-D array
  staging: r8188eu: make Index24G_BW40_Base a 1-D array
  staging: r8188eu: CCK_24G_Diff is set but not used
  staging: r8188eu: BW40_24G_Diff is set but not used
  staging: r8188eu: make OFDM_24G_Diff a 1-D array
  staging: r8188eu: make BW20_24G_Diff a 1-D array

 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 25 ++++++++-----------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 12 ++++-----
 .../staging/r8188eu/include/rtl8188e_hal.h    | 10 +++-----
 3 files changed, 20 insertions(+), 27 deletions(-)

-- 
2.30.2

