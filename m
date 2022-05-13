Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576DC52620A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350725AbiEMMeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380345AbiEMMeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:34:08 -0400
X-Greylist: delayed 197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 05:33:55 PDT
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C51689B3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:33:54 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 237F61C000D;
        Fri, 13 May 2022 12:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652445226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGLFeC+5BzmiDZEW3DjfaujlaliK0W2DIOOdDmyOjmU=;
        b=ayJAIYFCIs4K+zLWtMOGYFfS0jF5V3F5W6ET8B3w8Hcqeg1M680b8gvQZHpqXwxwySxTEE
        0nBXPdKA3NlOCr5+XFw8XMREmhEhlWzk49gPxN3MJTeW9n8hJXxU3EapuueKKcr4jB8fTh
        22piFVrSNNtWu02dwAl4sajQ5k0pEKZrMdRYIwbH7PZ5Ca3BYfCPZlJk4M1Pel5J3mEs1A
        rmHUf7l1rO2XXrazZAxlaCwmQ+Jhnc399/CgllsBJ4Y/SnDESojDbYeKf+QAOJQuhoi7xr
        b+6L8wSYqqj0/VQxfFd7mmLO/MLNiON2I4Tql7w/65/Qvi3JFfYFcI4u1xNlQw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add atsha204a node
In-Reply-To: <20220512095939.8595-1-pali@kernel.org>
References: <20220512095939.8595-1-pali@kernel.org>
Date:   Fri, 13 May 2022 14:33:28 +0200
Message-ID: <87tu9tr4rr.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Crypto module atsha204a is available at i2c address 0x64. Module is used
> for symmetric cryptography and provides also hardware random number
> generator and OTP storage for device serial number and MAC addresses.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boo=
t/dts/armada-385-turris-omnia.dts
> index bc778ab8618a..f4eb6898aa6b 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -349,7 +349,11 @@
>  			#size-cells =3D <0>;
>  			reg =3D <5>;
>=20=20
> -			/* ATSHA204A at address 0x64 */
> +			/* ATSHA204A-MAHDA-T crypto module */
> +			crypto@64 {
> +				compatible =3D "atmel,atsha204a";
> +				reg =3D <0x64>;
> +			};
>  		};
>=20=20
>  		i2c@6 {
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
