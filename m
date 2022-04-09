Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686484FA92E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbiDIPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbiDIPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:18:17 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76F1AF11
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:16:07 -0700 (PDT)
Received: from ipservice-092-217-091-111.092.217.pools.vodafone-ip.de ([92.217.91.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ndCol-0005k2-40; Sat, 09 Apr 2022 17:16:03 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/8] staging: r8188eu: clean up rtw_pwr_wakeup
Date:   Sat,  9 Apr 2022 17:15:49 +0200
Message-Id: <20220409151557.207980-1-martin@kaiser.cx>
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

Clean up the rtw_pwr_wakeup function. Use in-kernel routines for
handling timeouts.

Martin Kaiser (8):
  staging: r8188eu: simplify delay conditions in rtw_pwr_wakeup
  staging: r8188eu: don't set _SUCCESS again
  staging: r8188eu: make return values consistent
  staging: r8188eu: simplify the ps_processing check
  staging: r8188eu: summarize two if statements
  staging: r8188eu: use kernel functions for timeout handling
  staging: r8188eu: clean up the code to set ips_deny_time
  staging: r8188eu: remove the bInSuspend loop

 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 48 ++++++-------------
 .../staging/r8188eu/include/osdep_service.h   |  1 -
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |  5 --
 4 files changed, 15 insertions(+), 41 deletions(-)

-- 
2.30.2

