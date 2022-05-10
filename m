Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0C5213DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbiEJLhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbiEJLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:37:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF349695;
        Tue, 10 May 2022 04:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC669B81CFB;
        Tue, 10 May 2022 11:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42477C385C2;
        Tue, 10 May 2022 11:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652182392;
        bh=QilHbgP4OJJFhu6pWZ/iD/7nzOdj3ua+XvagKgVvp/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5/ij1/HwGtN9IwgdHuFn/51Mo5tG/ZR/teTcfU6EycepK8Jm0gvxTFHKjuhJcb8r
         hkgL/QGAYBGixQgIRMl0r1Ur+ayk5AVNhQUodp4wqhulX9FcBZqS66bps2rl7t4cP7
         eafSAKiQL8KIcYf8P82Z9LDDccNzXz7wHSUr/khhkzT9vedyENzv4v/HXIfAg3ychL
         DjZq3oJFWd0+2Pw1V/itE1SlE5hvnZJNpKrzRtOVtwAuu0RUv4P9gEb04HcBbS63Eu
         oVstgiCK8JUHdj277lGUPkIVNQYiLVlZb6nXGjqjS4QTIbMPgvEAwL0U1ge2j+BWhh
         UFOAeW8sHZvbA==
Date:   Tue, 10 May 2022 12:33:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, eddie.huang@mediatek.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        fshao@chromium.org, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, tinghan.shen@mediatek.com,
        hsin-hsiung.wang@mediatek.com, sean.wang@mediatek.com,
        macpaul.lin@mediatek.com, wen.su@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pmic: mt6366: add binding document
Message-ID: <YnpNb258/JRSjZFQ@sirena.org.uk>
References: <20220510064603.15920-1-zhiyong.tao@mediatek.com>
 <20220510064603.15920-2-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eivqfnsOGQBavwky"
Content-Disposition: inline
In-Reply-To: <20220510064603.15920-2-zhiyong.tao@mediatek.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eivqfnsOGQBavwky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2022 at 02:46:03PM +0800, Zhiyong Tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
>=20
> The commit adds mt6366 binding document.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.

--eivqfnsOGQBavwky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ6TW4ACgkQJNaLcl1U
h9Cqhwf8DVRTOtYWL6Y7xwHw2INdvAT+AmpFFwIuu6NrjGJzK88XnPHoXaHGBRhj
RnVchCU8AwLEohvJWg3hNTw5u/nOgro8PPhYZ8O6jnmqy4MNpYEUKfsYdiUjjtTv
PSpUp9RDJAyJ+Ug2eywKFEkMg6+zrQkayzqet6c1lKIaRUA+L6ldgpRSen8qAccC
8CGa9YAcmfuhKln7kpeVLWjDKpQybh0kWmiOZYLluu61rj32X+UWwULTPm/CRw4W
VZyUpl6B8COQN/HwPMfuAvzLmrw8TP/DAiAKXCSr/3382l0iJNdjQ4v3YSHKSitW
lhkIok52I973FY2hPvXt8gOsoFziEQ==
=T3z5
-----END PGP SIGNATURE-----

--eivqfnsOGQBavwky--
