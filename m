Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1A55A58F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiH3Bsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH3Bsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:48:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E67C8983E;
        Mon, 29 Aug 2022 18:48:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MGqw06dNbz4x1D;
        Tue, 30 Aug 2022 11:48:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661824113;
        bh=ilceOORPjDzxo7W91qMENJf1kMJzNlEbJMGGFT9VrZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DJgBbprOBB/3R9inbnm6E83JJOJV8lW6iylRhoprwCoUYNC7LDwC6clLTFXtqzz6E
         gZF/K2gKBBxoAd2lgVWU0AAzNbBUl/6vZ7/elTqF0gw6l2L/+pJC9MwpQIJYeRRNhT
         VgkPn9y6A4RRHMM2U+od/U6knJnk6AiNKdaF+0rYkrgQUarhzzRwqnXsharnRREd1R
         mpf/MhLS19kkoyy7jl7gUI/DeMNcqiHAnqsOvtlCddW//ITrKB42qxLVdSUXTWx0sq
         VhhwvwAoOd8TfmohEvuR1eTVGA8100G/Yn99MtbqVJRmGxkZSBVPbBwn8xeMXKc5WY
         OR+nwFBkfnFCg==
Date:   Tue, 30 Aug 2022 11:48:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20220830114831.28cccc46@canb.auug.org.au>
In-Reply-To: <20220811120501.15f84a79@canb.auug.org.au>
References: <20220811120501.15f84a79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y+jYHrREk3/UxCUOS1OqZq/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y+jYHrREk3/UxCUOS1OqZq/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 11 Aug 2022 12:05:01 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the amdgpu tree, today's linux-next build (htmldoc)
> produced this warning:
>=20
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9951: warning: Excess f=
unction parameter 'aconnector' description in 'amdgpu_dm_update_freesync_ca=
ps'
>=20
> Introduced by commit
>=20
>   8889a13f99e5 ("drm/amd/display: Add some extra kernel doc to amdgpu_dm")

I am still seeing this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/y+jYHrREk3/UxCUOS1OqZq/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMNbG8ACgkQAVBC80lX
0Gx13Qf+MpTCBsXuqS1uTvB/eh6cGqIkBlTCaLIo/vJ0WHhc5RdyzRaAlJsx+BC1
EKzFsrY22CiiuwmrRtSENpkpVI20uulxEoa5pYhQSwj1VQnATbFSXnWzD1ikF+gn
KVV/LOMv3SYKjwe2QbyTTa2SaUkopV3ZInoWXpRSTpkbwyEH7tTGT5AyrJo+A4OM
fATOcgP7fx1Lz1dsbTEeUhJE0LHXhqdnxSUqONTIiziJIslBddFrTRfMMPCIAJRN
G/RCy42xa0D4u97Y4bzBJzVuOejXfl+2rQbchWO35FuESDWSzXAPlP1XBIwJLGi/
MJx4HhAkwMMxn9JEhtt0burWJmOTHw==
=y8U1
-----END PGP SIGNATURE-----

--Sig_/y+jYHrREk3/UxCUOS1OqZq/--
