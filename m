Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0164DC949
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiCQOyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiCQOyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:54:03 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F0F202154;
        Thu, 17 Mar 2022 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1647528764; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IVYJfPU0rzzGa9hX02z9sV1yDGsv5kDMcOfss8bv8eQ=;
        b=DA60gc/c3O8sCB3ECGs5CZQzjoDCZ/waPK9k7Zq4U7G3cdq3ndgtsDeflLRpFdP5rWBvGm
        6ZzEaKzLG70I+KcjgiY8Tf4K21S6xik2OJpvAba9nnqS+tQeil+vC9kxMNsHnFjShS9Jj4
        AeKBbEbYiofc5rJMCXES0b70ObmpB/M=
Date:   Thu, 17 Mar 2022 14:52:28 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 06/18] dt-bindings: irqchip: ingenic: include generic
 schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andreas =?iso-8859-1?q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Jonathan =?iso-8859-1?q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Message-Id: <GB9W8R.4WH3AK5NKGDC@crapouillou.net>
In-Reply-To: <20220317115705.450427-5-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
        <20220317115705.450427-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu., mars 17 2022 at 12:56:53 +0100, Krzysztof Kozlowski=20
<krzysztof.kozlowski@canonical.com> a =E9crit :
> Include generic interrupt-controller.yaml schema, which enforces node
> naming and other generic properties.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  .../bindings/interrupt-controller/ingenic,intc.yaml          | 5=20
> ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yam=
l=20
> b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yam=
l
> index 0358a7739c8e..74597a98f86c 100644
> ---=20
> a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yam=
l
> +++=20
> b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yam=
l
> @@ -9,6 +9,9 @@ title: Ingenic SoCs interrupt controller devicetree=20
> bindings
>  maintainers:
>    - Paul Cercueil <paul@crapouillou.net>
>=20
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
>  properties:
>    $nodename:
>      pattern: "^interrupt-controller@[0-9a-f]+$"
> @@ -50,7 +53,7 @@ required:
>    - "#interrupt-cells"
>    - interrupt-controller
>=20
> -additionalProperties: false
> +unevaluatedProperties: false
>=20
>  examples:
>    - |
> --
> 2.32.0
>=20


