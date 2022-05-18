Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8D52B71C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiERJhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiERJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:36:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40ADB82DF;
        Wed, 18 May 2022 02:36:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 15D181F4245A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652866598;
        bh=w9vxsEMxP8ZOb1eaXm6eHhoM0t+W1qSfwTk8Rrym1/g=;
        h=From:To:Cc:Subject:Date:From;
        b=c12qUofxh1jcKvqyHR90xzkya+PqzExM/e5MgMle18x752R4y1/rC4ESRDslCQlwZ
         SwhCSmFXQ4/IqXkTyfoAxCps9XzbvmOSWc2TxvDjntf34scgiliCXPNDbjak+o9CEb
         6wSqHXthviknwmxGuCpKNpgzgxNgc7IlwYn5QU0otRY+Xrbfibs/OjVfBcT5kQ1AKv
         TyQRNpbIY1F2RntBe8d+94OCR+rlyZ5lOUrt+S7xL7VhAP1NnFz6sG3remSt0MW4Q1
         S/8Af3A6QYjs5wDyM7ZH0kQSn2G8wuUrprno3WAXk3vFM1XOoZa7xPyjdutKg99k7n
         2GTp+7ttCH+vw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 0/2] dt-bindings: arm: MediaTek: Fix clock bindings
Date:   Wed, 18 May 2022 11:36:29 +0200
Message-Id: <20220518093631.25491-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Rob Herring's review [1] on my mt6795 clocks bindings patches, for
which I've used the already upstreamed ones as a base, it was found that
these bindings have some issues.
This series is addressing the issues that were found by Rob on my series,
which are present on all of the already merged bindings.

[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220513165050.500831-5-angelogioacchino.delregno@collabora.com/#24859953

Changes in v2:
 - Squashed patches as suggested

AngeloGioacchino Del Regno (2):
  dt-bindings: arm: mtk-clock: Remove unnecessary 'items' and fix
    formatting
  dt-bindings: arm: mtk-clock: Set #clock-cells as required property

 .../arm/mediatek/mediatek,mt8186-clock.yaml   | 29 ++++-----
 .../mediatek/mediatek,mt8186-sys-clock.yaml   |  1 +
 .../arm/mediatek/mediatek,mt8192-clock.yaml   | 46 +++++++--------
 .../mediatek/mediatek,mt8192-sys-clock.yaml   |  1 +
 .../arm/mediatek/mediatek,mt8195-clock.yaml   | 59 ++++++++++---------
 .../mediatek/mediatek,mt8195-sys-clock.yaml   |  1 +
 6 files changed, 71 insertions(+), 66 deletions(-)

-- 
2.35.1

