Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC17574C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbiGNLmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbiGNLmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:42:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7E65B782;
        Thu, 14 Jul 2022 04:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D29FB824D2;
        Thu, 14 Jul 2022 11:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4593C34114;
        Thu, 14 Jul 2022 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798935;
        bh=451mWwuI9AcPCzu1ImZErrLyn7VNOtMxUA6oD0ptuxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=US1VNGygEHXBSUfDyO21KxZpT3Cj3CzXEVksTUgh4WZLXPLN4nQFG3kDu1GBmMDrj
         4Ak4s3uspIXlqoDyFVvEkRz/hXgE072CYbST+tJCI3niYz6+OZjwQ5laxJUVz1gSlO
         /JPZa14rBbWk3SnCZGVLWkru/U3WmVselAclZ4Veo/KBL/ooVSGgJPiZttPY/OJfxj
         wnq9B9Mkyl+R0c9Qtd7pJS1hAcFodCCCMZXyfadfVz4qRFMT62BYC65mT6XmnTVfZ5
         5nJwDnGfbqrlAoTsBKJr8JUS10WJyj5JiBA8Zfu0mr4BtVB759K5bg4rwJ7NNYLayx
         rXXYpf8L2T1Jg==
Date:   Thu, 14 Jul 2022 12:42:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
Message-ID: <YtABEDylGJkYLXrJ@sirena.org.uk>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1g8PH4M2W7Z50U@sirena.org.uk>
 <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
 <Ys/9TSV5muvKXN6W@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v0q6NINr4Hz+BhXJ"
Content-Disposition: inline
In-Reply-To: <Ys/9TSV5muvKXN6W@FVFF77S0Q05N>
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


--v0q6NINr4Hz+BhXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 12:26:05PM +0100, Mark Rutland wrote:

> I note that your log has:

> | Hit any key to stop autoboot:  1  0=20
> | smh_open: ERROR fd -1 for file 'boot.img'
> | smh_open: ERROR fd -1 for file 'Image'
> | smh_open: ERROR fd -1 for file 'devtree.dtb'
> | smh_open: ERROR fd -1 for file 'ramdisk.img'

=2E..

> | Hit any key to stop autoboot:  0  =20
> | smh_open: ERROR fd -1 for file 'boot.img'
> | loaded file Image from 80080000 to 82F299FF, 02EA9A00 bytes
> | smh_open: ERROR fd -1 for file 'devtree.dtb'
> | smh_open: ERROR fd -1 for file 'ramdisk.img'
> | fdt - flattened device tree utility commands

> ... and I wonder if that has something to do with it, given it appears th=
at
> your Image is corrupted somehow.

Naresh's command line is putting Image directly into RAM with

    --data cluster0.cpu0=3D/tuxrun-r4_1075p-lava-1/Image@0x80080000

--v0q6NINr4Hz+BhXJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQARAACgkQJNaLcl1U
h9D2zwf+N2o/jcPsfrNlnvFCPpVpPafkerd8QYDMB56/fvTZqGJNUs1iMPbXkUvf
dpYghnZZCTTCVpNJyYe8qVeZIbpItGPabW8+CfQgVcKqUeNM3OrcOMZbu6GreTa7
Cmmcz58RyqC/KQFvNIuANf5h3dbcM4RdWqgo4lh8zwfXO1a/pFbPp+apu4akAopi
Cg86TOKBETletb+YaZUAR+6aU5Evzi4eaDC565SPytiA/GCjmj8X62HmKWgS4Rvm
4xHGXXFdDWmlaXtpL0dz/2FP9akc6mnkS87BcxQdDz6D80mvkN8pkQ8z+5GhJjAJ
mycFQ8JUgg0sPDpdoLxe+iuNEhATlw==
=DdaV
-----END PGP SIGNATURE-----

--v0q6NINr4Hz+BhXJ--
