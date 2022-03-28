Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5826A4E8BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiC1CHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiC1CHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:07:36 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F175DF1B;
        Sun, 27 Mar 2022 19:05:56 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Mar 2022 11:05:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2AE5C2058B50;
        Mon, 28 Mar 2022 11:05:56 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 28 Mar 2022 11:05:56 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D3828B62B7;
        Mon, 28 Mar 2022 11:05:55 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/3] dt-bindings: phy: Fix uniphier descriptions
Date:   Mon, 28 Mar 2022 11:05:49 +0900
Message-Id: <1648433152-23126-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes dt-schema descriptions for USB2, USB3, and AHCI PHYs
implemented in UniPhier SoCs.

Kunihiko Hayashi (3):
  dt-bindings: phy: uniphier-usb2: Add vbus-supply
  dt-bindings: phy: uniphier-usb3ss: Treat vbus-supply as optional
  dt-bindings: phy: uniphier-ahci: Fix missing reset-names

 .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml   | 3 ++-
 .../devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml   | 3 +++
 .../devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml | 3 +--
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.25.1

