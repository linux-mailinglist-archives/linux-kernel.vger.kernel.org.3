Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8459F6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiHXJnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiHXJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:43:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF2585AB0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=WeFPj5LWD2/pjewhCsyVVgOAVYM
        c7hNBlVKJ1ZlsHo8=; b=RorYM6DEW/UxuEun7YjENZfqtvP9DHVXJ3DN3Za1wm/
        iJ7xdax0ttTIP3BrTI7pSvkJeYkViKxaa6oz+FMnL9/mlvdCNOZmE/W89FahbAiF
        BaBBnrWpdU4q6gyFy0Qa26R8P+Jqza2NxEGuKIbjMLprRBHqdKM8NeHtBRBUGQqg
        =
Received: (qmail 2162570 invoked from network); 24 Aug 2022 11:43:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Aug 2022 11:43:34 +0200
X-UD-Smtp-Session: l3s3148p1@r5Gxg/nmSJsgAwDPXxw3AFlguiwjsjwa
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 0/3] spi: add generic R-Car Gen4 and specific r8a779f0 support
Date:   Wed, 24 Aug 2022 11:43:23 +0200
Message-Id: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the patches to enable MSIOF on R-Car S4-8. They also introduce
generic Gen4 support and move V3U to Gen4 (which it really is).

Wolfram Sang (3):
  spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
  spi: sh-msiof: add generic Gen4 binding
  spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4

 .../devicetree/bindings/spi/renesas,sh-msiof.yaml          | 7 ++++++-
 drivers/spi/spi-sh-msiof.c                                 | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.35.1

