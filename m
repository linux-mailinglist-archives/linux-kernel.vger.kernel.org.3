Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81DC547BE1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 21:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiFLTsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 15:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiFLTs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 15:48:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9084B1E0;
        Sun, 12 Jun 2022 12:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95095B80D07;
        Sun, 12 Jun 2022 19:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F15CC3411C;
        Sun, 12 Jun 2022 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655063305;
        bh=KXksgttXApWUxueI4w47VhussaFvj+nyUo+8Y40qRHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+mnDGryHLzqWNzwf1ovMKskjKN45NObTBD/y0/sxWV6Ripj4Q0tNNONtOJBw4pHN
         2SmCcqe2sNKRtSoVHytQQCMkbWLesO4C77RUPIGby1dgjM5hITk6RIqf5wefRAHh7u
         XYA55wyIXSy/gbibkjsVUL2zKmVnS6OXS2hWCt7uwPwE06PVi0XiT2zE64CaEAh3KS
         5UGAnb3ILjBl8CkolUEmFXb0wSIXFoCh49Ft4AK1NxAnT9ae4AOlCuX8kyh17s+0/J
         UyuIvyLErK+Er9NJsan6yadiFPN+DdGRcLLx0DTHmlNCyI4rFqA4bWd8RYV19ZnI86
         9O7VD8OR4uJUw==
Date:   Sun, 12 Jun 2022 21:48:18 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Linh Phung <linh.phung.jy@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: r8a779f0: Add thermal support
Message-ID: <YqZDAiB/taLwmamr@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Linh Phung <linh.phung.jy@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220525151355.24175-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9VckkkDUpGs14q6a"
Content-Disposition: inline
In-Reply-To: <20220525151355.24175-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9VckkkDUpGs14q6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2022 at 05:13:55PM +0200, Wolfram Sang wrote:
> From: Linh Phung <linh.phung.jy@renesas.com>
>=20
> Add support for 3 TSC nodes of thermal. The 4th node is for the control
> domain and not for Linux.
>=20
> Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
> [wsa: rebased, fixed resource size, removed unused 4th node breaking prob=
e]
> Signed-off-by: Wolfram Sang <wsa@kernel.org>

Eeks, this should have been:

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Shall I resend?


--9VckkkDUpGs14q6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKmQv0ACgkQFA3kzBSg
KbbVCg/8Cd8FUd379dFfyawX25rCdr91g4PINDLdrzYMq44Cczpe+WohO/PRdBbY
dyuYJ8arv9PtuFVpbNCKFB+r54wdKyrJIyiM3ubxAjrT5179COYDvdcruS2UwtEO
jBArqrX7H1s0p9GaMe0UOrLf754fTe+7sHc3p8jyzlwR+bf62lhsQ+06jKG441Jx
yEuK5YXj0zYdAVrijo9jj+LLvTTLmF5Kmwcur6adnLcLZ0bd4hSpSB5pPVQ5Grfn
KGLnXuXWSa3+unSjco4tL4NwAlg44p/vVAKnUKgNbBppsg564Ig3fY4LWILwhacJ
4/2hkkUFpIvrLK9fOMqBo9UOopGU6QCPjNj1Lz5iCycnfGStzcKUqNMDwSirDxUa
OEDG5hBZJ8C6ufsXdXtlblVrv2BDHCPttTtd8FExTh1nwt7sj30kFoDGXB9JkKWP
BRoMzwPhvB6dPa0MW5wXhDuFR6H687ZDO2C5n/Pnr1pDwTwS57K70iutSLoWwfeE
0okGd1kDIELMu7yWjEa0cVsEQHXq+bQzNbb2M/2TBSJogdp+kTSCaSduSUCcJe45
LcyMPyIzcTaWupRyQCC99s2tDPlqmRzlqDeA8AmBEVf8kG2ZTxcXErHV/R11f0QB
4NKAO9Gc2GI+kHpv50N20zgYuTWuxx4CKRaJnGKCpIbuuzIz9xk=
=OWtV
-----END PGP SIGNATURE-----

--9VckkkDUpGs14q6a--
