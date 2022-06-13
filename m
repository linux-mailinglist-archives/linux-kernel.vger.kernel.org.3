Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12205549A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiFMRmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbiFMRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B6814AF4C;
        Mon, 13 Jun 2022 06:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CDB060C4A;
        Mon, 13 Jun 2022 13:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E803C3411B;
        Mon, 13 Jun 2022 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655125588;
        bh=wtPCz3OyedMcP/w7PQBeu2r2iV5lXm28OqwqVJ/Rk/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFGeokSDqmiWwRfrmobGSxacikejyYxTAfhHQo8kmW24MQ9fFA/W894Cx26yugOgO
         g02ZA5AZx6TMxyyqPSu4JDXijzAEnZ2Lv1vTZYqNu4YAlf4BVzrCxAhlSDxs9oKG/s
         DgcHVQ4WEjIpg/eClDj69JxNWIcEKUb35d01G0Eg6gmLLeK0iO315uKAfTzb+SKDL+
         carh9pH+5wXp6azNMwzXVWVhnGWvtfzVj1YJG+/STkDuU2zBjLDDvyqeybssx8Hw4n
         wZ91Cbh6E+o65sO/vmIp60Chf/sGg6gSqA62ZrkrvxgeWmy5MogMqosV76TjI+I2mx
         vEnpNrw5btqLg==
Date:   Mon, 13 Jun 2022 14:06:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome NEANNE <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, will@kernel.org, lee.jones@linaro.org,
        khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 5/5] arm64: dts: ti: Add TI TPS65219 PMIC support for
 AM642 SK board.
Message-ID: <Yqc2Tix9jOJtB+CV@sirena.org.uk>
References: <20220613090604.9975-1-jneanne@baylibre.com>
 <20220613090604.9975-6-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zZx7sPWxeWiq9OR6"
Content-Disposition: inline
In-Reply-To: <20220613090604.9975-6-jneanne@baylibre.com>
X-Cookie: innovate, v.:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zZx7sPWxeWiq9OR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2022 at 11:06:04AM +0200, Jerome NEANNE wrote:

> +			buck2_reg: buck2 {
> +				regulator-name = "VCC1V8";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};

The supply labelled 1V8 can vary between 1.7V and 1.8V?  That at least
deserves a comment.

You should only set boot-on for supplies where it is not possible to
read the current state.

--zZx7sPWxeWiq9OR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKnNk4ACgkQJNaLcl1U
h9A8AAf+L8/jIRuPSPB7WEwuvEuJ13zFfAdSdkMFCAWLTK6QyiPEMnzqfLIRjv/1
hDvwENyNnso8OH0+ftQsyFZvzUtyzyjwptKfuc8zjf9q0fd6ljrljacZ9NB97m2M
qztrTCanjB5npgomVdS3LW8kvgs1C5v3a7P15btIo+k8coGasstcwsJNi3pe5I1P
gESkfUjNRiEQOMhOGvn6j6YB5xEAzkTx2/ZowtjlCECwm2bgM627HoGI1C/SKRN6
/rGqtD3KvtdhnCxV9PinczxJeVVc2P77IUQ+3q+8ikpb3pkz+k+PXAJ5pPT2WED7
9TMqmOv6LyxOdaizBKUQzWLRYm6hmg==
=TolR
-----END PGP SIGNATURE-----

--zZx7sPWxeWiq9OR6--
