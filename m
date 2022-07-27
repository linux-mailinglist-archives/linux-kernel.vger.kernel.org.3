Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371EE582600
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiG0MAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0L76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:59:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACD027CC7;
        Wed, 27 Jul 2022 04:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57A09B81FE6;
        Wed, 27 Jul 2022 11:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBB5C433C1;
        Wed, 27 Jul 2022 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658923194;
        bh=Vpeh+fLR8fhAePR4gpuB9Tc/Vj/mATpE0vaPAwGND38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fTtgb4aqsEJGE/AXv02THG7FNf443jy/W8lSPkzY7uJUaAKkiAuCYKMJZEOqNhzd1
         qS+X5MYC+GK/K6o+WuCuyQ33Yc3co8k/r+xUuWj9utCwkYlZt7HXBhpiSbJYEUxuMX
         8WthMAZaUV6AGYTu3CL2BH+DGLJc+I6Bm5+iUod4oi0uGOIBsOf23idAlzgHUZGcHk
         tJaZ3LWpRttedQxp8ppa1bCgiVd8vkH+0DHO/DFGfFlGOYlJDaaFnSo4qligw1qZMv
         T3jWxAQh4GEsRu/WMdPeFtUliR1NSjjWw8LbUqfPiNxrgJzQqnCSitArnW0sJObjMn
         5A4cecE14zJ1w==
Date:   Wed, 27 Jul 2022 12:59:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 4/5] regulator: qcom_spmi: Add PM6125 PMIC support
Message-ID: <YuEosXO1xYMY8Mul@sirena.org.uk>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-5-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="26sqcxpjMBeK/bO+"
Content-Disposition: inline
In-Reply-To: <20220726181133.3262695-5-iskren.chernev@gmail.com>
X-Cookie: No motorized vehicles allowed.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--26sqcxpjMBeK/bO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 09:11:32PM +0300, Iskren Chernev wrote:

> @@ -2245,7 +2280,6 @@ static const struct spmi_regulator_data pm660l_regu=
lators[] =3D {
>  	{ }
>  };
>=20
> -
>  static const struct spmi_regulator_data pm8004_regulators[] =3D {
>  	{ "s2", 0x1700, "vdd_s2", },
>  	{ "s5", 0x2000, "vdd_s5", },

Unrelated indentation change (I think undoing a random extra blank line
added in the prior patch, at least there were some random extras in
that).

--26sqcxpjMBeK/bO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLhKK8ACgkQJNaLcl1U
h9ChSwf/aHTZnhAig+LV40j8fbrE5n7yXzXTD4fInIqXVctRS7cHh7Wjp+WSNONO
YU/n3Bon7zJMgr80Y9Cm5nHMjjE0Yxx8vD4L7t5YoSgje/4MgX/aeu6xmoR0oOS9
ts3jzMj9savB/ejl/W8HLFBIfqLzWQm9/TZZ3zHfDgltSbmFYxYzH2PK0j9jIlCW
MDhDtCodu6ZSO10E6UtOC2Qm3i8An0kcQvSfSn3FroC6QfMdT6yeFZ9swCfABlW8
M8bn/ijSjKOw2KOGNQQeT7K4mREPcCGj4e7wV7kUa/K0udio2mFEw0SXWRBSHdWy
iSl+eL5gIBpLBmuuJzVcaEziuiBKWw==
=UQyf
-----END PGP SIGNATURE-----

--26sqcxpjMBeK/bO+--
