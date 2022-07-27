Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF4F5821E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiG0IRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiG0IRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:17:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C42020BDA;
        Wed, 27 Jul 2022 01:17:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC57A6601B12;
        Wed, 27 Jul 2022 09:17:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658909837;
        bh=LZXLih2SwGeiRylAPXX7UXVKbKZwvUB3TU1jCoiphXk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nn7xtgzhD40NJk6UblOCXp35/hNMeaNnBVBFJg2X+9Oi/tk+Umdf/cGzINlaXcwv9
         pkuCvEGcOO8LvqrZbfWj8aaeaYuEFk0GOW68TFqVs0jro53FoIJbiWPN82pkhK7GN2
         PYucvOjkc2J4958CeH1HcyqiWp/DteMeTB8qv992tEJgxHIIT8v95xIaTAe4DEJXHp
         H556IfchTmZ2fNhnRRtPgSbmia/JHtHP8dUaM3eBL2jtstgOo2sFnx1Wx3Y2eHvzKU
         HhHRBesUXEieQPWl3oTZW1ViwhMNCw0ETuNJWNbjy3ACS6P05P9Wv5mMzYMSNwO3VD
         zPY6s6qRDzXtA==
Message-ID: <35e9db62-4233-1804-0233-f048b149c22c@collabora.com>
Date:   Wed, 27 Jul 2022 10:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 2/6] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>, rafael@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220726135506.485108-1-bchihi@baylibre.com>
 <20220726135506.485108-3-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220726135506.485108-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/07/22 15:55, Balsam CHIHI ha scritto:
> This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>   .../thermal/mediatek,mt8192-lvts.yaml         | 73 ++++++++++++++++++
>   .../thermal/mediatek,mt8195-lvts.yaml         | 75 +++++++++++++++++++
>   2 files changed, 148 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
>   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
> 

Hello Balsam,

I don't think that having two separated files is necessary (and I don't know if
that's correct, even).

You're referring to variants of the same hardware (and using the same driver, but
that's not really relevant here), so my suggestion here is to have only one YAML,
named like "mediatek,lvts-thermal.yaml", where we list all of the compatibles for
both MT8192 and MT8195 (and future SoCs).

Regards,
Angelo
