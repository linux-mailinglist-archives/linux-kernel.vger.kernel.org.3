Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C71B4EC676
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346817AbiC3O0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbiC3O0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:26:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F715FE3;
        Wed, 30 Mar 2022 07:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5FA0B81D4B;
        Wed, 30 Mar 2022 14:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F97DC340EE;
        Wed, 30 Mar 2022 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648650258;
        bh=8mGhUsP282BlInxzYzns/CDUIBuGHFUwBxqH317vbiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQkJxwf6qzT0NoAl/UXsj4Hc+5tHiEnQ52giQEXLKNANq8yCfIyEpxPSrkZx5UlhX
         kME5m6BljI6TEs5IcgxKa/AB7DOGHrCWPlahmcE8cUuW40U+zkdmI65Avc8jWV6Q7M
         UBzP4RRsJlEF+dKKHEXwIfGnmAVhjRRfJTi9YJ8LSM4ZvHAV/BNoDumoK7SHaa8r6H
         AFwSkLy+uUkmeU8HFYbTVWaPefLN1A65DhfqTJjQVuKghpq1Awj2I4yZvNhH/wiOIV
         vMbzyqLs6Zc8BOB8iLN+CWMCsxD/2M3qpxVOocVXf3b8zkjb4gPvAzqxN3YU4ZJsUk
         cyMELuCjDI3dg==
Date:   Wed, 30 Mar 2022 15:24:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, robh+dt@kernel.org, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [v7 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
Message-ID: <YkRoC30JLDMeVi1B@sirena.org.uk>
References: <20220324064511.10665-1-jiaxin.yu@mediatek.com>
 <20220324064511.10665-3-jiaxin.yu@mediatek.com>
 <20220329223002.uo7kiemopkh7ak4x@notapiano>
 <dee3fbb7c9f0c3e1f11143db1d6fc4381cab827f.camel@mediatek.com>
 <YkRNSoBKFvYYyZLu@sirena.org.uk>
 <61e9fb59448837cfc8e3ec862b711294bcb68872.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GNUxLScWaSBFpiDm"
Content-Disposition: inline
In-Reply-To: <61e9fb59448837cfc8e3ec862b711294bcb68872.camel@mediatek.com>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GNUxLScWaSBFpiDm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2022 at 10:06:24PM +0800, Jiaxin Yu wrote:
> On Wed, 2022-03-30 at 13:30 +0100, Mark Brown wrote:

> > Making a previously optional property required means that systems
> > that
> > previously worked may stop working unless they update their DT, DTs
> > may
> > be distributed separately to the kernel and perhaps even baked into
> > firmware or similar.

> Thank you for your detailed answer. I should keep the driver's behavior
> consistent with the description of dt-bindings. The "mediatek,hdmi-
> codec" needs to be set as the required property. Is my understanding
> right?

The binding document and code should match so if one is changed the
other needs to be changed too.

In theory we should never change a previously optional property to
required which would mean that the code should be updated to reflect the
binding document, however sometimes the DT isn't actually used as a
stable intereface by anything for a given property or device type so we
can get away with changing things.

--GNUxLScWaSBFpiDm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJEaAoACgkQJNaLcl1U
h9AhxQf+PZuCmGnFAmuUHNlVpmiRjr++vB0m1T22WhLGrda5HR7LQ87SMHwwffi9
xnkVrr30xgbSxZy7Sn5nfjPAo7EfnomIxlDu50xmlNM5nXoIchxDl83NiGRcHoWT
RfiId1J9P5ztudpTLcVLbj+uN5rLunutEkcHBWBxKymDy8wLA0nIX9fsER8xk8Zo
L40Yv45UohIvFclHx21U+eBGenN5kJKih02NQTvbcoy2Cjh/iMCWPprQLpjpY5s8
s/8dnyUGWx9SUBPfJJdtecq3riFE8MbQQrRLi1P+CaOfIonzYv1L0yEe5+7kBQHR
WZaz1EZs9fORae+t52imAuWFVCd0kQ==
=UCGf
-----END PGP SIGNATURE-----

--GNUxLScWaSBFpiDm--
