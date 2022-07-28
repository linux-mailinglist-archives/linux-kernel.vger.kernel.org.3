Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBCE583CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiG1LO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiG1LO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D266AE4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0EF961A4E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768CAC433D6;
        Thu, 28 Jul 2022 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659006865;
        bh=oXhKn484H8C4pSVsSAWT8FrTdxHfNXnO2/Oj96hh46g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecLDfjwfJxwxl7WL4Paa0dE9dnRnnddjlcSZ5n7EytRN8TpOVVUzlbYgO5njHL4uL
         FCpXsWxfjmdoqcX8cwxnN+XMiJTBZPm2i7Bs1kv+jvtOEuJTQQoHcPXv3aAa47SE4G
         PkxRIClibkhbMKJTF3jxT62/AshODfms/IA+1zds2vSoRyci+nVCaaDeFPOYUM4ve9
         7ck3gppV/uCUadE3BN+hMbddSeqp0rBBOJg4EkYgO6ZvKsH0tC/qqSwFD/eU9psQCp
         m2Tr9bd4tRyt8OJR/TzHrrAM6sSQB/EecxcgLFp4rHrsZg1ZjsnbHttkz+XwA/5hDS
         8U+zgAsmgx8cQ==
Date:   Thu, 28 Jul 2022 12:14:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Prasad, Prasad" <venkataprasad.potturu@amd.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Reddy, V sujith kumar" <Vsujithkumar.Reddy@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: amd: acp: Initialize list to store acp_stream
 during pcm_open
Message-ID: <YuJvi6IdbPyJWKUq@sirena.org.uk>
References: <20220722133530.3314087-1-venkataprasad.potturu@amd.com>
 <87h739464x.wl-tiwai@suse.de>
 <PH7PR12MB5951A322E8613E1A782ACCF3E9969@PH7PR12MB5951.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="djlTOc+vqayQK83P"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB5951A322E8613E1A782ACCF3E9969@PH7PR12MB5951.namprd12.prod.outlook.com>
X-Cookie: People respond to people who respond.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--djlTOc+vqayQK83P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2022 at 07:52:25AM +0000, Prasad, Prasad wrote:

> linked to multiple pcm device as we will have same dai->driver id
>=20
> or array index for multiple pcm open. Initialize new linked list
>=20
> stream_list to store opened pcm stream info dynamically.
>=20
>=20
>=20
> If an IRQ handler refers to the linked list, make sure that no list
>=20
> change will happen concurrently during the IRQ handling.  It seems
>=20
> that you have no protection for it yet.
> Yes, linked list may changes concurrently during IRQ handling, we will us=
e spin locks in the next version of patch.

Please fix your mail client to clearly identify quoted text, it's very
hard to read your mails since (among other things) it's hard to tell
what text you added.

--djlTOc+vqayQK83P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLib4oACgkQJNaLcl1U
h9CUMQf7BkXcYCSXzOPB2U5KyrOlXFxo/iePJ+LMnwXcK6XPHGwNqfIl3iQ2kBzz
HNgn7TA4mo7cKULBTZrXb3yx7Gn+lRYsZ/PfMQLbOX5hjUhGqEJEZA/6HxQkiP6J
++vIRGFtrqlNXV8emSJAurT1m6IikCD4PAmJOPyTzNHWHV9j1U7dfEwfY2XSxfSb
j9cB3geRNNb+jHxls+s8KTa/3E83/Krkyq1sAKH1UklL7X71KR4R9k1M3RU2ZP3o
4jAXneq6kLpEog7YnKsnASVbRZfdhxvO6WiISeHygrtESt5UvwTTWK68uh6QowvZ
cfDSAD0IJDBtvzFofrJ5HDbVfQgU4Q==
=/414
-----END PGP SIGNATURE-----

--djlTOc+vqayQK83P--
