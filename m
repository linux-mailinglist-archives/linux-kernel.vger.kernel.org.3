Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F974E4770
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiCVU0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiCVU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:26:18 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5266604
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:24:49 -0700 (PDT)
Received: from dslb-178-004-174-067.178.004.pools.vodafone-ip.de ([178.4.174.67] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWl3b-0006W7-IT; Tue, 22 Mar 2022 21:24:43 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] staging: r8188eu: simple mlme cleanups
Date:   Tue, 22 Mar 2022 21:24:35 +0100
Message-Id: <20220322202439.157999-1-martin@kaiser.cx>
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

some simple cleanups in the mlme part of the driver

Martin Kaiser (4):
  staging: r8188eu: make _rtw_init_mlme_priv static
  staging: r8188eu: the MCS_rate_2R array is not used
  staging: r8188eu: remove empty rtw_dummy_event_callback
  staging: r8188eu: remove empty rtw_fwdbg_event_callback

 drivers/staging/r8188eu/core/rtw_mlme.c        | 11 +----------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    |  1 -
 drivers/staging/r8188eu/include/rtw_mlme.h     |  2 --
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  9 +++------
 4 files changed, 4 insertions(+), 19 deletions(-)

-- 
2.30.2

