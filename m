Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E774559C9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiHVUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiHVUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:13:46 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D831DA1BB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:13:45 -0700 (PDT)
Received: from dslb-188-096-142-076.188.096.pools.vodafone-ip.de ([188.96.142.76] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oQDnn-0000pA-SX; Mon, 22 Aug 2022 22:13:39 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/3] staging: r8188eu: start cleaning up led blinking
Date:   Mon, 22 Aug 2022 22:13:26 +0200
Message-Id: <20220822201329.95559-1-martin@kaiser.cx>
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

The code for led blinking contains too many states and state variables.
This series is a first tiny step towards cleaning things up.

Martin Kaiser (3):
  staging: r8188eu: don't restart "no link" blinking unnecessarily
  staging: r8188eu: always cancel blink_work
  staging: r8188eu: always update the status variables

 drivers/staging/r8188eu/core/rtw_led.c | 36 ++++++++++++--------------
 1 file changed, 17 insertions(+), 19 deletions(-)

-- 
2.30.2

