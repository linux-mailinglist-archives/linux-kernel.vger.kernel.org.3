Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D451454AF19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356227AbiFNLL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356191AbiFNLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:11:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B51DEAF;
        Tue, 14 Jun 2022 04:11:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMm2s318dz4xZC;
        Tue, 14 Jun 2022 21:11:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655205078;
        bh=iZi7VXD/BQU3IcvSqC2JWvaTS297BwmoOBbqIwBTF5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G+uEXtJB77egfNtm4fRMXhvXGQj53V1OC1m633XgfopNtTUkNgWG3QvuiPlA3wCDb
         YB/8NalgxaV1PEjORlBwfy1evl2GzBuu0hRtKx5rHG76CI0sSh9yhIU+92F2kenmdI
         4iYQS/8D7B4ikof2rmlbwR9x18Gtk8GkDaNxFsAfb7I1UUQvEclGu4nspZ6KQnsfOr
         DCimXJCEvP83znV2RzXTfgUC7LoULrIlbYqLyN5lo4C9Gx9y43F7HLZmYeCnxfiOLz
         LQfrIA2WY8bTCJyLjLlKMCmglm2zUCUAnUrH08Ab/++2PoMWu7ClG7pCMWI7XQJZM7
         CcnEX/A9CBtqw==
Date:   Tue, 14 Jun 2022 21:11:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Neal Liu <neal_liu@aspeedtech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <20220614211116.1557b95e@canb.auug.org.au>
In-Reply-To: <YqhCZoA4SukXq9lf@debian.me>
References: <20220614120833.06cec8e7@canb.auug.org.au>
        <YqgtsXSNZKds2bDl@kroah.com>
        <20220614175247.30b02dc2@canb.auug.org.au>
        <YqhCZoA4SukXq9lf@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pVG0HKi1sIFI_zgWgSr3WdT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pVG0HKi1sIFI_zgWgSr3WdT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bagas,

On Tue, 14 Jun 2022 15:10:14 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wro=
te:
>
> I mean the missing error you reported was:
>=20
>   DTC     arch/arm/boot/dts/aspeed-ast2500-evb.dtb
>   DTC     arch/arm/boot/dts/aspeed-ast2600-evb-a1.dtb
> arch/arm/boot/dts/aspeed-g6.dtsi:320.21-328.5: ERROR (duplicate_node_name=
s): /ahb/usb@1e6a2000: Duplicate node name
> ERROR: Input tree has errors, aborting (use -f to force output)

Right, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/pVG0HKi1sIFI_zgWgSr3WdT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKobNQACgkQAVBC80lX
0Gy9gQf/bEUThYasyZV9JYaf2h9nHhtDMtE70J+1hq1BuJNs3ItJ2GSs67XI++jt
RcMS2x8AjhckJN+9nit53BzO54yygiJqsMUmoBuljqkJSAYR+HE9+V9/JWB+xrwT
fOefpgTBQV8msSQwdojymuocvx3kD+AT7vk31JLMZK8pPfy4IP+XpO68PfhomNYD
aQ3QXO1qS39tFJ2d6C3oQb4fevlCKhP/B6VwJV96OMiww3XZFhazFM61JhwjUp3v
AlJ+vOlc0HIvlhT1aUpDo15jodIkhNQrb4e6WSEToP/FVgcP3aJvQOUbJQZb/fy2
rmA1IT+Y/HDU3UGJltvCW1ZOpwYQMQ==
=tl4v
-----END PGP SIGNATURE-----

--Sig_/pVG0HKi1sIFI_zgWgSr3WdT--
