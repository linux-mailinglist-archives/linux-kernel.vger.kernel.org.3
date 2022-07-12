Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8D571204
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiGLFyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiGLFxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:53:36 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C78A93688;
        Mon, 11 Jul 2022 22:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657605179; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MAAwgUpaYPzvj0visl/5F+ofjnsPQibj1t3EPt2WejPivP0k5HDwC02WCJ+WHndxfwt1zQ903c2/tQrWO3M5guH3y4RfBRq9LBokxmtj/1ZBFLQmqn1dYSxIDB49He0cKC9TtQ599zIQ4g5BrVe4/8K2P+Ru7cz3NVySzSNuqH0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657605179; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ULxWfl6raq50v8Zkh37EltnR9fbxK0+r+HAVdAAchUE=; 
        b=Z/bTH7pfXEd849oKQZ/glJLTSM/kdVP8WpuLo8q/Ynl0Q6GK7WU6aFipB6NH2dRPKI3c+auovDMlVsKCjsKMHXjmC0/3R4IbK720dE4jw/zmweC+11KfhYay941wMbKU91bVaQVmk3RQnvbKX3d3RrKjEboDOgRnCDjy4xr/gAA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657605179;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ULxWfl6raq50v8Zkh37EltnR9fbxK0+r+HAVdAAchUE=;
        b=FxYvEIizeDAm6DYzbRspoQIR0r8jnwdjyIYCi+cUmaYmyVzxMwyAfCOfZPJWD6tn
        BW/Vm3w5NYAYh8hXWTw6F36ClsXMmmYUIvbbHI8RsCW2ko/28tfBpB03qd2EKpKVt+X
        Htb/RkVF0SGtnJ3R2rqleWXAXEuWfgrlPdqth/24=
Received: from edelgard.icenowy.me (59.41.160.3 [59.41.160.3]) by mx.zohomail.com
        with SMTPS id 1657605176777212.92071141357667; Mon, 11 Jul 2022 22:52:56 -0700 (PDT)
Message-ID: <b2a6c5f0bf0123a936ffac4f669488bf70d8c490.camel@icenowy.me>
Subject: Re: [PATCH 2/2] dt-bindings: arm: sunxi: Add several MBUS
 compatibles
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Date:   Tue, 12 Jul 2022 13:52:45 +0800
In-Reply-To: <20220702042447.26734-2-samuel@sholland.org>
References: <20220702042447.26734-1-samuel@sholland.org>
         <20220702042447.26734-2-samuel@sholland.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-07-01=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 23:24 -0500=EF=BC=
=8CSamuel Holland=E5=86=99=E9=81=93=EF=BC=9A
> All of the sunxi SoCs since at least the A33 have a similar structure
> for the MBUS and DRAM controller, but they all have minor differences
> in
> MBUS port assignments and DRAM controller behavior. Give each SoC its
> own compatible.

Should this kind of assignment be described in DT instead?

>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
> =C2=A0.../bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml=C2=A0=C2=A0 | =
10
> ++++++++++
> =C2=A01 file changed, 10 insertions(+)
>=20
> diff --git
> a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-
> mbus.yaml
> b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-
> mbus.yaml
> index 2b018feb56df..99566688d033 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-
> a10-mbus.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-
> a10-mbus.yaml
> @@ -29,10 +29,20 @@ properties:
> =C2=A0=C2=A0 compatible:
> =C2=A0=C2=A0=C2=A0=C2=A0 enum:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun5i-a13-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun8i-a33-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun8i-a50-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun8i-a83t-mbus
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun8i-h3-mbus
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun8i-r40-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun8i-v3s-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun8i-v536-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun20i-d1-mbus
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun50i-a64-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun50i-a100-mbus
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun50i-h5-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun50i-h6-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun50i-h616-mbus
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun50i-r329-mbus
> =C2=A0
> =C2=A0=C2=A0 reg:
> =C2=A0=C2=A0=C2=A0=C2=A0 minItems: 1


