Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207094B984D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiBQFas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:30:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBQFaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:30:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5223E5F3;
        Wed, 16 Feb 2022 21:30:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jzk1b1R2xz4xNq;
        Thu, 17 Feb 2022 16:30:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645075827;
        bh=0yh5fKlavinMSqqtJMwS6WKa+Z9MXbMShporssLVK2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OGFElLSqX4RyBX+SLFc+pASUNdCQzdfSIeSM7iRgT+CIeJmE2WuSqHO9TBysdKPgZ
         Rgw2FZNTuVeL7EYaDjW1szEOWVgv+xgZ/gBCqsgjKnB3rA7jR9K2bmVmkDvJj32oN6
         BJsPzKz3kWEA/vNaDOSO8sag6fMIQR0VkckfqM4CNMgFtmhIRG8ifo34j+ox9G9FGB
         Nix1joDg2NRmgT20Yh7HGT0cOumT3TPsdd1L8z1O8TT3pqqbhobPnZqSAaTjcPk+mj
         xcB/rLG/GmffGCUxmQ4im/luJMJp67vVpDeT0sRj5rVvJXEMz4qWnl5C8SDuSHo9Qv
         Co10R9um+kdvQ==
Date:   Thu, 17 Feb 2022 16:30:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 folio tree
Message-ID: <20220217163026.5e48ccb1@canb.auug.org.au>
In-Reply-To: <Yg1hf0iHdKcjnq6l@casper.infradead.org>
References: <20220215180043.23879691@canb.auug.org.au>
        <YgumpQrC+cuYe91H@casper.infradead.org>
        <20220216172109.72fd0a38@canb.auug.org.au>
        <Yg1hf0iHdKcjnq6l@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YQBQVycjhypHJ4c/BGgbRoj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YQBQVycjhypHJ4c/BGgbRoj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Wed, 16 Feb 2022 20:41:35 +0000 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> So where do we go from here?  I can see ways of resolving this if
> Andrew switches to git, but he won't, so that's out.  Perhaps I can
> publish a git tree of Hugh's mlock patches and Christoph's series,
> and you can pull that before Andrew's tree so git resolves the conflicts
> early before trying to resolve conflicts against my tree?

My response for any other subsystem would be that you need to go
through the maintainer's tree.  In this case that means feeding a patch
series to Andrew and updating that patch series.

Alternatively, you need to find someone (with Andrew's agreement) who
can maintain a git tree that includes all Andrew's MM patches and any
other topic branches and deals with all the conflicts and can feed it
all to Linus.  Linux-next would also include that tree/branch.

Andrew, do you have any comments?
--=20
Cheers,
Stephen Rothwell

--Sig_/YQBQVycjhypHJ4c/BGgbRoj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN3XIACgkQAVBC80lX
0Gzs2wgAmWswoQpVdry1rBJIYAJRwUWUwk2ijpIUXIS5/q+iZBuwsLii/nngtfd3
LgPtwcoCwsVUpxbfFZ5dWA0vLRxUZwJIZ1orXh6Z+OC5thO/+/Rr9fX9RMLFRl2n
AQYrBWdIeJ356FHhJQG3e31PrYndqyN+fz+rGMv3xbf99DbqZSnvwAqtfSGNWCqC
Qk70zdO6EfZIcoWGoZwgtJ2wVHPJk+XG4rDmeYfmZUul+SDJyrdX1IylDGeRK6GA
6US/cqIPgWos8BcYQ7GwLg9zloIhZQ8oc4oSgVRKjnHerI84Hws6Kjg121xijGy/
d5wD3lfrIDhUFA0CCU3XapvcEQ/lxw==
=Sj6f
-----END PGP SIGNATURE-----

--Sig_/YQBQVycjhypHJ4c/BGgbRoj--
