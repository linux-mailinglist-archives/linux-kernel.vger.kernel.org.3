Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CC05155AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380762AbiD2UeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiD2UeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:34:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AA64BFF6;
        Fri, 29 Apr 2022 13:30:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id F0F751F469D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651264248;
        bh=kAsfuPsvXs/HN4ujTEF3xFYlYjDqLSK6UGr16SYdfgE=;
        h=From:To:Cc:Subject:Date:From;
        b=SzxGQcTxE6k2qTzzReHyLAe7jlJlmUGpQNWY3a7V6pXaK2tuz1vZS/4RJOREQKhu+
         vvIaaf9iFOYFCa51RkzPCWdRokKr27OFqStuzo7CCpSIGCLleJb3CGdUKnqoJMeNWH
         7inbr2ODyd+mR2fHnmYrohMxSdY5Q4TX5mFOgOZsZakXkuwQjLq7chiwpa3XimSxRU
         75RZ6J3mY0bnIY/RnYFT/getYOg+WDq2hTDd6i7MnJ0nV+g9xkZqc0oa98FQKQJ2H3
         YW6t3q8FTaV520N6M3TwEEmoviL/E1fKeRGkZJ6dGJukNSy/1WIezg8llGzqGMn7Ks
         9EKwLw8K1XAgw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] Add missing dt-binding properties for audio components on mt8192-asurada
Date:   Fri, 29 Apr 2022 16:30:36 -0400
Message-Id: <20220429203039.2207848-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


These patches add properties that were missing on the dt-bindings of the
audio components used by mt8192-asurada. Namely the i2s-share
properties for the sound platform and the #sound-dai-cells on the
rt1015p and rt5682 codecs when they're referenced by the machine sound
node.


Nícolas F. R. A. Prado (3):
  ASoC: dt-bindings: mediatek: mt8192: Add i2s-share properties
  ASoC: dt-bindings: rt1015p: Add #sound-dai-cells
  ASoC: dt-bindings: rt5682: Add #sound-dai-cells

 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml  | 5 +++++
 Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml | 3 +++
 Documentation/devicetree/bindings/sound/rt5682.txt           | 2 ++
 3 files changed, 10 insertions(+)

-- 
2.36.0

