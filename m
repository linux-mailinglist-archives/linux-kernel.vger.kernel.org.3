Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9925F539974
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348399AbiEaWU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348387AbiEaWUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:20:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C49D06C;
        Tue, 31 May 2022 15:20:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id C06791F43F19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654035599;
        bh=lMri5Og8mqTLpkPs/QpNcaNHyLWk1vcQfF8MIfkQjsM=;
        h=From:To:Cc:Subject:Date:From;
        b=hqbt4AJDpV12l2MtXQCuns9kvvNq1oPaWtESyjZeW6aFuAtpf64RoyD6801X3kHXu
         PtZkfBsNNY/iy44xRTBfcqLOfpGZzcfoYJIa4da9TwcPuhUxe7P+/IRG/x4xNJN2Wi
         +nFosEzY7cdKKgxLwvZIGLykohmbMICaUNfgwitrT0982JzOnYcTiPDur7JQs0KA5L
         8bXUxR7WHxZGJ44IP878vtVb1Fp8zjoZe6wwpLe3HpEn751IOxmKCXRWrU5pH2kn19
         rJ5XKgc3+Ra6E3EDhBVmV4pWYU13DxvgDWP0Bh8nMMsTC/5nPgIWbNoRiOA6KknaGy
         AXM0sTmCxc5JQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] MT8192 pinctrl properties adjustments
Date:   Tue, 31 May 2022 18:19:52 -0400
Message-Id: <20220531221954.160036-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


The two patches in this series substitute properties in the mt8192
pinctrl dt-binding for ones which have a clearer meaning and are more
standardized. At this point there's no DT using the mt8192 pinctrl
binding, so if such changes are to be made, they need to happen now.

v1: https://lore.kernel.org/linux-mediatek/20220525155714.1837360-1-nfraprado@collabora.com/

Changes in v2:
- Dropped Fixes tags
- Added 'if' blocks to enforce mutual exclusion of properties

Nícolas F. R. A. Prado (2):
  dt-bindings: pinctrl: mt8192: Switch drive-strength-adv for -microamp
  dt-bindings: pinctrl: mt8192: Use generic bias instead of pull-*-adv

 .../bindings/pinctrl/pinctrl-mt8192.yaml      | 81 ++++++++++---------
 1 file changed, 41 insertions(+), 40 deletions(-)

-- 
2.36.1

