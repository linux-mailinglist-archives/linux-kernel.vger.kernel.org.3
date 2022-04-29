Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB483514885
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358626AbiD2Lv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiD2Lvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9113CB3C4E;
        Fri, 29 Apr 2022 04:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1ACC6205A;
        Fri, 29 Apr 2022 11:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA04C385A7;
        Fri, 29 Apr 2022 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651232908;
        bh=YddyMcIeDoK+LuBTa75Hcxrbfg+0jvhLvhQUUF3oiXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NoSuL4mUKRW3vjvgLoOSLrHHuHPs9iWONsh0DB7gz6COPoBNQxLQsqvZFw3xCawYQ
         S7+EvGUCR+2BTC4Y/44Ebm0+Y/MIkrAeKZb2XERxSklMhXpBaTwrHpoCCFTsFcINqx
         E5oNi6tMB+H+3iNaAbBvk1W3rPG+jcVpRobzis9/ah2tMJOn9RwIxZU+vLEs/DRZQ/
         Z+nLXuGRiMS/GCZwv7Ve+sYKlc1GN+FaJUyAWb3MGDzdr/EmwWsXSC6T7akZsi/yAF
         moohsoQ+vRtsPSw+UIuPTy6yI+blc1vAAZ1ewZG/iiCeTL4mY5S9LjSNMuZmo14y7g
         6qKqFtFtvK1zw==
Date:   Fri, 29 Apr 2022 12:48:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/5] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
Message-ID: <YmvQhpO8dg6VLHNP@sirena.org.uk>
References: <20220429113927.5145-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P/bFAWC8P9UAkdFW"
Content-Disposition: inline
In-Reply-To: <20220429113927.5145-1-markuss.broks@gmail.com>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P/bFAWC8P9UAkdFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 02:39:25PM +0300, Markuss Broks wrote:
> This patch adds device-tree bindings for regulators on Silicon Mitus
> SM5703 MFD.
>=20
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../siliconmitus,sm5703-regulator.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/siliconmi=
tus,sm5703-regulator.yaml

As Rob said please send an incremental patch with any fixes needed.

--P/bFAWC8P9UAkdFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJr0IUACgkQJNaLcl1U
h9AUswf6A3rRGKMwACJ831L5cTTs7vDmqfEXSrxM2+OTm3mlUVuue0ybuhAv8QY7
CZk8K+H9OGHsNDzBBefGZmJE0BWnZstr23eyFkWsTJwmdOmyuzSMws3U/+7QsIP/
DowZnycQuQzr9PSDJm1JFu8a2zc4Kp+lVDT7Xl8fk5dhkI/LTnIuho9A0vuSf8yy
DF73wcpw++SWeSMwnoJ+vulRJ3draNgaQexnYnrxwSuqbr6gESzfPsxwNiA9KT4M
5+y2F9PFeh5WGnliYlWnbmNWUm0ICwyWqs4G2BzJtaBIe2NGh9SPnORX5gYW51YH
Q/BG6cU+6GMKPmFthHMBHlkwuZheJg==
=P477
-----END PGP SIGNATURE-----

--P/bFAWC8P9UAkdFW--
