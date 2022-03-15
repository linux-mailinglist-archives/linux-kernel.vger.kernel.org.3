Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A584DA47E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351931AbiCOVWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiCOVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:22:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9E25B3F3;
        Tue, 15 Mar 2022 14:20:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 669FC1F42B7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647379246;
        bh=GsxKwxEoyVMpi9QnEKrL5AuRZVqQ1PwZULVbs0dY27k=;
        h=From:To:Cc:Subject:Date:From;
        b=h61l0YcKl1B4Yzl5OA0aoMfTb2YVYT1Gse4wDVqGX1o2XqvO+ac/C6hh/mpCngk8K
         ouUjOaAOYCjREhwUtZM/DVAD1Lv4SY1E1IZWPp5jcYaQlQAHAVrJ2qGcnpsg+EYLL6
         8mTZa1+ISpCXJ7K87vzznR7apFqH/208bNq2cEgSzaY1gxgnpVMcZSIqwcz07aMMKW
         b35qUMoj43TS9a8uC2TWs56lGQYnpSJ0L+iOaJnwoapr94Q00l0ds577mEa1bHXCQ5
         08cTqHwFamAqgZyC9/8XZEQpaAYf720FPrRY/fud09FjO9dAUD0detyNgq1PWf85RQ
         ghbr76+NAhqGg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 0/4] dt-bindings: pinctrl: mt8192: Add missing wrapping node and properties
Date:   Tue, 15 Mar 2022 17:19:32 -0400
Message-Id: <20220315211936.442708-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
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


This series adds the wrapping node for pinmux nodes that was missing in
the mt8192-pinctrl dt-binding as well as a couple other missing
properties.


Nícolas F. R. A. Prado (4):
  dt-bindings: pinctrl: mt8192: Add wrapping node for pin configurations
  dt-bindings: pinctrl: mt8192: Add mediatek,drive-strength-adv property
  dt-bindings: pinctrl: mt8192: Add mediatek,pull-up-adv property
  dt-bindings: pinctrl: mt8192: Add gpio-line-names property

 .../bindings/pinctrl/pinctrl-mt8192.yaml      | 155 +++++++++++-------
 1 file changed, 98 insertions(+), 57 deletions(-)

-- 
2.35.1

