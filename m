Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34B567934
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiGEVOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGEVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C114D15;
        Tue,  5 Jul 2022 14:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E1E61CDD;
        Tue,  5 Jul 2022 21:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F787C341C7;
        Tue,  5 Jul 2022 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657055648;
        bh=tM3Y0PjqNoMYIXHgfUZVzlLb92QWYsPd7cmjz6Jh9dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgfCx/80fWnbVR/dxr47PRvwzTtcQ1a5c0Y4Ar9ALWvv4rrmkdc6aTOUHjXtQTY1t
         0/ZVro2mx8ABmys8IZMc1Fma43BqE3TpZbr/WIzBxHEHIf3N2/Mec+CbpyuMlQp7xU
         34VzZMk7NMiZ83qoakNZO02RPIq8XokmqXXQF582P3SJ16Dn442usbAwB5BiR4lyx2
         VJJAR32WU2JX642WuV4IEdPEQhXZRqNuoZ3u/Nu1Wf3CxrhN9IsjThhnHu3qRzn2xk
         QiFu6WlrzWGc1jCmpjPKP7Kese8OyDycfPQHWAzudCvm5KYQg/MQUWwCT7Gmd7yIsa
         Ovxox8NQRf0Yg==
Date:   Tue, 5 Jul 2022 22:14:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     lgirdwood@gmail.com, samuel@sholland.org, wens@csie.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        perex@perex.cz, arnaud.ferraris@collabora.com,
        devicetree@vger.kernel.org, tiwai@suse.com,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [PATCH v2 0/3] ASoC: sun50i-codec-analog: Internal bias
 support
Message-ID: <YsSpmi5oS0po5Cv2@sirena.org.uk>
References: <20220621035452.60272-1-samuel@sholland.org>
 <3139722.aV6nBDHxoP@kista>
 <YsSl+JOmMpGLK1Xc@sirena.org.uk>
 <1819721.tdWV9SEqCh@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFZaAzCh3SOfFu3b"
Content-Disposition: inline
In-Reply-To: <1819721.tdWV9SEqCh@jernej-laptop>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iFZaAzCh3SOfFu3b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2022 at 11:04:54PM +0200, Jernej =C5=A0krabec wrote:
> Dne torek, 05. julij 2022 ob 22:58:32 CEST je Mark Brown napisal(a):

> > I can if the sunxi maintainers like, but normally changes to the DTs go
> > via the platform tree.

> I am sunxi maintainer. Wouldn't my branch generate warnings, if I have on=
ly DT=20
> changes but not bindings?

I guess, I think people tend not to worry about it so long as -next is
OK.  The issue with merging things through subsystem trees is that it's
very easy to generate lots of conflicts which tends to cause more issues
overall.

--iFZaAzCh3SOfFu3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLEqZkACgkQJNaLcl1U
h9AQZAf/frcrYF+gmNPeu2uFxUpNDw56EVnbALGZzBK40MfZlAghi7S8G4LcppkD
QJNkx/W/7mVjv60O+OvqY+9sq1v6NNmxWVtY26OdpE+qcrOA9wTfHcfMQxoiM1/o
bNcnjpOHdIfhamam0jD0+E3OdtyRbkF+1YDmMZGrT82dQKRlBXdLKmv7x/PHBTFz
zdIf6nPW9+p2CudZLnRgb2xDpWk486f/toymBqYqH255j0sOh+Irdp2ut8L63uOz
onJq+Nh0MYAsUcc+/d3b7UEQpDXerhEyYLnSd9bKpB7Kn0O3JBDiDSct5nsV3QFC
Elh3zbuoCBbWUpWNAxDeoRzg9s9ejQ==
=ld9x
-----END PGP SIGNATURE-----

--iFZaAzCh3SOfFu3b--
