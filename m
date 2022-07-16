Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7115771B7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiGPV6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 17:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGPV6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:58:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D119001;
        Sat, 16 Jul 2022 14:58:07 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1613E6601656;
        Sat, 16 Jul 2022 22:58:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658008686;
        bh=eOYXjXnbW3HI248qk1fsFd33W9qutAjETWlcFRdPbpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoXikzHmXrN398CI22exYfFWgAj/JjCN/LX1iprI2GOJnjuIY6Oak0gaBnKlA085b
         +/zu8u+UzSj9sbEX6wqrNe7JqyPkDGTW2XKAuMV6jSq9BW51kKaUSlAQSUABzC2bUN
         eYVyezKvsfdrualHI0YiTnKjoZVe4PKMoC1gF0HtCXQhFfvTtORBYrTv+IOfO8e+pW
         E4dIYI6eyKC0IpX5TMj//ofXhCxOtoessVnruHy4rxzX2JpKaP8A0Lm8EylAO8yyFj
         kaatoj1uNIacKFJl3A/AKJ4iMNB+zvKYbpl63q3KyGuv/g5u0FEuaFSX9qNfFWfy6e
         MHbFm887P2BcA==
Received: by mercury (Postfix, from userid 1000)
        id 78B581060428; Sat, 16 Jul 2022 23:58:03 +0200 (CEST)
Date:   Sat, 16 Jul 2022 23:58:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     corbet@lwn.net, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: reset: qcom-pon: add support for
 qcom,pmk8350-pon compatible string
Message-ID: <20220716215803.r3ldaswyhehfpcip@mercury.elektranox.org>
References: <20220713193350.29796-1-quic_amelende@quicinc.com>
 <20220713193350.29796-3-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="coghfurtcblj5che"
Content-Disposition: inline
In-Reply-To: <20220713193350.29796-3-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--coghfurtcblj5che
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 13, 2022 at 12:33:51PM -0700, Anjelique Melendez wrote:
> Add support for the new "qcom,pmk8350-pon" comptaible string.
>=20
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/power/reset/qcom-pon.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-po=
n.c
> index 4a688741a88a..16bc01738be9 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -82,6 +82,7 @@ static const struct of_device_id pm8916_pon_id_table[] =
=3D {
>  	{ .compatible =3D "qcom,pm8916-pon", .data =3D (void *)GEN1_REASON_SHIF=
T },
>  	{ .compatible =3D "qcom,pms405-pon", .data =3D (void *)GEN1_REASON_SHIF=
T },
>  	{ .compatible =3D "qcom,pm8998-pon", .data =3D (void *)GEN2_REASON_SHIF=
T },
> +	{ .compatible =3D "qcom,pmk8350-pon", .data =3D (void *)GEN2_REASON_SHI=
FT },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);

No handling of the second register? Why is it needed in DT in the
first place?

-- Sebastian

--coghfurtcblj5che
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTNGgACgkQ2O7X88g7
+pqiKg/+LF17fOmXDr6M1rW8mvNyg6UoohU3fDoP23Ilc+g15pCIBj00y2ZRMv9I
N+WroihDhGoMzPVa1o4QnzxMQNvwaPppwTv/gZspa1uiLTSaiSGukZmfS98ioBhN
h/RX+FKI/9tQ0od+K7ysBGnyHThqizVHA07DX3BFN8pM0xc+dzeuVg7NcOYu1jX6
CTqo7FVt5TG+B1hIAa8eoQGrMXZu3pA4MZNiQ0XM4rRT49fg7yzFJOTudgnMj+RB
a2FnKPzH5/k/R2B/vzPr+X3CKW90ZEFSJ8MlD7bsk56YppOM9p7SCsQU3zr1DbPq
8Qr6f15rBV5lIfnybUsFedhzosRxlSqFSwN9FpxpAYvFTqPKpE4CZNyPe+3hmcR3
1anosF9YA/EK5RLEikweVnvCEQKtjCHsJ0f413itHD1cZQDt6UhuPJtbGeHhGdHY
U+DPXf8LO7VveKUvI7b3yHBe4rYrYpROqaI454WB6FPv2rI/gqmf78QwYG3c4SCt
bq7ACr0F8QhLvOh5VbFILDR+z680cso1TkgDk7h/Jbz/oPg0zqCe1i2oFkTRF6jD
khQvmFmbzjSxi7hX5uH+1H0aWO3UmTvMgmg1gWtPeK6HMnwlK7SwBi8lk3nSceMX
WX63sqo7HpPc148XdAOZnNjUJoPxeSPWTGPbUuhne/tpbrT/CHQ=
=WB+v
-----END PGP SIGNATURE-----

--coghfurtcblj5che--
