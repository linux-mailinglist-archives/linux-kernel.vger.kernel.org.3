Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE714E8C01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbiC1CTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbiC1CTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:19:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824DDF4C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:18:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KRbvT5z4Bz4xL3;
        Mon, 28 Mar 2022 13:17:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648433884;
        bh=Nwso0YcyayIULNU/4nY4JVqah5Obu3BlRuqncIGGjuQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lxFTN5BDQ5YDmkElyCWxWus0y5oqTHiwSnyngtC6yh8y4xud3wJuHhGGgXgXW6Yvv
         jjGrCXPpER3Exjt4dGWtWEoBaZXM8ojd0qcKERiALh9DOMYiydkh29N+hMrXaqnPSY
         jwBQ9os6JnA1ilsTHPTpzmnsdTOqZag4SAXpdIIsY3sFIXCQ3U6OVaMFwYYpO10U66
         JeKzIxapUhB2OjbH/sUOKz33nH7hmOANMlBEBuJE/lwsyTL/fX93QflMlNl9BmUkUs
         g+hiGmo7zFPI97rtvWRbYpDD+aoeusd/wN7cKz/6GwOdOrhnvGU3Nd31k+nFFu9/jO
         V6vDs+kuWU07w==
Date:   Mon, 28 Mar 2022 13:17:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: Pull request for bitmap branch
Message-ID: <20220328131756.5aa6b7aa@canb.auug.org.au>
In-Reply-To: <YkEK37hEhUcl5NUU@yury-laptop>
References: <YkEK37hEhUcl5NUU@yury-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=Iiu1BFWm9DS44Zv1S=Q4Ex";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=Iiu1BFWm9DS44Zv1S=Q4Ex
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Sun, 27 Mar 2022 18:09:51 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>
> Can you please pull this branch for linux-next?
> https://github.com/norov/linux/tree/bitmap

Normally, I don't add new branches to linux-next during the merge
window.  An exception is for branches that only contain changes meant
to be merged by Linus during the current merge window.  Even then, this
is very late to the table :-(

Also, you should tell me the branch name I need to fetch (which I will
refetch every day, so it should be a good stable name - like
"for-next"), and if this branch will be merged directly by Linus, or
through some other tree.

OK, I just checked ... the above URL is not a git tree.  I suspect you
meant me to fetch the "bitmap" branch of
https://github.com/norov/linux.git, right?

One more thing, that branch is based on Linus' tree of today, so really
cannot have received much testing in its current form :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/=Iiu1BFWm9DS44Zv1S=Q4Ex
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJBGtQACgkQAVBC80lX
0Gzj7Qf/eGNIQHS89Ds4AiQ90A2a1CiWBzv8q71i8DazMvFs72+zH8/Kcy/0zT64
2ILSZFAaXzWI/kCXnyaZFQ32VZ4Fx3DXfrz5hXXKK3EIwiIZS6uHVcbJmuFMuEKu
GkZ4/oHAko4io96tm8jWqmY/hcwKwutFQIDNVuiKKM3DMd4fZMZ+Ew6JqP1yxnNh
oXGuYew10oQMm2JwSWqJ/OCIB7OHH6TiwqiDL0nvvS4x9WV7V37uO2DyJzaKrWiy
EagI3ldl7YYyxl+Agd8/BE/DVcHBOwIIslVkCWrF8tvWV4t/gNX1eMxaKTCkpQXz
5wDDnSCkgYAZkiK75/ELUCdhcBm6VA==
=kF0I
-----END PGP SIGNATURE-----

--Sig_/=Iiu1BFWm9DS44Zv1S=Q4Ex--
