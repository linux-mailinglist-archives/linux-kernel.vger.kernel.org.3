Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF8E4F6580
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbiDFQdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbiDFQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:32:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084B3F15F8;
        Tue,  5 Apr 2022 18:32:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KY6T65Vntz4xXS;
        Wed,  6 Apr 2022 11:32:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649208762;
        bh=Rxxn1TD2UuepLVLS1hwWe9JcrPraf9Iiaa5Ny2qSNaw=;
        h=Date:From:To:Cc:Subject:From;
        b=POlWXFTfFDSukK/5umCIKmt8FS0l7ph+FeMDUjz6xirkctNMlI6turW4LwC20ylCD
         CmMiyF2VcEuYMZJa/oJiJSf0fUsrx3xedWm25kS2H+d7DDPcLg1cD6vwSPX9qUHzrO
         vugQB9vrnv2j7WSn54uvOUv62e8gRTRT0+7YyTSPwNDR3XllEImr50GPwrjBss5NHE
         WPmXvU9np/YIhDgwk2iT63shZnXOGDXFzBc/WYcSSQCvGGrTSydOrR9vP45SVUr4tA
         TwRl82WwMr6K4H4cUne7omHlcicmomQxBCMF4v93RmPNXkqWQSNpijszlr+5Iajynl
         StXD0T6gJIRQw==
Date:   Wed, 6 Apr 2022 11:32:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: please clean up the usb-chipidea-fixes/next trees
Message-ID: <20220406113242.3d7aefbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.mfo3fXxDzL/nFbg7+KZ.0e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.mfo3fXxDzL/nFbg7+KZ.0e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Try again to an address that may work ...]

The usb-chipidea-fixes and -next trees have not been updated since Oct,
2021 and the -fixes tree is generating a conflict when merged.  Please
clean them it up WRT Linus' tree as the only patches in them have been
merged as other commits.

--=20
Cheers,
Stephen Rothwell

--Sig_/.mfo3fXxDzL/nFbg7+KZ.0e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJM7boACgkQAVBC80lX
0GxM4QgAozPVYrwAvoW2lTiAICEVaP8psjHfXi7yX3n6XOTpjR8wUp2iKxvlbC2D
NazdATRNOAslPWH7tLegAmYGZvRcYSbezPWdOGC8qZLS9LGShtz0Brby2wF4b9It
y68uRcpvWr92XJs4uNotDQI0XfDq0IKQPL0n31agN0Bz5hh/ta3mIuiZJJ0WNRZ9
f6HKkXd8BiA/MVTK6dauE7wNGAINpB5OHB/4gzfK89nENpF6mpTLTzB38QZyoQaa
r0/H2Zry1a6Rw828IzUH6+08eB+PyIZb7ZvvYJk7OsW5JCXVmxj+HPX162+jZBKU
v2lRL+2RxqavCtSExDFRLe/OnAUVsQ==
=HKB9
-----END PGP SIGNATURE-----

--Sig_/.mfo3fXxDzL/nFbg7+KZ.0e--
