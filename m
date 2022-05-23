Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05053140D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiEWNn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiEWNnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791B23A70A;
        Mon, 23 May 2022 06:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02DC060FF8;
        Mon, 23 May 2022 13:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73320C34100;
        Mon, 23 May 2022 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653313401;
        bh=TyiUkDHlflTnKEzILvhvONXQ/FiPqNQ7lI3Q/Y6bADg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPCciIhPVoG5lF2g5LwaEyIBRmWbqBpGLSjZG1umVrKPFpWqZ/qX9MAOcay5UhDAn
         QC59huFzN+dAsWD4VhdnaNAEzk74hPrlzZ4jg23TRL27/nEz533Dkled3lqhg638Xy
         zJbmaeez7/OkQOSYGx4sHJuJnTAqfSnLc2QN6erJ+CIKcQVAB1IuItZFmc4PMZBGsJ
         JE22rDq/n6KCzRQyofJ3uIP9oTvH5NCzPh40jcDJgHPwY4VhmcvF2wsXpBMICTeJM1
         tWHAebtGJfCShDnlxwZtLVbmxrfa1IbOT6CAcnsu/GFGq0FlU9QVW7qSvkZ+y0BKTm
         AKpDFW8AZJGBQ==
Date:   Mon, 23 May 2022 14:43:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] regulator: Add driver for MT6331 PMIC regulators
Message-ID: <YouPdNrBS2xwWwlI@sirena.org.uk>
References: <20220520133305.265310-1-angelogioacchino.delregno@collabora.com>
 <20220520133305.265310-3-angelogioacchino.delregno@collabora.com>
 <YoepiTUfdhkYByo7@sirena.org.uk>
 <6cc68be9-e509-eae4-801d-997fdc01dcf2@collabora.com>
 <YouFcSapkVC7ZfuP@sirena.org.uk>
 <a6606891-d55f-dbce-7c5a-86390694e1c4@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3JjAka1nrbTHhQDM"
Content-Disposition: inline
In-Reply-To: <a6606891-d55f-dbce-7c5a-86390694e1c4@collabora.com>
X-Cookie: Sales tax applies.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3JjAka1nrbTHhQDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2022 at 03:22:39PM +0200, AngeloGioacchino Del Regno wrote:
> Il 23/05/22 15:00, Mark Brown ha scritto:

> > Right, my point here is that it looks awfully like the documentation
> > (this came from documentation I guess?) is including some extra bits
> > that get ignored in the voltage selection field here.  That seems like a
> > weird choice somewhere along the line.

> I wish I had a datasheet for these parts...

> All of this comes from analyzing a running device on the downstream 3.4 kernel
> and on understanding the (not really readable) downstream kernel code...
> ..but yes, I agree on the fact that this seems to be a weird choice.

> Ah, besides, I hooked up an oscilloscope to the VCAM_IO and I can see that the
> vreg really does react as expected upon setting the upper bits.. but since it
> still works without, we can safely ignore them, which makes us able to simplify
> the driver (as no custom code for that will be required) and, at the same time,
> avoid seeing a table of values repeated 4 times in a row.

That seems safer in general if we don't know what those bits are doing -
it could be some kind of mode control or something.

> ...so, the regulator will indeed shut itself off and clear either/both the QI_EN
> and/or its relative bit in the enable register... I've also just found hints of
> the latter (enable register being set to 0) downstream, so I'm sure that this is
> indeed right.

That's still not quite the same thing as a status bit, if the regulator
disables itself then it won't try to turn itself back on.  Note that the
core will fall back on using the enable state if there's no status op so
there's no need for this logic, you can just omit the status op and the
behaviour will be the same.

--3JjAka1nrbTHhQDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKLj3MACgkQJNaLcl1U
h9DKVQf/UGKn8E+91K910/ff8+FvQzTWLerUNMOum06ibJb4I8BKQbcHMxBu0+X2
23dfHk88gYz0vd1WlsudGoJkMRZNsNOteA3QS38lEE37221ZUeBFMKV2kxkT19vf
/Q210UCz3dhF7XxwD23eWQXJDuTsMk9Z1t1wDVgLL3fqSGnLriIB/qybgOWKX5GT
/gggqqSwIcHYmoBf7sW8TsPdKCqVOGOp2Yw1cyZ0oYEtpv75uxAUSepDhFzZ7z0W
9jVXFzBhmLRl/CMAGBuFL9LQHARcQPAgnzH6KH0WG1ISkAvffqcttPQvZe9L59X4
yBnvUvGSs3ETgWrQCFkCA4WmsDwBeA==
=lRBO
-----END PGP SIGNATURE-----

--3JjAka1nrbTHhQDM--
