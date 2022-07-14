Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E47574C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiGNLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiGNLhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EFF5A2DE;
        Thu, 14 Jul 2022 04:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1297061C47;
        Thu, 14 Jul 2022 11:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3ECC34115;
        Thu, 14 Jul 2022 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798627;
        bh=xkb6opBAxI+SFBAgLXN/9AryGAOZRikgAkC+i4w8Uhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwPu+c5quI97M2cWmKO6K7vaWUI4RQvjpT6IsTzFnJMQLAXq9gM1oaA1Jx9Dau2Nq
         q7iTyQDdzGgEBRbeVR5dcOBbVF4PsKnZg3WIpYk1Na/3n9qcOhFDQkpJIHMGMRZULE
         p0tejvniIrSHXf2IxO9E+O4Rko6pklnRtypdwnMmczcH6Xklk3ZNs3oFlyJKfnbSIv
         Eqm++NccuvVRK5oZ59GPy8Hn+0CD77+41mCovNW6MwxBxTTfahqCna1l9kLpdIID9/
         r8x4Xc90cQXk+qW/MKFozgovbz+1TNejz4ASQvqNFTvW21WsUtIBWMjT4VC9rsVPPw
         G2i++Mx6esFOQ==
Date:   Thu, 14 Jul 2022 12:37:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
Message-ID: <Ys//3Vf7kNSfFsdE@sirena.org.uk>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1g8PH4M2W7Z50U@sirena.org.uk>
 <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mp2w4DZId8/NmPQ+"
Content-Disposition: inline
In-Reply-To: <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
X-Cookie: The devil finds work for idle glands.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mp2w4DZId8/NmPQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 01:07:32AM +0530, Naresh Kamboju wrote:

> Here I am providing the available data.
> Let me know what I am missing here, so that I will update my setup.
> Thanks in advance.

> Fast Models 11.17.21 (Feb 16 2022)

11.18 was released since (not that it should make any difference to this
issue).

> https://storage.tuxboot.com/fvp-aemva/tf-bl1.bin
> https://storage.tuxboot.com/fvp-aemva/fvp-base-revc.dtb
> https://storage.tuxboot.com/fvp-aemva/fip-uboot.bin

Where did you get the TF-A and u-boot from - what versions are they and
how are they configured and built?  Especially TF-A, u-boot isn't likely
to cause any issues here since it isn't responsible for initialising the
higher ELs.

That said I do seem to be able to boot with those images on my system -
it looks like a debug build of TF-A 2.5 and a modified version of u-boot
2021.04.  There's newer releases of both, especially with TF-A I'd
recommend keeping up with new releases though it doesn't *immediately*
look like your issue here.

> https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/Image.gz
> https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/modules.tar.xz

>   --data cluster0.cpu0=3D/tuxrun-r4_1075p-lava-1/fvp-base-revc.dtb@0x8600=
0000
>   --data cluster0.cpu0=3D/tuxrun-r4_1075p-lava-1/Image@0x80080000
>    -C pctl.startup=3D0.0.0.0
>    -C bp.secure_memory=3D0

You don't seem to have

	-C cluster0.mpidr_layout=3D1=20
	-C cluster1.mpidr_layout=3D1=20

though I would expect that the system wouldn't get as far as it was
without that, it doesn't seem to when I try testing here - it dies
running TF-A.

You might also want to turn on a few more options

	-C cluster0.has_fgt=3D1
	-C cluster1.has_fgt=3D1
	-C cluster0.memory_tagging_support_level=3D3
	-C cluster1.memory_tagging_support_level=3D3
	-C bp.dram_metadata.is_enabled=3D1=20

to turn on fine grained traps and MTE, plus at least the newer model has
more base architecture extensions, though these shouldn't be the issue
here.  They don't seem to be (and shouldn't be) relevant here though.
FGT is an EL2 feature so it'd die earlier.

--mp2w4DZId8/NmPQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLP/9wACgkQJNaLcl1U
h9CO2wgAgqBbvnchOc5rWP9J6VZBafqaSkOTJ+F0vZMUJlnTHoJkxMniYeLj6mwH
/z+5LKxlGS6P9OyoQ6mwpZxBJyuBgZDp2ps/vqnZiEUEvNhyve017Ad3vZZ7no2I
65W4ZuuokYI0RnXo74cnqDJDwch3XR8l60LAis92D6pmoqKP5+MYgN15DrhEfTHr
pi6+Zx08ZqkcMLxeeUq77g9nTYZ4iSwH5+D1Dm2YxT+jSFneogfH/6zLFf/w1Cgo
yAruxTrk2EzaHs3b/sqnpogLvFUREqrMlkN2n1EHlmSJv7LQD0WnSLZyvMEbsBnl
LM65RgF0G5UWCsgBIwFpqAnIxFtWDw==
=KuQS
-----END PGP SIGNATURE-----

--mp2w4DZId8/NmPQ+--
