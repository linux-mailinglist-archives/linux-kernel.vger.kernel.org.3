Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DDA5A75D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiHaFm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHaFmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:42:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A7BA14D;
        Tue, 30 Aug 2022 22:42:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHY3s52JCz4xG9;
        Wed, 31 Aug 2022 15:42:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661924570;
        bh=e7/yNaHGfRvgv/BEqtymT/jBSoDQAjO4GH2DvJqU9yk=;
        h=Date:From:To:Cc:Subject:From;
        b=Zj73mkrznlM2CHOkLjZ7AaFNgo32hRxAGmR+2ILuiR/nIecWYfFdPlRZbpZP4yKtE
         T3C/1u5hTFYqI6FwsGVMD+iebU/ATLQ4a/4V0hAjFKEJ9Dfzh8GeIquK9rK4S/VA3X
         nVFUlDRs1MUbd7+R3ZuL54oboIlI1sK5O5YaIFdCba8PKg9xJWPGs0Q4gB5r+OGW28
         1zC9Q0+Dwm4TWjTnNFC/PvtX5UJmTXhE5sG5PTiO6C2qiKUMIh9MU+xZylY5lrQfNj
         v+A3fno69Wv0sgl8exZsPeOq98KmtoYqArXRFb8EllDEA6HNHgfhh2elgpWoAqAPYs
         i5bai5ZPFHeiw==
Date:   Wed, 31 Aug 2022 15:42:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the mediatek tree
Message-ID: <20220831154248.20da2b6c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C/dg_I1UbTStYG_Ba.hZV3x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C/dg_I1UbTStYG_Ba.hZV3x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mediatek tree, today's linux-next build (arm64 defconfi)
produced these warnings:

arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning (power_dom=
ains_property): /soc/vcodec@18002000: Missing property '#power-domain-cells=
' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[=
0])
arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning (power_dom=
ains_property): /soc/vcodec@19002000: Missing property '#power-domain-cells=
' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[=
0])
arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning (power_dom=
ains_property): /soc/vcodec@18002000: Missing property '#power-domain-cells=
' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[=
0])
arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning (power_dom=
ains_property): /soc/vcodec@19002000: Missing property '#power-domain-cells=
' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[=
0])
arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning (power_dom=
ains_property): /soc/vcodec@18002000: Missing property '#power-domain-cells=
' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[=
0])
arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning (power_dom=
ains_property): /soc/vcodec@19002000: Missing property '#power-domain-cells=
' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[=
0])
arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning (power_dom=
ains_property): /soc/vcodec@18002000: Missing property '#power-domain-cells=
' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[=
0])
arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning (power_dom=
ains_property): /soc/vcodec@19002000: Missing property '#power-domain-cells=
' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[=
0])

Introduced by commit

  d3dfd4688574 ("arm64: dts: mediatek: Update mt81xx scpsys node to align w=
ith dt-bindings")

--=20
Cheers,
Stephen Rothwell

--Sig_/C/dg_I1UbTStYG_Ba.hZV3x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMO9NgACgkQAVBC80lX
0GxPYQf+J6ts+2KFGegDbrYFd2SM8yA7KbtWha5Y1GI5JCV1/mSmz30lyE65W6nj
Dx+4es2vcSf18VcQM9PzHx+LG2L1xug6uYhHK/6HZ2/TagdKNTX9x3yLuLUpShof
wbFX7dEFxupUpzwjdS+OjoDm5v9BSVQGreQwYZNO1LK9DVfv2StBVhQdCGHUStDX
uENUvF5FxJwynZiBsJmtB6eIde0+DvtnDszmy+F/yffOIXobr0CNMlRn/WAmHHF5
Sb1qj0gmK+hVxOLBmm0gFEVztvnoj+m7CgFtC1LO6iSvvFrcQr21RZ2IO0uLfckS
7ZrnaCPO3zsQZvykbRShHcDAT7hDLQ==
=QRn/
-----END PGP SIGNATURE-----

--Sig_/C/dg_I1UbTStYG_Ba.hZV3x--
