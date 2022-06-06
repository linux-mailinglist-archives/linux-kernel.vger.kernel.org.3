Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4766653E882
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbiFFQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbiFFQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:17:41 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5E20BEC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:17:34 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A8732805FE;
        Mon,  6 Jun 2022 18:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1654532252;
        bh=eP279UjGMMblW/RjkeTp8zITZb3eYCq6RyDyFwrQ+7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NiP6Zi5TLlJAUa34eeVil1qNPMOCzpnJ2vi3EUZ02x+nNIN/wC1eswPRa5LWX82gW
         xQsAbGE/b5fXwDTAe8gPQkVcLuwqjW9Gu2+njDvtRixFig1jguRVHf2HZer71OcUCm
         1mU0ZDBn35HZ0l5fbV4fRuhg+05hRjLKPqYs/RSE5AyyxXDl2PM6ZUE5IO2obcmome
         6j1BD5H6cQ7KTSGxiKQNxDUIuYRrvBxmhoX4UWFONLR7cY7kIyI417gU6YVK2B7UQG
         5rebzhBycZjddEqwOc5g/y3VcrB4HjpiPN67tizBDgf1F4Td+vzVRPPRIv7rAq9vxC
         IrUOLctsGkBIg==
Date:   Mon, 6 Jun 2022 18:17:31 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] ASoC: wm8940: Remove warning when no plat data
Message-ID: <20220606181731.04b6f771@ktm>
In-Reply-To: <Yp4iGvGFD9jo4WUP@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
        <Yp4iGvGFD9jo4WUP@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/3EtfwSfo=U0Fi_=NClQYqiP"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3EtfwSfo=U0Fi_=NClQYqiP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Mon, Jun 06, 2022 at 05:44:39PM +0200, Lukasz Majewski wrote:
> > The lack of platform data in the contemporary Linux
> > shall not be the reason to display warnings to the
> > kernel logs.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Given that the device requires configuration and doesn't appear to
> have any other firmware interface support that's rather a strong
> statement...

Thanks for the comment :-)

My point is that - similar codec - wm8974 don't display such warnings.
(this code was not updated/refactored for a quite long time).

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/3EtfwSfo=U0Fi_=NClQYqiP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmKeKJsACgkQAR8vZIA0
zr2YUgf/WLcHyS0nmSaNYGAiWqnLDVVXJzE7LDBHx5qszYi5HnaSvEoULIBRkLln
AbuRhbSM2WaBP2yqDQcm9YXg59zQM9WhCpuw4/Ai5G+8s9yw0vJhw54t+FCK0bqg
WvtYhHFY7VjdqkzQ7MrnoMLiG7Cjv/ZAy2l7Ba6Fmte/VL6ycMtqGtfz4ZUv0HbU
+YZ9w59YqnD4Uh5RdU47ZtNbTDgnRXilhEUSu6mMGsgeQJoNRYqtfxRva/9hGCgv
R/IYjUEBFA94mkMMD9NWQ/QteAAyclqrCxnpEFYcfPuR1Y944do5c7eOywep0J+n
tolWcSNafAhy+/+WL/n2to+BWduxZQ==
=WLzo
-----END PGP SIGNATURE-----

--Sig_/3EtfwSfo=U0Fi_=NClQYqiP--
