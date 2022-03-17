Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C057F4DC99C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiCQPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiCQPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:10:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45E5204C9E;
        Thu, 17 Mar 2022 08:09:28 -0700 (PDT)
X-UUID: 38b6bbde99fe4e84aeb373ab1ed4adbc-20220317
X-UUID: 38b6bbde99fe4e84aeb373ab1ed4adbc-20220317
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1317117794; Thu, 17 Mar 2022 23:09:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Mar 2022 23:09:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 23:09:19 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <krzysztof.kozlowski@canonical.com>
CC:     <afaerber@suse.de>, <bert@biot.com>,
        <claudiu.beznea@microchip.com>, <cristian.ciocaltea@gmail.com>,
        <daniel@thingy.jp>, <devicetree@vger.kernel.org>,
        <dinguyen@kernel.org>, <geert+renesas@glider.be>,
        <j.neuschaefer@gmx.net>, <jason@lakedaemon.net>,
        <jiaxun.yang@flygoat.com>, <john@phrozen.org>, <kaloz@openwrt.org>,
        <khalasa@piap.pl>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <l.stach@pengutronix.de>, <linusw@kernel.org>,
        <linux-actions@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-oxnas@groups.io>,
        <linux-riscv@lists.infradead.org>, <lokeshvutla@ti.com>,
        <mail@birger-koblitz.de>, <mani@kernel.org>,
        <mark-pk.tsai@mediatek.com>, <maz@kernel.org>, <michael@walle.cc>,
        <narmstrong@baylibre.com>, <nm@ti.com>, <openbmc@lists.ozlabs.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <paul@crapouillou.net>, <paulburton@kernel.org>,
        <qiangqing.zhang@nxp.com>, <robh+dt@kernel.org>, <s-anna@ti.com>,
        <sagar.kadam@sifive.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <tsbogend@alpha.franken.de>,
        <yj.chiang@mediatek.com>
Subject: [PATCH 12/18] dt-bindings: irqchip: mstar,mst-intc: include generic schema
Date:   Thu, 17 Mar 2022 23:09:19 +0800
Message-ID: <20220317150919.2089-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220317115705.450427-11-krzysztof.kozlowski@canonical.com>
References: <20220317115705.450427-11-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Include generic interrupt-controller.yaml schema, which enforces node
> naming and other generic properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/interrupt-controller/mstar,mst-intc.yaml        | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
> index bbf0f26cd008..7cae52490ff5 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
> @@ -16,6 +16,9 @@ description: |+
>    The HW block exposes a number of interrupt controllers, each
>    can support up to 64 interrupts.
>  
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
>  properties:
>    compatible:
>      const: mstar,mst-intc
> @@ -49,7 +52,7 @@ required:
>    - reg
>    - mstar,irqs-map-range
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> -- 
> 2.32.0

Acked-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

Thanks.
