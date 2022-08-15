Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253DD592725
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 02:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiHOAyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 20:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHOAy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 20:54:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5E7658;
        Sun, 14 Aug 2022 17:54:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M5bQQ04dcz4x1V;
        Mon, 15 Aug 2022 10:54:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660524863;
        bh=0Tch3PtuAnv8LMLwmFQ59clZK8afE4VSbddG6E/Jf3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Owc+TpwmJyj3pbtUDmsxtHQVoO+I8rmZ+tX/RGety4zJBmeNqOEjpINtkbAvCiGWm
         T1TpqFzFynBZcc0/COAiXBAtCZHXQQ6cfoJPsSWbi1MvHy/ZPcKZgVVAZMq86pbzpg
         0Dym5AKRoJuJYfaANj0B8spiQBroXl7d7hy8BH/1dVL8kNuqp4PCSLGHOTvXmqyPDV
         Vd/NUfROvQsi4d2UIYz7feq+YURFBYW+vQI6wBEm+MZ2znSluP+HLe7WEF7mBdoAiV
         hlfR7ntjgZ+cIoOEpCJmL6IwnIT7puXMvycLs2IFk1MgQIPRlc1G4musBaKESLIjJK
         QxHZQuQIxu5Ag==
Date:   Mon, 15 Aug 2022 10:54:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: build warnings after merge of the broadcom tree
Message-ID: <20220815105419.4df1005b@canb.auug.org.au>
In-Reply-To: <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
References: <20220725095913.31e859ec@canb.auug.org.au>
        <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I9PXC9.HQfrFk_d/f=ErhCk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I9PXC9.HQfrFk_d/f=ErhCk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Jul 2022 12:33:48 +0200 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.p=
l> wrote:
>
> On 25.07.2022 01:59, Stephen Rothwell wrote:
> > After merging the broadcom tree, today's linux-next build (arm
> > multi_v7_defconfig) produced these warnings:
> >=20
> > arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /ax=
i@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
> > arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /ax=
i@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
> > arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /ax=
i@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge) =20
>=20
> This is expected. My commit ef126d3f58d25 ("ARM: dts: BCM5301X: Add
> basic PCI controller properties") reduced following warnings:
>=20
> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'device_t=
ype' is a required property
>          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/p=
ci-bus.yaml
> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges' =
is a required property
>          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/p=
ci-bus.yaml
> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#address=
-cells' is a required property
>          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/p=
ci-bus.yaml
> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#size-ce=
lls' is a required property
>          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/p=
ci-bus.yaml
>=20
>=20
> down to this one:
>=20
> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges' =
is a required property
>          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/p=
ci-bus.yaml
>=20
>=20
> and basically does the right thing (adds required properties).
>=20
>=20
> I'm fully aware "ranges" need to be added (it's mentioned in the commit)
> and it's one of next things on my BCM5301X list.
>=20
> So while my commits triggers that problem it also reduces warnings so
> I'd say it's acceptable.

So, is something being done about these introduced warnings?

--=20
Cheers,
Stephen Rothwell

--Sig_/I9PXC9.HQfrFk_d/f=ErhCk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL5mTsACgkQAVBC80lX
0GywBgf/V3IfTKQEZs5t4RTle/SwJMMD9WOIndkxZlv9ZXJvInL96WgTmF6Mb8h0
WXQoXjDb9BkEvvCywjvHH4E75XQ/R7Gd0hfxSdEwBM7SKgCU0bKOejTbZ3C1vv45
TuKcChEUQt8LXCYZnHcsvZFB0Cfa/SINTFuh80b/vKAFO1QsrLE1RDLX8rL7Ibow
t1pG/kgvzszb5QbmCeo1hqPEjACBO89MiqJXmBGPrl+GgtUoyJ9rSUozFJWAqMbE
G6c88btYZgHbxMfr4ApEI5DqRkdF3NM17pI/mbC+sFistBldrtJFwTJCBY0bsk1a
DT9ux2NalDxYnmUTUB7C50Jeq6EiXQ==
=lRWN
-----END PGP SIGNATURE-----

--Sig_/I9PXC9.HQfrFk_d/f=ErhCk--
