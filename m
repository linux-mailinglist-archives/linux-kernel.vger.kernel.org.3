Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257D84B82CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiBPIRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:17:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiBPIRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:17:21 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB2913CFB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:17:09 -0800 (PST)
Received: from dslb-188-097-046-221.188.097.pools.vodafone-ip.de ([188.97.46.221] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nKFUm-0008Pc-6b; Wed, 16 Feb 2022 09:17:04 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/3] staging: r8188eu: three trivial cleanups
Date:   Wed, 16 Feb 2022 09:16:54 +0100
Message-Id: <20220216081657.622467-1-martin@kaiser.cx>
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

This set removes an unused struct and two unused variables.

Martin Kaiser (3):
  staging: r8188eu: evt_allocated_buf is not used
  staging: r8188eu: evt_done_cnt is set but not used
  staging: r8188eu: struct usb_suspend_parm is not used

 drivers/staging/r8188eu/core/rtw_cmd.c      |  1 -
 drivers/staging/r8188eu/core/rtw_mlme_ext.c |  2 --
 drivers/staging/r8188eu/include/rtw_cmd.h   | 14 --------------
 3 files changed, 17 deletions(-)

-- 
2.30.2

