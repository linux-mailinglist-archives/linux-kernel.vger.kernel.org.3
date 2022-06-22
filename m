Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2E55465E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiFVKwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiFVKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:52:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40DD3BBC4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:52:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B0CFB81C12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBDEC34114;
        Wed, 22 Jun 2022 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655895148;
        bh=rwk8hgLhyEq75QrfTeWAqx8ejeRm0e1M99H+oLicMnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nX24UuZL9S4TE9/a6fogP5oLkCv/s7fHSepSKb2LVz54fUPotYpsmnEIhfOKUIaCq
         qImBTvDQ9ZRzZ0YJSI7gJA5n5i6tXJRCUO5IYQh4dWAfJ2N18IwNsGrAH+vlykRvre
         5WryU7ziTXzslzbjqacGzayPAum1ExcBrGnfiRuJSiOozRlQjrOQKTP50n3uYaGp+E
         YD7kLVD/9z0b92Q3Y+1iN0M1GpCDKbge6YO59HMXf7zjVX0fLvUuWuJnuamRPwrNBg
         XVBtKySVNv8jAklhn3X1YwYfz1TCMGwJWXkePEN1WRpMbjWn1J4eJI14QZghK8FoaC
         r89fOCTTbgktQ==
Date:   Wed, 22 Jun 2022 11:52:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Judy Hsiao <judyhsiao@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Message-ID: <YrL0ZkIKF1U2OWNp@sirena.org.uk>
References: <20220619095324.492678-1-judyhsiao@chromium.org>
 <20220619095324.492678-2-judyhsiao@chromium.org>
 <CAGb2v64WsRV_pPsD4BQOjtFXOwca5xVkrXRxyxz2OLvQqKifPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BIVYhsqQd7Iog8ZD"
Content-Disposition: inline
In-Reply-To: <CAGb2v64WsRV_pPsD4BQOjtFXOwca5xVkrXRxyxz2OLvQqKifPg@mail.gmail.com>
X-Cookie: Truckers welcome.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BIVYhsqQd7Iog8ZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 02:02:41AM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> On Sun, Jun 19, 2022 at 5:54 PM Judy Hsiao <judyhsiao@chromium.org> wrote:
> >
> > We discoverd that the state of BCLK on, LRCLK off and SD_MODE on
> > may cause the speaker melting issue. Removing LRCLK while BCLK
> > is present can cause unexpected output behavior including a large
> > DC output voltage as described in the Max98357a datasheet.
> >
> > In order to:
> >   1. prevent BCLK from turning on by other component.
> >   2. keep BCLK and LRCLK being present at the same time
> >
> > This patch switches BCLK to GPIO func before LRCLK output, and

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--BIVYhsqQd7Iog8ZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKy9GUACgkQJNaLcl1U
h9A7MQf7BlCSyORrbv1Z1U1fwvocqMOp/zQ3ScF3gRjRuDSNSrc3rkFkEHkeviE/
1LpuBEcnpUIETJy3OltG1wNBZDQwx7lvGEhCEqn8JWCmdX9njKXd4tdU9Zs6/37v
nTJwRCJajfq+qlLJZIMjdycECSojoUe2VSQwwe+recGeE+glYfFMLD1JuWsHU/IO
LhhFX7Xt9gtFPjZ+lavlytNdY+r9F7kttndFGKy9gcEIw4u23tNIde48Fu0Fr5JA
9fAMlQB8BV4bgAwet7As6wudbSaK7xbmUPAxnK9bX1P44XO5VmmuCbtzZM0J09Gs
Y0IzBvxAq8WKbOfhZzfTE9g4wYjzDA==
=VY9T
-----END PGP SIGNATURE-----

--BIVYhsqQd7Iog8ZD--
