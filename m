Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37354D741
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245322AbiFPBlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242636AbiFPBk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:40:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD8580E3;
        Wed, 15 Jun 2022 18:40:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LNlHn0k88z4xYC;
        Thu, 16 Jun 2022 11:40:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655343653;
        bh=PzL331QKMC2iVu9ky6wyglh0P8+JgAP2fXKeOb1IHio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DBtdzQS7i+DQNyoctFRDmoZP4hD2ufLOTe0uxOwwnUDP6k3RYaA7AbrGKPxZLFcXZ
         KXGl7JydPBc0nGozP69Aq5ph9H72N37KPh8xLZ2dT0SbwkysIZGNQc7GaSQ0WlRvPY
         6dQ1SaNoShVVOky1knEDeeXnJTV/06xMddMGc8cG+WFyIsw0PxKM+QhSI1pwp54gTA
         2N5e5Zgqc3LC6CE/4mbx/lWDifOdEGIfyjeOLoHwHIdd77kXf5sICBAAASk1aDP1z1
         wSousirOcBdtdYBzhP7xqoclSBrQkDRMw+xiL/SsEXV0BXN+3t9Tgkq2+n4cV8T6au
         eAOSiZUdDJ4kg==
Date:   Thu, 16 Jun 2022 11:40:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: Contextual conflict between kspp and rcu trees
Message-ID: <20220616114052.05699141@canb.auug.org.au>
In-Reply-To: <20220616012629.GL1790663@paulmck-ThinkPad-P17-Gen-1>
References: <Yqo5SequJuC2qX6S@dev-arch.thelio-3990X>
        <20220616091634.55ebbdb0@canb.auug.org.au>
        <20220616012629.GL1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Jj57YEkZSK8rGPqbmPCFGgU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jj57YEkZSK8rGPqbmPCFGgU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, 15 Jun 2022 18:26:29 -0700 "Paul E. McKenney" <paulmck@kernel.org> =
wrote:
>
> > I will apply that to the merge of the rcu tree today (unless Paul finds
> > time to update (and test :-) ) the rcu tree before I get to it) as the
> > CFI fix is now in Linus' tree. =20
>=20
> Please!
>=20
> In theory, I could rebase -rcu to linus/master now, but in practice the
> odds of it producing something useful are all too low.  I will take care
> of it tomorrow (Thursday) morning, Pacific Time.

No worries.

--=20
Cheers,
Stephen Rothwell

--Sig_/Jj57YEkZSK8rGPqbmPCFGgU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKqiiQACgkQAVBC80lX
0GxFXAf/Yo3BlX8mpXVygR7c2hRySLvqr0W5uo8HulBs3E4Wos9pbWAdBlzhiJSV
lKJqI5MD0hGBM9XzfjJo7REEWDZNadN8CFZwcNwkid2xJj2S5r7rpYWOsWtPNFJE
ewmyfQrpTxGFXxNR9P9oVCzbcLiXaT7jPvFiqPyQFyQ7Ra9xiqHxYXWb1oAK1+uz
/i+vxBrQUfgNeN+0L2pHY9dFmoIN1fWLtxWcB7o2FDBru3M9r+1aiehAQs63M/T1
Z2OkiWe5tvApQQMiXSrSd7PNni62AE4zKqtClLFc101oxdZOeGxUdJJx0iCwisyZ
5Z2jhdTnc5GxqttQ77s04ly5rAhuKA==
=q3Jn
-----END PGP SIGNATURE-----

--Sig_/Jj57YEkZSK8rGPqbmPCFGgU--
