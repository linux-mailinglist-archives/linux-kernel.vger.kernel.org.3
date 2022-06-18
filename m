Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431335506C8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiFRVPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiFRVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:15:00 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD8D2672;
        Sat, 18 Jun 2022 14:14:58 -0700 (PDT)
Message-ID: <ac1f956bece0151a165afc18ec21898d00dacf31.camel@grimler.se>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1655586896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2AOfaSlPHrMVPcO5Ts97JY6OWsmj+2hfSsC8UnVib4=;
        b=Ve8XRXMAZq+qmbXnRkxh8sCqoflFuaV5TaGKrd9hOZq2ZGm4Dzma/LA4LLURkSHk4Bi6/0
        XW3ElXe5XCtvaSU1N+DSFaymv+J8uF41tov/YsYXAsFnEHqOwEO1XUyS4tIS+Y3V9qeiyc
        Na7EGUvDklSL6rXiXMHoAEPDw2Czlwc=
Subject: Re: [PATCH 3/3] ARM: dts: exynos: add function and color to aat1290
 flash LED node in Galaxy S3
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     replicant@osuosl.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Simon Shields <simon@lineageos.org>,
        Martin =?ISO-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
Date:   Sat, 18 Jun 2022 23:14:53 +0200
In-Reply-To: <f1cc0f5a-12fb-28bc-7345-13ac2bf5b74d@linaro.org>
References: <20220607085343.72414-1-krzysztof.kozlowski@linaro.org>
         <20220607085343.72414-3-krzysztof.kozlowski@linaro.org>
         <4a7f8ab6-c061-3861-5790-b6c0fbd7cad1@gmail.com>
         <ef62a7bb-2217-2947-17dd-fc4a51acdea5@linaro.org>
         <f1402a1d-a74d-f7b9-b9e2-fc3991781e64@gmail.com>
         <f1cc0f5a-12fb-28bc-7345-13ac2bf5b74d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: grimler.se
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof and Jacek,

On Sun, 2022-06-12 at 19:06 +0200, Krzysztof Kozlowski wrote:
> On 12/06/2022 17:09, Jacek Anaszewski wrote:
> > On 6/10/22 12:14, Krzysztof Kozlowski wrote:
> > > On 09/06/2022 22:31, Jacek Anaszewski wrote:
> > > > Hi Krzysztof,
> > > >=20
> > > > On 6/7/22 10:53, Krzysztof Kozlowski wrote:
> > > > > Add common LED properties - the function and color - to
> > > > > aat1290 flash
> > > > > LED node in Galaxy S3.
> > > > >=20
> > > > > Signed-off-by: Krzysztof Kozlowski
> > > > > <krzysztof.kozlowski@linaro.org>
> > > > > ---
> > > > > =C2=A0=C2=A0 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 3 +++
> > > > > =C2=A0=C2=A0 1 file changed, 3 insertions(+)
> > > > >=20
> > > > > diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
> > > > > b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
> > > > > index 72901772fcad..d76f3678dcab 100644
> > > > > --- a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
> > > > > +++ b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
> > > > > @@ -7,6 +7,7 @@
> > > > > =C2=A0=C2=A0=C2=A0 */
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0 /dts-v1/;
> > > > > +#include <dt-bindings/leds/common.h>
> > > > > =C2=A0=C2=A0 #include "exynos4412-midas.dtsi"
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0 / {
> > > > > @@ -27,6 +28,8 @@ led-controller {
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0led {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0label =3D "flash";
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
function =3D LED_FUNCTION_FLASH;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
color =3D <LED_COLOR_ID_WHITE>;
> > > >=20
> > > > Addition of these two properties will not change anything
> > > > because
> > > > the label has precedence. It is deprecated, but if you
> > > > introduce
> > > > function and color to the binding instead of the label, the
> > > > resulting
> > > > LED class device name will change.
> > >=20
> > > Which is not necessarily what we want, right? Adding these
> > > properties is
> > > a proper description of hardware, regardless whether current
> > > Linux
> > > implementation uses them or not.
> >=20
> > Actually I'd just drop label in addition to your change.
> > I don't think it would break anybody seriously - not expecting it
> > has
> > any larger group of users and having uniformly constructed DTS
> > files
> > in the mainline has greater value.
> >=20
>=20
> What about some PostmarketOSos, LineageOS and other OSes?
>=20
> Let me Cc here some folks - Simon, Martin, is the label in flash LED
> node anyhow important for you? Can it be dropped and replaced with
> function+color?
>=20

As far as I know LineageOS does not use a mainline-based kernel for the
S3. PostmarketOS and Replicant does though. For PostmarketOS it should
be fine to drop the label, and it sounded like it should be fine for
Replicant also in an IRC discussion, but adding their mailing list to
CC just in case.


Best regards,
Henrik Grimler
