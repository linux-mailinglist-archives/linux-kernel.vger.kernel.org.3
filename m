Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81598581CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiG0BLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiG0BLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:11:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C95DCE24;
        Tue, 26 Jul 2022 18:11:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LswhY6HC8z4x1f;
        Wed, 27 Jul 2022 11:11:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658884270;
        bh=kVOdgfUvMmBH9uYflpx3vVK+nb/gwC2FgYvjYaa4L+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DI5XWWFmsnD3WZOUTlxzOnWJsuKRrP5TlLMmxucQR41tjwBddahKsFpOEKjzrQ2dC
         iUmFnja+6dPb0qu0hYV/msiaBacAcpDB72TfPuEEoYpQtz3x7Lc/Z9ZYae25u1h3EJ
         hRXZZ723JVZg590q9aWvx/xLjhuQgtfg/7aSuMIuQhMVD6AGS8gQ3FxGuBBDrhcFJf
         QSCUTOz4RTAir+lLGor4hvKZ08kehUAy20yvS6e3yHWEiZYxV4lj1h9rU4H3MDpKON
         ZLKxR1l+E9ryJDmZv1iwB7ONLrzOAkbBH3HjOp60JURjRPFnjX78OcrW69oooPQIFs
         Ulv3nv1c7cdYQ==
Date:   Wed, 27 Jul 2022 11:11:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Aashish Sharma <shraash@google.com>,
        "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the hid tree
Message-ID: <20220727111108.37946dc6@canb.auug.org.au>
In-Reply-To: <nycvar.YFH.7.76.2207251142040.19850@cbobk.fhfr.pm>
References: <20220725104035.15c2e506@canb.auug.org.au>
        <nycvar.YFH.7.76.2207251142040.19850@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QbzsqsO55K4/M/8Ad6btqPb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QbzsqsO55K4/M/8Ad6btqPb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Mon, 25 Jul 2022 11:42:26 +0200 (CEST) Jiri Kosina <jikos@kernel.org> wr=
ote:
>
> My fault, I forgot that this was actually already fixed before by Daniel.
>=20
> Dropped for now from for-next. Thanks,

I am still getting the error.  Forgot to push?

--=20
Cheers,
Stephen Rothwell

--Sig_/QbzsqsO55K4/M/8Ad6btqPb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLgkKwACgkQAVBC80lX
0GxMlggAnhIOlvg9K6seqydMGwnUEBQ/6KahxrPdNwiUHgaesF/6Azg/5syl1a8D
0AzYwGpQYswoXZeNOSd4ET6dHPN66CrAyLy2PxKwxUUnIjhCO9Gj81DfotJV9gU2
njB0O+giOylcQW+eW7osjhzFL4NmGkpgJDTKEzGPEJ1EbgGmEMLlGGgRR+pWHkum
aN/IYDM+k3KJB5zlOMxjVHhtWjmRarqUTZWSprynh8yRRLYoV7giQqKKVVBydwMm
HlW8dzdtJPOrpcxPam62VxpnKgQA6LcO5/QdLaoYF1vU5OZ1NF3wX0rPAL2vI4mt
u2QM9aQzKCtnanXa2/m6NZP0lHJo0A==
=AKMP
-----END PGP SIGNATURE-----

--Sig_/QbzsqsO55K4/M/8Ad6btqPb--
