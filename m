Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C2566903
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiGELSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiGELSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E69215A09
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEEA961180
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E4AC341CD;
        Tue,  5 Jul 2022 11:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657019893;
        bh=eIpaiQzN1dQzf3QUOgYci66EBnivRL2tBpynLfqIPaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRr8nRu8ZiG9BE6VYc3ZhwPPPSY6zejoCJWcyrxSF+3X/o6qAOgga0gRcHF7zoBdz
         ZjO9qhYH2gpjcs8mIvU1qOtqEOBVsLXGd7ouy+UbxYN/kHPHG/O74Yh/kVfnLWMhhn
         a/foZp7MylCLC0bZBdwQw1TZZUIvCeIlpDsUxCa2guhASCrvI+4Y7d35ynbB7K4ANd
         VSYuyIV8rzLSMI3/ZFK0y6eJhS+w05ArwZBLMJ80fgoNa2sf0iSEqf6hiAm4mfB5GX
         whCW6icbB29f36C6RBtZUgzFo5yX3fq8yuMqLHswMvCIeRdWrvff9i4XjNhLkFEC8r
         3+QDnIOwLaOZg==
Date:   Tue, 5 Jul 2022 12:18:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: equalizer cfg in max98088 driver
Message-ID: <YsQd7mub0KJdYUDw@sirena.org.uk>
References: <20220705075500.GA1987744@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jiEe/WpmUIOBm7IC"
Content-Disposition: inline
In-Reply-To: <20220705075500.GA1987744@tom-ThinkPad-T14s-Gen-2i>
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


--jiEe/WpmUIOBm7IC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 05, 2022 at 09:55:00AM +0200, Tommaso Merciai wrote:

> Just a question. Can you explain me the proper way to configure eq1 and
> eq2 of max98089 using sound/soc/codecs/max98088.c driver?
> Could be a valid solution fetching eq1, eq2 bands params from dts?

There's plenty of examples of equalisers in the code already.  I don't
know how this specific device works but generally these are either
exposed as a series of volume like sliders or as binary controls.  This
doesn't restrict people to settings from the firmware, making
development of new configuraitons much easier.

--jiEe/WpmUIOBm7IC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLEHe4ACgkQJNaLcl1U
h9Cb/gf/RzD6mvd0NCfT6nAaNnVW3DladJyYo6d361/zwj1+xMIKwWgoOUgHaZxa
XFJ1EcBz3jR8xU+cYrMPKJUHp//ZOtZCVzBi0eYN9XIKROgv+vwi7PSypHi6TmI/
MrCp4Sv1F9QGU2Fkrmt7rPR7Q/Xjmq38mGF1WHe7C8pXCoja2g0Qm0QdqLXgjUM5
KFApmU7rNrMidL5JZo99BXUXBkJXtFSlNVKQIxFQetLdzq5LCHuq7L7sFJVsZO/V
L203bLlhYpJ619w2bV43gicKxqP/tFUa3eskAj6tcMpVoj/I0Je6pS1RNlTQxqFC
1Etq67paBflGIpt9Rhf8onu23RAfdA==
=uxw9
-----END PGP SIGNATURE-----

--jiEe/WpmUIOBm7IC--
