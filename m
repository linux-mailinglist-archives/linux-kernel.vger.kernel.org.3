Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9449E7E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbiA0Qoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:44:37 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:37359 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244054AbiA0Qof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:44:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jl5z466Pgz4xcT;
        Fri, 28 Jan 2022 03:44:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643301873;
        bh=MX51oCd5bYSXDZe8p/UcQRq6AXgsb/XDeiec+w4Y0wY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uao15/lhQjJwl2dipxNY9hvuxyNRyiggc/Y9TMjW0SAZVdse/rAQYvNMFyQOCQ5Nn
         dLd1qBLsk2zmx8LMMQ81QbOj1gD9WS1w4eH1xJTOy0zApo3XztRKXo+5D2FhnSbp95
         zx1Ught578YSy4xnNaX7k8CFUjoGPM8SNWpc6sTeAkEMhXZpK0tSvUGufq89wpjw0+
         69vqjQvE3mnSZNLsuQ+I11Lp0Lkuvt/btise/qWipXdaAJcoekaUSQX2x1KODIC0R2
         PZ3LmsWLfWUDie/TBpPz9535V60v9SfRmXaQs5WeM+3+KyJr/K9KWuPgO+t6pG7Gu1
         IqizhWW5aP4sQ==
Date:   Fri, 28 Jan 2022 03:44:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings in Linus' tree
Message-ID: <20220128034430.77fef717@canb.auug.org.au>
In-Reply-To: <20220127060141.GA10653@lst.de>
References: <20220127153055.6dd9f73d@canb.auug.org.au>
        <20220127060141.GA10653@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/03=0ATfZR7Di9qbVyibM7nu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/03=0ATfZR7Di9qbVyibM7nu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Thu, 27 Jan 2022 07:01:41 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jan 27, 2022 at 03:30:55PM +1100, Stephen Rothwell wrote:
> >=20
> > Building Linus' tree, today's linux-next build (htmldocs) produced
> > these warnings:
> >=20
> > include/linux/blkdev.h:1533: warning: Function parameter or member 'sta=
rt_time' not described in 'bio_end_io_acct'
> > include/linux/blkdev.h:1533: warning: Excess function parameter 'start'=
 description in 'bio_end_io_acct'
> >=20
> > Introduced by commit
> >=20
> >   956d510ee78c ("block: add disk/bio-based accounting helpers") =20
>=20
> The warning looks correct, but that commit is rather old, so something
> else must have caused it to be emitted now?

Yeah, but I couldn't see anything obvious.

--=20
Cheers,
Stephen Rothwell

--Sig_/03=0ATfZR7Di9qbVyibM7nu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHyy+4ACgkQAVBC80lX
0GxH8ggAn7Nw74omN15x0YNxT3itr8Sm2r6A2ogQkLGg+3R7+lXaPBj5tSSJbPhY
3OIRG+BpK/l9OcP8NOP9wLNidd6mg6qbpjD4F4Y28K94p38sXAYnCMBcMmyBVMEk
JuLOChGb2BCaESVJkK9MTvII6kigVgSstUkzKWhb98hcJrETZ//fA44EPiM0D9Q5
QC3ic6OkVMYPeDA22oE+lC5Uj92J6uQlMCiPcyp68xSnU+VAtPtFLlX0sDGOCu/x
xNC+WQJNo9oe81Z5wt86QZ658G9e9+C8c/bRlk9LiD9Z+MFZSNdXQHydoFG96b5w
U5taHJ2gYE60tTH6e2vplWZ1n85Y1w==
=WLhG
-----END PGP SIGNATURE-----

--Sig_/03=0ATfZR7Di9qbVyibM7nu--
