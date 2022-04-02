Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3994F00C0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354457AbiDBKp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbiDBKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:45:50 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7357289AE;
        Sat,  2 Apr 2022 03:43:53 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id 6B7CE5FED6;
        Sat,  2 Apr 2022 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1648896231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rb93FZyk5VcvUPyEKX4EHnPX+8i+oZK4NouS1CY0eCI=;
        b=qyTmWar7dxUWgSinj9fVZT4mxA+E6r8AzyoQg6qDoEnZoLk0/yW7rQ2vLVKcnJ0soQC9a1
        Sv3n6QLJN59ve4F7CB6COWBwSGlWUyT9KIGU7F8pSmQ0hOFIVOFZoMUme8AkyFYhF4Z5d8
        XAUg8pdBB/vw6L9FEOYDszI7oAo0F6E=
Received: from localhost.localdomain (fttx-pool-80.245.79.107.bambit.de [80.245.79.107])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 8191E403AC;
        Sat,  2 Apr 2022 10:43:50 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: 
Date:   Sat,  2 Apr 2022 12:43:10 +0200
Message-Id: <20220402104313.100333-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: d7b3723d-f836-4d72-a170-ec15ef3cf76e
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Subject: [PATCH v1 0/2] Change Bananapi-R2-Pro board to match V1.0

Mainline Devicetree was created for v00 prototype that was not in
public sale and only shipped to few developers. V1.0 of the board
has some changes in io-domain and gmacs are swapped.

Change mainline DTS to match the current hardware.

Frank Wunderlich (2):
  arm64: dts: rockchip: Change io-domains of bpi-r2-pro
  arm64: dts: rockchip: Add gmac1 and change network settings

 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 40 ++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

-- 
2.25.1

