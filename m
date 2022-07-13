Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A45733C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiGMKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiGMKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:06:19 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2DDAB86
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=OFtpbHyPxPsBorl70r188hepc7O
        Li4w0ef89SaUq7CI=; b=1hrGRpKahehHPT1CueheTInAqe/tt6vqLN8aQkzirdN
        rWiLp78tETZecuMbydhDQQ10VvfcMV1dsN1sfJWd8Nil2hiL0CWPvnE8EaWrjkvV
        MegpmNUXMq50EouLVzBVG5tUV6JNY2shTmi3KgdR5050Q2B+Cd/djLcrbYJKaeIQ
        =
Received: (qmail 123341 invoked from network); 13 Jul 2022 12:06:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 12:06:13 +0200
X-UD-Smtp-Session: l3s3148p1@1rUt76zjzLwgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clocksource: sh_cmt: add Gen4 and r8a779f0 support
Date:   Wed, 13 Jul 2022 12:06:00 +0200
Message-Id: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three patches update the bindings and the CMT driver for Renesas
R-Car Gen4 and the r8a779f0 SoC.

Wolfram Sang (3):
  dt-bindings: timer: renesas,cmt: Add r8a779f0 and generic Gen4 CMT
    support
  dt-bindings: timer: renesas,cmt: R-Car V3U is R-Car Gen4
  clocksource/drivers/sh_cmt: Add R-Car Gen4 support

 .../devicetree/bindings/timer/renesas,cmt.yaml     | 14 ++++++++++++--
 drivers/clocksource/sh_cmt.c                       |  8 ++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.35.1

