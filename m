Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593DC516E75
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiEBLDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiEBLDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:03:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B64822A;
        Mon,  2 May 2022 04:00:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E4465C00D3;
        Mon,  2 May 2022 07:00:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 02 May 2022 07:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651489214; x=1651575614; bh=ItYICrTgTo
        hpwpBDhrRzrv8Mk71TJQUctJQK+kNCaEg=; b=LYscJNJ6Guke04cT64YEDVdjPk
        ZMKEn58Y41ffSfK8puh+bLL8Il/6dVJCwe4qSMJUNXWfMqBNmftpGAynZlUzbSQr
        aED+fki4Eq7DLKNWXZb6F0qa3RwbxEn+/eO11NZQglhXj14J7eDz+6lPWx5wEx2P
        No6/xGxh2vzIYk5eOlF4t8FWICQwJ3oyaYmqRy2a4745Ef3XdRUcRfe8UAOaHnht
        gKajLcDMaCbFe8bopUKxsWkB+QTdov7Ym4McXAZLAS13P13UMbwQOyJUY0wsVvs4
        p0yVsFzj9negvdfW9yMcI2XEt2VNY+w09LXuCxDTlTvIE58pF1tMxu+tFg2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651489214; x=
        1651575614; bh=ItYICrTgTohpwpBDhrRzrv8Mk71TJQUctJQK+kNCaEg=; b=f
        NJxWMgo52DAUSvr5ppVD+jC98ovCq/y/mMenmbrdp1EDOWqHv4+xjHNd9jMw+aoA
        7vDzbEfF0CJMBMc398il+QjxgJFmtskl12ypCYCMldCTPlTExBPk/uQGCs29N61N
        CRC9XF90FvFRnHCLN5uqoIqsPEZ8hf/PQf7XkFuolTHaVksroukqiM4O6NbEWBXH
        r7u+9Ujfwui2a/QraPDLfb5wuXQyLACkhhWvdVkWXBrLscWzhObwOeHPRw0hBT+x
        b6+56x+V39044xAn9XmHlEOivbXdjY0qSg35eN1DrKzTgUEOZZTHhehertKdRkKP
        ftdQgGe+2vQWGjy7JQlHg==
X-ME-Sender: <xms:vLlvYjR4YVGLpJu6ZquLlIf-XQi967msLSX4px2vi9WFcvV4L0qbFw>
    <xme:vLlvYkwCZWhz55WPjTh2TH0oX6gARsWO8YljXKjUhIPZ5faiD4cl4dc5WlcY-GAB4
    yJ82HJHpuzM41R_5Nc>
X-ME-Received: <xmr:vLlvYo2agjDSHTbynvHVJWXHrMG4QpDLvI2mCLCVnqfJrazd8TdCK_DoiM9OeIERiU1EarzL-4UJqwoqVSYFCQsCoz1j_-hBECBxhME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vLlvYjDoVQPSrU9DIM4GPu6EZp8Su4e_o5YCQvDZYIk5IbG89SV_3w>
    <xmx:vLlvYsjAsoL1FPfpWcxksuDQ_nbt-7XVgR4cjSCe0Lk7KzFoHP-WYA>
    <xmx:vLlvYnphluj0VrpjS-ZULyjgnx7wOwCnYRFqORRRVDj7j1lAdWeDAg>
    <xmx:vrlvYlVA8XUyTDMdzKQLvVQxzRNDBJ9b2eK4lsOf65Eg0WVZsT9pVQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 May 2022 07:00:12 -0400 (EDT)
Date:   Mon, 2 May 2022 13:00:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ruslan Zalata <rz@fabmicro.ru>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
Message-ID: <20220502110010.q7vvdkdpaiz5acjl@houat>
References: <20220428210906.29527-1-rz@fabmicro.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jlw5hd26lnyezkda"
Content-Disposition: inline
In-Reply-To: <20220428210906.29527-1-rz@fabmicro.ru>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jlw5hd26lnyezkda
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 28, 2022 at 09:09:03PM +0000, Ruslan Zalata wrote:
> Some Allwinner SoCs like A13, A20 or T2 are equipped with two-channel
> low rate (6 bit) ADC that is often used for extra keys. There's a driver
> for that already implementing standard input device, but it has these
> limitations: 1) it cannot be used for general ADC data equisition, and
> 2) it uses only one LRADC channel of two available.
>=20
> This driver provides basic hwmon interface to both channels of LRADC on
> such Allwinner SoCs.
>=20
> Signed-off-by: Ruslan Zalata <rz@fabmicro.ru>
> ---
>  MAINTAINERS                       |   6 +
>  drivers/hwmon/Kconfig             |  13 ++
>  drivers/hwmon/Makefile            |   1 +
>  drivers/hwmon/sun4i-lradc-hwmon.c | 280 ++++++++++++++++++++++++++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 drivers/hwmon/sun4i-lradc-hwmon.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e8c2f61176..d9c71e94133 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18861,6 +18861,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-key=
s.yaml
>  F:	drivers/input/keyboard/sun4i-lradc-keys.c
> =20
> +SUN4I LOW RES ADC HWMON DRIVER
> +M:	Ruslan Zalata <rz@fabmicro.ru>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/sun4i-lradc-hwmon.c
> +
>  SUNDANCE NETWORK DRIVER
>  M:	Denis Kirjanov <kda@linux-powerpc.org>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68a8a27ab3b..86776488a81 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1691,6 +1691,19 @@ config SENSORS_SIS5595
>  	  This driver can also be built as a module. If so, the module
>  	  will be called sis5595.
> =20
> +config SENSORS_SUN4I_LRADC
> +	tristate "Allwinner A13/A20 LRADC hwmon"
> +	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
> +	help
> +	  Say y here to support the LRADC found in Allwinner A13/A20 SoCs.
> +	  Both channels are supported.
> +
> +	  This driver can also be built as module. If so, the module
> +	  will be called sun4i-lradc-hwmon.
> +
> +	  This option is not compatible with KEYBOARD_SUN4I_LRADC, one
> +	  of these must be used at a time.

How do you plan on enforcing that?

I guess a better path forward would be to either register an hwmon
device in the original driver, or convert that driver to iio and use
iio-hwmon.

Maxime

--jlw5hd26lnyezkda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYm+5ugAKCRDj7w1vZxhR
xWLTAQCboX/1BSKFvZS12C8iuG73rMmjtoEPp7an4m1k3cxlmQEA1j3nBoQoAViK
ntBC9sXc867rFYwx0NGyOqdWhao8Ywk=
=5vhh
-----END PGP SIGNATURE-----

--jlw5hd26lnyezkda--
