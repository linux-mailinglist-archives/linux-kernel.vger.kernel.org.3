Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6B4AB11D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbiBFR7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiBFR7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:59:37 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56350C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:59:37 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGloz-0002n8-6R; Sun, 06 Feb 2022 18:59:33 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/5] staging: r8188eu: clean up struct dvobj_priv
Date:   Sun,  6 Feb 2022 18:59:20 +0100
Message-Id: <20220206175925.461426-1-martin@kaiser.cx>
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

Remove unused or unnecessary components from struct dvobj_priv.

Martin Kaiser (5):
  staging: r8188eu: usb_vendor_req_mutex is not used
  staging: r8188eu: dvobj_priv's signal_strength is not used
  staging: r8188eu: RegUsbSS is not used
  staging: r8188eu: usb_suspend_sema is initialised but not used
  staging: r8188eu: remove ishighspeed from dvobj_priv

 drivers/staging/r8188eu/core/rtw_iol.c      | 4 +++-
 drivers/staging/r8188eu/hal/usb_halinit.c   | 4 ++--
 drivers/staging/r8188eu/include/drv_types.h | 5 -----
 drivers/staging/r8188eu/include/usb_ops.h   | 2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 9 ---------
 5 files changed, 6 insertions(+), 18 deletions(-)

-- 
2.30.2

