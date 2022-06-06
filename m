Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4876D53EED4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiFFTpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiFFTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:44:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE2564D6;
        Mon,  6 Jun 2022 12:44:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3E36B8198B;
        Mon,  6 Jun 2022 19:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D122BC385A9;
        Mon,  6 Jun 2022 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654544687;
        bh=TdyzOHBijyDDuJa2kymQDu3XUPAwTzmKg4DRuJ4dnrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfuwYUHQcSCTFzs4dSzoQUcCQF+ZZHaLVUn0UV2rRBcCmdFfEhGh4NnKetgvUk1kI
         O3LAEHez8RgANUrufP2o/DWqEtA6dihYZEqwTKKHZp5348tIXqvii4XljVl7dEZB+y
         DykCz2bL4OOTh3E9WAaR9B70f0zqex800F83+hTZpmET7+ZXofKcLNe2iJ/n8F686P
         ebQ9auP9Dz9pv4F6rzmNLwCGICqCU4deKMQtmn3da/jbmB6dclsKHSkje9jJUUDl9J
         otobhR/BlmJMPh2NAx0Wf5qo6D0dj5J/LEfzJ/qCkcpPSz+RBd350XJLhb9kLRql/m
         Zty0pLS61y7Pg==
Date:   Mon, 6 Jun 2022 20:44:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: sound: Add Apple MCA I2S
 transceiver
Message-ID: <Yp5ZKZ+MOW/75KXi@sirena.org.uk>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-2-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AlCYaszFUFMsVBIw"
Content-Disposition: inline
In-Reply-To: <20220606191910.16580-2-povik+lin@cutebit.org>
X-Cookie: Have an adequate day.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AlCYaszFUFMsVBIw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 09:19:06PM +0200, Martin Povi=C5=A1er wrote:

> +  interrupts:
> +    maxItems: 6
> +    description: |
> +      One interrupt per each cluster

Other properties are specified in a manner which implies that there's a
minimum of 4 clusters, eg:

> +  clocks:
> +    minItems: 4
> +    maxItems: 6
> +    description: |
> +      Clusters' input reference clock.

--AlCYaszFUFMsVBIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKeWSgACgkQJNaLcl1U
h9Aqfwf+NBQXCTVBk663Vwcd22hz9vBXtdVIMfmgPBYszdHc/ZlYb3vSsd7l2Cb4
SvxdYa7uixpvVOi1yoFW0M7G4fBAVHT1PEt9s2sRkE0iFu4QcOaUfKDyo8pY9jdc
ak3EHjJ74hPZtcHSF4KfFkKIJm6kl7mgjpATzUfhi8D1GGDXmyaGBBncDgCvUnEl
ulVKVpRQcd12KVDLfvzZZCDMIJOiZO6WF5F3OtN0alwfekPGU9poRs+QxpjAWxHf
Q8WIk7rctnKt4HREyq7egXNJuG3V06K3jzZnwIT7P1n9ye7RrZH87PR3oLsQIVWd
zh6Ibuyl9Ia2Zh9q4RLPcaLE+mbYUA==
=TRq/
-----END PGP SIGNATURE-----

--AlCYaszFUFMsVBIw--
