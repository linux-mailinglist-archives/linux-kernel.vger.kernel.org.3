Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A05AB563
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiIBPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiIBPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:38:14 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5561A32D96
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:25:04 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4CC20C000B;
        Fri,  2 Sep 2022 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662132302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGbRNf7kbHhzYj5QSqdFH2Zj9eYIH7p6ttXTqmWZyIU=;
        b=DTUzlHI/6GYydDQYnyMIjTeMVctAHDbyahgKeVQ43uCl/wRxWfsMb1ONTQ8a1CoFA0lTsJ
        hDmph31DjNdEAJH+ITGpNYY24lzwRIJra2dliv85dOn/Ce1qvulUE2NGpvQnhl+z2VdsC+
        Q9kdp6LDAfWV2lYYWJGrdCElAFtWlg8jFtsyaVnqBeSFpWKfR6bDiSO/VIG8EQX/sEWpuN
        kVqb+lxwmBqXfuYobdDU6AiVSuZPF9Cmc82M4lDCb4T5n7AznkTb1FFZBFrpzGLI+nJlSp
        WVsiWA2CGn5jjoSajmuN3kjPpkdQ9N4CudtuDzlM5PnKlH3WBULpnArP/VNKTw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: armada-38x: Add gpio-ranges for pin muxing
In-Reply-To: <20220727131619.3056-1-pali@kernel.org>
References: <20220727131619.3056-1-pali@kernel.org>
Date:   Fri, 02 Sep 2022 17:25:01 +0200
Message-ID: <87ilm5er3m.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> GPIOs are configured by pinmux driver, so add corresponding references.
>
> Fixes: 0d3d96ab0059 ("ARM: mvebu: add Device Tree description of the Arma=
da 380/385 SoCs")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada=
-38x.dtsi
> index a176898944f7..1590143c52c8 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -298,6 +298,7 @@
>  				reg-names =3D "gpio", "pwm";
>  				ngpios =3D <32>;
>  				gpio-controller;
> +				gpio-ranges =3D <&pinctrl 0 0 32>;
>  				#gpio-cells =3D <2>;
>  				#pwm-cells =3D <2>;
>  				interrupt-controller;
> @@ -316,6 +317,7 @@
>  				reg-names =3D "gpio", "pwm";
>  				ngpios =3D <28>;
>  				gpio-controller;
> +				gpio-ranges =3D <&pinctrl 0 32 28>;
>  				#gpio-cells =3D <2>;
>  				#pwm-cells =3D <2>;
>  				interrupt-controller;
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
