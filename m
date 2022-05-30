Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477F538421
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiE3PKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbiE3PKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:10:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3243386
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 964C0B80D83
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A30C385B8;
        Mon, 30 May 2022 14:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653919708;
        bh=6yJwH0Qtege0fuuWHs7JPfABW5rmIkEq/jLLe+CmRzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1f3GrY9+U+HeLvwqqAKYP47U7iTcvJBrSMMllVaow2UUZ+KwaXx7nfmbYfSOY8Gm
         bYI+O9PH8zJG8ZpiPx8D+0f7PHTVLcZy8f1MvJSE69hEUj/DDwJNQJ220qZLXcc0TC
         4KI9PuOvrXZ+IFgYpITnyUsz5jPtJuOt+l3pYwijdU3Q4rU9D4DrkycjQY3I+SL482
         m9LWu9tnV0kW/K3g1hAwbwTvDJTA0Qu2LTE/Nm0XHhAWtjyFbhhAIY2evZMApO5XJp
         8oevlYAcegECpNW4jF3AuBUgIY1g2aoR0DCLR6B3nXsDQjrofMhc/Ob2AnpETV2/ym
         +I1MolQBkhjVg==
Date:   Mon, 30 May 2022 16:08:24 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V0 0/1] asoc: msm: use hashtable to check kcontrol
Message-ID: <YpTP2JOlCiYb3lBf@sirena.org.uk>
References: <cover.1653813866.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aIU0NN+cmsmUm//m"
Content-Disposition: inline
In-Reply-To: <cover.1653813866.git.quic_rbankapu@quicinc.com>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aIU0NN+cmsmUm//m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 29, 2022 at 02:20:08PM +0530, Raghu Bankapur wrote:
> use hashtabe instead of linear list to check kcontrol before
> adding them for improving early audio KPI.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--aIU0NN+cmsmUm//m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKUz9IACgkQJNaLcl1U
h9ChTQf/duQmG7wg4bgtA5ruZ3mBY8YxW6zE2kB6eqkK00oVcl8BC5+DLbJMf3JT
cRJrInl97+FLPrAe5+IsILEucvqReiz/Vh90tjpFYD4MP70CCyufAP5eSuyvWaw0
737IcMy/8iopHT07ME/Q4phDk016xu0G4Iz7AJOiW9ksELBo7RRvvE/HgtB1ePRM
EpWJzYamz2MYdWgWudkfEoEkHKIN+Lh/i7h+EmqoW1+cKqqzejVIBxkxi7C8ZAZT
CPKhmiamN/+xb9UlTTz1vOaswdNcr6/SJFVKNNCvubKzcMh1KTiYNuoHJVu9EWy/
b5Lx/nYA6OgE8CCdZ97av2i4n+CEng==
=ggfw
-----END PGP SIGNATURE-----

--aIU0NN+cmsmUm//m--
