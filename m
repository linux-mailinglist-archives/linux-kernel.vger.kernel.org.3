Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D624151C224
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380511AbiEEOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237840AbiEEOTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:19:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F085453B7A;
        Thu,  5 May 2022 07:16:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C8CE51F457A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651760159;
        bh=W4SZhjT6xZkzhOrReGV1YPJvbxvwLaVfN3yGmI/6XVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btmxl3G8sDIAPPdG1+hUMFjECMvX+iri8m431iaZXu9AYDVoOa5I+oLD04/2xDKhU
         YsITj8AwxTR14nLRzZWb1WxTFHHqatH58vjU55vtj/3YLoTXnrgyxwHt1G8/CsrrwC
         /PMrgmjDsWrHXMKmPbkH+UlzqBuXSmKsHdyhebLhHeNP6kKxzlkpLsQrwWhmLD0i0T
         9p3T48DW3IlxM6C9DHD7qD8dc0I0+tFcbbWETIaN/XArqfSS3PMD4UcjFg18T6+uGA
         E60GT9kG09E6EXQu9XDKy9+zBR3hVTO2O2VW/AB0QqFUStuoJ4JVTlAAHndBRtMJAa
         lG1LvrzgN7f2Q==
Received: by mercury (Postfix, from userid 1000)
        id 234601060437; Thu,  5 May 2022 16:15:57 +0200 (CEST)
Date:   Thu, 5 May 2022 16:15:57 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCHv2 02/21] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rk3588
Message-ID: <20220505141557.txgr4ngcxhwr57oe@mercury.elektranox.org>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
 <20220504213251.264819-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikswav6d3jtgfdq4"
Content-Disposition: inline
In-Reply-To: <20220504213251.264819-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikswav6d3jtgfdq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 04, 2022 at 11:32:32PM +0200, Sebastian Reichel wrote:
> Add compatible value for the Rockchip rk3588 dwcmshc controller.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

This patch has already been applied, but I accidently resend it.
Please ignore it.

-- Sebastian

>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index f300ced4cdf3..71f8e726d641 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3568-dwcmshc
> +      - rockchip,rk3588-dwcmshc
>        - snps,dwcmshc-sdhci
> =20
>    reg:
> --=20
> 2.35.1
>=20

--ikswav6d3jtgfdq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJz3BwACgkQ2O7X88g7
+przfg/9FbMnqzN7qvpUMSuTIRwd9SJSrzxF+gH4JtICrgZvUPmXt1N+Pk/gebXg
jeG5x0ldbj/HLRJ+EqMkER8QGhB1aKHtDSLIT02XAh1kZEYEwUeNcIpdfLggfi41
vqvMPtM7u5skv/Pbdq4VbRAgEeKuWHMHlvqETZQzykbsfbUH71zNTQspLAubtTy2
AFev02lYfb/njlYgqdudSbHJwHORR0JP1Mmuy2M7Iuihbf0cBa22aHe0kXwgvY7m
EXWopIIKJmWSSFFCt+ubRpwG4K7NY1LWMgHFEE9Mfaxt8YlnZht832Gn5FJTYyG4
tDfw/cNNhl32b+W3qxFqdFsm1Wn29VZjOk/pO404Jexyu6PO2nlKgK3r2W5yDAhC
Kc00Z+8pLMTlhwZktCx6Bs3vzFttkqRYxUMRgu5hmVFzNMidxBssYys+Ni+namvk
588Wm2STU0kVg2yBTqUlJxlrfArbmC8hIOZ95N/oHkrWR9P2kO1wH6rhwAvUpJVV
eTDDddmcLKXIrbV1EtcjF2OnwpQR/uLLP1cIGVccagmahiWrzjePFShYfQ0wPEnq
CUQDIFfgtNUwKk2F8Ya/7Ytj/mHtQdahkR7FVhlCs9YwNB0OdoLSYQHKw0vvi3BD
b2Rl3V2/IAF5AmWcHynuIZjbKf8dXo9X5o0R2DA6+7SOjcKO3mI=
=MsHG
-----END PGP SIGNATURE-----

--ikswav6d3jtgfdq4--
