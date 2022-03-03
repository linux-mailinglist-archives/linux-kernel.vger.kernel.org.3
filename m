Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9367D4CB7D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiCCHaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiCCH37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:29:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D122607;
        Wed,  2 Mar 2022 23:29:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K8N0150d3z4xbw;
        Thu,  3 Mar 2022 18:29:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646292548;
        bh=qHElhGY8fx0IVkA4MKaoAT7SKM+zW+9ViYbBstwm0qs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aIyY689iO5Ub2F3h0/YJn7qTudOFn5rwYsr0nmJi1qb7/hdplSA6zfgtIzjyWFa6v
         yW51QBkSrGmBySUO4PvmQuDWzEjknWQ/Q909NxxG1ym6uw1xXf177Ob21kqQ3CpA6n
         XiePVycbfe4sjhkOy60jrTT8rvUOIBW4B1H0AoaSkB0CQv6lq4nDsfzj5goc+SNjJ8
         nx2G65gOYNO9Wx9Lb/q36Bnne/C4cvK+ogKbp0TTF3kUsil/mmTF2yZNn3LKpAjoQn
         0s+z2ioFOi3oGL8+OQGKhh7+yNbsFbOZ0nZFAjhWaGZupZeK9wKRvtQbsb5Qq3fAg8
         sPF1FaaAUTX9g==
Date:   Thu, 3 Mar 2022 18:29:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Robert Foss <robert.foss@linaro.org>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        DRI <dri-devel@lists.freedesktop.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220303182904.43c5b1fb@canb.auug.org.au>
In-Reply-To: <20220302201610.56ccfbc3@canb.auug.org.au>
References: <20220301092730.10de23c5@canb.auug.org.au>
        <202202281453.C8B840C7@keescook>
        <20220302201610.56ccfbc3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YxTb1i_/VP0VO9/qtU0JIP0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YxTb1i_/VP0VO9/qtU0JIP0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

ok, today I used the current kspp tree and added three patches as merge fix=
ups:

https://lore.kernel.org/all/20220228081421.1504213-1-hsinyi@chromium.org/
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Dd4da1f27396fb1dde079=
447a3612f4f512caed07
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Da2151490cc6c57b368d7=
974ffd447a8b36ade639

(the second one required a bit of fuzzing)

I will remove them as they appear in the drm trees (hopefully).

Kees, you just need to remember that you have a dependency on the DRM
patches being in Linus' tree before you send your pull request.

--=20
Cheers,
Stephen Rothwell

--Sig_/YxTb1i_/VP0VO9/qtU0JIP0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIgbkAACgkQAVBC80lX
0Gw4Ngf9Hh9eVHWDQaSTSHnrUIHmluK7vvHnUi0Pjx7xKwZQa3sRpGhNgBE28dgp
GgvFpjgLlH0zTebqMXovp17jeyylA198sromn6QAnrctzTQskJAIG/TAYI71FMGc
eAaU2FQae9QR581hBTZVG6MZVxSWkMPJRUFly7FOO53QHk5xbWH+Z5JcztX9L77S
5h3GpvbPij1uyybDjwfj8dm06gA1NYd1pyqgZJo0kzvCtSzManYdTfyRZuZk+vmS
9/I1MdCHCUElvpGnEqfitzO6JCtFa/05jQa6b2P2SwDUhF4SErOW9Y3+47vCIx9y
pUiPzw4KbXxKt6mGlaqjHmxFoNGmRw==
=4sHe
-----END PGP SIGNATURE-----

--Sig_/YxTb1i_/VP0VO9/qtU0JIP0--
