Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC84DD539
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiCRH2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiCRH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:28:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F212EBF90;
        Fri, 18 Mar 2022 00:27:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KKbDp3chXz4xvn;
        Fri, 18 Mar 2022 18:27:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647588428;
        bh=4P6oBHZbWcIxwT6MsapuBObcRne1x7bQPyYjSFdT/sU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t06yomXIIhLoRCIv5pwUZf3K3QHga4Hmcri1Yz0celrwLXpTXIM7uyCv2pcZZ7BLW
         ejEpLV+HkQwhFqmc2rZTlEVcW4L8hGKdnK+4F0vGZrA/5iOUr4PgP8WFhIN1FZS3Ox
         4Lmyw5QrL8v76wv5Nii626a53JfsM5NwzVOei9Wkb1g7B5jO+g7E232o27bH/POJP3
         uORhO1YspCFPk8oVgfgI9nsFbBG3525vC1CSfjVRO+ajGN6PFPlcLl1XWL49e6IEqX
         qLsSzflkreiwfNZCwwPxiuhVk+nIJH4X5hPNhyh4dCcbLzIqB4/8m1wXQy5NdRhZOZ
         Rz1uoPS5D1wrA==
Date:   Fri, 18 Mar 2022 18:27:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     broonie@kernel.org, Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: manual merge of the tegra tree with the qcom tree
Message-ID: <20220318182704.22cfa5d5@canb.auug.org.au>
In-Reply-To: <20211216080100.3496490-1-broonie@kernel.org>
References: <20211216080100.3496490-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fL01buxU.9hxKK+6Xp_J/Px";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fL01buxU.9hxKK+6Xp_J/Px
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 16 Dec 2021 08:01:00 +0000 broonie@kernel.org wrote:
>
> Today's linux-next merge of the tegra tree got a conflict in:
>=20
>   arch/arm/configs/multi_v7_defconfig
>=20
> between commit:
>=20
>   7495af9308354 ("ARM: multi_v7_defconfig: Enable drivers for DragonBoard=
 410c")
>=20
> from the qcom tree and commit:
>=20
>   ca1f7d245f530 ("ARM: config: multi v7: Enable display drivers used by T=
egra devices")
>=20
> from the tegra tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc arch/arm/configs/multi_v7_defconfig
> index ae227d309dc1b,3d509bc134440..0000000000000
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@@ -705,7 -690,7 +708,8 @@@ CONFIG_DRM_PANEL_ORISETECH_OTM8009A=3D
>   CONFIG_DRM_PANEL_RAYDIUM_RM68200=3Dm
>   CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=3Dm
>   CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=3Dm
>  +CONFIG_DRM_DISPLAY_CONNECTOR=3Dm
> + CONFIG_DRM_LVDS_CODEC=3Dm
>   CONFIG_DRM_NXP_PTN3460=3Dm
>   CONFIG_DRM_PARADE_PS8622=3Dm
>   CONFIG_DRM_SII902X=3Dm

This is now a conflict between the qcom tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/fL01buxU.9hxKK+6Xp_J/Px
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI0NEgACgkQAVBC80lX
0Gy4/Qf+Ku4iswK0aK0VYdx3zBb7ksEo0rFwdhzbqS0BWfsZkpwoplEhZIzYZbR/
8gzLLGaoe+6hCLlwP2zNzOeSXNFdmjOazGMEJ/2QRTws1pqkV6TiOhcwPYOE00xB
aNedh2g8UMd3K8Fb2fXxcZH7i6PwD7OKlZJ3Nf/keCkeeMUdsmFW//B/o8coe25T
DUQwmQtE1C8rZoXWNzeV4RjPwuNT6TqYNLoGUt4Jz779cdvchIX51jz5waG4Afyn
3jFcR5x7mwnSadnrB2mAbncaC3BqRm8sH9W4iU3+6MMw9KGUuwNA9No/9oGX94p+
HyMjg+QAfGp7r276k63sPJDE/XC1tw==
=D+xB
-----END PGP SIGNATURE-----

--Sig_/fL01buxU.9hxKK+6Xp_J/Px--
