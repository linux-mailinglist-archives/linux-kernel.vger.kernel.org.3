Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6974E5B23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbiCWWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiCWWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:17:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375B8F9AE;
        Wed, 23 Mar 2022 15:15:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KP2jX0xPpz4xNq;
        Thu, 24 Mar 2022 09:15:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648073730;
        bh=FoPtAuE4pQcC8jfIQaXoX+XiJ05dF3ejRmfZnbBHepA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=unBbTGjLmIbykBGyWa5Szlle/0GtcGbWpqTg1SZRLunXMlEmQSC52JssPJsXaXSz6
         3sP9DcLp8Udg/h9/X1Hzd9+0AtO7HIoFEGhWb1GzgbkzdtfQTM0Z8rr4P/0kz1tVnJ
         9Bc4O5rI77A9ePY0if6xDaf9mCp/EK7onglOgucvtSJ4Rcy2T2z7ZUuHexzu+Mn+79
         wlEKEieYWvx5wB9dxjoRWfBrr6HXlckAe9nwb6cT++wFyTzYA5z87gSmI3HTV0Z5sT
         DrAEvqZ26Y5/dAISPS6mzuzvmWjwGUF3ClAOaDeSdUxfv7iRsn4Snniku+jBXcBN+a
         fK0KlBmpmzo6Q==
Date:   Thu, 24 Mar 2022 09:15:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alan Kao <alankao@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: linux-next: manual merge of the folio tree with the asm-generic
 tree
Message-ID: <20220324091527.077e068f@canb.auug.org.au>
In-Reply-To: <20220303172427.24e17e51@canb.auug.org.au>
References: <20220303172427.24e17e51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UlhfWn0BOoST8ctAF+MXS6+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UlhfWn0BOoST8ctAF+MXS6+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi a;;,

On Thu, 3 Mar 2022 17:24:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the folio tree got a conflict in:
>=20
>   arch/nds32/include/asm/pgtable.h
>=20
> between commit:
>=20
>   9f15ac318b83 ("nds32: Remove the architecture")
>=20
> from the asm-generic tree and commit:
>=20
>   e558a885a525 ("arch: Add pmd_pfn() where it is missing")
>=20
> from the folio tree.
>=20
> I fixed it up (I just deleted the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the asm-generic tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/UlhfWn0BOoST8ctAF+MXS6+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI7m/8ACgkQAVBC80lX
0GwowAf+I5xjordPyRlykQnhEQBJh2uJlWPCZ8oAu5zLHk0zi0rpSTQG+b6SnSzb
pEthnYEILIGXPjNFHRISIj7VlCimrqwOV/Jcc8nkADhSuvCbikexvq/EqICw5PFp
isT2NCkpj1YCythEopL6yBJOdFfI761GFeKlYF/Hpizsh86MfD2/HtJx1tFB8pV+
z+SunxtsH5t68CDudyvcWbK0j3NrX5nxyjDfULHyuHYOcl3al+RiMqgfv6vQMbGu
LrtCLZMYTNLonVl+lMf9JospLxDEP4WL5QgsrjhyfI/pnfNnm4v2ZEmDBuEuZrxZ
kRUTg8vBidTs60LrfkOQM7foaOUU8A==
=n1Kl
-----END PGP SIGNATURE-----

--Sig_/UlhfWn0BOoST8ctAF+MXS6+--
