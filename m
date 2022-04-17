Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE7550478E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 12:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiDQKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 06:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiDQKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 06:25:12 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA1286C1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 03:22:35 -0700 (PDT)
Received: from dslb-188-096-140-061.188.096.pools.vodafone-ip.de ([188.96.140.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ng230-0002FP-0d; Sun, 17 Apr 2022 12:22:26 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/6] staging: r8188eu: clean up mgt_dispatcher
Date:   Sun, 17 Apr 2022 12:22:15 +0200
Message-Id: <20220417102221.466524-1-martin@kaiser.cx>
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

Clean up the mgt_dispatcher function and remove unnecessary info from the
mlme_sta_tbl array.

Martin Kaiser (6):
  staging: r8188eu: check receiver address only once
  staging: r8188eu: replace the GetFrameSubType call
  staging: r8188eu: the frame type is shifted out
  staging: r8188eu: replace mlme_handler with function pointer
  staging: r8188eu: don't call empty DoReserved function
  staging: r8188eu: use ARRAY_SIZE for mlme_sta_tbl

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 60 ++++++++-----------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  6 +-
 2 files changed, 25 insertions(+), 41 deletions(-)

-- 
2.30.2

