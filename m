Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62578579772
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiGSKRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiGSKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:17:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054EC1A3A6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5363B81A5E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A61C341C6;
        Tue, 19 Jul 2022 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658225835;
        bh=oqP/Xh2tpjQDFtuqBkRGg45SMZ6PZlX0tyfAB133gG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNiTzVqGEMb0m3WuaWF2J8hrKZG9/NUMZF0EjjtFOmnPHvy+0SUejkjyauU/WhEKX
         Q6eTE1ZZK21BRLYD+WQvlCfqtKwD0BLgjXM09FnbooacQqKeR21+aHtI5s5N/2te8f
         LBwFeqCOXFo6rGwCZtQUle0JmUYolWZLmnOTTQs7rlFSJjix8NRQ12IpAjXtB317N8
         dMCxzp9kaDnAe+LYaipi783nt/+kODAQR58rb1JzpCS7mR6mV27bpGRj4l754z50C8
         AvKB3XQa8irExShPCo3OYdiMez9cA7Gbs6jgagauQbJbWiBMCRWFRWRNmW6U2rjPzo
         V/ByuOXK9SeCQ==
Date:   Tue, 19 Jul 2022 11:17:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Shengjiu Wang' <shengjiu.wang@nxp.com>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 2/5] ASoC: fsl_asrc: force cast the asrc_format type
Message-ID: <YtaEpf6Cd7KH7wH4@sirena.org.uk>
References: <1658222864-25378-1-git-send-email-shengjiu.wang@nxp.com>
 <1658222864-25378-3-git-send-email-shengjiu.wang@nxp.com>
 <f2609401c8834e8bbe926200bfc87971@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LFRJZB4yNeG2Q0Le"
Content-Disposition: inline
In-Reply-To: <f2609401c8834e8bbe926200bfc87971@AcuMS.aculab.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LFRJZB4yNeG2Q0Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2022 at 10:01:54AM +0000, David Laight wrote:
> From: Shengjiu Wang

> > -	ret = of_property_read_u32(np, "fsl,asrc-format", &asrc->asrc_format);
> > +	ret = of_property_read_u32(np, "fsl,asrc-format", (u32 *)&asrc->asrc_format);

> Ugg, you really shouldn't need to do that.
> It means that something is badly wrong somewhere.
> Casting pointers to integer types is just asking for a bug.

That's casting one pointer type to another pointer type.

--LFRJZB4yNeG2Q0Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWhKQACgkQJNaLcl1U
h9BPlgf+JGVf/ji4pgeN+BGwYdDo93frPQL5cU/EaCnDYcwQa1TAfhLTCpDrCsui
StpSb2FMjgupXLjNy3oQfKO4tNg6xc65g5EjKLp3yYOoqx9AZPpZc7jt6FxA2tKo
UBKw6FlfQALG7nEGPFIpTNHJUh/dzi4f8oHH7KTPgRZzFSxshjeWi6cMcOS2TPa1
tEqbOywPpR9d30/vRLa6bjUOCRw07PpHcAg2AcHawKHc6rtq7BHKU7GQavNFj7pK
MIRBHFc80by53rkgR6ebwloSVluV0cJv7TIMY8U5kginz5yypS+GVNNzq2m6S+lI
lKjTbNKherzmaXwg+nnCV9Sg1VoaYA==
=Ewrl
-----END PGP SIGNATURE-----

--LFRJZB4yNeG2Q0Le--
