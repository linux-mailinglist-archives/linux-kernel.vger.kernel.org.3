Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22597473E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhLNIqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhLNIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:46:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB93C061574;
        Tue, 14 Dec 2021 00:46:53 -0800 (PST)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639471612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXldcYkZudz3/aGAn1WeAYHENq/EY0ztgDX09+lZaTM=;
        b=UfLjtJmRojggIIGvbcP0HUvpM3zrthzC7LC9HMjfive1iqapm07WaorkQNZR50Trq9bb3m
        BhkusG1skzIBN0jS1X69qVZNBvp/SUzRSTOD7LLTQm4PAzgb988R1s2Q8h5LlTB7UZX/MA
        tmJ/irVekCix6nmQ/8V2xFqSLkAbqCvalFVA4nUa5HCkx1ZF2WE6/RtI9YI8vUzzvyaN8z
        kM/Y+VXnmrP2PqRmJbZvI/QHnGtkBg32zSO3ORMN0LzaMwIGRf8O+zAmnom7xK40kEHXEL
        LFFN/6M1nCA4KXb1kDhy7TeSHAhLnTLW+/jelZS5fyWS30VC11CT2F3W25LGcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639471612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXldcYkZudz3/aGAn1WeAYHENq/EY0ztgDX09+lZaTM=;
        b=q7p0d2OZvdbUTTxV9Y5J/xihIn3+jZf6/67oUPotm2kOBuLXGXJrLZ9v9R4hs6pO18+0TO
        ocu6FbD4QQgtxMCQ==
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH devicetree 01/10] irqchip/ls-extirq: rename
 "interrupt-map" OF property to "fsl,extirq-map"
In-Reply-To: <20211214013800.2703568-2-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
 <20211214013800.2703568-2-vladimir.oltean@nxp.com>
Date:   Tue, 14 Dec 2021 09:46:50 +0100
Message-ID: <87wnk7375x.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue Dec 14 2021, Vladimir Oltean wrote:
> This OF property was supposed to be named "fsl,extirq-map" since the
> first patch submissions, but at Rob Herring's suggestion it was named
> "interrupt-map":
> https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/

nit: The preferred form is https://lore.kernel.org/r/<message-id>=20

[snip]

> diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-ext=
irq.c
> index 853b3972dbe7..b6ecc5e3472f 100644
> --- a/drivers/irqchip/irq-ls-extirq.c
> +++ b/drivers/irqchip/irq-ls-extirq.c
> @@ -101,9 +101,15 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, str=
uct device_node *node)
>  	u32 mapsize;
>  	int ret;
>=20=20
> -	map =3D of_get_property(node, "interrupt-map", &mapsize);
> -	if (!map)
> -		return -ENOENT;
> +	map =3D of_get_property(node, "fsl,extirq-map", &mapsize);
> +	if (!map) {
> +		map =3D of_get_property(node, "interrupt-map", &mapsize);
> +		if (!map)
> +			return -ENOENT;
> +
> +		pr_warn("\"interrupt-map\" is a reserved OF property, and support for =
it will be removed. Please use \"fsl,extirq-map\" instead.\n");
> +	}

Looks reasonable. For instance, DSA does the same thing wrt "ports"
vs. "ethernet-ports".

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAmG4WfoTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRB5KluBy5jwps22D/0T4pp9MYMfIE77SpjYJG8P0arrC1FT
Zewga7/kfRpopo0rJ6tVYXZQQ7osbiYRBaQWk6PW1uq0bAU5FvP0xAV/MD7TRDNq
RuXMNgwiKmGPsQ7upC9vEFC9Wfq6PgYvhOJX4AakXMQSMMimDyo0OC3SY0dKgCPz
ufb3JWYqVFlzNRY5mxoTJk2H8OXHpnEoDfliso6I1iVlNTRHdK8GBk7wk/bV0obm
5o70udgi3dl+Cz7jmC8yC4CDd1ecpWkgoxBd3+mJm8ylOP01cbWgsEGOwhOQpDtp
lwJr2nBUA9aAlfrDUFa11N1dUkQrS+g7jPBfWfjNQKk0fKxByheE5qvZ8v+H/3qP
BtcJWPHTmemzy03Vp8pnfV7H4JshbENBvz4cB1qpjX0cFL9bv3OYv/T8u6L/3AQj
fNETUePc+dtP2RfZbFn+mx72CYqZVXFaRzLMXgI0VmvTQqXsYBoBPe+HORIoAY1j
WrIoDEE+3SwKM/yLRNNcuidrtkq9fAaKGZBusqHOvcULI4nm8HzMfT4EQKGmV0z0
P2vWS1YHtObQKGWRwMyS1DtvcFUVxDE+/v7VpiFZKTvkUK9E6YqLRrLrmVvbpqwx
Go0SqrcuBSefj0U36bUHWwbmIU1t3Ym+8CLrFJcdOia6g0oWBdNzhv5/QI4KZNYP
rfj/qJvQjLfzhg==
=uxJ9
-----END PGP SIGNATURE-----
--=-=-=--
