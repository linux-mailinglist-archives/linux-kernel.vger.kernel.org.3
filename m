Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0390F4EBF45
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245618AbiC3K5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbiC3K5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:57:07 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB74264F6C;
        Wed, 30 Mar 2022 03:55:22 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Mar 2022 19:55:20 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 05D462058B50;
        Wed, 30 Mar 2022 19:55:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 19:55:19 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 7C28AB62B7;
        Wed, 30 Mar 2022 19:55:19 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 0/5] dt-bindings: phy: Fix uniphier descriptions
Date:   Wed, 30 Mar 2022 19:55:10 +0900
Message-Id: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes dt-schema descriptions for all PHYs implemented in
UniPhier SoCs.

Changes since v2:
- Add "Reviewed-by:" line to patch 3 and 4
- Add constraints of clocks and resets for compatible cases

Changes since v1:
- Add "Reviewed-by:" line to patch 1 and 2
- Remove result messages about unpublished nodes in patch 3
- Add patch 4 for fixing incorrect properties in ahci-phy
- Add patch 5 to rewrite properties using allOf-if-then in all phys

Kunihiko Hayashi (5):
  dt-bindings: phy: uniphier-usb2: Add vbus-supply
  dt-bindings: phy: uniphier-usb3ss: Treat vbus-supply as optional
  dt-bindings: phy: uniphier-ahci: Fix missing reset-names
  dt-bindings: phy: uniphier-usb3hs: Fix incorrect clock-names and
    reset-names
  dt-bindings: phy: uniphier: Clean up clocks, resets, and their names
    using compatible string

 .../phy/socionext,uniphier-ahci-phy.yaml      | 91 ++++++++++++-----
 .../phy/socionext,uniphier-pcie-phy.yaml      | 47 ++++++---
 .../phy/socionext,uniphier-usb2-phy.yaml      |  3 +
 .../phy/socionext,uniphier-usb3hs-phy.yaml    | 89 ++++++++++++++---
 .../phy/socionext,uniphier-usb3ss-phy.yaml    | 98 ++++++++++++++-----
 5 files changed, 257 insertions(+), 71 deletions(-)

-- 
2.25.1

