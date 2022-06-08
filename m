Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE75438C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245367AbiFHQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245340AbiFHQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:20:27 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF23D1D2;
        Wed,  8 Jun 2022 09:20:25 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id 3B22C625BA;
        Wed,  8 Jun 2022 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1654704730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vcRXrkxmByG59E3QuDmo3RcMks52bHHiQMdDLjicSqU=;
        b=b0j9rveDPlkXL3I1zkUEsw2Tzqx4iWa9VTtQYFTS1cSlKV4VPHFqbgSLxAn6XxrMEZ+C8r
        IG/2t4zP85mDpIafl/rgL7WG+A53j1yiFQjCH4yHEgLwD+JyGQIkeZZ5MWJFoXJF1PTxEg
        Rc53GeUTLS+GPyJLK5fHUuNtKS+QG7E=
Received: from frank-G5.. (fttx-pool-80.245.76.43.bambit.de [80.245.76.43])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 3E67E10021A;
        Wed,  8 Jun 2022 16:12:09 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 0/2] Support RTC on BPI-R2 Pro
Date:   Wed,  8 Jun 2022 18:11:47 +0200
Message-Id: <20220608161150.58919-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 22b3b44b-de0c-442e-8bb0-8b92e72ec305
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This series is updating hym8563 rtc driver and add devicetree nodes
for Bananapi R2 Pro board.

Frank Wunderlich (1):
  arm64: dts: rockchip: add RTC to BPI-R2 Pro

Peter Geis (1):
  rtc: hym8563: try multiple times to init device

 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 23 +++++++++++++++++++
 drivers/rtc/rtc-hym8563.c                     | 11 +++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.34.1

