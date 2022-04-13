Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF74FFF69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiDMTkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiDMTkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:40:02 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A7076659
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:37:40 -0700 (PDT)
Received: from dslb-178-004-174-121.178.004.pools.vodafone-ip.de ([178.4.174.121] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1neio3-0005fr-8s; Wed, 13 Apr 2022 21:37:35 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/8] staging: r8188eu: clean up rtw_pwr_wakeup
Date:   Wed, 13 Apr 2022 21:36:46 +0200
Message-Id: <20220413193654.258507-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409151557.207980-1-martin@kaiser.cx>
References: <20220409151557.207980-1-martin@kaiser.cx>
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

v2:
 - drop the "don't set _SUCCESS again" patch
 - add another patch to remove unused timer functions

Martin Kaiser (8):
  staging: r8188eu: simplify delay conditions in rtw_pwr_wakeup
  staging: r8188eu: make return values consistent
  staging: r8188eu: simplify the ps_processing check
  staging: r8188eu: summarize two if statements
  staging: r8188eu: use kernel functions for timeout handling
  staging: r8188eu: clean up the code to set ips_deny_time
  staging: r8188eu: remove the bInSuspend loop
  staging: r8188eu: remove unused timer functions

 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 44 ++++++-------------
 .../staging/r8188eu/include/osdep_service.h   |  4 --
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 +-
 .../staging/r8188eu/os_dep/osdep_service.c    | 16 -------
 4 files changed, 14 insertions(+), 52 deletions(-)

-- 
2.30.2

