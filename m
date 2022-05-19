Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E940452DE14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbiESUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244441AbiESUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9AD72217
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D5DF61C58
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032B7C385AA;
        Thu, 19 May 2022 20:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652990847;
        bh=VjzLZNFWnq32OoJjiMnVfMTg9IEgi4OMPr67a9sVT3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7JCdV/77UEkDqiOpRsCd+YOdaFP5aV4PZSTcuZs5m4pwtuUuzfC0UK76GwekffzR
         h+cFXDQw9e46VY4aK0TjDV5DtodUPSgG/qJQUgdGR3wGNzcG1FKqjPKuYmNPD/v1xN
         UzgAUs0TP/8hbnRaz/8LYvKF4WBeUKZcUJUPKwrFl9RDr+hpYELOHr0ygH2KHD10jo
         fci8ilsYXqWMhMIwjH1IvrTFXCyOohou3d4FlxkM5CnTehuiwi5UO1vroGzil4+Zq5
         ve8OJOL0ljGdLL9XDzxEmBTo2RIGenwYIwxZ7pxltyJoGxybFEr10gWl88FjrH65s6
         rshP6r3hP236g==
Date:   Thu, 19 May 2022 21:07:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] ASoC: max98090: Remove unneeded check in
 max98090_put_enab_tlv()
Message-ID: <YoajesD+D1W3ZV7/@sirena.org.uk>
References: <1652980212-21473-1-git-send-email-khoroshilov@ispras.ru>
 <YoZ+dmprwb5Ohto3@sirena.org.uk>
 <fd58c07c-488e-1c90-a755-194f714bbe45@ispras.ru>
 <YoaEXWGEY4s14je+@sirena.org.uk>
 <ce6853a9-6789-f151-3193-59b7dd73bd27@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jJAdLz6GK64fEyDl"
Content-Disposition: inline
In-Reply-To: <ce6853a9-6789-f151-3193-59b7dd73bd27@ispras.ru>
X-Cookie: Some restrictions may apply.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jJAdLz6GK64fEyDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 19, 2022 at 09:27:25PM +0300, Alexey Khoroshilov wrote:
> On 19.05.2022 20:54, Mark Brown wrote:

> > Oh, the check won't be working properly - it's just that like I say the
> > fix is to move rather than remove it so it's operating on the signed
> > value.

> Do you mean something like this?

That looks about right.

--jJAdLz6GK64fEyDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKGo3kACgkQJNaLcl1U
h9Bajwf/eGaouPOu8j/aU4kLc3j8bxbcRDfzLtUFL2wwu3VPEXy8/ToXspVWxomp
JfUUtlcpdCahhDwSJ0uZ2aKUkWwmbPhjKH6iUrz2Kn/a4+m4MhROZMRUf1VAj+O8
r8YFZ6arWauRMQRPSVWfznlJlvnipMkfUMzFwYR0DeCWOt8+wrbybaEvFx3bQVG5
z0SMkWqoR75sL4e7lhy+aW+uENAMND8ghqbZu3+uxhvKdhkHEMlj/pHoj5AeAGya
FjP+osfPtRa6nR0kM373UhZHyADEV/A16xLf6ttYbn1m6/g2mPAkypZ5axYaAnAM
8XQvvNrRZkoQqKQijhGeztx0I+0LjQ==
=/nHu
-----END PGP SIGNATURE-----

--jJAdLz6GK64fEyDl--
