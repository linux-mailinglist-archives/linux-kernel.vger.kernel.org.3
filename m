Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC3A5A88BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiHaWFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiHaWFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:05:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292091839D;
        Wed, 31 Aug 2022 15:05:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHysF1VV2z4x7X;
        Thu,  1 Sep 2022 08:05:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661983505;
        bh=QTrBWLQDf6nn0LFT978vIuJAJrSo12rieT4q35AtP7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b4TcQNzH96C5So5QN79LdnOUTiQhWnt21tXs04T/l/SOHkfgprWq4iq9W9qYrexNP
         DRE4vMb7QVQdWwd0Xdv0LL3TAU4qeg4U1dZZ0rpjCQVBVPSxHTXhPDoHtxBoHUJehY
         JH/lLBZmlerIM9di0YIPEcO63B+WFs2UqBdQgZ9I0SHBVTRICC2CEanSVq0BIGzoga
         zOug/El74REc0Hm6CiMQ1TXcOMpCG07+VC9lLTkWLJwmUvQ6jxo8cXi4wTuavoiF3M
         ZyVvUtn3KcVTzT6hNq+1FWk/NbPrfXFOFRdzA1E5PGGAzdwkCZqKtbAA4TBA5G4w1c
         sYszlC6oIUCPA==
Date:   Thu, 1 Sep 2022 08:05:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with the kspp tree
Message-ID: <20220901080504.73843b04@canb.auug.org.au>
In-Reply-To: <202208311050.60A8E9C43@keescook>
References: <20220830170051.6c190838@canb.auug.org.au>
        <202208311050.60A8E9C43@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qidW2e2dr/ryDc=qB2cTvnE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qidW2e2dr/ryDc=qB2cTvnE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Wed, 31 Aug 2022 10:51:08 -0700 Kees Cook <keescook@chromium.org> wrote:
>
> Thanks! Andrew, can you drop these patches from -mm please? I corrected
> the filename convention in the above named patch.

He did that yesterday, so all good.

--=20
Cheers,
Stephen Rothwell

--Sig_/qidW2e2dr/ryDc=qB2cTvnE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMP2xAACgkQAVBC80lX
0GxQhwf+ITuo5Lq/IM3ZfCQ8BNx7UpuxR/bvQP94FF+OVUZUM9vokNh0aGw+0dc/
smIcGzlbUbrXjMQQYM1IefIaUtu85OiiSGV0gJ5KNOum1XlDgvBqoTe/yderLVf0
oASzeb5Gz22jkJdgvo+ix4+UodAN+3AqGcq/oXmBvXz2J+fi0WC8YUYX8/g478M6
mu9orR38YOGuMj+qPEbONf+gMojQiWVhuLxR5SHNiMtW23iyQ+8jDC1FyomY1+47
Wd7NPod2qUuU0EDZ/M0EzelvexTPm9IAiuhI3lD3Mjr486/XvQ+wm7Fa6iBlKnOe
de/yNt+6g6THO9d2kQ/BK+2+4qbwBQ==
=T+jv
-----END PGP SIGNATURE-----

--Sig_/qidW2e2dr/ryDc=qB2cTvnE--
