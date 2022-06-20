Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B5552887
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 02:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbiFUAOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 20:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiFUAOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 20:14:39 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Jun 2022 17:14:37 PDT
Received: from gnutoo.cyberdimension.org (cyberdimension.org [IPv6:2001:910:1314:ffff::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D2B1836D;
        Mon, 20 Jun 2022 17:14:36 -0700 (PDT)
Received: from gnutoo.cyberdimension.org (localhost [127.0.0.1])
        by cyberdimension.org (OpenSMTPD) with ESMTP id 0950e3d8;
        Mon, 20 Jun 2022 23:39:55 +0000 (UTC)
Received: from primarylaptop.localdomain (localhost [::1])
        by gnutoo.cyberdimension.org (OpenSMTPD) with ESMTP id 8547062c;
        Mon, 20 Jun 2022 23:39:55 +0000 (UTC)
Date:   Tue, 21 Jun 2022 01:47:48 +0200
From:   Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
To:     Krzysztof Kozlowski via Replicant <replicant@osuosl.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Simon Shields <simon@lineageos.org>,
        Martin =?UTF-8?B?SsO8Y2tlcg==?= <martin.juecker@gmail.com>
Subject: Re: [Replicant] [PATCH 3/3] ARM: dts: exynos: add function and
 color to aat1290 flash LED node in Galaxy S3
Message-ID: <20220621014748.1c0b2b05@primarylaptop.localdomain>
In-Reply-To: <f1cc0f5a-12fb-28bc-7345-13ac2bf5b74d@linaro.org>
References: <20220607085343.72414-1-krzysztof.kozlowski@linaro.org>
        <20220607085343.72414-3-krzysztof.kozlowski@linaro.org>
        <4a7f8ab6-c061-3861-5790-b6c0fbd7cad1@gmail.com>
        <ef62a7bb-2217-2947-17dd-fc4a51acdea5@linaro.org>
        <f1402a1d-a74d-f7b9-b9e2-fc3991781e64@gmail.com>
        <f1cc0f5a-12fb-28bc-7345-13ac2bf5b74d@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RXcLkuiECAhv+Y3/6Gw0ixN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RXcLkuiECAhv+Y3/6Gw0ixN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Jun 2022 19:06:09 +0200
Krzysztof Kozlowski via Replicant <replicant@osuosl.org> wrote:

> On 12/06/2022 17:09, Jacek Anaszewski wrote:
> > On 6/10/22 12:14, Krzysztof Kozlowski wrote:
> >> On 09/06/2022 22:31, Jacek Anaszewski wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On 6/7/22 10:53, Krzysztof Kozlowski wrote:
> >>>> Add common LED properties - the function and color - to aat1290
> >>>> flash LED node in Galaxy S3.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski
> >>>> <krzysztof.kozlowski@linaro.org> ---
> >>>>    arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 3 +++
> >>>>    1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
> >>>> b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi index
> >>>> 72901772fcad..d76f3678dcab 100644 ---
> >>>> a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi +++
> >>>> b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi @@ -7,6 +7,7 @@
> >>>>     */
> >>>>   =20
> >>>>    /dts-v1/;
> >>>> +#include <dt-bindings/leds/common.h>
> >>>>    #include "exynos4412-midas.dtsi"
> >>>>   =20
> >>>>    / {
> >>>> @@ -27,6 +28,8 @@ led-controller {
> >>>>   =20
> >>>>    		led {
> >>>>    			label =3D "flash";
> >>>> +			function =3D LED_FUNCTION_FLASH;
> >>>> +			color =3D <LED_COLOR_ID_WHITE>;
> >>>
> >>> Addition of these two properties will not change anything because
> >>> the label has precedence. It is deprecated, but if you introduce
> >>> function and color to the binding instead of the label, the
> >>> resulting LED class device name will change.
> >>
> >> Which is not necessarily what we want, right? Adding these
> >> properties is a proper description of hardware, regardless whether
> >> current Linux implementation uses them or not.
> >=20
> > Actually I'd just drop label in addition to your change.
> > I don't think it would break anybody seriously - not expecting it
> > has any larger group of users and having uniformly constructed DTS
> > files in the mainline has greater value.
> >=20
>=20
> What about some PostmarketOSos, LineageOS and other OSes?
>=20
> Let me Cc here some folks - Simon, Martin, is the label in flash LED
> node anyhow important for you? Can it be dropped and replaced with
> function+color?
We don't have flash or camera support yet with Replicant version(s) that
use kernel(s) based on upstream Linux, so it won't break anything.

Denis.

--Sig_/RXcLkuiECAhv+Y3/6Gw0ixN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeC+d2+Nrp/PU3kkGX138wUF34mMFAmKxByUACgkQX138wUF3
4mMYKBAAizG0drTNSDYUxHg7Da7PcIFOxip+GcGDJLI27Fi0cFg/kEyaJboALnxx
Q3CvVhpuJqOGKDe0HfF6FZO/+BxzShNC/NxDXUlfkyI2SXvY3EAqe4kBkU7ynyKc
aejrFq9CTXXvnPiVbyRlOzz15tkj8byNqNvN7cgd6kGzLtU13B7w+tPBzL3lg5Zh
sT/kPqF8Wq++sN1INqMT9g1WVUUWl47dia1DJ9xz11qYznYCKea7Khej/vOsRh9b
Aue1drPuUX+19MEGaCmkvXJAwhP3gMJVSrxuPg0iKJwwNMS93o2bRQmST0MIqp+F
UAvDTEHqxpWhCG1O3wwKFLAVZCSlPr0bf8o8iRyMrJF+y1Cu/h9VA+ejvRSsyvIr
Ggk7X0uBWphQIzESAW8z3Ggl8ZDev17m6kn99kHa522fhbT7zpxMzmbKMfmtI4CZ
kHdmyNiJXVblYc9nIdF1OdjoeNxuJaYRSPFX+rzIluT2Hd17Ds6AkgoyNAvjRmOT
Omh3UORRJgSxE2L0yECrpfXbSenPuaKQqv1OUcNjaHj6k3VonRi4DbFeGMRCOCr5
aDs+T1CgdPDOzxytoxrevY5g1aY6iIIIjkqQOVn8gFF6KmyarAmr6XVARHURYenI
7fPUQnHtSdHqBS5NlDvYwhMDL992U1ibbhNDsSE0NUpElEIU4ZU=
=YOd1
-----END PGP SIGNATURE-----

--Sig_/RXcLkuiECAhv+Y3/6Gw0ixN--
