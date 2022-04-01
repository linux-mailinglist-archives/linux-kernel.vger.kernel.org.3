Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41474EE579
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbiDAAnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiDAAnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:43:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4024E27E;
        Thu, 31 Mar 2022 17:41:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KV1Zg4tDZz4xLS;
        Fri,  1 Apr 2022 11:41:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648773708;
        bh=/88WX07JiX8VYxmmbpmIqJeBpU5QCVP33iKwWdV9YWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vAPKkYftMxMbtzOX3cVCbuxf5pqarEpFIl7vGnQul3esunHNHmHSamL8ZF+twbo1q
         HC3HP7FpGX8HGJaQ5ELuCga144v6f+3mj7A+596y038EqI9Bxp12Qc67sOL6mFPJBg
         5guvxfFb/6JcdWEMCmv42ZWJ1WDxGqE5x215zuBHI3a29DhdKWgYiFAADz9PBMbxAJ
         /8gNCPa8BJhqOXN/f5poInNgv+1dqEHEjNaYYdOn4vmBvywdkGDkXz5vC7C2jZrYBU
         nbLROPatTKGuM8LdJv8FsgjDGiScLR2MJi5YbMQu9fgm9Y+iG1fKjpEtS9Mc5JtoTU
         0Ak/kx3Hies7Q==
Date:   Fri, 1 Apr 2022 11:41:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul@pwsan.com>, Atish Patra <atishp@rivosinc.com>,
        atishp@atishpatra.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: linux-next: build warning after merge of the risc-v tree
Message-ID: <20220401114146.25ef9683@canb.auug.org.au>
In-Reply-To: <mhng-165544a6-8754-47cf-b57b-74bba73ac76b@palmer-mbp2014>
References: <mhng-f46f3c64-24e0-4284-a6cb-71266e61e9ef@palmer-mbp2014>
        <mhng-165544a6-8754-47cf-b57b-74bba73ac76b@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ctW7Ac+5dS=2po4ABV7cCCL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ctW7Ac+5dS=2po4ABV7cCCL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Thu, 31 Mar 2022 17:05:15 -0700 (PDT) Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
>
> On Tue, 29 Mar 2022 09:46:57 PDT (-0700), Palmer Dabbelt wrote:
> > On Mon, 28 Mar 2022 19:34:12 PDT (-0700), Stephen Rothwell wrote: =20
> >>
> >> After merging the risc-v tree, today's linux-next build (htmldocs)
> >> produced this warning:
> >>
> >> Documentation/riscv/index.rst:5: WARNING: toctree contains reference t=
o nonexisting document 'riscv/pmu'
> >>
> >> Introduced by commit
> >>
> >>   23b1f18326ec ("Documentation: riscv: Remove the old documentation")
> >>
> >> This is actually in Linus' tree.  Sorry I missed it when it was
> >> introduced. =20
> >
> > I guess I missed it too.  I just sent a patch to fix it up. =20
>=20
> Coming around to the fix reminds me that I should have asked what you're=
=20
> running to trigger these, as I should probably add it to my tests.

I just do a "make htmldocs" once a day and compare it to the previous
days results.  You will need to install quite a bit of extra stuff for
sphinx to work.

--=20
Cheers,
Stephen Rothwell

--Sig_/ctW7Ac+5dS=2po4ABV7cCCL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJGSkoACgkQAVBC80lX
0Gy5IAf/bZ7yBsyijztIGDzZn0ByQ17JcgVwN0DJDIZLkkWohyn7oS+aRaI9z7A6
L1xXkpoWj1I/GtUP3GL4/45QEWg/ZN3lx+NhSzccMBiv7nxzH3kCgpep4Ty/yuAC
uKpS9YuAs3SnB0B1p81xzBfIVihBDK+SMQ9ZaiPeLCuRLTMQTf8F+WtUobaQpUt2
YolvPxIb1LjgoFPvAHBmK3BaVx+kmFa9ajP7zDgkVlhn+WOA4Hoag18RFhGS4S8A
I8n52gELCrPqj++BRoFe0riPxX4rNoVw4m4+ZLMBmfC0t+wfU5s3HyyFv65eU+uu
xwcu9cpnS2Hti5g2MN9tiOkc8Bxfeg==
=k0ey
-----END PGP SIGNATURE-----

--Sig_/ctW7Ac+5dS=2po4ABV7cCCL--
