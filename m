Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA454B678D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiBOJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:27:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiBOJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:27:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41087F6EC;
        Tue, 15 Feb 2022 01:27:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JybND3Sq6z4xNn;
        Tue, 15 Feb 2022 20:27:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644917260;
        bh=McdOwpaEj6gFhhNqxdSro7qiIBma8FGDAXXUlis6U/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=RbHHSuExVJLIrwe2TGC9gaVKPD3i2XkOPnouY4HmiiTx/NFuigy1vXltxg4Dej3VN
         waUwZeyXkQgdKb+D+QGoUOiog1y4YzU37GRqEOBACxMiudJaYXhvZfT/CP8W5PhPaA
         8kS8xaVRrnWNdLzJKsI16FX3lW5nHC6agsiD8OjXCANMNSLSpQSw7SIP26GGgPnEzb
         GfYDjI6GAc2M7EZg+jRW45Ad0kSVfipinaLKR5jzo1esK+VK5AyCYPSrMXwg2iWvIH
         cl+C3PPWpuTUr3YxP5eYjy7aJo1EJofJAZNZQe07l+CHDTrmcn0lcNtnOTTTjheBjE
         noARtUrmRH8ng==
Date:   Tue, 15 Feb 2022 20:27:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the nfsd tree
Message-ID: <20220215202739.39a276f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WB/10e_mJ+uptyhUrLKooAW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WB/10e_mJ+uptyhUrLKooAW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nfsd tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/networking/kapi:62: net/sunrpc/svc_xprt.c:331: WARNING: Unkno=
wn target name: "sock".

Introduced by commit

  26978084103a ("SUNRPC: Rename svc_create_xprt()")

--=20
Cheers,
Stephen Rothwell

--Sig_/WB/10e_mJ+uptyhUrLKooAW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmILcgsACgkQAVBC80lX
0GzM1AgAiUly3qExp9sgIg+7M8AD61k1YJAoZkxV8DRq4NyO77YKWAZEMSabP+VR
IKgYOivfIhcCNILObv1/96arcDqwVeteK/x7K1Kpi9vbAfyEUrEYIsXXNd6/Z/AN
6nFq3PEKvrZQqCpS4KUJJVBOPtcAqvibCPiH1YRmfUYVJg+cVwr7gT9aQckiNCjp
WMnhvy/tevYjFQgsTF7rCdW5AKb/7nw6CjAsjqH4yQn8B/TU1biSzPrCGU64bsc2
tEIPcMawb5xWPxencBf/Ha48bOp72wr7OjfYE6sEXBXxEAV/889BEbkPapgDLm7J
leo4X2V3JTm7swVm51P2ntozqzOSNA==
=OKbN
-----END PGP SIGNATURE-----

--Sig_/WB/10e_mJ+uptyhUrLKooAW--
