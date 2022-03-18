Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF04DD550
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiCRHki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiCRHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:40:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFBB23BC1;
        Fri, 18 Mar 2022 00:39:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KKbVr3HnXz4xNm;
        Fri, 18 Mar 2022 18:39:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647589158;
        bh=6Wb4c0vzY/hCjgjcuIHVKafvd8nAittXKbk139WRcJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EWn52FZod2Zk+l8QkuB554b1TyvVj6liBzxR3FpOG1YoyBYELeN+FJIISmA5PPOKU
         EPP+krM0lp86K5GZ6NJzkEq3fLqMbOHB38w/4a2cD2DMvBg550AsIR84Hdp/VTAcnS
         dCSWEzuVxkw43J8K8fscraSSqCBos4mPoEBG7dFRDTFj2uq7axLu0Z4+xWiwV3x2Cb
         fnFbmDDIDVmfsCMleIs51EeIlFZbI9NtLWK8uneJ5WDFFSl/UYrlS6i7CFPnSfL9LB
         WDBaTs6rbPCOFYqelXrNFEEI5VlwGxHI5CKxqPRKhWqIcU1myCqv6LguQsZkuGvBfO
         hiGQ1DqfW5TSA==
Date:   Fri, 18 Mar 2022 18:39:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        David Heidelberg <david@ixit.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: manual merge of the usb tree with the xilinx tree
Message-ID: <20220318183915.08544653@canb.auug.org.au>
In-Reply-To: <d7f84e0a-7c3a-116a-0911-2ed5a0bab2d9@xilinx.com>
References: <20220210141550.56359523@canb.auug.org.au>
        <YgTGdwkTkDgx+pan@kroah.com>
        <d7f84e0a-7c3a-116a-0911-2ed5a0bab2d9@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PJVRzEizXvFrKDqxVxbgvhI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PJVRzEizXvFrKDqxVxbgvhI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 10 Feb 2022 13:24:44 +0100 Michal Simek <michal.simek@xilinx.com> w=
rote:
>
> On 2/10/22 09:01, Greg KH wrote:
> > On Thu, Feb 10, 2022 at 02:15:50PM +1100, Stephen Rothwell wrote: =20
> >>
> >> Today's linux-next merge of the usb tree got a conflict in:
> >>
> >>    arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >>
> >> between commit:
> >>
> >>    eceb6f8677d3 ("arm64: xilinx: dts: drop legacy property #stream-id-=
cells")
> >>
> >> from the xilinx tree and commit:
> >>
> >>    d8b1c3d0d700 ("arm64: dts: zynqmp: Move USB clocks to dwc3 node")
> >>
> >> from the usb tree.
> >>
> >> I fixed it up (see below) and can carry the fix as necessary. This
> >> is now fixed as far as linux-next is concerned, but any non trivial
> >> conflicts should be mentioned to your upstream maintainer when your tr=
ee
> >> is submitted for merging.  You may also want to consider cooperating
> >> with the maintainer of the conflicting tree to minimise any particular=
ly
> >> complex conflicts.
> >>
> >> diff --cc arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >> index 056761c974fd,ba68fb8529ee..000000000000
> >> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >> @@@ -823,6 -824,8 +822,7 @@@
> >>    				interrupt-parent =3D <&gic>;
> >>    				interrupt-names =3D "dwc_usb3", "otg";
> >>    				interrupts =3D <0 65 4>, <0 69 4>;
> >> + 				clock-names =3D "bus_early", "ref";
> >>   -				#stream-id-cells =3D <1>;
> >>    				iommus =3D <&smmu 0x860>;
> >>    				snps,quirk-frame-length-adjustment =3D <0x20>;
> >>    				/* dma-coherent; */
> >> @@@ -849,6 -851,8 +848,7 @@@
> >>    				interrupt-parent =3D <&gic>;
> >>    				interrupt-names =3D "dwc_usb3", "otg";
> >>    				interrupts =3D <0 70 4>, <0 74 4>;
> >> + 				clock-names =3D "bus_early", "ref";
> >>   -				#stream-id-cells =3D <1>;
> >>    				iommus =3D <&smmu 0x861>;
> >>    				snps,quirk-frame-length-adjustment =3D <0x20>;
> >>    				/* dma-coherent; */ =20
> >> -- >> Cheers, =20
> >> Stephen Rothwell =20
> >=20
> >=20
> >=20
> > Looks good, thanks! =20
>=20
> +1 on this.

This is now a conflict between the usb tree and the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/PJVRzEizXvFrKDqxVxbgvhI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI0NyMACgkQAVBC80lX
0GyzXAf8CM9oN7bvxMkix19UMXbQNqqe0tm8SWZCZJZtZLXa5MZLuUqOFLrwYUwZ
0fm63wN2A2ti271tO6w5A6aStMD1I+0L/XGU9efaZqw/7GDwrVn6tgvAZg6LxZ48
/W5hHhGQqEBRx/OZW3zU00vAeFFKNTQVBSHIexGINPZuRPLfNln9hfaU692d1ext
la2JADEjm9zTvRN2kJV0Pety5Vaq1EJAyFTCkbFfz5x8vWdOQLirgsXXEs1giLtX
/zhO7edJkUJ8+YxQBoOumjssG7u/KMpDflysASHkmtnVOcBDfddyltkTch+/pBlw
UGVDCeOU6Q1jY9qB/WL8z8Ev9xa4oA==
=LVhJ
-----END PGP SIGNATURE-----

--Sig_/PJVRzEizXvFrKDqxVxbgvhI--
