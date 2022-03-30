Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCDD4ECDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiC3UOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiC3UOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:14:11 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2A06623A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:12:25 -0700 (PDT)
Received: from dslb-178-004-172-185.178.004.pools.vodafone-ip.de ([178.4.172.185] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nZefx-0007FS-5x; Wed, 30 Mar 2022 22:12:17 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/2] staging: r8188eu: remove debug code for dumping packets
Date:   Wed, 30 Mar 2022 22:12:08 +0200
Message-Id: <20220330201210.175941-1-martin@kaiser.cx>
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

Remove the remains of debug code to print incoming and outgoing packets.

Martin Kaiser (2):
  staging: r8188eu: remove the "dump rx packet" fragments
  staging: r8188eu: remove the "dump tx packet" fragments

 drivers/staging/r8188eu/core/rtw_recv.c        |  4 ----
 drivers/staging/r8188eu/hal/usb_halinit.c      | 12 ------------
 drivers/staging/r8188eu/include/hal_intf.h     |  2 --
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  3 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c   |  7 -------
 5 files changed, 28 deletions(-)

-- 
2.30.2

