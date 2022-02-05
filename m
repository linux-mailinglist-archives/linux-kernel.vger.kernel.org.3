Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE14A4AA8EC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379903AbiBEM7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:59:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:57629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379880AbiBEM7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644065920;
        bh=xnR5tInK/u5lykmthzTAQflPIfF3ao8XC7TXRw6C/2Y=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fM0VSDFHPQvrKzQ+fbTvlGb6ICy1tgRWOYL4oYO2VsOGhMil28XzgWuSIlp/VReaT
         jEr6tkkNOW56nfrzg9+TzvqcwMWarDawRV77A77p9wrW2GloJDCx4op2vYQlMS/FtW
         5wbwDAwas54RqXvakOLA4KAMmRnhXFVje4AMg7fo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1mxHxn2SSV-00JcDo; Sat, 05
 Feb 2022 13:58:40 +0100
Date:   Sat, 5 Feb 2022 13:58:39 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v3 1/4] clk: actions: Terminate clk_div_table with
 sentinel element
Message-ID: <Yf50f7wbJi9PnUNV@latitude>
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
 <20220205005232.772726-2-j.neuschaefer@gmx.net>
 <5567d063-39b3-adfb-6556-d9973fa2074b@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YBFJ4SofsUKDzzjR"
Content-Disposition: inline
In-Reply-To: <5567d063-39b3-adfb-6556-d9973fa2074b@amsat.org>
X-Provags-ID: V03:K1:41l+cW+d5pQhmIzZO8dZwyGex3A5zj9rmHZaal5XWgiHe8X5JTJ
 jF/RAWpgZ6aVAZve0UjBNc/E7izw/VsRYkernLAC3zgAPX/W9Wj8WyVfRbLmUW+UczTXDzu
 jGDHSBQhyyWnEr1jmFNoTCe3bgddvjCaFUXpgyTuPPCSKZ3aG4KgWNZorJuima1Ubbkinwd
 oF4na22DvQGIt/2fjWnag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pMkWCdt5NtE=:sMfwhYwp04HwULsC4ikiHy
 Hf+M55MLvD++bdqrdj56hh9aySbxpDQIQwhpRgzYHkbZ09k6m18jOWyPKbpL8ZTORErw5qTah
 4SubXNJXa++z2Hmg65EHz7Qma9rSrlDhusvjWVW4m00WBgrIKIXcdn+7hEDm75AgsPiyo+KBZ
 H5IGT14p0ibDu4tzpdhgOq/SiFFbYZ/8ZMvSN7sWTX5Ha5I1JxdoJIb6cGshnsspK/cJLw2v5
 s/WDG7jJubVIvU77edj11hv+I0uqVfRLAwqjKIDM3eJkVMVRUxMJ8lYRn68p23Iin+NH9Xske
 FvRI7HPZsIXCmHkFxedYqFH4Bi8lRJ56Gw0zTa6Jncv8FVhGBh55ko5aETHSbOpZ7WqbQan51
 iiERA999F7+NI4Ack7dt8/v6j0fVqECPHx54JmftnORfrzm6SMy5fzXQHOVIsJksZsc+bZomw
 zCcNVbj4Yrcz/MP3lzBPPvwB3o5HVGgwDHvfVgK3NlK3sK9Rk9A3uwkElBXE6rKxuTkNGIum2
 eHxG+9qAoGk98zhr7NzO1FHE9yHJEodQPfF6LgacLDI7aoNjTgKSUag+/6RYselczjmW3mE7G
 FLPhdyf8S0f0YNsmlBadCh5h0eS12mI9WH7W61oeO57vcA752pUIPugTTDZp2zoKHjv9PJ2W/
 j+pyA6kvy7/WdgRC7pC+irwl0h23bZqQl3c592QaVfAM5HnvS16/oUk7CCILe8ZX6+UjwISlV
 QzYHOpzBEPnwsn2A5SHgHNJ17eUj0snRVHYzUj5N7FSq76mFafUuOmDXbFTqyGU8Z/baedPAV
 A8INLdiZvwk231Fq0bxi5EjYLDvaGoq+gd+UHCmJL6PSQ1wVTcv1qpAhg9zYZT94RzQOMooA3
 ahrTfmDkdTpOR/pmTSgARj7MuUnFI2kW6Bd6ppaBtYIqS+Bw+omwkiGrKVdqH0hwLPMaFY8Pq
 vFACIf+33rBqI/WkloqbBIZvelsaWI1FNju8K1gRX1LmvSrmFPwZx8ifrVu/iOKlKH1skLeBp
 e91iXv6DDAVYBSohCLKoCaQbiY79QQ+VUCxn0XK6WKOD9IStDtnTqYIxExHW4n3cehbZ8vrlK
 ZE9V3BmNMHh/zA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YBFJ4SofsUKDzzjR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 01:15:46PM +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On 5/2/22 01:52, Jonathan Neusch=C3=A4fer wrote:
> > In order that the end of a clk_div_table can be detected, it must be
> > terminated with a sentinel element (.div =3D 0).
> >=20
> > In owl-s900.s, the { 0, 8 } element was probably meant to be just that,
> > so this patch changes { 0, 8 } to { 0, 0 }.
> >=20
> > Fixes: d47317ca4ade1 ("clk: actions: Add S700 SoC clock support")
> > Fixes: d85d20053e195 ("clk: actions: Add S900 SoC clock support")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
[...]
> >   static struct clk_div_table rmii_div_table[] =3D {
> >   	{0, 4},   {1, 10},
> > +	{0, 0},
>=20
> Again, clearer to use:
>=20
>         { /* sentinel */ }
>=20
> (without the trailing comma, to enforce this is the last entry).

This style is locally consistent in the file, so anyone who reads the
file will encounter { 0, 0 } elements anyway.

So, I think it makes sense to:

- Keep this patch as is (except for the trailing comma, I'll remove that)
- Add a second patch that replaces all the sentinel elements with
  { /* sentinel */ }

This patch can go into stable branches, and the style cleanup doesn't
have to.


Best regards,
Jonathan

--YBFJ4SofsUKDzzjR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH+dF0ACgkQCDBEmo7z
X9uIcxAAwTPCLuuevTIdsEYvfMcSraNZ0Eq2WUy/QuVS6LJO6Vo9+bCxU8ZiaPrk
i5BwZnq2/ISWmu2ustVPb7p5xQ6slYZjB23cp8bo/t4lV9kk0AWF5Gv1m55UTGC5
ApyNm18NS3EOm2vE9VgKLuBMs5d8XHcdy2/DRkGfrJTYMKw8Hci2vROwXaf+xSbR
nceq9Ay2IUYeRcLJN6BKMUwuHWHnm/0JPhKMks4RgPmY6o2QdUcNzQiYs041jcvz
w2yrA0/aUAtQF9WOxTRTAMuClwr6yYNxGq7HypC8LSS0Acm3s5oip9+j8PXmuywK
Zppv9QcAYj9btke+sSgGVZFP+55ST1PrJoXTCG4e6PzXHVtlexp2lGCEFzVDIro7
nid2IDNaTirON78e5+fP7vSc+HdWAQBtTW4/UOrZ3Vlo7f20ALRjsBBXaVB7msCY
rnkbtCiJn8XTJl2U4d+4WeWiYW7BdM0XlwIYNSMPJoAyMvIgsFH3EvGmgzfZmsET
GpuEuW1EsNmBmQcKWW8wRH6JB4J3W5IL+hN5/C/m5hXbEx/ShXYJpKDj0g5+DUS7
uZRLcmv4bxrXG6B/gyS0zlIC89iurXVKpaAhiuJJpvJrgJjcXy6NBOzbJCYtAiGn
GfbxAFDkepj2hLav+uSxz9qQyZk8N4df8f3SVrmG+D3FA/twP8Y=
=SrEk
-----END PGP SIGNATURE-----

--YBFJ4SofsUKDzzjR--
