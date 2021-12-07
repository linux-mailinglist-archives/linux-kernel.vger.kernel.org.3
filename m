Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89046B5A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhLGIZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhLGIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:25:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57289C061748;
        Tue,  7 Dec 2021 00:21:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d9so27776562wrw.4;
        Tue, 07 Dec 2021 00:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pxADwkKJ3p5GfU561CoF9jqAVhSHXf66cNWzqYkmA6g=;
        b=nbG6E4eX8TwqYxzDoeC0rjXHXy6XkQNAynNdWfawClOCnz2jBIP4KszFlRc2tHF+By
         wup7zBBwH+AQLTDE30XtIHX+hm3/ojhCczie+Fzbc6+cMcFiEEG/zXv+cEgHwOiSEtHV
         iVvH3DYEQCzU49sZ4UQXDHVec0p4KuRTCdvwqx2rfIlShJEbDZ99JpSHvyjfsLDbXUjM
         EcnHP5dZSQYFS62/lolUfdfrrQlQlQtmbnwNg252fVuyRdRl1/AHopDNtRuKlReJaIS/
         OUt5cwR3ch4tkAXToZ90QRvdpjowQynrwoeXIP0GRAKza1ZeavES7sOL4zfiMsJvvhM8
         A1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxADwkKJ3p5GfU561CoF9jqAVhSHXf66cNWzqYkmA6g=;
        b=6+gWNhBxebaxLDB6tLnEImfAB8Tvb/XgCiqd+mvCknuRZe6A5OGYmepKeTE1rcG2Mp
         bEQMBodnJdFeg7zBcXVksKk5oXUtv5TAOs321bZg2Gm+xcrGN3Y1yg1c67g512fSVZwA
         7MbVrrESporHAH37fY753QMzq8d3Zxa6COg482fyFHzqQ4BldGFE/npmDMcIBHiShjZb
         ApXvb2ZQLdmRqlGLEyQ5oQvNGzlPpgd0+Va4vrCCg12tllOXxYRQwFvlnzEgAQG8q+cQ
         XRTOIAsK66IFleFOngR8dvkngomMrCwbx5mBVM0TzQVgBs7ZsPM3ra2/JMVyP8dXUDrm
         5gyg==
X-Gm-Message-State: AOAM5329I3b4fb3lm6nj46mgR0NxRWEEgVnMWDx1Umgmh++PAhOg58yS
        Rp3LNNzFS9sRPNFtWD4YH4E=
X-Google-Smtp-Source: ABdhPJzPy7c5440OxS9ArVEm6sxiaVulH1S5T46C09W28YC/mpFjCBiG4XMayEp1tmMujWnfGHn6XA==
X-Received: by 2002:adf:bbc2:: with SMTP id z2mr48508726wrg.582.1638865303959;
        Tue, 07 Dec 2021 00:21:43 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id o12sm19366929wrc.85.2021.12.07.00.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:21:43 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:21:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sameer Pujar <spujar@nvidia.com>, tiwai@suse.com,
        broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        perex@perex.cz, jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix Tegra194 HDA regression
Message-ID: <Ya8Zk/9n7nAtjvSe@orome.fritz.box>
References: <1638858770-22594-1-git-send-email-spujar@nvidia.com>
 <s5hy24won6h.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="49TuLyavIf+IS4GG"
Content-Disposition: inline
In-Reply-To: <s5hy24won6h.wl-tiwai@suse.de>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--49TuLyavIf+IS4GG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 09:04:54AM +0100, Takashi Iwai wrote:
> On Tue, 07 Dec 2021 07:32:47 +0100,
> Sameer Pujar wrote:
> >=20
> > HDA probe failure is observed on Tegra194 based platforms and this
> > happens due to a reset failure. The series fixes this problem by
> > avoiding explicit resets on BPMP based devices.
> >=20
> > Sameer Pujar (3):
> >   ALSA: hda/tegra: Skip reset on BPMP devices
> >   dt-bindings: sound: tegra: Update HDA resets
> >   arm64: tegra: Remove non existent Tegra194 reset
>=20
> The change in HDA drier looks fine, and the question how to take those
> patches.  If other people can give acks, I can take those to sound.git
> tree destined for 5.16.
>=20
> Or, if anyone else prefers taking those, feel free to do: for the
> first patch,
>=20
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

My understanding is that patches 1-2 are mostly independent of patch 3,
with the latter being mostly a complementary cleanup. Patch 1 will
effectively ignore the non-existent reset on Tegra194 anyway. Patch 1
(and potentially 2) could go into v5.16 to fix the regression via
sound.git, but the cleanup in patch 3 isn't time-critical, so I could
just queue that up for v5.17 via the Tegra tree.

Sameer, any objections to that? Did I miss anything?

Thierry

--49TuLyavIf+IS4GG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvGZMACgkQ3SOs138+
s6HgkQ/+N8u8Xz+5+Ee5hefCCyEjNub0t9cEf0+Tk5v0L2TrMzxSmeHNItD0WBBi
udtQ8EZAti4dd4czN/XGVZRlM5WwLCB6OyDinnP4ORVr9AFQZnsY3ypiJmaeE8Bo
6Kz0bVYlnBCUZEizjETjYdHWz+b8dBKtAykaU7+qDG2Dp+cjx8nUWTvtbb4yMg+I
TvDsGs0tcvJ4KBb0Ryf6rgpxJ4NE/5Vi/qczIsJtqOtiRlw3ktNuvOlw9HmHLG6N
exMCoTxydM2iImudrVjobsHzVrxjMIfFCCmxXmwAAuwJuwechDb4C6eLVTbVag4B
tdv2y44xJXI9zax8PJjahOcyZKu6wuCmckQAoIPYAXgOJNSLGfqTom8iF+vn+vaF
+DbLzjsJOeokOXg47iDDsNQ3ZGRYs2pjArwmQ+A6m0oOGqjl3ucpnzjSxTMTMiaD
p/0qj/KawuoakssmZ0lwVRsy3kO299UDd4DLQ/iQ2sSOOCp20NTnVaHsxmq/3wnD
jkqELDynjSVSM8q7GB1yETfBth6mJfXBXcuMaXLRTlU3nG8tTIyi3/jL908qmZN7
C4bwgD4e7gZ97h9iaCMlihkrO+LFzI7vJyhaaBiITeuA8BC0kerIJYSc2OMJ40Zy
zn+AOY/uo5gx8rh7tVWX9CuWWz2btkKq0zp4/8w9UtAgcM3Bahc=
=Lb4G
-----END PGP SIGNATURE-----

--49TuLyavIf+IS4GG--
