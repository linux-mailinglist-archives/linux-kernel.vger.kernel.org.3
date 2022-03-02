Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8352D4C9CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiCBFC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiCBFC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:02:56 -0500
Received: from gimli.rothwell.id.au (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3A1E3E1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 21:02:13 -0800 (PST)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4K7hmr2W2DzyR1;
        Wed,  2 Mar 2022 16:02:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1646197326;
        bh=uzjcaWgkXXsocOO4l8FmrzePxqW13WJublt0pDESlHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i983zv3fziLp2PBywQALnf/P1IukX8e25j0L3qxcgWqbcNX0NFGJJ2OhUJOziQEFx
         I54UUySJ1vTgUDs4DCLaYDof1bM7c0wMqPwQbaClhxMPPaRfzjTzxF4mRlYmLIFR49
         bmRNihxyauSeUmpK2qczkoO+1DaxPvjzfbpl2XpklIWAs0/3qZEWoS3078bH1GNZC2
         5jzPMNBFnhS9Zawg9OojZMOhxOsC36aCHFENrpPQzUvaSOgRzDy9eGnOewKOdJpYcs
         BIMrYPE15YmBamkCbE7vO8Ft/GcRjCqzejnTaA5cIpiah7rJ+nA9MPLFbHqHXsJabu
         +teymvxn3QRbA==
Date:   Wed, 2 Mar 2022 16:02:01 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20220302160201.6ee2c586@elm.ozlabs.ibm.com>
In-Reply-To: <14b6a691-d31e-2e54-cf91-352b9b30414d@amd.com>
References: <20211117134926.1d339d71@canb.auug.org.au>
        <20220120142639.02c54ae9@canb.auug.org.au>
        <20220302123126.65bcbc82@canb.auug.org.au>
        <14b6a691-d31e-2e54-cf91-352b9b30414d@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+CPxGtbE5SBkEEZMmwIvi+1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+CPxGtbE5SBkEEZMmwIvi+1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

On Tue, 1 Mar 2022 22:26:12 -0500 Andrey Grodzovsky <andrey.grodzovsky@amd.=
com> wrote:
>
> Please check you have commit c7703ce38c1e Andrey Grodzovsky=C2=A0=C2=A0 3=
 weeks ago=C2=A0=C2=A0=C2=A0 drm/amdgpu: Fix htmldoc warning

That has arrived in linux-next today for the first time.  It is in the
drm tree, but that tree has had build problems for some time and so has
not been included completely until today.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/+CPxGtbE5SBkEEZMmwIvi+1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIe+kkACgkQAVBC80lX
0Gy6zAf+JLyE27RwbUECLPb5aqE7lO8RcwYu0T82oZkMwLJ0dvV3vLJDWsspmOdW
/GOOnbp3HgK+BnmzswANmXJ7AQKV+kZz345wLuAkxwIb093msrH4zTz7v2cSZzT9
oBly2C2V427DkjeZAJ66Y4522MNq4tqMJIG/ElyrhWDgghqRCskQbnh5/eDZJIcc
53IldotYe4YC5jhdWmd31rYOW+EobwSx8Pmu3NOBE3iRatj/qC+XvJzi79CLb0S2
f0rWUxXu0q4lxIQ7mV4cKP2m9Psgpv33Jv6dxn3GNrcKz0tv2NIIuhllb1w+8b6G
2IOvnB4EfX0fzlst9e2CsQPAj8Rwbw==
=9KR5
-----END PGP SIGNATURE-----

--Sig_/+CPxGtbE5SBkEEZMmwIvi+1--
