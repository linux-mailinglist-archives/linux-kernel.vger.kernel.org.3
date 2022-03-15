Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8954D9AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbiCOMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiCOMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:05:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F6C52E6D;
        Tue, 15 Mar 2022 05:03:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHsWd6g3wz4xbs;
        Tue, 15 Mar 2022 23:03:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647345838;
        bh=FboyynBUQ4Ct3KLPx/K6ai77V62V72koVZsaldPGPD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dodzfGMo0o5eLFuRLrZKtUpA7GgnSXjqywS5D2q+GvawBTyORtr6ndjs5pLDTLVn0
         V5sxueGsVkPRJP5p0BN/jHDsA/9Hbi00tXNvOogU2ozKrGJ+KQg5vGbktGFKFmRVyI
         aEDB0r+mh7vFX1avZE0suvNjgVsvGmeHtdj+VjE4Ev0VORNjwVxARVf+xPXghaTPI5
         0moj00ZrFVQcjPK7dAej5QxsaQtDlNlZP2LFHPJNUrcUNDbEOapio3Ct7DKsxROX5b
         CFPYV5bwcZON9ogLwnOykCXVh9nNp43AstTHI4JoY6L4IWbd635iEuHvlQTtnXYx8z
         4XxN2YSZx0KpA==
Date:   Tue, 15 Mar 2022 23:03:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the folio tree with the ext4 tree
Message-ID: <20220315230356.54b3ff8c@canb.auug.org.au>
In-Reply-To: <20220315112512.yl7dewzglimjurh5@quack3.lan>
References: <20220315204007.05ad4817@canb.auug.org.au>
        <20220315112512.yl7dewzglimjurh5@quack3.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xcCLTI6ScvhFGlIwlh=20=d";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xcCLTI6ScvhFGlIwlh=20=d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Tue, 15 Mar 2022 12:25:12 +0100 Jan Kara <jack@suse.cz> wrote:
>
> Thanks for the notice Stephen! The resolution should be like:
>=20
> - 	WARN_ON_ONCE(!page_has_buffers(page));
> + 	WARN_ON_ONCE(!folio_buffers(folio));

Thanks, I have updated "git rerere"s resolution for tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/xcCLTI6ScvhFGlIwlh=20=d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwgKwACgkQAVBC80lX
0GyFugf/cU0Xj4zeHMWc+lqVp5VddUP6tniOf5IuXl+LILL4C7d3JAicjwvwAHFJ
x8iCraMSimoEVS24EqeqA7X1msaozIkV+ftuQtxFOX0aZj7j2w0DHk/DeSMK5dgv
5xc7NyxkkVddtW4YhHuTH8RrzlzQXflP6zrvkGucx3YAz+7IT+mPHVAbQcXynWEz
UWPgk/98iIO9ucjsZGTzFaxKW9y05wl0P3aTSp+LmSFDtqgPhDXzPt28W7Z33/PN
es+/BQsG7CR457VC4WLOVsog8dLJbxsVLJQ530xM3HlvDj1jqohylCNNaRdIIE0M
yraOH/MwTJboGXnhy5S7AekWkra4fg==
=S9Ii
-----END PGP SIGNATURE-----

--Sig_/xcCLTI6ScvhFGlIwlh=20=d--
