Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD12B59F226
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiHXDpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiHXDpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:45:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5648983BF7;
        Tue, 23 Aug 2022 20:45:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MCBnm1f4Nz4x1J;
        Wed, 24 Aug 2022 13:45:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661312732;
        bh=6y/TMB8qS12dSKw6GYNrawVI+5PHIab7zWx33lBdJ6Q=;
        h=Date:From:To:Cc:Subject:From;
        b=bSkvyXOVBdxEK2ddSs4ITy16vJ0M+Ke1shIY13cn6q+IEqnaQB+ox5RooFhUPI31R
         8wi73TBr6gCQQph3uuq29C8S9hcyy3P/KcNVwI4E1zZ9A3/KWkvYSV69jn7iMSyoL1
         b9pMXnhpfKPd7I30kun6OzjwU5o0BFaErKJuRgEta8HPtX3V/AxU2WRoPSv3su28Xh
         D1qRuFj54Xs6ACb2nN+3VBpwQq/2Os8mjYW5tT7ZSHvN+GstF9GfVI1Zmx1UbNxPT9
         hAeySknpsEcO5sx/AdCtGQHYaKGVDI8gzCagjSvc1vOaq/NlUs+0yG2c12nt4rHj8k
         9hPePNR0HsUug==
Date:   Wed, 24 Aug 2022 13:45:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the slab tree
Message-ID: <20220824134530.1b10e768@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e4G=+4=H=X8s=EX41usEeV8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e4G=+4=H=X8s=EX41usEeV8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the slab tree, today's linux-next build (htmldocs) produced
these warnings:

mm/slab_common.c:964: warning: Function parameter or member 'object' not de=
scribed in 'kfree'
mm/slab_common.c:964: warning: Excess function parameter 'objp' description=
 in 'kfree'

Introduced by commit

  79c7527b9805 ("mm/sl[au]b: generalize kmalloc subsystem")

--=20
Cheers,
Stephen Rothwell

--Sig_/e4G=+4=H=X8s=EX41usEeV8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMFntoACgkQAVBC80lX
0Gxoxgf+N6Bq/+M+Tpf1FSSWz58zmuI9BZAEDNXAP2QMjL9B5y59ri9pP0/togkV
Sl+TgLy619LVpmplrFDvdibBSQlvExe/vFcCss3h2jG6lYNWJAyUU6rp/9iiQORy
WyvaHAhGpnkjV0MLnP7TsIKYFGT+YzlZG9IUGC1T3J9QuivwlLI9gZuHRQmxRXGR
RJI9iWlREGdenipl2JTbudmd1laSIrWL5MsFTmn4/ZTsUsGY3mBWmCvN6g5HUdNd
plmieqV5Gsm2ty4047d0E7ZySdDIIvdXHkx1nmr9gvm1rgCW3f1yTSaOES3InxJK
noATSBcpu2s/kLWlAvH1XTWopI/W3A==
=lq1g
-----END PGP SIGNATURE-----

--Sig_/e4G=+4=H=X8s=EX41usEeV8--
