Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6446C536958
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 02:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355236AbiE1AVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 20:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiE1AVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 20:21:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D56353B;
        Fri, 27 May 2022 17:21:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L92QH1FkVz4xZ7;
        Sat, 28 May 2022 10:20:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653697255;
        bh=9iX5eYHjvvMd4p5OHyu1aZN9k5oGPYrd+kxO6q8i/N4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H2IhBYfCxgsBw5EHy1QEaQwv29vLLjb8onMR1IyarhLkSL5CLOpKgOfYz06Y5wVe3
         OlRsoM+228ZZQO3ZEuTNqKSqnLj7Wa8y7rBz0ZMvtZYsM7RREH8BJ8clSXs/WiHkSP
         STk1/oCu/P0S/pwygryH/Tv8RKuSvR4hOwGcugDDGpKVAh8PmE1Jk8vhgHIkykz1aB
         HzdNENOTKHNGOWDu9wFwxhlK/lWOq/V7QsxFxEGs9EhTUToib0kFEGDdOCQBi5GQlr
         AyGDITCrt5PiAXqT/m/hK1WcX8sij0aw2pgv86TaOadjJUvFZ90R+zfe2wsUsfNUEq
         CoOa/O6Y3O2xQ==
Date:   Sat, 28 May 2022 10:20:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: wireless for-next branches
Message-ID: <20220528102053.3733f275@canb.auug.org.au>
In-Reply-To: <87a6b3qrms.fsf@kernel.org>
References: <87a6b3qrms.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bJA+k1Jf5MS2lksuvRPfLGH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bJA+k1Jf5MS2lksuvRPfLGH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

On Fri, 27 May 2022 11:58:03 +0300 Kalle Valo <kvalo@kernel.org> wrote:
>
> We are experimenting how we could take "next-next" patches during merge
> windows and avoid accumulation of patches for the period which is in
> practice three weeks for wireless patches. To do that could you please
> change linux-next to pull from wireless trees for-next branches instead
> of main branches? So the new locations are:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-n=
ext
> git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git =
for-next
>=20
> The idea we have is that wireless-next for-next branch is not updated
> during the merge window and then the "next-next" patches will not be
> included in linux-next until the merge window has closed.

OK, I have switched to using those branches.

--=20
Cheers,
Stephen Rothwell

--Sig_/bJA+k1Jf5MS2lksuvRPfLGH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKRauUACgkQAVBC80lX
0GwpZgf/Wgdjan/yq/9DqHd8Ppy3uahDMHlrxRfAHTTWOA6D83N3g4pD2V6/r6jg
wAuD/3hwJuTIRc9D9BEu+yhmO6LAC+76pBTNooc7mJWYCHkbmqjShw19XdFNsLxv
O9cwePyrAdHr6qUtr3pMYUnuyBGLa3jV7v/+HGFsfRH5ePiLaevuSLwMVh1k8sOf
p4XcCChut3N8/N5znKx8BBDNRHYuPikmo9sEDGwNvxQYibAPE1oB3cF7HmfbybjR
RBPonbYaTdrwaCeM/7phZbs6/QPPio3Eb3IiapLc/Mw5Jcfa9xF6S+a7vspQKenX
DRVsEPr1uSEbrHK0YRBi9pTd+n9fuQ==
=1uUL
-----END PGP SIGNATURE-----

--Sig_/bJA+k1Jf5MS2lksuvRPfLGH--
